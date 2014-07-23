Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55DDE1A01E6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 21:12:48 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] powerpc/perf: Clear all MMCR settings before calling
 compute_mmcr()
Date: Wed, 23 Jul 2014 21:12:36 +1000
Message-Id: <1406113958-28653-1-git-send-email-mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Because we reuse cpuhw->mmcr on each call to compute_mmcr() there's a
risk that we could forget to set one of the values and use whatever
value was in there previously.

Currently all the implementations are careful to set all the values, but
it's safer to clear them all before we call compute_mmcr().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/perf/core-book3s.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index fe52db2eea6a..f82c0973866f 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1219,8 +1219,10 @@ static void power_pmu_enable(struct pmu *pmu)
 	}
 
 	/*
-	 * Compute MMCR* values for the new set of events
+	 * Clear all MMCR settings and recompute them for the new set of events.
 	 */
+	memset(cpuhw->mmcr, 0, sizeof(cpuhw->mmcr));
+
 	if (ppmu->compute_mmcr(cpuhw->events, cpuhw->n_events, hwc_index,
 			       cpuhw->mmcr)) {
 		/* shouldn't ever get here */
-- 
1.9.1
