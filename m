Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPlNF4QRlzDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 20:41:17 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Jack Miller <jack@codezen.org>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org, mikey@neuling.org,
 cyrilbur@gmail.com
Subject: [PATCH v6 3/3] powerpc: Load Monitor Register Tests
Date: Wed,  8 Jun 2016 20:38:36 +1000
Message-Id: <1465382316-18588-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1465382316-18588-1-git-send-email-mikey@neuling.org>
References: <1462501822-11262-1-git-send-email-mikey@neuling.org>
 <1465382316-18588-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jack Miller <jack@codezen.org>

Adds two tests. One is a simple test to ensure that the new registers
LMRR and LMSER are properly maintained. The other actually uses the
existing EBB test infrastructure to test that LMRR and LMSER behave as
documented.

Signed-off-by: Jack Miller <jack@codezen.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 tools/testing/selftests/powerpc/pmu/ebb/.gitignore |   2 +
 tools/testing/selftests/powerpc/pmu/ebb/Makefile   |   2 +-
 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.c  | 143 +++++++++++++++++++++
 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.h  |  39 ++++++
 .../selftests/powerpc/pmu/ebb/ebb_lmr_regs.c       |  37 ++++++
 tools/testing/selftests/powerpc/reg.h              |   5 +
 6 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.h
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr_regs.c

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/.gitignore b/tools/testing/selftests/powerpc/pmu/ebb/.gitignore
index 42bddbe..44b7df1 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/.gitignore
+++ b/tools/testing/selftests/powerpc/pmu/ebb/.gitignore
@@ -20,3 +20,5 @@ back_to_back_ebbs_test
 lost_exception_test
 no_handler_test
 cycles_with_mmcr2_test
+ebb_lmr
+ebb_lmr_regs
\ No newline at end of file
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/Makefile b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
index 8d2279c4..6b0453e 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
@@ -14,7 +14,7 @@ TEST_PROGS := reg_access_test event_attributes_test cycles_test	\
 	 fork_cleanup_test ebb_on_child_test			\
 	 ebb_on_willing_child_test back_to_back_ebbs_test	\
 	 lost_exception_test no_handler_test			\
-	 cycles_with_mmcr2_test
+	 cycles_with_mmcr2_test ebb_lmr ebb_lmr_regs
 
 all: $(TEST_PROGS)
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.c
new file mode 100644
index 0000000..c47ebd5
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.c
@@ -0,0 +1,143 @@
+/*
+ * Copyright 2016, Jack Miller, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+
+#include "ebb.h"
+#include "ebb_lmr.h"
+
+#define SIZE		(32 * 1024 * 1024)	/* 32M */
+#define LM_SIZE		0	/* Smallest encoding, 32M */
+
+#define SECTIONS	64	/* 1 per bit in LMSER */
+#define SECTION_SIZE	(SIZE / SECTIONS)
+#define SECTION_LONGS   (SECTION_SIZE / sizeof(long))
+
+static unsigned long *test_mem;
+
+static int lmr_count = 0;
+
+void ebb_lmr_handler(void)
+{
+	lmr_count++;
+}
+
+void ldmx_full_section(unsigned long *mem, int section)
+{
+	unsigned long *ptr;
+	int i;
+
+	for (i = 0; i < SECTION_LONGS; i++) {
+		ptr = &mem[(SECTION_LONGS * section) + i];
+		ldmx((unsigned long) &ptr);
+		ebb_lmr_reset();
+	}
+}
+
+unsigned long section_masks[] = {
+	0x8000000000000000,
+	0xFF00000000000000,
+	0x0000000F70000000,
+	0x8000000000000001,
+	0xF0F0F0F0F0F0F0F0,
+	0x0F0F0F0F0F0F0F0F,
+	0x0
+};
+
+int ebb_lmr_section_test(unsigned long *mem)
+{
+	unsigned long *mask = section_masks;
+	int i;
+
+	for (; *mask; mask++) {
+		mtspr(SPRN_LMSER, *mask);
+		printf("Testing mask 0x%016lx\n", mfspr(SPRN_LMSER));
+
+		for (i = 0; i < 64; i++) {
+			lmr_count = 0;
+			ldmx_full_section(mem, i);
+			if (*mask & (1UL << (63 - i)))
+				FAIL_IF(lmr_count != SECTION_LONGS);
+			else
+				FAIL_IF(lmr_count);
+		}
+	}
+
+	return 0;
+}
+
+int ebb_lmr(void)
+{
+	int i;
+
+	SKIP_IF(!lmr_is_supported());
+
+	setup_ebb_handler(ebb_lmr_handler);
+
+	ebb_global_enable();
+
+	FAIL_IF(posix_memalign((void **)&test_mem, SIZE, SIZE) != 0);
+
+	mtspr(SPRN_LMSER, 0);
+
+	FAIL_IF(mfspr(SPRN_LMSER) != 0);
+
+	mtspr(SPRN_LMRR, ((unsigned long)test_mem | LM_SIZE));
+
+	FAIL_IF(mfspr(SPRN_LMRR) != ((unsigned long)test_mem | LM_SIZE));
+
+	/* Read every single byte to ensure we get no false positives */
+	for (i = 0; i < SECTIONS; i++)
+		ldmx_full_section(test_mem, i);
+
+	FAIL_IF(lmr_count != 0);
+
+	/* Turn on the first section */
+
+	mtspr(SPRN_LMSER, (1UL << 63));
+	FAIL_IF(mfspr(SPRN_LMSER) != (1UL << 63));
+
+	/* Enable LM (BESCR) */
+
+	mtspr(SPRN_BESCR, mfspr(SPRN_BESCR) | BESCR_LME);
+	FAIL_IF(!(mfspr(SPRN_BESCR) & BESCR_LME));
+
+	ldmx((unsigned long)&test_mem);
+
+	FAIL_IF(lmr_count != 1);	// exactly one exception
+	FAIL_IF(mfspr(SPRN_BESCR) & BESCR_LME);	// LM now disabled
+	FAIL_IF(!(mfspr(SPRN_BESCR) & BESCR_LMEO));	// occurred bit set
+
+	printf("Simple LMR EBB OK\n");
+
+	/* This shouldn't cause an EBB since it's been disabled */
+	ldmx((unsigned long)&test_mem);
+	FAIL_IF(lmr_count != 1);
+
+	printf("LMR disable on EBB OK\n");
+
+	ebb_lmr_reset();
+
+	/* This should cause an EBB or reset is broken */
+	ldmx((unsigned long)&test_mem);
+	FAIL_IF(lmr_count != 2);
+
+	printf("LMR reset EBB OK\n");
+
+	ebb_lmr_reset();
+
+	return ebb_lmr_section_test(test_mem);
+}
+
+int main(void)
+{
+	int ret = test_harness(ebb_lmr, "ebb_lmr");
+
+	if (test_mem)
+		free(test_mem);
+
+	return ret;
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.h b/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.h
new file mode 100644
index 0000000..ef50abd
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.h
@@ -0,0 +1,39 @@
+#ifndef _SELFTESTS_POWERPC_PMU_EBB_LMR_H
+#define _SELFTESTS_POWERPC_PMU_EBB_LMR_H
+
+#include "reg.h"
+
+#ifndef PPC_FEATURE2_ARCH_3_00
+#define PPC_FEATURE2_ARCH_3_00 0x00800000
+#endif
+
+#define lmr_is_supported() have_hwcap2(PPC_FEATURE2_ARCH_3_00)
+
+static inline void ebb_lmr_reset(void)
+{
+	unsigned long bescr = mfspr(SPRN_BESCR);
+	bescr &= ~(BESCR_LMEO);
+	bescr |= BESCR_LME;
+	mtspr(SPRN_BESCR, bescr);
+}
+
+#define LDMX(t, a, b)\
+	(0x7c00026a |				\
+	 (((t) & 0x1f) << 21) |			\
+	 (((a) & 0x1f) << 16) |			\
+	 (((b) & 0x1f) << 11))
+
+static inline unsigned long ldmx(unsigned long address)
+{
+	unsigned long ret;
+
+	asm volatile ("mr 9, %1\r\n"
+		      ".long " __stringify(LDMX(9, 0, 9)) "\r\n"
+		      "mr %0, 9\r\n":"=r"(ret)
+		      :"r"(address)
+		      :"r9");
+
+	return ret;
+}
+
+#endif
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr_regs.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr_regs.c
new file mode 100644
index 0000000..aff4241
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr_regs.c
@@ -0,0 +1,37 @@
+/*
+ * Copyright 2016, Jack Miller, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include "ebb.h"
+#include "ebb_lmr.h"
+
+#define CHECKS 10000
+
+int ebb_lmr_regs(void)
+{
+	int i;
+
+	SKIP_IF(!lmr_is_supported());
+
+	ebb_global_enable();
+
+	for (i = 0; i < CHECKS; i++) {
+		mtspr(SPRN_LMRR, i << 25);	// skip size and rsvd bits
+		mtspr(SPRN_LMSER, i);
+
+		FAIL_IF(mfspr(SPRN_LMRR) != (i << 25));
+		FAIL_IF(mfspr(SPRN_LMSER) != i);
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(ebb_lmr_regs, "ebb_lmr_regs");
+}
diff --git a/tools/testing/selftests/powerpc/reg.h b/tools/testing/selftests/powerpc/reg.h
index 65bfdee..fddf368 100644
--- a/tools/testing/selftests/powerpc/reg.h
+++ b/tools/testing/selftests/powerpc/reg.h
@@ -34,6 +34,11 @@
 
 #define BESCR_PMEO     0x1     /* PMU Event-based exception Occurred */
 #define BESCR_PME      (0x1ul << 32) /* PMU Event-based exception Enable */
+#define BESCR_LME      (0x1ul << 34) /* Load Monitor Enable */
+#define BESCR_LMEO     (0x1ul << 2)  /* Load Monitor Exception Occurred */
+
+#define SPRN_LMRR      813     /* Load Monitor Region Register */
+#define SPRN_LMSER     814     /* Load Monitor Section Enable Register */
 
 #define SPRN_PMC1      771
 #define SPRN_PMC2      772
-- 
2.7.4
