Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzHr22xPKzDr5j
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 10:45:22 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5U0hZmj043613
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:45:20 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bcsuwx860-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:45:19 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 21:45:17 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5U0ewAQ26869772
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 21:40:58 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5U0jFIF002966
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 21:45:15 -0300
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: leitao@debian.org, Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/tm: test for regs sanity in VSX exception
Date: Thu, 29 Jun 2017 20:44:50 -0400
In-Reply-To: <1498783490-23675-1-git-send-email-gromero@linux.vnet.ibm.com>
References: <1498783490-23675-1-git-send-email-gromero@linux.vnet.ibm.com>
Message-Id: <1498783490-23675-2-git-send-email-gromero@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a test to check if FP/VSX registers are sane (restored correctly) after
a VSX unavailable exception is caught in the middle of a transaction.

Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/powerpc/tm/Makefile        |   3 +-
 .../testing/selftests/powerpc/tm/tm-vsx-unavail.c  | 144 +++++++++++++++++++++
 2 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-vsx-unavail.c

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 958c11c..d0ffbb8 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -2,7 +2,7 @@ SIGNAL_CONTEXT_CHK_TESTS := tm-signal-context-chk-gpr tm-signal-context-chk-fpu
 	tm-signal-context-chk-vmx tm-signal-context-chk-vsx
 
 TEST_GEN_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
-	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-vmx-unavail \
+	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-vmx-unavail tm-vsx-unavail \
 	$(SIGNAL_CONTEXT_CHK_TESTS)
 
 include ../../lib.mk
@@ -15,6 +15,7 @@ $(OUTPUT)/tm-syscall: tm-syscall-asm.S
 $(OUTPUT)/tm-syscall: CFLAGS += -I../../../../../usr/include
 $(OUTPUT)/tm-tmspr: CFLAGS += -pthread
 $(OUTPUT)/tm-vmx-unavail: CFLAGS += -pthread -m64
+$(OUTPUT)/tm-vsx-unavail: CFLAGS += -pthread -m64
 
 SIGNAL_CONTEXT_CHK_TESTS := $(patsubst %,$(OUTPUT)/%,$(SIGNAL_CONTEXT_CHK_TESTS))
 $(SIGNAL_CONTEXT_CHK_TESTS): tm-signal.S
diff --git a/tools/testing/selftests/powerpc/tm/tm-vsx-unavail.c b/tools/testing/selftests/powerpc/tm/tm-vsx-unavail.c
new file mode 100644
index 0000000..7ff933a
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-vsx-unavail.c
@@ -0,0 +1,144 @@
+/*
+ * Copyright 2017, Gustavo Romero and Breno Leitao, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Force VSX unavailable exception during a transaction and see
+ * if it corrupts the checkpointed FP registers state after the abort.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <inttypes.h>
+#include <pthread.h>
+#include <sched.h>
+
+#include "tm.h"
+#include "utils.h"
+
+int passed;
+
+void *ping(void *not_used)
+{
+	asm goto(
+		// r3 = 0x5555555555555555
+		"lis  3, 0x5555    ;"
+		"ori  3, 3, 0x5555 ;"
+		"sldi 3, 3, 32     ;"
+		"oris 3, 3, 0x5555 ;"
+		"ori  3, 3, 0x5555 ;"
+
+		//r4 = 0xFFFFFFFFFFFFFFFF
+		"lis  4, 0xFFFF    ;"
+		"ori  4, 4, 0xFFFF ;"
+		"sldi 4, 4, 32     ;"
+		"oris 4, 4, 0xFFFF ;"
+		"ori  4, 4, 0xFFFF ;"
+
+		// vs33 and vs34 will just be used to construct vs0 from r3 and
+		// r4. Both won't be used in any other place after that.
+		"mtvsrd 33, 3      ;"
+		"mtvsrd 34, 4      ;"
+
+		// vs0 = (r3 || r4) = 0x5555555555555555FFFFFFFFFFFFFFFF
+		"xxmrghd 0, 33, 34 ;"
+
+
+		// Wait ~8s so we have a sufficient amount of context
+		// switches so load_fp and load_vec overflow and MSR.FP, MSR.VEC
+		// and MSR.VSX are disabled.
+		"       lis	 7, 0x1       ;"
+		"       ori      7, 7, 0xBFFE ;"
+		"       sldi     7, 7, 15     ;"
+		"1:	addi     7, 7, -1     ;"
+		"       cmpdi    7, 0         ;"
+		"       bne      1b           ;"
+
+		// Any floating-point instruction in here.
+		// N.B. 'fmr' is *not touching* any previously set register,
+		// i.e. it's not touching vs0.
+		"fmr    10, 10     ;"
+
+		// vs0 is *still* 0x5555555555555555FFFFFFFFFFFFFFFF, right?
+		// Get in a transaction and cause a VSX unavailable exception.
+		"2:	tbegin.               ;" // Begin HTM
+		"       beq      3f           ;" // Failure handler
+		"       xxmrghd  10, 10, 10   ;" // VSX unavailable in TM
+		"       tend.                 ;" // End HTM
+		"3:     nop                   ;" // Fall through to code below
+
+		// Immediately after a transaction failure we save vs0 to two
+		// general purpose registers to check its value. We need to have
+		// the same value as before we entered in transactional state.
+
+		// vs0 should be *still* 0x5555555555555555FFFFFFFFFFFFFFFF
+
+		// Save high half - MSB (64bit).
+		"mfvsrd  5, 0                 ;"
+
+		// Save low half - LSB (64bit).
+		// We mess with vs3, but it's not important.
+		"xxsldwi 3, 0, 0, 2           ;"
+		"mfvsrd  6, 3                 ;"
+
+		// N.B. r3 and r4 never changed since they were used to
+		// construct the initial vs0 value, hence we can use them to do
+		// the comparison. r3 and r4 will be destroy but it's ok.
+		"cmpd  3, 5                ;" // compare r3 to r5
+		"bne   %[value_mismatch]      ;"
+		"cmpd  4, 6                ;" // compare r4 to r6
+		"bne   %[value_mismatch]      ;"
+		"b     %[value_ok]            ;"
+		:
+		:
+		: "r3", "r4", "vs33", "vs34", "vs0",
+		  "vs10", "fr10", "r7", "r5", "r6", "vs3"
+		: value_mismatch, value_ok
+		);
+value_mismatch:
+		passed = 0;
+		return NULL;
+value_ok:
+		passed = 1;
+		return NULL;
+}
+
+void *pong(void *not_used)
+{
+	while (1)
+		sched_yield(); // will be classed as interactive-like thread
+}
+
+int tm_vsx_unavail_test(void)
+{
+	pthread_t t0, t1;
+	pthread_attr_t attr;
+	cpu_set_t cpuset;
+
+	// Set only CPU 0 in the mask. Both threads will be bound to cpu 0
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+
+	// Init pthread attribute
+	pthread_attr_init(&attr);
+
+	// Set CPU 0 mask into the pthread attribute
+	pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &cpuset);
+
+	// 'pong' thread used to induce context switches on 'ping' thread
+	pthread_create(&t1, &attr /* bound to cpu 0 */, pong, NULL);
+
+	printf("Checking if FP/VSX is sane after a VSX exception in TM...\n");
+
+	pthread_create(&t0, &attr /* bound to cpu 0 as well */, ping, NULL);
+	pthread_join(t0, NULL);
+
+	return passed ? EXIT_SUCCESS : EXIT_FAILURE;
+}
+
+int main(int argc, char **argv)
+{
+	return test_harness(tm_vsx_unavail_test, "tm_vsx_unavail_test");
+}
-- 
2.7.4
