Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A4601A01E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 17:20:12 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/perf: Fix MMCR2 handling for EBB
Date: Wed, 23 Jul 2014 17:20:04 +1000
Message-Id: <1406100004-8776-1-git-send-email-mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, joel@jms.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the recent commit b50a6c584bb4 "Clear MMCR2 when enabling PMU", I
screwed up the handling of MMCR2 for tasks using EBB.

We must make sure we set MMCR2 *before* ebb_switch_in(), otherwise we
overwrite the value of MMCR2 that userspace may have written. That
potentially breaks a task that uses EBB and manually uses MMCR2 for
event freezing.

Fixes: b50a6c584bb4 ("powerpc/perf: Clear MMCR2 when enabling PMU")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/perf/core-book3s.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 6b0641c3f03f..fe52db2eea6a 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1307,6 +1307,9 @@ static void power_pmu_enable(struct pmu *pmu)
  out_enable:
 	pmao_restore_workaround(ebb);
 
+	if (ppmu->flags & PPMU_ARCH_207S)
+		mtspr(SPRN_MMCR2, 0);
+
 	mmcr0 = ebb_switch_in(ebb, cpuhw->mmcr[0]);
 
 	mb();
@@ -1315,9 +1318,6 @@ static void power_pmu_enable(struct pmu *pmu)
 
 	write_mmcr0(cpuhw, mmcr0);
 
-	if (ppmu->flags & PPMU_ARCH_207S)
-		mtspr(SPRN_MMCR2, 0);
-
 	/*
 	 * Enable instruction sampling if necessary
 	 */
-- 
1.9.1
