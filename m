Return-Path: <tom.huynh@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0115.outbound.protection.outlook.com [65.55.169.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39D511A083B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 09:55:28 +1100 (AEDT)
From: Tom Huynh <tom.huynh@freescale.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <cl@linux.com>, <tj@kernel.org>
Subject: [PATCH] powerpc/perf: fix fsl_emb_pmu_start to write correct pmc value
Date: Tue, 20 Jan 2015 16:19:50 -0600
Message-ID: <1421792390-2400-1-git-send-email-tom.huynh@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tom Huynh <tom.huynh@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PMCs on PowerPC increases towards 0x80000000 and triggers an overflow
interrupt when the msb is set to collect a sample. Therefore, to setup
for the next sample collection, pmu_start should set the pmc value to
0x80000000 - left instead of left which incorrectly delays the next
overflow interrupt. Same as commit 9a45a9407c69 ("powerpc/perf:
power_pmu_start restores incorrect values, breaking frequency events")
for book3s.

Signed-off-by: Tom Huynh <tom.huynh@freescale.com>
---
 arch/powerpc/perf/core-fsl-emb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index 4acaea0..e9fe904 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -389,6 +389,7 @@ static void fsl_emb_pmu_del(struct perf_event *event, int flags)
 static void fsl_emb_pmu_start(struct perf_event *event, int ef_flags)
 {
 	unsigned long flags;
+	unsigned long val;
 	s64 left;
 
 	if (event->hw.idx < 0 || !event->hw.sample_period)
@@ -405,7 +406,10 @@ static void fsl_emb_pmu_start(struct perf_event *event, int ef_flags)
 
 	event->hw.state = 0;
 	left = local64_read(&event->hw.period_left);
-	write_pmc(event->hw.idx, left);
+	val = 0;
+	if (left < 0x80000000L)
+		val = 0x80000000L - left;
+	write_pmc(event->hw.idx, val);
 
 	perf_event_update_userpage(event);
 	perf_pmu_enable(event->pmu);
-- 
1.9.1
