Return-Path: <B44306@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 73BE82C02BB
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 06:01:45 +1000 (EST)
Received: from mail45-am1 (localhost [127.0.0.1])	by mail45-am1-R.bigfish.com
 (Postfix) with ESMTP id 396392A0487	for <linuxppc-dev@ozlabs.org>;
 Wed,  5 Jun 2013 20:01:41 +0000 (UTC)
Received: from AM1EHSMHS020.bigfish.com (unknown [10.3.201.243])	by
 mail45-am1.bigfish.com (Postfix) with ESMTP id 36A42C00A9	for
 <linuxppc-dev@ozlabs.org>; Wed,  5 Jun 2013 20:01:39 +0000 (UTC)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/4] powerpc/perf: increase the perf HW events to 6
Date: Wed, 5 Jun 2013 15:01:33 -0500
Message-ID: <1370462495-30054-2-git-send-email-Lijun.Pan@freescale.com>
In-Reply-To: <1370462495-30054-1-git-send-email-Lijun.Pan@freescale.com>
References: <1370462495-30054-1-git-send-email-Lijun.Pan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Lijun.Pan@freescale.com, Catalin Udma <catalin.udma@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Catalin Udma <catalin.udma@freescale.com>

This change is required after the e6500 perf support has been added.
There are 6 counters in e6500 core instead of 4 in e500 core and
the MAX_HWEVENTS counter should be changed accordingly from 4 to 6.
Added also runtime check for counters overflow.

Signed-off-by: Catalin Udma <catalin.udma@freescale.com>
Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
---
 arch/powerpc/include/asm/perf_event_fsl_emb.h |    2 +-
 arch/powerpc/perf/core-fsl-emb.c              |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/perf_event_fsl_emb.h b/arch/powerpc/include/asm/perf_event_fsl_emb.h
index 718a9fa..a581654 100644
--- a/arch/powerpc/include/asm/perf_event_fsl_emb.h
+++ b/arch/powerpc/include/asm/perf_event_fsl_emb.h
@@ -13,7 +13,7 @@
 #include <linux/types.h>
 #include <asm/hw_irq.h>
 
-#define MAX_HWEVENTS 4
+#define MAX_HWEVENTS 6
 
 /* event flags */
 #define FSL_EMB_EVENT_VALID      1
diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index 106c533..0b13f74 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -462,6 +462,12 @@ static int fsl_emb_pmu_event_init(struct perf_event *event)
 	int num_restricted;
 	int i;
 
+	if (ppmu->n_counter > MAX_HWEVENTS) {
+		WARN(1, "No. of perf counters (%d) is higher than max array size(%d)\n",
+			ppmu->n_counter, MAX_HWEVENTS);
+		ppmu->n_counter = MAX_HWEVENTS;
+	}
+
 	switch (event->attr.type) {
 	case PERF_TYPE_HARDWARE:
 		ev = event->attr.config;
-- 
1.7.9.7
