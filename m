Return-Path: <vwool@ru.mvista.com>
Date: Thu, 26 Oct 2006 10:43:44 +0400
From: Vitaly Wool <vwool@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [2/2] build failure for E500 CPUs w/ CONFIG_OPROFLE=y
Message-Id: <20061026104344.ed4bfc60.vwool@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: oprofile-list@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Below is the patch for the problem described in "[0/2] build failure for 8540 w/ CONFIG_OPROFLE=y" letter representing the second approach. This approach just fixes the mess with ctr_read/ctr_write functions.
Pro: no need to mess with arch's and add more confusion to arch/powerpc/oprofile/common.c.
Con: when compiled for FSL_BOOKE, op_model_7450 is not valid as it takes ctr_read/ctr_write from FSL_BOOKE variant, which is confusing but actually doesn't matter since it will never be used in this case.

So, here's the second patch...

 arch/powerpc/oprofile/op_model_7450.c      |   12 ++++-----
 arch/powerpc/oprofile/op_model_fsl_booke.c |   37 -----------------------------
 include/asm-powerpc/oprofile_impl.h        |   36 ++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 43 deletions(-)

Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

Index: linux-2.6.18/arch/powerpc/oprofile/op_model_7450.c
===================================================================
--- linux-2.6.18.orig/arch/powerpc/oprofile/op_model_7450.c
+++ linux-2.6.18/arch/powerpc/oprofile/op_model_7450.c
@@ -58,7 +58,7 @@ static u32 mmcr0_val, mmcr1_val, mmcr2_v
  * enables the counters to trigger the interrupt, and sets the
  * counters to only count when the mark bit is not set.
  */
-static void pmc_start_ctrs(void)
+static void pmc_7450_start_ctrs(void)
 {
 	u32 mmcr0 = mfspr(SPRN_MMCR0);
 
@@ -69,7 +69,7 @@ static void pmc_start_ctrs(void)
 }
 
 /* Disables the counters on this CPU, and freezes them */
-static void pmc_stop_ctrs(void)
+static void pmc_7450_stop_ctrs(void)
 {
 	u32 mmcr0 = mfspr(SPRN_MMCR0);
 
@@ -84,7 +84,7 @@ static void pmc_stop_ctrs(void)
 static void fsl7450_cpu_setup(void *unused)
 {
 	/* freeze all counters */
-	pmc_stop_ctrs();
+	pmc_7450_stop_ctrs();
 
 	mtspr(SPRN_MMCR0, mmcr0_val);
 	mtspr(SPRN_MMCR1, mmcr1_val);
@@ -145,7 +145,7 @@ static void fsl7450_start(struct op_coun
 	/* Clear the freeze bit, and enable the interrupt.
 	 * The counters won't actually start until the rfi clears
 	 * the PMM bit */
-	pmc_start_ctrs();
+	pmc_7450_start_ctrs();
 
 	oprofile_running = 1;
 }
@@ -154,7 +154,7 @@ static void fsl7450_start(struct op_coun
 static void fsl7450_stop(void)
 {
 	/* freeze counters */
-	pmc_stop_ctrs();
+	pmc_7450_stop_ctrs();
 
 	oprofile_running = 0;
 
@@ -194,7 +194,7 @@ static void fsl7450_handle_interrupt(str
 	/* Clear the freeze bit, and reenable the interrupt.
 	 * The counters won't actually start until the rfi clears
 	 * the PMM bit */
-	pmc_start_ctrs();
+	pmc_7450_start_ctrs();
 }
 
 struct op_powerpc_model op_model_7450= {
Index: linux-2.6.18/arch/powerpc/oprofile/op_model_fsl_booke.c
===================================================================
--- linux-2.6.18.orig/arch/powerpc/oprofile/op_model_fsl_booke.c
+++ linux-2.6.18/arch/powerpc/oprofile/op_model_fsl_booke.c
@@ -32,43 +32,6 @@ static unsigned long reset_value[OP_MAX_
 static int num_counters;
 static int oprofile_running;
 
-static inline unsigned int ctr_read(unsigned int i)
-{
-	switch(i) {
-		case 0:
-			return mfpmr(PMRN_PMC0);
-		case 1:
-			return mfpmr(PMRN_PMC1);
-		case 2:
-			return mfpmr(PMRN_PMC2);
-		case 3:
-			return mfpmr(PMRN_PMC3);
-		default:
-			return 0;
-	}
-}
-
-static inline void ctr_write(unsigned int i, unsigned int val)
-{
-	switch(i) {
-		case 0:
-			mtpmr(PMRN_PMC0, val);
-			break;
-		case 1:
-			mtpmr(PMRN_PMC1, val);
-			break;
-		case 2:
-			mtpmr(PMRN_PMC2, val);
-			break;
-		case 3:
-			mtpmr(PMRN_PMC3, val);
-			break;
-		default:
-			break;
-	}
-}
-
-
 static void fsl_booke_reg_setup(struct op_counter_config *ctr,
 			     struct op_system_config *sys,
 			     int num_ctrs)
Index: linux-2.6.18/include/asm-powerpc/oprofile_impl.h
===================================================================
--- linux-2.6.18.orig/include/asm-powerpc/oprofile_impl.h
+++ linux-2.6.18/include/asm-powerpc/oprofile_impl.h
@@ -121,6 +121,42 @@ static inline void ctr_write(unsigned in
 		break;
 	}
 }
+#else
+static inline unsigned int ctr_read(unsigned int i)
+{
+	switch(i) {
+		case 0:
+			return mfpmr(PMRN_PMC0);
+		case 1:
+			return mfpmr(PMRN_PMC1);
+		case 2:
+			return mfpmr(PMRN_PMC2);
+		case 3:
+			return mfpmr(PMRN_PMC3);
+		default:
+			return 0;
+	}
+}
+
+static inline void ctr_write(unsigned int i, unsigned int val)
+{
+	switch(i) {
+		case 0:
+			mtpmr(PMRN_PMC0, val);
+			break;
+		case 1:
+			mtpmr(PMRN_PMC1, val);
+			break;
+		case 2:
+			mtpmr(PMRN_PMC2, val);
+			break;
+		case 3:
+			mtpmr(PMRN_PMC3, val);
+			break;
+		default:
+			break;
+	}
+}
 #endif /* !CONFIG_FSL_BOOKE */
 
 extern void op_powerpc_backtrace(struct pt_regs * const regs, unsigned int depth);
