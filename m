Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF5A71A0065
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 16:03:15 +1100 (AEDT)
Received: by mail-pa0-x233.google.com with SMTP id wq6so17257308pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 21:03:15 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org
Subject: [PATCH] selftests/powerpc: Add test to check if TM SPRs are corrupted
Date: Wed, 16 Dec 2015 16:03:04 +1100
Message-Id: <1450242184-3261-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just testing that things are behaving the way they should. Uses more
threads than cpus to see if the following values persist with context
switching:
- the FS (failure summary) flag in TEXASR
- TFIAR and TFHAR

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 tools/testing/selftests/powerpc/tm/.gitignore |   1 +
 tools/testing/selftests/powerpc/tm/Makefile   |   6 +-
 tools/testing/selftests/powerpc/tm/tm-tmspr.c | 154 ++++++++++++++++++++++++++
 3 files changed, 159 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-tmspr.c

diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
index c4667790d01d..42a6467afe93 100644
--- a/tools/testing/selftests/powerpc/tm/.gitignore
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -3,3 +3,4 @@ tm-syscall
 tm-signal-msr-resv
 tm-signal-stack 
 tm-vmxcopy
+tm-tmspr
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index d013447fb6d9..21435399e8e9 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,11 +1,13 @@
-TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack tm-vmxcopy
+TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack tm-vmxcopy tm-tmspr
 
 all: $(TEST_PROGS)
 
 $(TEST_PROGS): ../harness.c ../utils.c
 
 tm-syscall: tm-syscall-asm.S
-	tm-syscall: CFLAGS += -mhtm -I../../../../../usr/include
+tm-syscall: CFLAGS += -mhtm -I../../../../../usr/include
+
+tm-tmspr: CFLAGS += -pthread
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-tmspr.c b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
new file mode 100644
index 000000000000..6b317b8d7067
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
@@ -0,0 +1,154 @@
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
+
+
+#define __stringify_1(x)	#x
+#define __stringify(x)		__stringify_1(x)
+#define mfspr(rn)	({unsigned long rval; \
+			asm volatile("mfspr %0," __stringify(rn) \
+				: "=r" (rval)); rval; })
+#define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : \
+				     : "r" ((unsigned long)(v)) \
+				     : "memory")
+#define SPRN_TEXASR     0x82
+#define TEXASR_FS       0x08000000
+#define SPRN_TFIAR	0x81	/* Transaction Failure Inst Addr    */
+#define SPRN_TFHAR	0x80	/* Transaction Failure Handler Addr */
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
