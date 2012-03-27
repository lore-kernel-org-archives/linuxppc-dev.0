Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C3887B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2012 17:47:50 +1100 (EST)
Message-ID: <1332830854.2882.54.camel@pasglop>
Subject: [PATCH] powerpc/perf: Fix instruction address sampling on 970 and
 Power4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 27 Mar 2012 17:47:34 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Anton Blanchard <anton@au1.ibm.com>, Paul Mackerras <paulus@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

970 and Power4 don't support "continuous sampling" which means that
when we aren't in marked instruction sampling mode (marked events),
SIAR isn't updated with the last instruction sampled before the
perf interrupt. On those processors, we must thus use the exception
SRR0 value as the sampled instruction pointer.

Those processors also don't support the SIPR and SIHV bits in MMCRA
which means we need some kind of heuristic to decide if SIAR values
represent kernel or user addresses.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/perf_event_server.h |    2 +
 arch/powerpc/perf/core-book3s.c              |   46 +++++++++++++++++++++++---
 arch/powerpc/perf/power4-pmu.c               |    1 +
 arch/powerpc/perf/ppc970-pmu.c               |    1 +
 4 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 1a8093f..078019b 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -47,6 +47,8 @@ struct power_pmu {
  */
 #define PPMU_LIMITED_PMC5_6	1	/* PMC5/6 have limited function */
 #define PPMU_ALT_SIPR		2	/* uses alternate posn for SIPR/HV */
+#define PPMU_NO_SIPR		4	/* no SIPR/HV in MMCRA at all */
+#define PPMU_NO_CONT_SAMPLING	8	/* no continuous sampling */
 
 /*
  * Values for flags to get_alternatives()
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index c2e27ed..02aee03 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -116,14 +116,45 @@ static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
 		*addrp = mfspr(SPRN_SDAR);
 }
 
+static inline u32 perf_flags_from_msr(struct pt_regs *regs)
+{
+	if (regs->msr & MSR_PR)
+		return PERF_RECORD_MISC_USER;
+	if ((regs->msr & MSR_HV) && freeze_events_kernel != MMCR0_FCHV)
+		return PERF_RECORD_MISC_HYPERVISOR;
+	return PERF_RECORD_MISC_KERNEL;
+}
+
 static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 {
 	unsigned long mmcra = regs->dsisr;
 	unsigned long sihv = MMCRA_SIHV;
 	unsigned long sipr = MMCRA_SIPR;
 
+	/* Not a PMU interrupt: Make up flags from regs->msr */
 	if (TRAP(regs) != 0xf00)
-		return 0;	/* not a PMU interrupt */
+		return perf_flags_from_msr(regs);
+
+	/*
+	 * If we don't support continuous sampling and this
+	 * is not a marked event, same deal
+	 */
+	if ((ppmu->flags & PPMU_NO_CONT_SAMPLING) &&
+	    !(mmcra & MMCRA_SAMPLE_ENABLE))
+		return perf_flags_from_msr(regs);
+
+	/*
+	 * If we don't have flags in MMCRA, rather than using
+	 * the MSR, we intuit the flags from the address in
+	 * SIAR which should give slightly more reliable
+	 * results
+	 */
+	if (ppmu->flags & PPMU_NO_SIPR) {
+		unsigned long siar = mfspr(SPRN_SIAR);
+		if (siar >= PAGE_OFFSET)
+			return PERF_RECORD_MISC_KERNEL;
+		return PERF_RECORD_MISC_USER;
+	}
 
 	if (ppmu->flags & PPMU_ALT_SIPR) {
 		sihv = POWER6_MMCRA_SIHV;
@@ -1299,13 +1330,18 @@ unsigned long perf_misc_flags(struct pt_regs *regs)
  */
 unsigned long perf_instruction_pointer(struct pt_regs *regs)
 {
-	unsigned long ip;
+	unsigned long mmcra = regs->dsisr;
 
+	/* Not a PMU interrupt */
 	if (TRAP(regs) != 0xf00)
-		return regs->nip;	/* not a PMU interrupt */
+		return regs->nip;
+
+	/* Processor doesn't support sampling non marked events */
+	if ((ppmu->flags & PPMU_NO_CONT_SAMPLING) &&
+	    !(mmcra & MMCRA_SAMPLE_ENABLE))
+		return regs->nip;
 
-	ip = mfspr(SPRN_SIAR) + perf_ip_adjust(regs);
-	return ip;
+	return mfspr(SPRN_SIAR) + perf_ip_adjust(regs);
 }
 
 static bool pmc_overflow(unsigned long val)
diff --git a/arch/powerpc/perf/power4-pmu.c b/arch/powerpc/perf/power4-pmu.c
index b4f1dda..9103a1d 100644
--- a/arch/powerpc/perf/power4-pmu.c
+++ b/arch/powerpc/perf/power4-pmu.c
@@ -607,6 +607,7 @@ static struct power_pmu power4_pmu = {
 	.n_generic		= ARRAY_SIZE(p4_generic_events),
 	.generic_events		= p4_generic_events,
 	.cache_events		= &power4_cache_events,
+	.flags			= PPMU_NO_SIPR | PPMU_NO_CONT_SAMPLING,
 };
 
 static int __init init_power4_pmu(void)
diff --git a/arch/powerpc/perf/ppc970-pmu.c b/arch/powerpc/perf/ppc970-pmu.c
index 111eb25..20139ce 100644
--- a/arch/powerpc/perf/ppc970-pmu.c
+++ b/arch/powerpc/perf/ppc970-pmu.c
@@ -487,6 +487,7 @@ static struct power_pmu ppc970_pmu = {
 	.n_generic		= ARRAY_SIZE(ppc970_generic_events),
 	.generic_events		= ppc970_generic_events,
 	.cache_events		= &ppc970_cache_events,
+	.flags			= PPMU_NO_SIPR | PPMU_NO_CONT_SAMPLING,
 };
 
 static int __init init_ppc970_pmu(void)
