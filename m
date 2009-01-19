Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-10.online-age.net (ext-nj2ut-10.online-age.net
	[64.14.54.240])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 219D947620
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 22:33:37 +1100 (EST)
Received: from int-nj2ut-5.online-age.net (int-nj2ut-5.online-age.net
	[3.159.237.74])
	by ext-nj2ut-10.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id n0JBXY6J032173
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 06:33:34 -0500
Received: from cinmlip01.e2k.ad.ge.com (int-nj2ut-5.online-age.net
	[3.159.237.74])
	by int-nj2ut-5.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id n0JBXYnI010806
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 06:33:34 -0500
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 3/3] powerpc/86xx: Extend GE Fanuc GPIO driver for the SBC310
To: linuxppc-dev@ozlabs.org
Date: Mon, 19 Jan 2009 11:33:34 +0000
Message-ID: <20090119113329.9225.83409.stgit@ubuntu8041.localdomain>
In-Reply-To: <20090119112130.9225.82681.stgit@ubuntu8041.localdomain>
References: <20090119112130.9225.82681.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds basic support for the 6 GPIO lines found on GE Fanucs SBC310 to the GE Fanuc GPIO driver.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/configs/86xx/gef_sbc310_defconfig |    2 +
 arch/powerpc/platforms/86xx/gef_gpio.c         |   36 +++++++++++++++++++++---
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/configs/86xx/gef_sbc310_defconfig b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
index 157fdcd..79542ce 100644
--- a/arch/powerpc/configs/86xx/gef_sbc310_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
@@ -880,7 +880,7 @@ CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
 CONFIG_GPIOLIB=y
 # CONFIG_DEBUG_GPIO is not set
-# CONFIG_GPIO_SYSFS is not set
+CONFIG_GPIO_SYSFS=y
 
 #
 # Memory mapped GPIO expanders:
diff --git a/arch/powerpc/platforms/86xx/gef_gpio.c b/arch/powerpc/platforms/86xx/gef_gpio.c
index 85b2800..b2ea887 100644
--- a/arch/powerpc/platforms/86xx/gef_gpio.c
+++ b/arch/powerpc/platforms/86xx/gef_gpio.c
@@ -37,8 +37,6 @@
 #define GEF_GPIO_OVERRUN	0x1C
 #define GEF_GPIO_MODE		0x20
 
-#define NUM_GPIO 19
-
 static void _gef_gpio_set(void __iomem *reg, unsigned int offset, int value)
 {
 	unsigned int data;
@@ -103,10 +101,10 @@ static void gef_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 static int __init gef_gpio_init(void)
 {
 	struct device_node *np;
+	int retval;
+	struct of_mm_gpio_chip *gef_gpio_chip;
 
 	for_each_compatible_node(np, NULL, "gef,sbc610-gpio") {
-		int retval;
-		struct of_mm_gpio_chip *gef_gpio_chip;
 
 		pr_debug("%s: Initialising GEF GPIO\n", np->full_name);
 
@@ -120,7 +118,35 @@ static int __init gef_gpio_init(void)
 
 		/* Setup pointers to chip functions */
 		gef_gpio_chip->of_gc.gpio_cells = 2;
-		gef_gpio_chip->of_gc.gc.ngpio = NUM_GPIO;
+		gef_gpio_chip->of_gc.gc.ngpio = 19;
+		gef_gpio_chip->of_gc.gc.direction_input = gef_gpio_dir_in;
+		gef_gpio_chip->of_gc.gc.direction_output = gef_gpio_dir_out;
+		gef_gpio_chip->of_gc.gc.get = gef_gpio_get;
+		gef_gpio_chip->of_gc.gc.set = gef_gpio_set;
+
+		/* This function adds a memory mapped GPIO chip */
+		retval = of_mm_gpiochip_add(np, gef_gpio_chip);
+		if (retval) {
+			kfree(gef_gpio_chip);
+			pr_err("%s: Unable to add GPIO\n", np->full_name);
+		}
+	}
+
+	for_each_compatible_node(np, NULL, "gef,sbc310-gpio") {
+
+		pr_debug("%s: Initialising GEF GPIO\n", np->full_name);
+
+		/* Allocate chip structure */
+		gef_gpio_chip = kzalloc(sizeof(*gef_gpio_chip), GFP_KERNEL);
+		if (!gef_gpio_chip) {
+			pr_err("%s: Unable to allocate structure\n",
+				np->full_name);
+			continue;
+		}
+
+		/* Setup pointers to chip functions */
+		gef_gpio_chip->of_gc.gpio_cells = 2;
+		gef_gpio_chip->of_gc.gc.ngpio = 6;
 		gef_gpio_chip->of_gc.gc.direction_input = gef_gpio_dir_in;
 		gef_gpio_chip->of_gc.gc.direction_output = gef_gpio_dir_out;
 		gef_gpio_chip->of_gc.gc.get = gef_gpio_get;
