Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 6/7] powerpc/perf: Add support for SIER
Date: Fri, 26 Apr 2013 15:28:27 +1000
Message-Id: <1366954108-27081-6-git-send-email-michael@ellerman.id.au>
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

On power8 we have a new SIER (Sampled Instruction Event Register), which
captures information about instructions when we have random sampling
enabled.

Add support for loading the SIER into pt_regs, overloading regs->dar.
Also set the new NO_SIPR flag in regs->result if we don't have SIPR.

Update regs_sihv/sipr() to look for SIPR/SIHV in SIER.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/perf_event_server.h |    1 +
 arch/powerpc/include/asm/reg.h               |    5 +++++
 arch/powerpc/perf/core-book3s.c              |   19 +++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 7074aec..57b42da 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -53,6 +53,7 @@ struct power_pmu {
 #define PPMU_NO_CONT_SAMPLING	0x00000008 /* no continuous sampling */
 #define PPMU_SIAR_VALID		0x00000010 /* Processor has SIAR Valid bit */
 #define PPMU_HAS_SSLOT		0x00000020 /* Has sampled slot in MMCRA */
+#define PPMU_HAS_SIER		0x00000040 /* Has SIER */
 
 /*
  * Values for flags to get_alternatives()
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 5735ebb..5c6fbe2 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -671,6 +671,11 @@
 #define SPRN_PMC8	794
 #define SPRN_SIAR	780
 #define SPRN_SDAR	781
+#define SPRN_SIER	784
+#define   SIER_SIPR		0x2000000	/* Sampled MSR_PR */
+#define   SIER_SIHV		0x1000000	/* Sampled MSR_HV */
+#define   SIER_SIAR_VALID	0x0400000	/* SIAR contents valid */
+#define   SIER_SDAR_VALID	0x0200000	/* SDAR contents valid */
 
 #define SPRN_PA6T_MMCR0 795
 #define   PA6T_MMCR0_EN0	0x0000000000000001UL
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 1c13c3d..4ac6e64 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -140,6 +140,9 @@ static bool regs_sihv(struct pt_regs *regs)
 {
 	unsigned long sihv = MMCRA_SIHV;
 
+	if (ppmu->flags & PPMU_HAS_SIER)
+		return !!(regs->dar & SIER_SIHV);
+
 	if (ppmu->flags & PPMU_ALT_SIPR)
 		sihv = POWER6_MMCRA_SIHV;
 
@@ -150,6 +153,9 @@ static bool regs_sipr(struct pt_regs *regs)
 {
 	unsigned long sipr = MMCRA_SIPR;
 
+	if (ppmu->flags & PPMU_HAS_SIER)
+		return !!(regs->dar & SIER_SIPR);
+
 	if (ppmu->flags & PPMU_ALT_SIPR)
 		sipr = POWER6_MMCRA_SIPR;
 
@@ -203,6 +209,7 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 /*
  * Overload regs->dsisr to store MMCRA so we only need to read it once
  * on each interrupt.
+ * Overload regs->dar to store SIER if we have it.
  * Overload regs->result to specify whether we should use the MSR (result
  * is zero) or the SIAR (result is non zero).
  */
@@ -219,6 +226,18 @@ static inline void perf_read_regs(struct pt_regs *regs)
 		regs->result |= 2;
 
 	/*
+	 * On power8 if we're in random sampling mode, the SIER is updated.
+	 * If we're in continuous sampling mode, we don't have SIPR.
+	 */
+	if (ppmu->flags & PPMU_HAS_SIER) {
+		if (marked)
+			regs->dar = mfspr(SPRN_SIER);
+		else
+			regs->result |= 2;
+	}
+
+
+	/*
 	 * If this isn't a PMU exception (eg a software event) the SIAR is
 	 * not valid. Use pt_regs.
 	 *
-- 
1.7.10.4
