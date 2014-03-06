Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/5] powerpc/perf: Avoid mutating event in
 power8_get_constraint()
Date: Thu,  6 Mar 2014 17:59:10 +1100
Message-Id: <1394089152-603-3-git-send-email-mpe@ellerman.id.au>
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

We only need to mask the EBB bit out of the event for the check of the
special PMC 5 & 6 events. So use a local to do it just for that code,
rather than changing the event value for the life of the function.

While we're there move the set of mask and value after all the checks.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/perf/power8-pmu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 26905ce..04c1c77 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -268,18 +268,20 @@ static int power8_get_constraint(u64 event, unsigned long *maskp, unsigned long
 	cache = (event >> EVENT_CACHE_SEL_SHIFT)  & EVENT_CACHE_SEL_MASK;
 	ebb   = (event >> EVENT_EBB_SHIFT)        & EVENT_EBB_MASK;
 
-	/* Clear the EBB bit in the event, so event checks work below */
-	event &= ~(EVENT_EBB_MASK << EVENT_EBB_SHIFT);
-
 	if (pmc) {
+		u64 base_event;
+
 		if (pmc > 6)
 			return -1;
 
-		mask  |= CNST_PMC_MASK(pmc);
-		value |= CNST_PMC_VAL(pmc);
+		/* Ignore Linux defined bits when checking event below */
+		base_event = event & ~(EVENT_EBB_MASK << EVENT_EBB_SHIFT);
 
-		if (pmc >= 5 && event != 0x500fa && event != 0x600f4)
+		if (pmc >= 5 && base_event != 0x500fa && base_event != 0x600f4)
 			return -1;
+
+		mask  |= CNST_PMC_MASK(pmc);
+		value |= CNST_PMC_VAL(pmc);
 	}
 
 	if (pmc <= 4) {
-- 
1.8.3.2
