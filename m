Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/7] powerpc/perf: Add regs_no_sipr()
Date: Fri, 26 Apr 2013 15:28:26 +1000
Message-Id: <1366954108-27081-5-git-send-email-michael@ellerman.id.au>
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

On power8 the presence or absence of SIPR depends on settings at runtime,
so convert to using a dynamic flag for NO_SIPR. Existing backends that
set NO_SIPR unconditionally set the dynamic flag obviously.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/perf/core-book3s.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 5d30001..1c13c3d 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -156,6 +156,11 @@ static bool regs_sipr(struct pt_regs *regs)
 	return !!(regs->dsisr & sipr);
 }
 
+static bool regs_no_sipr(struct pt_regs *regs)
+{
+	return !!(regs->result & 2);
+}
+
 static inline u32 perf_flags_from_msr(struct pt_regs *regs)
 {
 	if (regs->msr & MSR_PR)
@@ -178,7 +183,7 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 	 * SIAR which should give slightly more reliable
 	 * results
 	 */
-	if (ppmu->flags & PPMU_NO_SIPR) {
+	if (regs_no_sipr(regs)) {
 		unsigned long siar = mfspr(SPRN_SIAR);
 		if (siar >= PAGE_OFFSET)
 			return PERF_RECORD_MISC_KERNEL;
@@ -208,6 +213,10 @@ static inline void perf_read_regs(struct pt_regs *regs)
 	int use_siar;
 
 	regs->dsisr = mmcra;
+	regs->result = 0;
+
+	if (ppmu->flags & PPMU_NO_SIPR)
+		regs->result |= 2;
 
 	/*
 	 * If this isn't a PMU exception (eg a software event) the SIAR is
@@ -232,12 +241,12 @@ static inline void perf_read_regs(struct pt_regs *regs)
 		use_siar = 1;
 	else if ((ppmu->flags & PPMU_NO_CONT_SAMPLING))
 		use_siar = 0;
-	else if (!(ppmu->flags & PPMU_NO_SIPR) && regs_sipr(regs))
+	else if (!regs_no_sipr(regs) && regs_sipr(regs))
 		use_siar = 0;
 	else
 		use_siar = 1;
 
-	regs->result = use_siar;
+	regs->result |= use_siar;
 }
 
 /*
-- 
1.7.10.4
