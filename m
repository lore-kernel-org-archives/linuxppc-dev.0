Return-Path: <karim.eshapa@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wK4GR70HNzDqKK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 18:06:07 +1000 (AEST)
Received: by mail-wr0-x242.google.com with SMTP id v42so3582399wrc.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 May 2017 01:06:07 -0700 (PDT)
From: Karim Eshapa <karim.eshapa@gmail.com>
To: oss@buserror.net
Cc: claudiu.manoil@nxp.com, roy.pledge@nxp.com, colin.king@canonical.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] drivers:soc:fsl:qbman:qman.c: Change a comment for an entry
 check inside drain_mr_fqrni function
Date: Fri,  5 May 2017 10:05:56 +0200
Message-Id: <1493971556-14918-1-git-send-email-karim.eshapa@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change the comment for an entry check inside function
drain_mr_fqrni() with sleep for sufficient period
of time instead of long time proccessor cycles.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/soc/fsl/qbman/qman.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 18d391e..636a7d7 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1071,18 +1071,19 @@ static int drain_mr_fqrni(struct qm_portal *p)
 	msg = qm_mr_current(p);
 	if (!msg) {
 		/*
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
+		 * if MR was full and h/w had other FQRNI entries to
+		 * produce, we need to allow it time to produce those
+		 * entries once the existing entries are consumed.
+		 * A worst-case situation (fully-loaded system) means
+		 * h/w sequencers may have to do 3-4 other things
+		 * before servicing the portal's MR pump, each of
+		 * which (if slow) may take ~50 qman cycles
+		 * (which is ~200 processor cycles). So sleep with
+		 * 1 ms would be very efficient, after this period
+		 * we can check if there is something produced.
+		 * NB, we consume one entry at a time, so h/w has
+		 * an opportunity to produce new entries well before
+		 * the ring has been fully consumed.
 		 */
 		msleep(1);
 		msg = qm_mr_current(p);
-- 
2.7.4
