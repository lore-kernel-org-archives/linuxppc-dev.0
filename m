Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7ED651A00A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 09:09:33 +1100 (AEDT)
Received: by pacdm15 with SMTP id dm15so18415303pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Dec 2015 14:09:31 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org
Subject: [PATCH] selftests/powerpc: Add test to check if VSRs are corrupted
Date: Wed,  9 Dec 2015 09:09:20 +1100
Message-Id: <1449612560-2587-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a transaction is aborted, VSR values should rollback to the
checkpointed values before the transaction began. VSRs used elsewhere in
the kernel during a transaction, or while the transaction is suspended
should not affect the checkpointed values.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---

Prior to the bug fix in "powerpc: Don't corrupt transactional state when
using FP/VMX in kernel", when VMX was requested by the kernel the .vr_state
(which held the checkpointed state of VSRs before the transaction) was
overwritten with the current state from outside the transation. Thus if the
transaction did not complete, the VSR values would be "rolled back" to
potentially incorrect values.

 tools/testing/selftests/powerpc/tm/.gitignore   |   1 +
 tools/testing/selftests/powerpc/tm/Makefile     |   2 +-
 tools/testing/selftests/powerpc/tm/tm-vmxcopy.c | 104 ++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-vmxcopy.c

diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
index 9bf6749550e3..b86c94ea462d 100644
--- a/tools/testing/selftests/powerpc/tm/.gitignore
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -5,3 +5,4 @@ tm-signal-stack
 tm-fork
 tm-dscr
 tm-tar
+tm-vmxcopy
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index cd3d42a15601..fc9a5ed1aba2 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-fork tm-dscr tm-tar tm-signal-stack
+TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-fork tm-dscr tm-tar tm-vmxcopy tm-signal-stack
 
 all: $(TEST_PROGS)
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-vmxcopy.c b/tools/testing/selftests/powerpc/tm/tm-vmxcopy.c
new file mode 100644
index 000000000000..288c9c3d0776
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-vmxcopy.c
@@ -0,0 +1,104 @@
+/*
+ * Copyright 2015, Michael Neuling, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Original: Michael Neuling 4/12/2013
+ * Edited: Rashmica Gupta 4/12/2015
+ *
+ * See if the altivec state is leaked out of an aborted transaction due to
+ * kernel vmx copy loops.
+ *
+ * When the transaction aborts, VSR values should rollback to the values
+ * they held before the transaction commenced. Using VSRs while transaction
+ * is suspended should not affect the checkpointed values.
+ *
+ * (1) write A to a VSR
+ * (2) start transaction
+ * (3) suspend transaction
+ * (4) change the VSR to B
+ * (5) trigger kernel vmx copy loop
+ * (6) abort transaction
+ * (7) check that the VSR value is A
+ */
+
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <string.h>
+#include <assert.h>
+
+#include "tm.h"
+#include "utils.h"
+
+int test_vmxcopy()
+{
+	long double vecin = 1.3;
+	long double vecout;
+	unsigned long pgsize = getpagesize();
+	int i;
+	int fd;
+	int size = pgsize*16;
+	char tmpfile[] = "/tmp/page_faultXXXXXX";
+	char buf[pgsize];
+	char *a;
+	uint64_t aborted = 0;
+
+	SKIP_IF(!have_htm());
+
+	fd = mkstemp(tmpfile);
+	assert(fd >= 0);
+
+	memset(buf, 0, pgsize);
+	for (i = 0; i < size; i += pgsize)
+		assert(write(fd, buf, pgsize) == pgsize);
+
+	unlink(tmpfile);
+
+	a = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	assert(a != MAP_FAILED);
+
+	asm __volatile__(
+		"lxvd2x 40,0,%[vecinptr];"	/* set 40 to initial value*/
+		"tbegin.;"
+		"beq	3f;"
+		"tsuspend.;"
+		"xxlxor 40,40,40;"		/* set 40 to 0 */
+		"std	5, 0(%[map]);"		/* cause kernel vmx copy page */
+		"tabort. 0;"
+		"tresume.;"
+		"tend.;"
+		"li	%[res], 0;"
+		"b	5f;"
+
+		/* Abort handler */
+		"3:;"
+		"li	%[res], 1;"
+
+		"5:;"
+		"stxvd2x 40,0,%[vecoutptr];"
+		: [res]"=r"(aborted)
+		: [vecinptr]"r"(&vecin),
+		  [vecoutptr]"r"(&vecout),
+		  [map]"r"(a)
+		: "memory", "r0", "r3", "r4", "r5", "r6", "r7");
+
+	if (aborted && (vecin != vecout)){
+		printf("FAILED: vector state leaked on abort %f != %f\n",
+		       (double)vecin, (double)vecout);
+		return 1;
+	}
+
+	munmap(a, size);
+
+	close(fd);
+
+	return 0;
+}
+
+
+int main(int argc, char *argv[]){
+
+	return test_harness(test_vmxcopy, "tm_vmxcopy");
+}
-- 
2.5.0
