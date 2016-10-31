Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6dNk6nKzzDvRH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 13:19:50 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: Jack Miller <jack@codezen.org>, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] Revert "selftests/powerpc: Load Monitor Register Tests"
Date: Mon, 31 Oct 2016 13:19:38 +1100
Message-Id: <20161031021939.30989-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Load monitored won't be supported in POWER9, so PPC_FEATURE2_ARCH_3_00
(in HWCAP2) will no longer imply Load monitor support.

These Load monitored tests are enabled by PPC_FEATURE2_ARCH_3_00 so
they are now bogus and need to be removed.

This reverts commit 16c19a2e983346c547501795aadffde1977b058d.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 tools/testing/selftests/powerpc/pmu/ebb/.gitignore |   2 -
 tools/testing/selftests/powerpc/pmu/ebb/Makefile   |   2 +-
 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.c  | 143 ---------------------
 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.h  |  39 ------
 .../selftests/powerpc/pmu/ebb/ebb_lmr_regs.c       |  37 ------
 tools/testing/selftests/powerpc/reg.h              |   5 -
 6 files changed, 1 insertion(+), 227 deletions(-)
 delete mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.c
 delete mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.h
 delete mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr_regs.c

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/.gitignore b/tools/testing/selftests/powerpc/pmu/ebb/.gitignore
index 44b7df14a9..42bddbed8b 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/.gitignore
+++ b/tools/testing/selftests/powerpc/pmu/ebb/.gitignore
@@ -20,5 +20,3 @@ back_to_back_ebbs_test
 lost_exception_test
 no_handler_test
 cycles_with_mmcr2_test
-ebb_lmr
-ebb_lmr_regs
\ No newline at end of file
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/Makefile b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
index 6b0453e60d..8d2279c4bb 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
@@ -14,7 +14,7 @@ TEST_PROGS := reg_access_test event_attributes_test cycles_test	\
 	 fork_cleanup_test ebb_on_child_test			\
 	 ebb_on_willing_child_test back_to_back_ebbs_test	\
 	 lost_exception_test no_handler_test			\
-	 cycles_with_mmcr2_test ebb_lmr ebb_lmr_regs
+	 cycles_with_mmcr2_test
 
 all: $(TEST_PROGS)
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.c
deleted file mode 100644
index c47ebd55ba..0000000000
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.c
+++ /dev/null
@@ -1,143 +0,0 @@
-/*
- * Copyright 2016, Jack Miller, IBM Corp.
- * Licensed under GPLv2.
- */
-
-#include <stdlib.h>
-#include <stdio.h>
-
-#include "ebb.h"
-#include "ebb_lmr.h"
-
-#define SIZE		(32 * 1024 * 1024)	/* 32M */
-#define LM_SIZE		0	/* Smallest encoding, 32M */
-
-#define SECTIONS	64	/* 1 per bit in LMSER */
-#define SECTION_SIZE	(SIZE / SECTIONS)
-#define SECTION_LONGS   (SECTION_SIZE / sizeof(long))
-
-static unsigned long *test_mem;
-
-static int lmr_count = 0;
-
-void ebb_lmr_handler(void)
-{
-	lmr_count++;
-}
-
-void ldmx_full_section(unsigned long *mem, int section)
-{
-	unsigned long *ptr;
-	int i;
-
-	for (i = 0; i < SECTION_LONGS; i++) {
-		ptr = &mem[(SECTION_LONGS * section) + i];
-		ldmx((unsigned long) &ptr);
-		ebb_lmr_reset();
-	}
-}
-
-unsigned long section_masks[] = {
-	0x8000000000000000,
-	0xFF00000000000000,
-	0x0000000F70000000,
-	0x8000000000000001,
-	0xF0F0F0F0F0F0F0F0,
-	0x0F0F0F0F0F0F0F0F,
-	0x0
-};
-
-int ebb_lmr_section_test(unsigned long *mem)
-{
-	unsigned long *mask = section_masks;
-	int i;
-
-	for (; *mask; mask++) {
-		mtspr(SPRN_LMSER, *mask);
-		printf("Testing mask 0x%016lx\n", mfspr(SPRN_LMSER));
-
-		for (i = 0; i < 64; i++) {
-			lmr_count = 0;
-			ldmx_full_section(mem, i);
-			if (*mask & (1UL << (63 - i)))
-				FAIL_IF(lmr_count != SECTION_LONGS);
-			else
-				FAIL_IF(lmr_count);
-		}
-	}
-
-	return 0;
-}
-
-int ebb_lmr(void)
-{
-	int i;
-
-	SKIP_IF(!lmr_is_supported());
-
-	setup_ebb_handler(ebb_lmr_handler);
-
-	ebb_global_enable();
-
-	FAIL_IF(posix_memalign((void **)&test_mem, SIZE, SIZE) != 0);
-
-	mtspr(SPRN_LMSER, 0);
-
-	FAIL_IF(mfspr(SPRN_LMSER) != 0);
-
-	mtspr(SPRN_LMRR, ((unsigned long)test_mem | LM_SIZE));
-
-	FAIL_IF(mfspr(SPRN_LMRR) != ((unsigned long)test_mem | LM_SIZE));
-
-	/* Read every single byte to ensure we get no false positives */
-	for (i = 0; i < SECTIONS; i++)
-		ldmx_full_section(test_mem, i);
-
-	FAIL_IF(lmr_count != 0);
-
-	/* Turn on the first section */
-
-	mtspr(SPRN_LMSER, (1UL << 63));
-	FAIL_IF(mfspr(SPRN_LMSER) != (1UL << 63));
-
-	/* Enable LM (BESCR) */
-
-	mtspr(SPRN_BESCR, mfspr(SPRN_BESCR) | BESCR_LME);
-	FAIL_IF(!(mfspr(SPRN_BESCR) & BESCR_LME));
-
-	ldmx((unsigned long)&test_mem);
-
-	FAIL_IF(lmr_count != 1);	// exactly one exception
-	FAIL_IF(mfspr(SPRN_BESCR) & BESCR_LME);	// LM now disabled
-	FAIL_IF(!(mfspr(SPRN_BESCR) & BESCR_LMEO));	// occurred bit set
-
-	printf("Simple LMR EBB OK\n");
-
-	/* This shouldn't cause an EBB since it's been disabled */
-	ldmx((unsigned long)&test_mem);
-	FAIL_IF(lmr_count != 1);
-
-	printf("LMR disable on EBB OK\n");
-
-	ebb_lmr_reset();
-
-	/* This should cause an EBB or reset is broken */
-	ldmx((unsigned long)&test_mem);
-	FAIL_IF(lmr_count != 2);
-
-	printf("LMR reset EBB OK\n");
-
-	ebb_lmr_reset();
-
-	return ebb_lmr_section_test(test_mem);
-}
-
-int main(void)
-{
-	int ret = test_harness(ebb_lmr, "ebb_lmr");
-
-	if (test_mem)
-		free(test_mem);
-
-	return ret;
-}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.h b/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.h
deleted file mode 100644
index ef50abd557..0000000000
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr.h
+++ /dev/null
@@ -1,39 +0,0 @@
-#ifndef _SELFTESTS_POWERPC_PMU_EBB_LMR_H
-#define _SELFTESTS_POWERPC_PMU_EBB_LMR_H
-
-#include "reg.h"
-
-#ifndef PPC_FEATURE2_ARCH_3_00
-#define PPC_FEATURE2_ARCH_3_00 0x00800000
-#endif
-
-#define lmr_is_supported() have_hwcap2(PPC_FEATURE2_ARCH_3_00)
-
-static inline void ebb_lmr_reset(void)
-{
-	unsigned long bescr = mfspr(SPRN_BESCR);
-	bescr &= ~(BESCR_LMEO);
-	bescr |= BESCR_LME;
-	mtspr(SPRN_BESCR, bescr);
-}
-
-#define LDMX(t, a, b)\
-	(0x7c00026a |				\
-	 (((t) & 0x1f) << 21) |			\
-	 (((a) & 0x1f) << 16) |			\
-	 (((b) & 0x1f) << 11))
-
-static inline unsigned long ldmx(unsigned long address)
-{
-	unsigned long ret;
-
-	asm volatile ("mr 9, %1\r\n"
-		      ".long " __stringify(LDMX(9, 0, 9)) "\r\n"
-		      "mr %0, 9\r\n":"=r"(ret)
-		      :"r"(address)
-		      :"r9");
-
-	return ret;
-}
-
-#endif
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr_regs.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr_regs.c
deleted file mode 100644
index aff4241fd8..0000000000
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb_lmr_regs.c
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Copyright 2016, Jack Miller, IBM Corp.
- * Licensed under GPLv2.
- */
-
-#include <stdlib.h>
-#include <stdio.h>
-#include <unistd.h>
-
-#include "ebb.h"
-#include "ebb_lmr.h"
-
-#define CHECKS 10000
-
-int ebb_lmr_regs(void)
-{
-	int i;
-
-	SKIP_IF(!lmr_is_supported());
-
-	ebb_global_enable();
-
-	for (i = 0; i < CHECKS; i++) {
-		mtspr(SPRN_LMRR, i << 25);	// skip size and rsvd bits
-		mtspr(SPRN_LMSER, i);
-
-		FAIL_IF(mfspr(SPRN_LMRR) != (i << 25));
-		FAIL_IF(mfspr(SPRN_LMSER) != i);
-	}
-
-	return 0;
-}
-
-int main(void)
-{
-	return test_harness(ebb_lmr_regs, "ebb_lmr_regs");
-}
diff --git a/tools/testing/selftests/powerpc/reg.h b/tools/testing/selftests/powerpc/reg.h
index fddf368ed8..65bfdeeebd 100644
--- a/tools/testing/selftests/powerpc/reg.h
+++ b/tools/testing/selftests/powerpc/reg.h
@@ -34,11 +34,6 @@
 
 #define BESCR_PMEO     0x1     /* PMU Event-based exception Occurred */
 #define BESCR_PME      (0x1ul << 32) /* PMU Event-based exception Enable */
-#define BESCR_LME      (0x1ul << 34) /* Load Monitor Enable */
-#define BESCR_LMEO     (0x1ul << 2)  /* Load Monitor Exception Occurred */
-
-#define SPRN_LMRR      813     /* Load Monitor Region Register */
-#define SPRN_LMSER     814     /* Load Monitor Section Enable Register */
 
 #define SPRN_PMC1      771
 #define SPRN_PMC2      772
-- 
2.9.3
