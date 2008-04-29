Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 84D21DDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 00:05:27 +1000 (EST)
Date: Tue, 29 Apr 2008 18:05:24 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] of/gpio: use dynamic base allocation
Message-ID: <20080429140524.GA14573@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since gpiolib-dynamic-gpio-number-allocation.patch -mm patch was recently
merged into Linus' tree (commit 8d0aab2f16c4fa170f32e7a74a52cd0122bbafef),
we can use dynamic GPIO base allocation now.

This, in turn, removes number of gpios per chip constraint.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/of/gpio.c |   38 +-------------------------------------
 1 files changed, 1 insertions(+), 37 deletions(-)

diff --git a/drivers/of/gpio.c b/drivers/of/gpio.c
index 000681e..1c9cab8 100644
--- a/drivers/of/gpio.c
+++ b/drivers/of/gpio.c
@@ -137,38 +137,6 @@ int of_gpio_simple_xlate(struct of_gpio_chip *of_gc, struct device_node *np,
 }
 EXPORT_SYMBOL(of_gpio_simple_xlate);
 
-/* Should be sufficient for now, later we'll use dynamic bases. */
-#if defined(CONFIG_PPC32) || defined(CONFIG_SPARC32)
-#define GPIOS_PER_CHIP 32
-#else
-#define GPIOS_PER_CHIP 64
-#endif
-
-static int of_get_gpiochip_base(struct device_node *np)
-{
-	struct device_node *gc = NULL;
-	int gpiochip_base = 0;
-
-	while ((gc = of_find_all_nodes(gc))) {
-		if (!of_get_property(gc, "gpio-controller", NULL))
-			continue;
-
-		if (gc != np) {
-			gpiochip_base += GPIOS_PER_CHIP;
-			continue;
-		}
-
-		of_node_put(gc);
-
-		if (gpiochip_base >= ARCH_NR_GPIOS)
-			return -ENOSPC;
-
-		return gpiochip_base;
-	}
-
-	return -ENOENT;
-}
-
 /**
  * of_mm_gpiochip_add - Add memory mapped GPIO chip (bank)
  * @np:		device node of the GPIO chip
@@ -205,11 +173,7 @@ int of_mm_gpiochip_add(struct device_node *np,
 	if (!mm_gc->regs)
 		goto err1;
 
-	gc->base = of_get_gpiochip_base(np);
-	if (gc->base < 0) {
-		ret = gc->base;
-		goto err1;
-	}
+	gc->base = -1;
 
 	if (!of_gc->xlate)
 		of_gc->xlate = of_gpio_simple_xlate;
-- 
1.5.5.1
