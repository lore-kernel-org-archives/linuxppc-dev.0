Return-Path: <j.anaszewski@samsung.com>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A626A1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2015 02:51:37 +1100 (AEDT)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NY400P57E96FQ80@mailout3.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Sat, 21 Nov 2015 00:41:30 +0900 (KST)
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-leds@vger.kernel.orv
Cc: linuxppc-dev@lists.ozlabs.org, Jacek Anaszewski <j.anaszewski@samsung.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: [PATCH] leds: powernv: Implement brightness_set_blocking op
Date: Fri, 20 Nov 2015 16:41:06 +0100
Message-id: <1448034066-22978-1-git-send-email-j.anaszewski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since brightness setting can sleep for this driver, implement
brightness_set_blocking op, instead of brightness_set.
It makes this driver compatible with LED triggers.

Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 drivers/leds/leds-powernv.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
index 1e75e1f..dd76f34 100644
--- a/drivers/leds/leds-powernv.c
+++ b/drivers/leds/leds-powernv.c
@@ -77,7 +77,7 @@ static int powernv_get_led_type(const char *led_type_desc)
  * This function is called from work queue task context when ever it gets
  * scheduled. This function can sleep at opal_async_wait_response call.
  */
-static void powernv_led_set(struct powernv_led_data *powernv_led,
+static int powernv_led_set(struct powernv_led_data *powernv_led,
 			    enum led_brightness value)
 {
 	int rc, token;
@@ -99,7 +99,7 @@ static void powernv_led_set(struct powernv_led_data *powernv_led,
 		if (token != -ERESTARTSYS)
 			dev_err(dev, "%s: Couldn't get OPAL async token\n",
 				__func__);
-		return;
+		return token;
 	}
 
 	rc = opal_leds_set_ind(token, powernv_led->loc_code,
@@ -125,6 +125,7 @@ static void powernv_led_set(struct powernv_led_data *powernv_led,
 
 out_token:
 	opal_async_release_token(token);
+	return rc;
 }
 
 /*
@@ -173,20 +174,23 @@ static enum led_brightness powernv_led_get(struct powernv_led_data *powernv_led)
  * LED classdev 'brightness_get' function. This schedules work
  * to update LED state.
  */
-static void powernv_brightness_set(struct led_classdev *led_cdev,
+static int powernv_brightness_set(struct led_classdev *led_cdev,
 				   enum led_brightness value)
 {
 	struct powernv_led_data *powernv_led =
 		container_of(led_cdev, struct powernv_led_data, cdev);
 	struct powernv_led_common *powernv_led_common = powernv_led->common;
+	int rc;
 
 	/* Do not modify LED in unload path */
 	if (powernv_led_common->led_disabled)
-		return;
+		return 0;
 
 	mutex_lock(&powernv_led_common->lock);
-	powernv_led_set(powernv_led, value);
+	rc = powernv_led_set(powernv_led, value);
 	mutex_unlock(&powernv_led_common->lock);
+
+	return rc;
 }
 
 /* LED classdev 'brightness_get' function */
@@ -227,7 +231,7 @@ static int powernv_led_create(struct device *dev,
 		return -ENOMEM;
 	}
 
-	powernv_led->cdev.brightness_set = powernv_brightness_set;
+	powernv_led->cdev.brightness_set_blocking = powernv_brightness_set;
 	powernv_led->cdev.brightness_get = powernv_brightness_get;
 	powernv_led->cdev.brightness = LED_OFF;
 	powernv_led->cdev.max_brightness = LED_FULL;
-- 
1.7.9.5
