Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/7] powerpc/perf: Convert mmcra_sipr/sihv() to
 regs_sipr/sihv()
Date: Fri, 26 Apr 2013 15:28:24 +1000
Message-Id: <1366954108-27081-3-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1366954108-27081-1-git-send-email-michael@ellerman.id.au>
References: <1366954108-27081-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On power8 the SIPR and SIHV are not in MMCRA, so convert the routines
to take regs and change the names accordingly.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/perf/core-book3s.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index eb64480..2417fe2 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -131,24 +131,24 @@ static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
 		*addrp = mfspr(SPRN_SDAR);
 }
 
-static bool mmcra_sihv(unsigned long mmcra)
+static bool regs_sihv(struct pt_regs *regs)
 {
 	unsigned long sihv = MMCRA_SIHV;
 
 	if (ppmu->flags & PPMU_ALT_SIPR)
 		sihv = POWER6_MMCRA_SIHV;
 
-	return !!(mmcra & sihv);
+	return !!(regs->dsisr & sihv);
 }
 
-static bool mmcra_sipr(unsigned long mmcra)
+static bool regs_sipr(struct pt_regs *regs)
 {
 	unsigned long sipr = MMCRA_SIPR;
 
 	if (ppmu->flags & PPMU_ALT_SIPR)
 		sipr = POWER6_MMCRA_SIPR;
 
-	return !!(mmcra & sipr);
+	return !!(regs->dsisr & sipr);
 }
 
 static inline u32 perf_flags_from_msr(struct pt_regs *regs)
@@ -162,7 +162,6 @@ static inline u32 perf_flags_from_msr(struct pt_regs *regs)
 
 static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 {
-	unsigned long mmcra = regs->dsisr;
 	unsigned long use_siar = regs->result;
 
 	if (!use_siar)
@@ -182,10 +181,12 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 	}
 
 	/* PR has priority over HV, so order below is important */
-	if (mmcra_sipr(mmcra))
+	if (regs_sipr(regs))
 		return PERF_RECORD_MISC_USER;
-	if (mmcra_sihv(mmcra) && (freeze_events_kernel != MMCR0_FCHV))
+
+	if (regs_sihv(regs) && (freeze_events_kernel != MMCR0_FCHV))
 		return PERF_RECORD_MISC_HYPERVISOR;
+
 	return PERF_RECORD_MISC_KERNEL;
 }
 
@@ -201,6 +202,8 @@ static inline void perf_read_regs(struct pt_regs *regs)
 	int marked = mmcra & MMCRA_SAMPLE_ENABLE;
 	int use_siar;
 
+	regs->dsisr = mmcra;
+
 	/*
 	 * If this isn't a PMU exception (eg a software event) the SIAR is
 	 * not valid. Use pt_regs.
@@ -224,12 +227,11 @@ static inline void perf_read_regs(struct pt_regs *regs)
 		use_siar = 1;
 	else if ((ppmu->flags & PPMU_NO_CONT_SAMPLING))
 		use_siar = 0;
-	else if (!(ppmu->flags & PPMU_NO_SIPR) && mmcra_sipr(mmcra))
+	else if (!(ppmu->flags & PPMU_NO_SIPR) && regs_sipr(regs))
 		use_siar = 0;
 	else
 		use_siar = 1;
 
-	regs->dsisr = mmcra;
 	regs->result = use_siar;
 }
 
-- 
1.7.10.4
