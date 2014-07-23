Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ACF261A05D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 21:12:50 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/3] powerpc/perf: Pass the struct perf_events down to
 compute_mmcr()
Date: Wed, 23 Jul 2014 21:12:37 +1000
Message-Id: <1406113958-28653-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1406113958-28653-1-git-send-email-mpe@ellerman.id.au>
References: <1406113958-28653-1-git-send-email-mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To support per-event exclude settings on Power8 we need access to the
struct perf_events in compute_mmcr().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/perf_event_server.h | 3 ++-
 arch/powerpc/perf/core-book3s.c              | 2 +-
 arch/powerpc/perf/power4-pmu.c               | 2 +-
 arch/powerpc/perf/power5+-pmu.c              | 2 +-
 arch/powerpc/perf/power5-pmu.c               | 2 +-
 arch/powerpc/perf/power6-pmu.c               | 2 +-
 arch/powerpc/perf/power7-pmu.c               | 2 +-
 arch/powerpc/perf/power8-pmu.c               | 3 ++-
 arch/powerpc/perf/ppc970-pmu.c               | 2 +-
 9 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index b3e936027b26..17b419949036 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -30,7 +30,8 @@ struct power_pmu {
 	unsigned long	add_fields;
 	unsigned long	test_adder;
 	int		(*compute_mmcr)(u64 events[], int n_ev,
-				unsigned int hwc[], unsigned long mmcr[]);
+				unsigned int hwc[], unsigned long mmcr[],
+				struct perf_event *pevents[]);
 	int		(*get_constraint)(u64 event_id, unsigned long *mskp,
 				unsigned long *valp);
 	int		(*get_alternatives)(u64 event_id, unsigned int flags,
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index f82c0973866f..01b30238d7d1 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1224,7 +1224,7 @@ static void power_pmu_enable(struct pmu *pmu)
 	memset(cpuhw->mmcr, 0, sizeof(cpuhw->mmcr));
 
 	if (ppmu->compute_mmcr(cpuhw->events, cpuhw->n_events, hwc_index,
-			       cpuhw->mmcr)) {
+			       cpuhw->mmcr, cpuhw->event)) {
 		/* shouldn't ever get here */
 		printk(KERN_ERR "oops compute_mmcr failed\n");
 		goto out;
diff --git a/arch/powerpc/perf/power4-pmu.c b/arch/powerpc/perf/power4-pmu.c
index 9103a1de864d..ce6072fa481b 100644
--- a/arch/powerpc/perf/power4-pmu.c
+++ b/arch/powerpc/perf/power4-pmu.c
@@ -356,7 +356,7 @@ static int p4_get_alternatives(u64 event, unsigned int flags, u64 alt[])
 }
 
 static int p4_compute_mmcr(u64 event[], int n_ev,
-			   unsigned int hwc[], unsigned long mmcr[])
+			   unsigned int hwc[], unsigned long mmcr[], struct perf_event *pevents[])
 {
 	unsigned long mmcr0 = 0, mmcr1 = 0, mmcra = 0;
 	unsigned int pmc, unit, byte, psel, lower;
diff --git a/arch/powerpc/perf/power5+-pmu.c b/arch/powerpc/perf/power5+-pmu.c
index b03b6dc0172d..0526dac66007 100644
--- a/arch/powerpc/perf/power5+-pmu.c
+++ b/arch/powerpc/perf/power5+-pmu.c
@@ -452,7 +452,7 @@ static int power5p_marked_instr_event(u64 event)
 }
 
 static int power5p_compute_mmcr(u64 event[], int n_ev,
-				unsigned int hwc[], unsigned long mmcr[])
+				unsigned int hwc[], unsigned long mmcr[], struct perf_event *pevents[])
 {
 	unsigned long mmcr1 = 0;
 	unsigned long mmcra = 0;
diff --git a/arch/powerpc/perf/power5-pmu.c b/arch/powerpc/perf/power5-pmu.c
index 1e8ce423c3af..4dc99f9f7962 100644
--- a/arch/powerpc/perf/power5-pmu.c
+++ b/arch/powerpc/perf/power5-pmu.c
@@ -383,7 +383,7 @@ static int power5_marked_instr_event(u64 event)
 }
 
 static int power5_compute_mmcr(u64 event[], int n_ev,
-			       unsigned int hwc[], unsigned long mmcr[])
+			       unsigned int hwc[], unsigned long mmcr[], struct perf_event *pevents[])
 {
 	unsigned long mmcr1 = 0;
 	unsigned long mmcra = MMCRA_SDAR_DCACHE_MISS | MMCRA_SDAR_ERAT_MISS;
diff --git a/arch/powerpc/perf/power6-pmu.c b/arch/powerpc/perf/power6-pmu.c
index 31128e086fed..9c9d646b68a1 100644
--- a/arch/powerpc/perf/power6-pmu.c
+++ b/arch/powerpc/perf/power6-pmu.c
@@ -175,7 +175,7 @@ static int power6_marked_instr_event(u64 event)
  * Assign PMC numbers and compute MMCR1 value for a set of events
  */
 static int p6_compute_mmcr(u64 event[], int n_ev,
-			   unsigned int hwc[], unsigned long mmcr[])
+			   unsigned int hwc[], unsigned long mmcr[], struct perf_event *pevents[])
 {
 	unsigned long mmcr1 = 0;
 	unsigned long mmcra = MMCRA_SDAR_DCACHE_MISS | MMCRA_SDAR_ERAT_MISS;
diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index 56c67bca2f75..5b62f2389290 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -245,7 +245,7 @@ static int power7_marked_instr_event(u64 event)
 }
 
 static int power7_compute_mmcr(u64 event[], int n_ev,
-			       unsigned int hwc[], unsigned long mmcr[])
+			       unsigned int hwc[], unsigned long mmcr[], struct perf_event *pevents[])
 {
 	unsigned long mmcr1 = 0;
 	unsigned long mmcra = MMCRA_SDAR_DCACHE_MISS | MMCRA_SDAR_ERAT_MISS;
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 639cd9156585..19bbddf495dd 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -393,7 +393,8 @@ static int power8_get_constraint(u64 event, unsigned long *maskp, unsigned long
 }
 
 static int power8_compute_mmcr(u64 event[], int n_ev,
-			       unsigned int hwc[], unsigned long mmcr[])
+			       unsigned int hwc[], unsigned long mmcr[],
+			       struct perf_event *pevents[])
 {
 	unsigned long mmcra, mmcr1, unit, combine, psel, cache, val;
 	unsigned int pmc, pmc_inuse;
diff --git a/arch/powerpc/perf/ppc970-pmu.c b/arch/powerpc/perf/ppc970-pmu.c
index 20139ceeacf6..8b6a8a36fa38 100644
--- a/arch/powerpc/perf/ppc970-pmu.c
+++ b/arch/powerpc/perf/ppc970-pmu.c
@@ -257,7 +257,7 @@ static int p970_get_alternatives(u64 event, unsigned int flags, u64 alt[])
 }
 
 static int p970_compute_mmcr(u64 event[], int n_ev,
-			     unsigned int hwc[], unsigned long mmcr[])
+			     unsigned int hwc[], unsigned long mmcr[], struct perf_event *pevents[])
 {
 	unsigned long mmcr0 = 0, mmcr1 = 0, mmcra = 0;
 	unsigned int pmc, unit, byte, psel;
-- 
1.9.1
