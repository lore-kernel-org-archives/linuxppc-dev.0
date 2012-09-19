Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 324292C0085
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2012 16:55:36 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 19 Sep 2012 02:55:32 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8J6tUmO177958
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2012 02:55:30 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8J6tTGh012961
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2012 03:55:29 -0300
Date: Tue, 18 Sep 2012 23:56:11 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH][v4]: powerpc/perf: Sample only if SIAR-Valid bit is set in P7+
Message-ID: <20120919065611.GA5907@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
 cel@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/perf: Sample only if SIAR-Valid bit is set in P7+

On POWER7+ two new bits (mmcra[35] and mmcra[36]) indicate whether the
contents of SIAR and SDAR are valid.

For marked instructions on P7+, we must save the contents of SIAR and
SDAR registers only if these new bits are set.

This code/check for the SIAR-Valid bit is specific to P7+, so rather than
waste a CPU-feature bit use the PVR flag.

Note that Carl Love proposed a similar change for oprofile:

        https://lkml.org/lkml/2012/6/22/309

Changelog [v4]:
	- Port to powerpc/next branch - where PV_POWER7p is now PVR_POWER7p
	  and __is_processor() is now pvr_version_is()
	- Ensure patch doesn't break 32-bit build.

Changelog[v3]:
	- Commit 5c093efa6f2 added checks to use SIAR only for kernel samples.
	  Extend that to use SIAR only if SIAR-valid bit is set (in processors
	  that implement that bit).

Changelog[v2]:
	- [Gabriel Paubert] Rename PV_POWER7P to PV_POWER7p.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h |    1 +
 arch/powerpc/include/asm/reg.h               |    4 ++
 arch/powerpc/perf/core-book3s.c              |   44 ++++++++++++++++++++++---
 arch/powerpc/perf/power7-pmu.c               |    3 ++
 4 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 078019b..9710be3 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -49,6 +49,7 @@ struct power_pmu {
 #define PPMU_ALT_SIPR		2	/* uses alternate posn for SIPR/HV */
 #define PPMU_NO_SIPR		4	/* no SIPR/HV in MMCRA at all */
 #define PPMU_NO_CONT_SAMPLING	8	/* no continuous sampling */
+#define PPMU_SIAR_VALID		16	/* Processor has SIAR Valid bit */
 
 /*
  * Values for flags to get_alternatives()
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index a1096fb..d24c141 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -606,6 +606,10 @@
 #define   POWER6_MMCRA_SIPR   0x0000020000000000ULL
 #define   POWER6_MMCRA_THRM	0x00000020UL
 #define   POWER6_MMCRA_OTHER	0x0000000EUL
+
+#define   POWER7P_MMCRA_SIAR_VALID 0x10000000	/* P7+ SIAR contents valid */
+#define   POWER7P_MMCRA_SDAR_VALID 0x08000000	/* P7+ SDAR contents valid */
+
 #define SPRN_PMC1	787
 #define SPRN_PMC2	788
 #define SPRN_PMC3	789
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index fb55da9..0db88f5 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -82,6 +82,11 @@ static inline int perf_intr_is_nmi(struct pt_regs *regs)
 	return 0;
 }
 
+static inline int siar_valid(struct pt_regs *regs)
+{
+	return 1;
+}
+
 #endif /* CONFIG_PPC32 */
 
 /*
@@ -106,14 +111,20 @@ static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
  * If we're not doing instruction sampling, give them the SDAR
  * (sampled data address).  If we are doing instruction sampling, then
  * only give them the SDAR if it corresponds to the instruction
- * pointed to by SIAR; this is indicated by the [POWER6_]MMCRA_SDSYNC
- * bit in MMCRA.
+ * pointed to by SIAR; this is indicated by the [POWER6_]MMCRA_SDSYNC or
+ * the [POWER7P_]MMCRA_SDAR_VALID bit in MMCRA.
  */
 static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
 {
 	unsigned long mmcra = regs->dsisr;
-	unsigned long sdsync = (ppmu->flags & PPMU_ALT_SIPR) ?
-		POWER6_MMCRA_SDSYNC : MMCRA_SDSYNC;
+	unsigned long sdsync;
+
+	if (ppmu->flags & PPMU_SIAR_VALID)
+		sdsync = POWER7P_MMCRA_SDAR_VALID;
+	else if (ppmu->flags & PPMU_ALT_SIPR)
+		sdsync = POWER6_MMCRA_SDSYNC;
+	else
+		sdsync = MMCRA_SDSYNC;
 
 	if (!(mmcra & MMCRA_SAMPLE_ENABLE) || (mmcra & sdsync))
 		*addrp = mfspr(SPRN_SDAR);
@@ -230,6 +241,24 @@ static inline int perf_intr_is_nmi(struct pt_regs *regs)
 	return !regs->softe;
 }
 
+/*
+ * On processors like P7+ that have the SIAR-Valid bit, marked instructions
+ * must be sampled only if the SIAR-valid bit is set.
+ *
+ * For unmarked instructions and for processors that don't have the SIAR-Valid
+ * bit, assume that SIAR is valid.
+ */
+static inline int siar_valid(struct pt_regs *regs)
+{
+	unsigned long mmcra = regs->dsisr;
+	int marked = mmcra & MMCRA_SAMPLE_ENABLE;
+
+	if ((ppmu->flags & PPMU_SIAR_VALID) && marked)
+		return mmcra & POWER7P_MMCRA_SIAR_VALID;
+
+	return 1;
+}
+
 #endif /* CONFIG_PPC64 */
 
 static void perf_event_interrupt(struct pt_regs *regs);
@@ -1291,6 +1320,7 @@ struct pmu power_pmu = {
 	.event_idx	= power_pmu_event_idx,
 };
 
+
 /*
  * A counter has overflowed; update its count and record
  * things if requested.  Note that interrupts are hard-disabled
@@ -1324,7 +1354,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			left += period;
 			if (left <= 0)
 				left = period;
-			record = 1;
+			record = siar_valid(regs);
 			event->hw.last_period = event->hw.sample_period;
 		}
 		if (left < 0x80000000LL)
@@ -1374,8 +1404,10 @@ unsigned long perf_instruction_pointer(struct pt_regs *regs)
 {
 	unsigned long use_siar = regs->result;
 
-	if (use_siar)
+	if (use_siar && siar_valid(regs))
 		return mfspr(SPRN_SIAR) + perf_ip_adjust(regs);
+	else if (use_siar)
+		return 0;		// no valid instruction pointer
 	else
 		return regs->nip;
 }
diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index 1251e4d..441af08 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -373,6 +373,9 @@ static int __init init_power7_pmu(void)
 	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power7"))
 		return -ENODEV;
 
+	if (pvr_version_is(PVR_POWER7p))
+		power7_pmu.flags |= PPMU_SIAR_VALID;
+
 	return register_power_pmu(&power7_pmu);
 }
 
-- 
1.7.1
