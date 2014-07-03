Return-Path: <joel@jms.id.au>
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com
 [IPv6:2607:f8b0:400e:c02::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5BE31A00D8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 16:12:54 +1000 (EST)
Received: by mail-pd0-f172.google.com with SMTP id w10so13259375pde.31
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Jul 2014 23:12:52 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: paulus@samba.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [PATCH 2/3] powerpc/perf: Add PPMU_ARCH_207S define
Date: Thu,  3 Jul 2014 15:42:35 +0930
Message-Id: <1404367956-19515-3-git-send-email-joel@jms.id.au>
In-Reply-To: <1404367956-19515-1-git-send-email-joel@jms.id.au>
References: <1404367956-19515-1-git-send-email-joel@jms.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of separate bits for every POWER8 PMU feature, have a single one
for v2.07 of the architecture.

This saves us adding a MMCR2 define for a future patch.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/include/asm/perf_event_server.h | 3 +--
 arch/powerpc/perf/core-book3s.c              | 6 +++---
 arch/powerpc/perf/power8-pmu.c               | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 9ed73714..b3e9360 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -61,8 +61,7 @@ struct power_pmu {
 #define PPMU_SIAR_VALID		0x00000010 /* Processor has SIAR Valid bit */
 #define PPMU_HAS_SSLOT		0x00000020 /* Has sampled slot in MMCRA */
 #define PPMU_HAS_SIER		0x00000040 /* Has SIER */
-#define PPMU_BHRB		0x00000080 /* has BHRB feature enabled */
-#define PPMU_EBB		0x00000100 /* supports event based branch */
+#define PPMU_ARCH_207S		0x00000080 /* PMC is architecture v2.07S */
 
 /*
  * Values for flags to get_alternatives()
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 4520c93..a2ff1bd 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -485,7 +485,7 @@ static bool is_ebb_event(struct perf_event *event)
 	 * check that the PMU supports EBB, meaning those that don't can still
 	 * use bit 63 of the event code for something else if they wish.
 	 */
-	return (ppmu->flags & PPMU_EBB) &&
+	return (ppmu->flags & PPMU_ARCH_207S) &&
 	       ((event->attr.config >> PERF_EVENT_CONFIG_EBB_SHIFT) & 1);
 }
 
@@ -777,7 +777,7 @@ void perf_event_print_debug(void)
 	if (ppmu->flags & PPMU_HAS_SIER)
 		sier = mfspr(SPRN_SIER);
 
-	if (ppmu->flags & PPMU_EBB) {
+	if (ppmu->flags & PPMU_ARCH_207S) {
 		pr_info("MMCR2: %016lx EBBHR: %016lx\n",
 			mfspr(SPRN_MMCR2), mfspr(SPRN_EBBHR));
 		pr_info("EBBRR: %016lx BESCR: %016lx\n",
@@ -1696,7 +1696,7 @@ static int power_pmu_event_init(struct perf_event *event)
 
 	if (has_branch_stack(event)) {
 	        /* PMU has BHRB enabled */
-		if (!(ppmu->flags & PPMU_BHRB))
+		if (!(ppmu->flags & PPMU_ARCH_207S))
 			return -EOPNOTSUPP;
 	}
 
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index fe2763b..639cd91 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -792,7 +792,7 @@ static struct power_pmu power8_pmu = {
 	.get_constraint		= power8_get_constraint,
 	.get_alternatives	= power8_get_alternatives,
 	.disable_pmc		= power8_disable_pmc,
-	.flags			= PPMU_HAS_SSLOT | PPMU_HAS_SIER | PPMU_BHRB | PPMU_EBB,
+	.flags			= PPMU_HAS_SSLOT | PPMU_HAS_SIER | PPMU_ARCH_207S,
 	.n_generic		= ARRAY_SIZE(power8_generic_events),
 	.generic_events		= power8_generic_events,
 	.cache_events		= &power8_cache_events,
-- 
2.0.0
