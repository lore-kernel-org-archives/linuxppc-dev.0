Return-Path: <rashmicy@gmail.com>
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6396D1A0E74
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 16:50:34 +1100 (AEDT)
Received: by mail-pf0-x232.google.com with SMTP id 78so44772645pfw.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 21:50:34 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org,
	mpe@ellermen.id.au
Subject: [PATCH 5/5] selftests/powerpc: Add test to check if TM SPRs are
 corrupted
Date: Wed, 23 Dec 2015 16:49:54 +1100
Message-Id: <1450849794-23174-6-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1450849794-23174-1-git-send-email-rashmicy@gmail.com>
References: <1450849794-23174-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Testing that the TM SPRs are behaving the way they should. Uses more
threads than cpus to see if the following register values persist with
context switching:
- the FS (failure summary) flag in TEXASR
- TFIAR and TFHAR

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 tools/testing/selftests/powerpc/tm/.gitignore |   1 +
 tools/testing/selftests/powerpc/tm/Makefile   |   3 +-
 tools/testing/selftests/powerpc/tm/tm-tmspr.c | 143 ++++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-tmspr.c

diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
index 2ac376410c70..bb942db845bf 100644
--- a/tools/testing/selftests/powerpc/tm/.gitignore
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -5,3 +5,4 @@ tm-signal-stack
 tm-vmxcopy
 tm-fork
 tm-tar
+tm-tmspr
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index cb4b3bf57a4d..d0505dbd22d5 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack tm-vmxcopy tm-fork tm-tar
+TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack tm-vmxcopy tm-fork tm-tar tm-tmspr
 
 all: $(TEST_PROGS)
 
@@ -6,6 +6,7 @@ $(TEST_PROGS): ../harness.c ../utils.c
 
 tm-syscall: tm-syscall-asm.S
 tm-syscall: CFLAGS += -mhtm -I../../../../../usr/include
+tm-tmspr: CFLAGS += -pthread
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-tmspr.c b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
new file mode 100644
index 000000000000..2bda81c7bf23
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
@@ -0,0 +1,143 @@
+/*
+ * Copyright 2015, Michael Neuling, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Original: Michael Neuling 3/4/2014
+ * Modified: Rashmica Gupta 8/12/2015
+ *
+ * Check if any of the Transaction Memory SPRs get corrupted.
+ * - TFIAR  - stores address of location of transaction failure
+ * - TFHAR  - stores address of software failure handler (if transaction
+ *   fails)
+ * - TEXASR - lots of info about the transacion(s)
+ *
+ * (1) create more threads than cpus
+ * (2) in each thread:
+ * 	(a) set TFIAR and TFHAR a unique value
+ * 	(b) loop for awhile, continually checking to see if
+ * 	either register has been corrupted.
+ *
+ * (3) Loop:
+ * 	(a) begin transaction
+ *    	(b) abort transaction
+ *	(c) check TEXASR to see if FS has been corrupted
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <string.h>
+
+#include "utils.h"
+#include "tm.h"
+
+int	num_loops	= 10000;
+int	passed = 1;
+
+void tfiar_tfhar(void *in)
+{
+	int i, cpu;
+	unsigned long tfhar, tfhar_rd, tfiar, tfiar_rd;
+	cpu_set_t cpuset;
+
+	CPU_ZERO(&cpuset);
+	cpu = (unsigned long)in >> 1;
+	CPU_SET(cpu, &cpuset);
+	sched_setaffinity(0, sizeof(cpuset), &cpuset);
+
+	/* TFIAR: Last bit has to be high so userspace can read register */
+	tfiar = ((unsigned long)in) + 1;
+	tfiar += 2;
+	mtspr(SPRN_TFIAR, tfiar);
+
+	/* TFHAR: Last two bits are reserved */
+	tfhar = ((unsigned long)in);
+	tfhar &= ~0x3UL;
+	tfhar += 4;
+	mtspr(SPRN_TFHAR, tfhar);
+
+	for (i = 0; i < num_loops; i++)	{
+		tfhar_rd = mfspr(SPRN_TFHAR);
+		tfiar_rd = mfspr(SPRN_TFIAR);
+		if ( (tfhar != tfhar_rd) || (tfiar != tfiar_rd) ) {
+			passed = 0;
+			return;
+		}
+	}
+	return;
+}
+
+void texasr(void *in)
+{
+	unsigned long i;
+	uint64_t result = 0;
+
+	for (i = 0; i < num_loops; i++) {
+		asm __volatile__(
+			"tbegin.;"
+			"beq    3f ;"
+			"tabort. 0 ;"
+			"tend.;"
+
+			/* Abort handler */
+			"3: ;"
+			::: "memory");
+
+                /* Check the TEXASR */
+                result = mfspr(SPRN_TEXASR);
+		if ((result & TEXASR_FS) == 0) {
+			passed = 0;
+			return;
+		}
+	}
+	return;
+}
+
+int test_tmspr()
+{
+	pthread_t 	thread;
+	int	   	thread_num;
+	unsigned long	i;
+
+	SKIP_IF(!have_htm());
+
+	/* To cause some context switching */
+	thread_num = 10 * sysconf(_SC_NPROCESSORS_ONLN);
+
+	/* Test TFIAR and TFHAR */
+	for (i = 0 ; i < thread_num ; i += 2){
+		if (pthread_create(&thread, NULL, (void*)tfiar_tfhar, (void *)i))
+			return EXIT_FAILURE;
+	}
+	if (pthread_join(thread, NULL) != 0)
+		return EXIT_FAILURE;
+
+	/* Test TEXASR */
+	for (i = 0 ; i < thread_num ; i++){
+		if (pthread_create(&thread, NULL, (void*)texasr, (void *)i))
+			return EXIT_FAILURE;
+	}
+	if (pthread_join(thread, NULL) != 0)
+		return EXIT_FAILURE;
+
+	if (passed)
+		return 0;
+	else
+		return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc > 1) {
+		if (strcmp(argv[1], "-h") == 0) {
+			printf("Syntax:\t [<num loops>]\n");
+			return 0;
+		} else {
+			num_loops = atoi(argv[1]);
+		}
+	}
+	return test_harness(test_tmspr, "tm_tmspr");
+}
-- 
2.5.0
