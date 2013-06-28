Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 8/9] powerpc/perf: Add power8 EBB support
Date: Fri, 28 Jun 2013 18:15:17 +1000
Message-Id: <1372407319-718-8-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1372407319-718-1-git-send-email-michael@ellerman.id.au>
References: <1372407319-718-1-git-send-email-michael@ellerman.id.au>
Cc: sukadev@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add logic to the power8 PMU code to support EBB. Future processors would
also be expected to implement similar constraints. At that time we could
possibly factor these out into common code.

Finally mark the power8 PMU as supporting EBB, which is the actual
enable switch which allows EBBs to be configured.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
v2: Use EVENT_EBB_MASK
---
 arch/powerpc/perf/power8-pmu.c |   45 +++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index d59f5b2..96a64d6 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -31,9 +31,9 @@
  *
  *        60        56        52        48        44        40        36        32
  * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
- *                                     [      thresh_cmp     ]   [  thresh_ctl   ]
- *                                                                       |
- *                                       thresh start/stop OR FAB match -*
+ *   |                                 [      thresh_cmp     ]   [  thresh_ctl   ]
+ *   |                                                                   |
+ *   *- EBB (Linux)                      thresh start/stop OR FAB match -*
  *
  *        28        24        20        16        12         8         4         0
  * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
@@ -85,6 +85,7 @@
  *
  */
 
+#define EVENT_EBB_MASK		1ull
 #define EVENT_THR_CMP_SHIFT	40	/* Threshold CMP value */
 #define EVENT_THR_CMP_MASK	0x3ff
 #define EVENT_THR_CTL_SHIFT	32	/* Threshold control value (start/stop) */
@@ -117,6 +118,7 @@
 	 (EVENT_UNIT_MASK      << EVENT_UNIT_SHIFT)		|	\
 	 (EVENT_COMBINE_MASK   << EVENT_COMBINE_SHIFT)		|	\
 	 (EVENT_MARKED_MASK    << EVENT_MARKED_SHIFT)		|	\
+	 (EVENT_EBB_MASK       << EVENT_CONFIG_EBB_SHIFT)	|	\
 	  EVENT_PSEL_MASK)
 
 /* MMCRA IFM bits - POWER8 */
@@ -140,10 +142,10 @@
  *
  *        28        24        20        16        12         8         4         0
  * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
- *                       [ ]   [  sample ]   [     ]   [6] [5]   [4] [3]   [2] [1]
- *                        |                     |
- *      L1 I/D qualifier -*                     |      Count of events for each PMC.
- *                                              |        p1, p2, p3, p4, p5, p6.
+ *                   |   [ ]   [  sample ]   [     ]   [6] [5]   [4] [3]   [2] [1]
+ *              EBB -*    |                     |
+ *                        |                     |      Count of events for each PMC.
+ *      L1 I/D qualifier -*                     |        p1, p2, p3, p4, p5, p6.
  *                     nc - number of counters -*
  *
  * The PMC fields P1..P6, and NC, are adder fields. As we accumulate constraints
@@ -159,6 +161,9 @@
 #define CNST_THRESH_VAL(v)	(((v) & EVENT_THRESH_MASK) << 32)
 #define CNST_THRESH_MASK	CNST_THRESH_VAL(EVENT_THRESH_MASK)
 
+#define CNST_EBB_VAL(v)		(((v) & EVENT_EBB_MASK) << 24)
+#define CNST_EBB_MASK		CNST_EBB_VAL(EVENT_EBB_MASK)
+
 #define CNST_L1_QUAL_VAL(v)	(((v) & 3) << 22)
 #define CNST_L1_QUAL_MASK	CNST_L1_QUAL_VAL(3)
 
@@ -217,7 +222,7 @@ static inline bool event_is_fab_match(u64 event)
 
 static int power8_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp)
 {
-	unsigned int unit, pmc, cache;
+	unsigned int unit, pmc, cache, ebb;
 	unsigned long mask, value;
 
 	mask = value = 0;
@@ -225,9 +230,13 @@ static int power8_get_constraint(u64 event, unsigned long *maskp, unsigned long
 	if (event & ~EVENT_VALID_MASK)
 		return -1;
 
-	pmc   = (event >> EVENT_PMC_SHIFT)       & EVENT_PMC_MASK;
-	unit  = (event >> EVENT_UNIT_SHIFT)      & EVENT_UNIT_MASK;
-	cache = (event >> EVENT_CACHE_SEL_SHIFT) & EVENT_CACHE_SEL_MASK;
+	pmc   = (event >> EVENT_PMC_SHIFT)        & EVENT_PMC_MASK;
+	unit  = (event >> EVENT_UNIT_SHIFT)       & EVENT_UNIT_MASK;
+	cache = (event >> EVENT_CACHE_SEL_SHIFT)  & EVENT_CACHE_SEL_MASK;
+	ebb   = (event >> EVENT_CONFIG_EBB_SHIFT) & EVENT_EBB_MASK;
+
+	/* Clear the EBB bit in the event, so event checks work below */
+	event &= ~(EVENT_EBB_MASK << EVENT_CONFIG_EBB_SHIFT);
 
 	if (pmc) {
 		if (pmc > 6)
@@ -297,6 +306,18 @@ static int power8_get_constraint(u64 event, unsigned long *maskp, unsigned long
 		value |= CNST_THRESH_VAL(event >> EVENT_THRESH_SHIFT);
 	}
 
+	if (!pmc && ebb)
+		/* EBB events must specify the PMC */
+		return -1;
+
+	/*
+	 * All events must agree on EBB, either all request it or none.
+	 * EBB events are pinned & exclusive, so this should never actually
+	 * hit, but we leave it as a fallback in case.
+	 */
+	mask  |= CNST_EBB_VAL(ebb);
+	value |= CNST_EBB_MASK;
+
 	*maskp = mask;
 	*valp = value;
 
@@ -591,7 +612,7 @@ static struct power_pmu power8_pmu = {
 	.get_constraint		= power8_get_constraint,
 	.get_alternatives	= power8_get_alternatives,
 	.disable_pmc		= power8_disable_pmc,
-	.flags			= PPMU_HAS_SSLOT | PPMU_HAS_SIER | PPMU_BHRB,
+	.flags			= PPMU_HAS_SSLOT | PPMU_HAS_SIER | PPMU_BHRB | PPMU_EBB,
 	.n_generic		= ARRAY_SIZE(power8_generic_events),
 	.generic_events		= power8_generic_events,
 	.attr_groups		= power8_pmu_attr_groups,
-- 
1.7.10.4
