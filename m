Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc/perf: Revert to original NO_SIPR logic
Date: Thu, 16 May 2013 16:19:30 +1000
Message-Id: <1368685171-1948-1-git-send-email-michael@ellerman.id.au>
Cc: sukadev@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a revert and then some of commit 860aad7 "Add regs_no_sipr()".
This workaround was only needed on early chip versions.

As before NO_SIPR becomes a static flag of the PMU struct.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/perf/core-book3s.c |   30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 426180b..b2f873b 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -110,7 +110,7 @@ static inline void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw) {}
 
 static bool regs_use_siar(struct pt_regs *regs)
 {
-	return !!(regs->result & 1);
+	return !!regs->result;
 }
 
 /*
@@ -181,11 +181,6 @@ static bool regs_sipr(struct pt_regs *regs)
 	return !!(regs->dsisr & sipr);
 }
 
-static bool regs_no_sipr(struct pt_regs *regs)
-{
-	return !!(regs->result & 2);
-}
-
 static inline u32 perf_flags_from_msr(struct pt_regs *regs)
 {
 	if (regs->msr & MSR_PR)
@@ -208,7 +203,7 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 	 * SIAR which should give slightly more reliable
 	 * results
 	 */
-	if (regs_no_sipr(regs)) {
+	if (ppmu->flags & PPMU_NO_SIPR) {
 		unsigned long siar = mfspr(SPRN_SIAR);
 		if (siar >= PAGE_OFFSET)
 			return PERF_RECORD_MISC_KERNEL;
@@ -239,22 +234,9 @@ static inline void perf_read_regs(struct pt_regs *regs)
 	int use_siar;
 
 	regs->dsisr = mmcra;
-	regs->result = 0;
-
-	if (ppmu->flags & PPMU_NO_SIPR)
-		regs->result |= 2;
-
-	/*
-	 * On power8 if we're in random sampling mode, the SIER is updated.
-	 * If we're in continuous sampling mode, we don't have SIPR.
-	 */
-	if (ppmu->flags & PPMU_HAS_SIER) {
-		if (marked)
-			regs->dar = mfspr(SPRN_SIER);
-		else
-			regs->result |= 2;
-	}
 
+	if (ppmu->flags & PPMU_HAS_SIER)
+		regs->dar = mfspr(SPRN_SIER);
 
 	/*
 	 * If this isn't a PMU exception (eg a software event) the SIAR is
@@ -279,12 +261,12 @@ static inline void perf_read_regs(struct pt_regs *regs)
 		use_siar = 1;
 	else if ((ppmu->flags & PPMU_NO_CONT_SAMPLING))
 		use_siar = 0;
-	else if (!regs_no_sipr(regs) && regs_sipr(regs))
+	else if (!(ppmu->flags & PPMU_NO_SIPR) && regs_sipr(regs))
 		use_siar = 0;
 	else
 		use_siar = 1;
 
-	regs->result |= use_siar;
+	regs->result = use_siar;
 }
 
 /*
-- 
1.7.10.4
