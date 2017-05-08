Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wLv1s4ySzzDqFy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 May 2017 17:16:33 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, cyrilbur@gmail.com,
 Breno Leitao <brenohl@br.ibm.com>,
 Gustavo Bueno Romero <gromero@br.ibm.com>
Subject: [PATCH 2/2] selftests/powerpc: Test TM and VMX register state
Date: Mon,  8 May 2017 17:16:27 +1000
Message-Id: <20170508071627.21851-2-mikey@neuling.org>
In-Reply-To: <20170508071627.21851-1-mikey@neuling.org>
References: <20170508071627.21851-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Test that the VMX checkpointed register state is maintained when a VMX
unavailable exception is taken during a transaction.

Thanks to Breno Leitao <brenohl@br.ibm.com> and
Gustavo Bueno Romero <gromero@br.ibm.com> for the original test this
is based heavily on.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 tools/testing/selftests/powerpc/tm/Makefile        |   4 +-
 .../testing/selftests/powerpc/tm/tm-vmx-unavail.c  | 118 +++++++++++++++++++++
 2 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 5576ee6a51..b947995bb1 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -2,7 +2,8 @@ SIGNAL_CONTEXT_CHK_TESTS := tm-signal-context-chk-gpr tm-signal-context-chk-fpu
 	tm-signal-context-chk-vmx tm-signal-context-chk-vsx
 
 TEST_GEN_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
-	tm-vmxcopy tm-fork tm-tar tm-tmspr $(SIGNAL_CONTEXT_CHK_TESTS)
+	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-vmx-unavail \
+	$(SIGNAL_CONTEXT_CHK_TESTS)
 
 include ../../lib.mk
 
@@ -13,6 +14,7 @@ CFLAGS += -mhtm
 $(OUTPUT)/tm-syscall: tm-syscall-asm.S
 $(OUTPUT)/tm-syscall: CFLAGS += -I../../../../../usr/include
 $(OUTPUT)/tm-tmspr: CFLAGS += -pthread
+$(OUTPUT)/tm-vmx-unavail: CFLAGS += -pthread
 
 SIGNAL_CONTEXT_CHK_TESTS := $(patsubst %,$(OUTPUT)/%,$(SIGNAL_CONTEXT_CHK_TESTS))
 $(SIGNAL_CONTEXT_CHK_TESTS): tm-signal.S
diff --git a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
new file mode 100644
index 0000000000..137185ba49
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
@@ -0,0 +1,118 @@
+/*
+ * Copyright 2017, Michael Neuling, IBM Corp.
+ * Licensed under GPLv2.
+ * Original: Breno Leitao <brenohl@br.ibm.com> &
+ *           Gustavo Bueno Romero <gromero@br.ibm.com>
+ * Edited: Michael Neuling
+ *
+ * Force VMX unavailable during a transaction and see if it corrupts
+ * the checkpointed VMX register state after the abort.
+ */
+
+#include <inttypes.h>
+#include <htmintrin.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <pthread.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <pthread.h>
+
+#include "tm.h"
+#include "utils.h"
+
+int passed;
+
+void *worker(void *unused)
+{
+	__int128 vmx0;
+	uint64_t texasr;
+
+	asm goto (
+		"li       3, 1;"  /* Stick non-zero value in VMX0 */
+		"std      3, 0(%[vmx0_ptr]);"
+		"lvx      0, 0, %[vmx0_ptr];"
+
+		/* Wait here a bit so we get scheduled out 255 times */
+		"lis      3, 0x3fff;"
+		"1: ;"
+		"addi     3, 3, -1;"
+		"cmpdi    3, 0;"
+		"bne      1b;"
+
+		/* Kernel will hopefully turn VMX off now */
+
+		"tbegin. ;"
+		"beq      failure;"
+
+		/* Cause VMX unavail. Any VMX instruction */
+		"vaddcuw  0,0,0;"
+
+		"tend. ;"
+		"b        %l[success];"
+
+		/* Check VMX0 sanity after abort */
+		"failure: ;"
+		"lvx       1,  0, %[vmx0_ptr];"
+		"vcmpequb. 2,  0, 1;"
+		"bc        4, 24, %l[value_mismatch];"
+		"b        %l[value_match];"
+		:
+		: [vmx0_ptr] "r"(&vmx0)
+		: "r3"
+		: success, value_match, value_mismatch
+		);
+
+	/* HTM aborted and VMX0 is corrupted */
+value_mismatch:
+	texasr = __builtin_get_texasr();
+
+	printf("\n\n==============\n\n");
+	printf("Failure with error: %lx\n",   _TEXASR_FAILURE_CODE(texasr));
+	printf("Summary error     : %lx\n",   _TEXASR_FAILURE_SUMMARY(texasr));
+	printf("TFIAR exact       : %lx\n\n", _TEXASR_TFIAR_EXACT(texasr));
+
+	passed = 0;
+	return NULL;
+
+	/* HTM aborted but VMX0 is correct */
+value_match:
+//	printf("!");
+	return NULL;
+
+success:
+//	printf(".");
+	return NULL;
+}
+
+int tm_vmx_unavail_test()
+{
+	int threads;
+	pthread_t *thread;
+
+	SKIP_IF(!have_htm());
+
+	passed = 1;
+
+	threads = sysconf(_SC_NPROCESSORS_ONLN) * 4;
+	thread = malloc(sizeof(pthread_t)*threads);
+	if (!thread)
+		return EXIT_FAILURE;
+
+	for (uint64_t i = 0; i < threads; i++)
+		pthread_create(&thread[i], NULL, &worker, NULL);
+
+	for (uint64_t i = 0; i < threads; i++)
+		pthread_join(thread[i], NULL);
+
+	free(thread);
+
+	return passed ? EXIT_SUCCESS : EXIT_FAILURE;
+}
+
+
+int main(int argc, char **argv)
+{
+	return test_harness(tm_vmx_unavail_test, "tm_vmx_unavail_test");
+}
-- 
2.11.0
