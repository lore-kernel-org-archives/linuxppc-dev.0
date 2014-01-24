Return-Path: <Bharat.Bhushan@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3D2092C0092
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 22:11:25 +1100 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <rtc-linux@googlegroups.com>, <a.zummo@towertech.it>,
 <scottwood@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] rtc: ds3232 make it possible to share an irq
Date: Fri, 24 Jan 2014 16:36:32 +0530
Message-ID: <1390561592-23968-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <Bharat.Bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's possible to have RTC irq shared with other device (e.g.
t4240qds board shares ds3232irq with phy one).  Handle this in
driver.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@freescale.com>
---
 drivers/rtc/rtc-ds3232.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index b83bb5a..598837b 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -419,8 +419,8 @@ static int ds3232_probe(struct i2c_client *client,
 	}
 
 	if (client->irq >= 0) {
-		ret = devm_request_irq(&client->dev, client->irq, ds3232_irq, 0,
-				 "ds3232", client);
+		ret = devm_request_irq(&client->dev, client->irq, ds3232_irq,
+				       IRQF_SHARED, "ds3232", client);
 		if (ret) {
 			dev_err(&client->dev, "unable to request IRQ\n");
 			return ret;
-- 
1.7.0.4
