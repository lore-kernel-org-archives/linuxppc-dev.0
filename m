Return-Path: <opurdila@ixiacom.com>
Received: from ixro-ex1.ixiacom.com (unknown [92.87.192.98])
	by ozlabs.org (Postfix) with ESMTP id CE8CADDDB6
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 23:22:21 +1100 (EST)
From: Octavian Purdila <opurdila@ixiacom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 1/2] powerpc: G4 oprofile: variable number of counters
Date: Tue, 24 Feb 2009 14:09:58 +0200
Message-Id: <1235477399-20428-2-git-send-email-opurdila@ixiacom.com>
In-Reply-To: <1233724934.16867.290.camel@pasglop>
References: <1233724934.16867.290.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Octavian Purdila <opurdila@ixiacom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For ppc750 processors which use 4 performance counters instead of the
6 G4 uses but otherwise is compatible with G4.

Signed-off-by: Octavian Purdila <opurdila@ixiacom.com>
---
 arch/powerpc/oprofile/op_model_7450.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/oprofile/op_model_7450.c b/arch/powerpc/oprofile/op_model_7450.c
index cc599eb..f8d36f9 100644
--- a/arch/powerpc/oprofile/op_model_7450.c
+++ b/arch/powerpc/oprofile/op_model_7450.c
@@ -29,7 +29,7 @@
 static unsigned long reset_value[OP_MAX_COUNTER];
 
 static int oprofile_running;
-static u32 mmcr0_val, mmcr1_val, mmcr2_val;
+static u32 mmcr0_val, mmcr1_val, mmcr2_val, num_pmcs;
 
 #define MMCR0_PMC1_SHIFT	6
 #define MMCR0_PMC2_SHIFT	0
@@ -88,13 +88,12 @@ static int fsl7450_cpu_setup(struct op_counter_config *ctr)
 
 	mtspr(SPRN_MMCR0, mmcr0_val);
 	mtspr(SPRN_MMCR1, mmcr1_val);
-	mtspr(SPRN_MMCR2, mmcr2_val);
+	if (num_pmcs > 4)
+		mtspr(SPRN_MMCR2, mmcr2_val);
 
 	return 0;
 }
 
-#define NUM_CTRS 6
-
 /* Configures the global settings for the countes on all CPUs. */
 static int fsl7450_reg_setup(struct op_counter_config *ctr,
 			     struct op_system_config *sys,
@@ -102,12 +101,13 @@ static int fsl7450_reg_setup(struct op_counter_config *ctr,
 {
 	int i;
 
+	num_pmcs = num_ctrs;
 	/* Our counters count up, and "count" refers to
 	 * how much before the next interrupt, and we interrupt
 	 * on overflow.  So we calculate the starting value
 	 * which will give us "count" until overflow.
 	 * Then we set the events on the enabled counters */
-	for (i = 0; i < NUM_CTRS; ++i)
+	for (i = 0; i < num_ctrs; ++i)
 		reset_value[i] = 0x80000000UL - ctr[i].count;
 
 	/* Set events for Counters 1 & 2 */
@@ -123,9 +123,10 @@ static int fsl7450_reg_setup(struct op_counter_config *ctr,
 
 	/* Set events for Counters 3-6 */
 	mmcr1_val = mmcr1_event3(ctr[2].event)
-		| mmcr1_event4(ctr[3].event)
-		| mmcr1_event5(ctr[4].event)
-		| mmcr1_event6(ctr[5].event);
+		| mmcr1_event4(ctr[3].event);
+	if (num_ctrs > 4)
+		mmcr1_val |= mmcr1_event5(ctr[4].event)
+			| mmcr1_event6(ctr[5].event);
 
 	mmcr2_val = 0;
 
@@ -139,7 +140,7 @@ static int fsl7450_start(struct op_counter_config *ctr)
 
 	mtmsr(mfmsr() | MSR_PMM);
 
-	for (i = 0; i < NUM_CTRS; ++i) {
+	for (i = 0; i < num_pmcs; ++i) {
 		if (ctr[i].enabled)
 			classic_ctr_write(i, reset_value[i]);
 		else
@@ -184,7 +185,7 @@ static void fsl7450_handle_interrupt(struct pt_regs *regs,
 	pc = mfspr(SPRN_SIAR);
 	is_kernel = is_kernel_addr(pc);
 
-	for (i = 0; i < NUM_CTRS; ++i) {
+	for (i = 0; i < num_pmcs; ++i) {
 		val = classic_ctr_read(i);
 		if (val < 0) {
 			if (oprofile_running && ctr[i].enabled) {
-- 
1.5.6.5
