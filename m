Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id BF654B7BFA
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2010 07:54:39 +1100 (EST)
Date: Fri, 5 Feb 2010 23:54:37 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] leds-gpio: Fix default state handling on OF platforms
Message-ID: <20100205205437.GA4733@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, Trent Piepho <xyzzy@speakeasy.org>,
	linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The driver wrongly sets default state for LEDs that don't specify
default-state property.

Currently the driver handles default state this way:

memset(&led, 0, sizeof(led));
for_each_child_of_node(np, child) {
	state = of_get_property(child, "default-state", NULL);
	if (state) {
		if (!strcmp(state, "keep"))
			led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
		...
	}
	ret = create_gpio_led(&led, ...);
}

Which means that all LEDs that do not specify default-state will
inherit the last value of the default-state property, which is wrong.

This patch fixes the issue by moving LED's template initialization
into the loop body.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/leds/leds-gpio.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index e5225d2..0823e26 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -211,7 +211,6 @@ static int __devinit of_gpio_leds_probe(struct of_device *ofdev,
 					const struct of_device_id *match)
 {
 	struct device_node *np = ofdev->node, *child;
-	struct gpio_led led;
 	struct gpio_led_of_platform_data *pdata;
 	int count = 0, ret;
 
@@ -226,8 +225,8 @@ static int __devinit of_gpio_leds_probe(struct of_device *ofdev,
 	if (!pdata)
 		return -ENOMEM;
 
-	memset(&led, 0, sizeof(led));
 	for_each_child_of_node(np, child) {
+		struct gpio_led led = {};
 		enum of_gpio_flags flags;
 		const char *state;
 
-- 
1.6.5.7
