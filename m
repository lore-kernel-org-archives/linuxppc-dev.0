Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/perf: Fix handling of FAB events
Date: Wed,  2 Oct 2013 18:04:06 +1000
Message-Id: <1380701046-8542-1-git-send-email-michael@ellerman.id.au>
Cc: soonair3@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 4df4899 "Add power8 EBB support" included a bug in the handling
of the FAB_CRESP_MATCH and FAB_TYPE_MATCH fields.

These values are pulled out of the event code using EVENT_THR_CTL_SHIFT,
however we were then or'ing that value directly into MMCR1.

This meant we were failing to set the FAB fields correctly, and also
potentially corrupting the value for PMC4SEL. Leading to no counts for
the FAB events and incorrect counts for PMC4.

The fix is simply to shift left the FAB value correctly before or'ing it
with MMCR1.

Reported-by: Sooraj Ravindran Nair <soonair3@in.ibm.com>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Cc: <stable@vger.kernel.org> # 3.10+
---
 arch/powerpc/perf/power8-pmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Ben for 3.13 please.

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 2ee4a70..a3f7abd 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -199,6 +199,7 @@
 #define MMCR1_UNIT_SHIFT(pmc)		(60 - (4 * ((pmc) - 1)))
 #define MMCR1_COMBINE_SHIFT(pmc)	(35 - ((pmc) - 1))
 #define MMCR1_PMCSEL_SHIFT(pmc)		(24 - (((pmc) - 1)) * 8)
+#define MMCR1_FAB_SHIFT			36
 #define MMCR1_DC_QUAL_SHIFT		47
 #define MMCR1_IC_QUAL_SHIFT		46
 
@@ -388,8 +389,8 @@ static int power8_compute_mmcr(u64 event[], int n_ev,
 		 * the threshold bits are used for the match value.
 		 */
 		if (event_is_fab_match(event[i])) {
-			mmcr1 |= (event[i] >> EVENT_THR_CTL_SHIFT) &
-				  EVENT_THR_CTL_MASK;
+			mmcr1 |= ((event[i] >> EVENT_THR_CTL_SHIFT) &
+				  EVENT_THR_CTL_MASK) << MMCR1_FAB_SHIFT;
 		} else {
 			val = (event[i] >> EVENT_THR_CTL_SHIFT) & EVENT_THR_CTL_MASK;
 			mmcra |= val << MMCRA_THR_CTL_SHIFT;
-- 
1.8.1.2
