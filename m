Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/4] powerpc/perf: Add support for SIER
Date: Wed, 10 Apr 2013 18:32:45 +1000
Message-Id: <1365582765-6939-4-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1365582765-6939-1-git-send-email-michael@ellerman.id.au>
References: <1365582765-6939-1-git-send-email-michael@ellerman.id.au>
Cc: sukadev@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michaele@au1.ibm.com>

On power8 we have a new SIER (Sampled Instruction Event Register), which
captures information about instructions when we have random sampling
enabled.

Add support for loading the SIER into pt_regs, overloading regs->dar.
Also set the new NO_SIPR flag in regs->result if we don't have SIPR.

Update regs_sihv/sipr() to look for SIPR/SIHV in SIER.

Signed-off-by: Michael Ellerman <michaele@au1.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h |    1 +
 arch/powerpc/perf/core-book3s.c              |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index e287aef..a1a1ad8 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -53,6 +53,7 @@ struct power_pmu {
 #define PPMU_NO_CONT_SAMPLING	0x00000008 /* no continuous sampling */
 #define PPMU_SIAR_VALID		0x00000010 /* Processor has SIAR Valid bit */
 #define PPMU_HAS_SSLOT		0x00000020 /* Has sampled slot in MMCRA */
+#define PPMU_HAS_SIER		0x00000040 /* Has SIER */
 
 /*
  * Values for flags to get_alternatives()
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 4255b12..a4bbd4d 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -116,6 +116,9 @@ static bool regs_sihv(struct pt_regs *regs)
 {
 	unsigned long sihv = MMCRA_SIHV;
 
+	if (ppmu->flags & PPMU_HAS_SIER)
+		return !!(regs->dar & SIER_SIHV);
+
 	if (ppmu->flags & PPMU_ALT_SIPR)
 		sihv = POWER6_MMCRA_SIHV;
 
@@ -126,6 +129,9 @@ static bool regs_sipr(struct pt_regs *regs)
 {
 	unsigned long sipr = MMCRA_SIPR;
 
+	if (ppmu->flags & PPMU_HAS_SIER)
+		return !!(regs->dar & SIER_SIPR);
+
 	if (ppmu->flags & PPMU_ALT_SIPR)
 		sipr = POWER6_MMCRA_SIPR;
 
@@ -184,6 +190,7 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 /*
  * Overload regs->dsisr to store MMCRA so we only need to read it once
  * on each interrupt.
+ * Overload regs->dar to store SIER if we have it.
  * Overload regs->result to specify whether we should use the MSR (result
  * is zero) or the SIAR (result is non zero).
  */
@@ -200,6 +207,18 @@ static inline void perf_read_regs(struct pt_regs *regs)
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
