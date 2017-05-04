Return-Path: <karim.eshapa@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJN8p6kzfzDqCv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 14:58:50 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id z129so785886wmb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 May 2017 21:58:50 -0700 (PDT)
From: Karim Eshapa <karim.eshapa@gmail.com>
To: oss@buserror.net
Cc: claudiu.manoil@nxp.com, roy.pledge@nxp.com, colin.king@canonical.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH v2] drivers:soc:fsl:qbman:qman.c: Sleep instead of stuck
 hacking jiffies.
Date: Thu,  4 May 2017 06:58:37 +0200
Message-Id: <1493873917-7484-1-git-send-email-karim.eshapa@gmail.com>
In-Reply-To: <1493508775.25397.26.camel@buserror.net>
References: <1493508775.25397.26.camel@buserror.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avoid stuck and hacking jiffies for a long time and using msleep()
for certatin numeber of cylces without the factor of safety
but using the the long delay considering the factor of safety
with the while loop such that after msleep for a short period
of time we check the  msg if it's OK, breaking the big loop delay.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/soc/fsl/qbman/qman.c | 47 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 6f509f6..4f99298 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1067,32 +1067,33 @@ static irqreturn_t portal_isr(int irq, void *ptr)
 static int drain_mr_fqrni(struct qm_portal *p)
 {
 	const union qm_mr_entry *msg;
+	unsigned long stop;
+	unsigned int timeout = jiffies_to_msecs(1000);
 loop:
 	msg = qm_mr_current(p);
-	if (!msg) {
-		/*
-		 * if MR was full and h/w had other FQRNI entries to produce, we
-		 * need to allow it time to produce those entries once the
-		 * existing entries are consumed. A worst-case situation
-		 * (fully-loaded system) means h/w sequencers may have to do 3-4
-		 * other things before servicing the portal's MR pump, each of
-		 * which (if slow) may take ~50 qman cycles (which is ~200
-		 * processor cycles). So rounding up and then multiplying this
-		 * worst-case estimate by a factor of 10, just to be
-		 * ultra-paranoid, goes as high as 10,000 cycles. NB, we consume
-		 * one entry at a time, so h/w has an opportunity to produce new
-		 * entries well before the ring has been fully consumed, so
-		 * we're being *really* paranoid here.
-		 */
-		u64 now, then = jiffies;
-
-		do {
-			now = jiffies;
-		} while ((then + 10000) > now);
+	stop = jiffies + 10000;
+	/*
+	 * if MR was full and h/w had other FQRNI entries to produce, we
+	 * need to allow it time to produce those entries once the
+	 * existing entries are consumed. A worst-case situation
+	 * (fully-loaded system) means h/w sequencers may have to do 3-4
+	 * other things before servicing the portal's MR pump, each of
+	 * which (if slow) may take ~50 qman cycles (which is ~200
+	 * processor cycles). So rounding up and then multiplying this
+	 * worst-case estimate by a factor of 10, just to be
+	 * ultra-paranoid, goes as high as 10,000 cycles. NB, we consume
+	 * one entry at a time, so h/w has an opportunity to produce new
+	 * entries well before the ring has been fully consumed, so
+	 * we're being *really* paranoid here.
+	 */
+	do {
+		if (msg)
+			break;
+		msleep(timeout);
 		msg = qm_mr_current(p);
-		if (!msg)
-			return 0;
-	}
+	} while (time_before(jiffies, stop));
+	if (!msg)
+		return 0;
 	if ((msg->verb & QM_MR_VERB_TYPE_MASK) != QM_MR_VERB_FQRNI) {
 		/* We aren't draining anything but FQRNIs */
 		pr_err("Found verb 0x%x in MR\n", msg->verb);
-- 
2.7.4
