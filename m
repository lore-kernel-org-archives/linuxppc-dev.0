Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/7] powerpc/perf: Add an explict flag indicating presence of
 SLOT field
Date: Fri, 26 Apr 2013 15:28:23 +1000
Message-Id: <1366954108-27081-2-git-send-email-michael@ellerman.id.au>
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

In perf_ip_adjust() we potentially use the MMCRA[SLOT] field to adjust
the reported IP of a sampled instruction.

Currently the logic is written so that if the backend does NOT have
the PPMU_ALT_SIPR flag set then we assume MMCRA[SLOT] exists.

However on power8 we do not want to set ALT_SIPR (it's in a third
location), and we also do not have MMCRA[SLOT].

So add a new flag which only indicates whether MMCRA[SLOT] exists.

Naively we'd set it on everything except power6/7, because they set
ALT_SIPR, and we've reversed the polarity of the flag. But it's more
complicated than that.

mpc7450 is 32-bit, and uses its own version of perf_ip_adjust()
which doesn't use MMCRA[SLOT], so it doesn't need the new flag set and
the behaviour is unchanged.

PPC970 (and I assume power4) don't have MMCRA[SLOT], so shouldn't have
the new flag set. This is a behaviour change on those cpus, though we
were probably getting lucky and the bits in question were 0.

power5 and power5+ set the new flag, behaviour unchanged.

power6 & power7 do not set the new flag, behaviour unchanged.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/perf_event_server.h |    1 +
 arch/powerpc/perf/core-book3s.c              |    3 ++-
 arch/powerpc/perf/power5+-pmu.c              |    2 +-
 arch/powerpc/perf/power5-pmu.c               |    1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index d0aec72..7074aec 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -52,6 +52,7 @@ struct power_pmu {
 #define PPMU_NO_SIPR		0x00000004 /* no SIPR/HV in MMCRA at all */
 #define PPMU_NO_CONT_SAMPLING	0x00000008 /* no continuous sampling */
 #define PPMU_SIAR_VALID		0x00000010 /* Processor has SIAR Valid bit */
+#define PPMU_HAS_SSLOT		0x00000020 /* Has sampled slot in MMCRA */
 
 /*
  * Values for flags to get_alternatives()
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 65362e9..eb64480 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -98,11 +98,12 @@ static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
 {
 	unsigned long mmcra = regs->dsisr;
 
-	if ((mmcra & MMCRA_SAMPLE_ENABLE) && !(ppmu->flags & PPMU_ALT_SIPR)) {
+	if ((ppmu->flags & PPMU_HAS_SSLOT) && (mmcra & MMCRA_SAMPLE_ENABLE)) {
 		unsigned long slot = (mmcra & MMCRA_SLOT) >> MMCRA_SLOT_SHIFT;
 		if (slot > 1)
 			return 4 * (slot - 1);
 	}
+
 	return 0;
 }
 
diff --git a/arch/powerpc/perf/power5+-pmu.c b/arch/powerpc/perf/power5+-pmu.c
index a8757ba..b03b6dc 100644
--- a/arch/powerpc/perf/power5+-pmu.c
+++ b/arch/powerpc/perf/power5+-pmu.c
@@ -671,7 +671,7 @@ static struct power_pmu power5p_pmu = {
 	.get_alternatives	= power5p_get_alternatives,
 	.disable_pmc		= power5p_disable_pmc,
 	.limited_pmc_event	= power5p_limited_pmc_event,
-	.flags			= PPMU_LIMITED_PMC5_6,
+	.flags			= PPMU_LIMITED_PMC5_6 | PPMU_HAS_SSLOT,
 	.n_generic		= ARRAY_SIZE(power5p_generic_events),
 	.generic_events		= power5p_generic_events,
 	.cache_events		= &power5p_cache_events,
diff --git a/arch/powerpc/perf/power5-pmu.c b/arch/powerpc/perf/power5-pmu.c
index e7f06eb..1e8ce42 100644
--- a/arch/powerpc/perf/power5-pmu.c
+++ b/arch/powerpc/perf/power5-pmu.c
@@ -615,6 +615,7 @@ static struct power_pmu power5_pmu = {
 	.n_generic		= ARRAY_SIZE(power5_generic_events),
 	.generic_events		= power5_generic_events,
 	.cache_events		= &power5_cache_events,
+	.flags			= PPMU_HAS_SSLOT,
 };
 
 static int __init init_power5_pmu(void)
-- 
1.7.10.4
