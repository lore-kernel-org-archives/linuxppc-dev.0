Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/8] powerpc/perf: Check that events only include valid bits
 on Power8
Date: Mon, 24 Jun 2013 21:28:49 +1000
Message-Id: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
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

A mistake we have made in the past is that we pull out the fields we
need from the event code, but don't check that there are no unknown bits
set. This means that we can't ever assign meaning to those unknown bits
in future.

Although we have once again failed to do this at release, it is still
early days for Power8 so I think we can still slip this in and get away
with it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/perf/power8-pmu.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index f7d1c4f..84cdc6d 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -109,6 +109,16 @@
 #define EVENT_IS_MARKED		(EVENT_MARKED_MASK << EVENT_MARKED_SHIFT)
 #define EVENT_PSEL_MASK		0xff	/* PMCxSEL value */
 
+#define EVENT_VALID_MASK	\
+	((EVENT_THRESH_MASK    << EVENT_THRESH_SHIFT)		|	\
+	 (EVENT_SAMPLE_MASK    << EVENT_SAMPLE_SHIFT)		|	\
+	 (EVENT_CACHE_SEL_MASK << EVENT_CACHE_SEL_SHIFT)	|	\
+	 (EVENT_PMC_MASK       << EVENT_PMC_SHIFT)		|	\
+	 (EVENT_UNIT_MASK      << EVENT_UNIT_SHIFT)		|	\
+	 (EVENT_COMBINE_MASK   << EVENT_COMBINE_SHIFT)		|	\
+	 (EVENT_MARKED_MASK    << EVENT_MARKED_SHIFT)		|	\
+	  EVENT_PSEL_MASK)
+
 /* MMCRA IFM bits - POWER8 */
 #define	POWER8_MMCRA_IFM1		0x0000000040000000UL
 #define	POWER8_MMCRA_IFM2		0x0000000080000000UL
@@ -212,6 +222,9 @@ static int power8_get_constraint(u64 event, unsigned long *maskp, unsigned long
 
 	mask = value = 0;
 
+	if (event & ~EVENT_VALID_MASK)
+		return -1;
+
 	pmc   = (event >> EVENT_PMC_SHIFT)       & EVENT_PMC_MASK;
 	unit  = (event >> EVENT_UNIT_SHIFT)      & EVENT_UNIT_MASK;
 	cache = (event >> EVENT_CACHE_SEL_SHIFT) & EVENT_CACHE_SEL_MASK;
-- 
1.7.10.4
