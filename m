Return-Path: <alexandru.sardan@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8AFF1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 19:15:18 +1000 (EST)
From: Alexandru-Cezar Sardan <alexandru.sardan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] perf/powerpc: reset event hw state when adding it to the PMU
Date: Thu, 26 Jun 2014 11:58:58 +0300
Message-ID: <1403773138-7558-1-git-send-email-alexandru.sardan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Alexandru-Cezar Sardan <alexandru.sardan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When adding an event to the PMU with PERF_EF_START the STOPPED and UPTODATE
flags need to be cleared in the hw.event status variable because they are
preventing the update of the event count on overflow interrupt.

Signed-off-by: Alexandru-Cezar Sardan <alexandru.sardan@freescale.com>
---
 arch/powerpc/perf/core-fsl-emb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index d35ae52..ef2ce48 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -330,9 +330,11 @@ static int fsl_emb_pmu_add(struct perf_event *event, int flags)
 	}
 	local64_set(&event->hw.prev_count, val);
 
-	if (!(flags & PERF_EF_START)) {
+	if (unlikely(!(flags & PERF_EF_START))) {
 		event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
 		val = 0;
+	} else {
+		event->hw.state &= ~(PERF_HES_STOPPED | PERF_HES_UPTODATE);
 	}
 
 	write_pmc(i, val);
-- 
1.7.9.5
