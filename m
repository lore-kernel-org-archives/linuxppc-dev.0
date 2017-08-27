Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgR4M5z5QzDqgq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 06:16:19 +1000 (AEST)
To: linux-leds@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] leds-PowerNV: Delete an error message for a failed memory
 allocation in powernv_led_create()
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <019499e0-68d8-b89d-f5d6-6aefd9cbaf04@users.sourceforge.net>
Date: Sun, 27 Aug 2017 22:10:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 27 Aug 2017 22:00:22 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/leds/leds-powernv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
index b2a98c7b521b..b1adbd70ce2e 100644
--- a/drivers/leds/leds-powernv.c
+++ b/drivers/leds/leds-powernv.c
@@ -224,12 +224,8 @@ static int powernv_led_create(struct device *dev,
 	powernv_led->cdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s",
 						powernv_led->loc_code,
 						led_type_desc);
-	if (!powernv_led->cdev.name) {
-		dev_err(dev,
-			"%s: Memory allocation failed for classdev name\n",
-			__func__);
+	if (!powernv_led->cdev.name)
 		return -ENOMEM;
-	}
 
 	powernv_led->cdev.brightness_set_blocking = powernv_brightness_set;
 	powernv_led->cdev.brightness_get = powernv_brightness_get;
-- 
2.14.1
