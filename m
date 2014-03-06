Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/5] powerpc/perf: Clean up the EBB hash defines a little
Date: Thu,  6 Mar 2014 17:59:09 +1100
Message-Id: <1394089152-603-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1394089152-603-1-git-send-email-mpe@ellerman.id.au>
References: <1394089152-603-1-git-send-email-mpe@ellerman.id.au>
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

Rather than using PERF_EVENT_CONFIG_EBB_SHIFT everywhere, add an
EVENT_EBB_SHIFT like every other event and use that.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/perf/power8-pmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 96cee20..26905ce 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -117,6 +117,7 @@
  */
 
 #define EVENT_EBB_MASK		1ull
+#define EVENT_EBB_SHIFT		PERF_EVENT_CONFIG_EBB_SHIFT
 #define EVENT_THR_CMP_SHIFT	40	/* Threshold CMP value */
 #define EVENT_THR_CMP_MASK	0x3ff
 #define EVENT_THR_CTL_SHIFT	32	/* Threshold control value (start/stop) */
@@ -149,7 +150,7 @@
 	 (EVENT_UNIT_MASK      << EVENT_UNIT_SHIFT)		|	\
 	 (EVENT_COMBINE_MASK   << EVENT_COMBINE_SHIFT)		|	\
 	 (EVENT_MARKED_MASK    << EVENT_MARKED_SHIFT)		|	\
-	 (EVENT_EBB_MASK       << PERF_EVENT_CONFIG_EBB_SHIFT)	|	\
+	 (EVENT_EBB_MASK       << EVENT_EBB_SHIFT)		|	\
 	  EVENT_PSEL_MASK)
 
 /* MMCRA IFM bits - POWER8 */
@@ -265,10 +266,10 @@ static int power8_get_constraint(u64 event, unsigned long *maskp, unsigned long
 	pmc   = (event >> EVENT_PMC_SHIFT)        & EVENT_PMC_MASK;
 	unit  = (event >> EVENT_UNIT_SHIFT)       & EVENT_UNIT_MASK;
 	cache = (event >> EVENT_CACHE_SEL_SHIFT)  & EVENT_CACHE_SEL_MASK;
-	ebb   = (event >> PERF_EVENT_CONFIG_EBB_SHIFT) & EVENT_EBB_MASK;
+	ebb   = (event >> EVENT_EBB_SHIFT)        & EVENT_EBB_MASK;
 
 	/* Clear the EBB bit in the event, so event checks work below */
-	event &= ~(EVENT_EBB_MASK << PERF_EVENT_CONFIG_EBB_SHIFT);
+	event &= ~(EVENT_EBB_MASK << EVENT_EBB_SHIFT);
 
 	if (pmc) {
 		if (pmc > 6)
-- 
1.8.3.2
