Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/5] powerpc/perf: Add BHRB constraint and IFM MMCRA handling
 for EBB
Date: Thu,  6 Mar 2014 17:59:11 +1100
Message-Id: <1394089152-603-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1394089152-603-1-git-send-email-mpe@ellerman.id.au>
References: <1394089152-603-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ymanton@ca.ibm.com, Paul Mackerras <paulus@samba.org>,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want a way for users of EBB (Event Based Branches) to also access the
BHRB (Branch History Rolling Buffer). EBB does not interoperate with our
existing BHRB support, which is wired into the generic Linux branch
stack sampling support.

To support EBB & BHRB we add three new bits to the event code. The first
bit indicates that the event wants access to the BHRB, and the other two
bits indicate the desired IFM (Instruction Filtering Mode).

We allow multiple events to request access to the BHRB, but they must
agree on the IFM value. Events which are not interested in the BHRB can
also interoperate with events which do.

Finally we program the desired IFM value into MMCRA. Although we do this
for every event, we know that the value will be identical for all events
that request BHRB access.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/perf/power8-pmu.c | 53 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 04c1c77..babc3c0 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -62,9 +62,11 @@
  *
  *        60        56        52        48        44        40        36        32
  * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
- *   |                                 [      thresh_cmp     ]   [  thresh_ctl   ]
- *   |                                                                   |
- *   *- EBB (Linux)                      thresh start/stop OR FAB match -*
+ *   | | [ ]                           [      thresh_cmp     ]   [  thresh_ctl   ]
+ *   | |  |                                                              |
+ *   | |  *- IFM (Linux)                 thresh start/stop OR FAB match -*
+ *   | *- BHRB (Linux)
+ *   *- EBB (Linux)
  *
  *        28        24        20        16        12         8         4         0
  * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
@@ -114,10 +116,18 @@
  *	MMCRA[57:59] = sample[0:2]	(RAND_SAMP_ELIG)
  *	MMCRA[61:62] = sample[3:4]	(RAND_SAMP_MODE)
  *
+ * if EBB and BHRB:
+ *	MMCRA[32:33] = IFM
+ *
  */
 
 #define EVENT_EBB_MASK		1ull
 #define EVENT_EBB_SHIFT		PERF_EVENT_CONFIG_EBB_SHIFT
+#define EVENT_BHRB_MASK		1ull
+#define EVENT_BHRB_SHIFT	62
+#define EVENT_WANTS_BHRB	(EVENT_BHRB_MASK << EVENT_BHRB_SHIFT)
+#define EVENT_IFM_MASK		3ull
+#define EVENT_IFM_SHIFT		60
 #define EVENT_THR_CMP_SHIFT	40	/* Threshold CMP value */
 #define EVENT_THR_CMP_MASK	0x3ff
 #define EVENT_THR_CTL_SHIFT	32	/* Threshold control value (start/stop) */
@@ -142,6 +152,12 @@
 #define EVENT_IS_MARKED		(EVENT_MARKED_MASK << EVENT_MARKED_SHIFT)
 #define EVENT_PSEL_MASK		0xff	/* PMCxSEL value */
 
+/* Bits defined by Linux */
+#define EVENT_LINUX_MASK	\
+	((EVENT_EBB_MASK  << EVENT_EBB_SHIFT)			|	\
+	 (EVENT_BHRB_MASK << EVENT_BHRB_SHIFT)			|	\
+	 (EVENT_IFM_MASK  << EVENT_IFM_SHIFT))
+
 #define EVENT_VALID_MASK	\
 	((EVENT_THRESH_MASK    << EVENT_THRESH_SHIFT)		|	\
 	 (EVENT_SAMPLE_MASK    << EVENT_SAMPLE_SHIFT)		|	\
@@ -150,7 +166,7 @@
 	 (EVENT_UNIT_MASK      << EVENT_UNIT_SHIFT)		|	\
 	 (EVENT_COMBINE_MASK   << EVENT_COMBINE_SHIFT)		|	\
 	 (EVENT_MARKED_MASK    << EVENT_MARKED_SHIFT)		|	\
-	 (EVENT_EBB_MASK       << EVENT_EBB_SHIFT)		|	\
+	  EVENT_LINUX_MASK					|	\
 	  EVENT_PSEL_MASK)
 
 /* MMCRA IFM bits - POWER8 */
@@ -174,10 +190,11 @@
  *
  *        28        24        20        16        12         8         4         0
  * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
- *                   |   [ ]   [  sample ]   [     ]   [6] [5]   [4] [3]   [2] [1]
- *              EBB -*    |                     |
- *                        |                     |      Count of events for each PMC.
- *      L1 I/D qualifier -*                     |        p1, p2, p3, p4, p5, p6.
+ *               [ ] |   [ ]   [  sample ]   [     ]   [6] [5]   [4] [3]   [2] [1]
+ *                |  |    |                     |
+ *      BHRB IFM -*  |    |                     |      Count of events for each PMC.
+ *              EBB -*    |                     |        p1, p2, p3, p4, p5, p6.
+ *      L1 I/D qualifier -*                     |
  *                     nc - number of counters -*
  *
  * The PMC fields P1..P6, and NC, are adder fields. As we accumulate constraints
@@ -196,6 +213,9 @@
 #define CNST_EBB_VAL(v)		(((v) & EVENT_EBB_MASK) << 24)
 #define CNST_EBB_MASK		CNST_EBB_VAL(EVENT_EBB_MASK)
 
+#define CNST_IFM_VAL(v)		(((v) & EVENT_IFM_MASK) << 25)
+#define CNST_IFM_MASK		CNST_IFM_VAL(EVENT_IFM_MASK)
+
 #define CNST_L1_QUAL_VAL(v)	(((v) & 3) << 22)
 #define CNST_L1_QUAL_MASK	CNST_L1_QUAL_VAL(3)
 
@@ -242,6 +262,7 @@
 #define MMCRA_THR_SEL_SHIFT		16
 #define MMCRA_THR_CMP_SHIFT		32
 #define MMCRA_SDAR_MODE_TLB		(1ull << 42)
+#define MMCRA_IFM_SHIFT			30
 
 
 static inline bool event_is_fab_match(u64 event)
@@ -275,7 +296,7 @@ static int power8_get_constraint(u64 event, unsigned long *maskp, unsigned long
 			return -1;
 
 		/* Ignore Linux defined bits when checking event below */
-		base_event = event & ~(EVENT_EBB_MASK << EVENT_EBB_SHIFT);
+		base_event = event & ~EVENT_LINUX_MASK;
 
 		if (pmc >= 5 && base_event != 0x500fa && base_event != 0x600f4)
 			return -1;
@@ -345,6 +366,15 @@ static int power8_get_constraint(u64 event, unsigned long *maskp, unsigned long
 		/* EBB events must specify the PMC */
 		return -1;
 
+	if (event & EVENT_WANTS_BHRB) {
+		if (!ebb)
+			/* Only EBB events can request BHRB */
+			return -1;
+
+		mask  |= CNST_IFM_MASK;
+		value |= CNST_IFM_VAL(event >> EVENT_IFM_SHIFT);
+	}
+
 	/*
 	 * All events must agree on EBB, either all request it or none.
 	 * EBB events are pinned & exclusive, so this should never actually
@@ -434,6 +464,11 @@ static int power8_compute_mmcr(u64 event[], int n_ev,
 			mmcra |= val << MMCRA_THR_CMP_SHIFT;
 		}
 
+		if (event[i] & EVENT_WANTS_BHRB) {
+			val = (event[i] >> EVENT_IFM_SHIFT) & EVENT_IFM_MASK;
+			mmcra |= val << MMCRA_IFM_SHIFT;
+		}
+
 		hwc[i] = pmc - 1;
 	}
 
-- 
1.8.3.2
