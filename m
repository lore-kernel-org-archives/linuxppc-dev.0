Return-Path: <R58495@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 952512C0142
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Sep 2013 01:43:58 +1000 (EST)
From: York Sun <yorksun@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 3/7] i2c/rtc-ds3232: Fix irq for probing
Date: Fri, 6 Sep 2013 08:43:15 -0700
Message-ID: <1378482199-10581-3-git-send-email-yorksun@freescale.com>
In-Reply-To: <1378482199-10581-1-git-send-email-yorksun@freescale.com>
References: <1378482199-10581-1-git-send-email-yorksun@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Driver shouldn't request irq when irq = 0. It is returned from parsing
device tree. 0 means no interrupt.

Signed-off-by: York Sun <yorksun@freescale.com>
Reviewed-by: Zang Tiefei-R61911 <tie-fei.zang@freescale.com>
Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
Tested-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
---
 drivers/rtc/rtc-ds3232.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index b83bb5a5..ae8a28e 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -418,7 +418,7 @@ static int ds3232_probe(struct i2c_client *client,
 		return PTR_ERR(ds3232->rtc);
 	}
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		ret = devm_request_irq(&client->dev, client->irq, ds3232_irq, 0,
 				 "ds3232", client);
 		if (ret) {
-- 
1.7.9.5
