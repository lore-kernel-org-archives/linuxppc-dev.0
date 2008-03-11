Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BA944DDE0C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 05:40:14 +1100 (EST)
Date: Tue, 11 Mar 2008 21:40:12 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4] GPIO LIB API support for OF and PowerPC
Message-ID: <20080311184012.GA28466@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Here are few patches needed to support GPIO LIB API on PowerPC.
It would be great to see these applied for the 2.6.26...

For now we use static gpio base allocation, later we'll switch to
the dynamic bases. The patch below shows the idea of what needs to be
done when dynamic gpio base allocation patch[1] will hit the mainline.

[1] http://lkml.org/lkml/2008/3/11/261

- - - -
Subject: of/gpio: use dynamic base allocation

Signed-off-by: not yet
---

depends on http://lkml.org/lkml/2008/3/11/261

 drivers/of/gpio.c |   38 +-------------------------------------
 1 files changed, 1 insertions(+), 37 deletions(-)

diff --git a/drivers/of/gpio.c b/drivers/of/gpio.c
index ed1c161..a6775ff 100644
--- a/drivers/of/gpio.c
+++ b/drivers/of/gpio.c
@@ -118,38 +118,6 @@ static int of_gpio_simple_xlate(struct of_gpio_chip *of_gc,
 	return *gpio;
 }
 
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
 int of_mm_gpiochip_add(struct device_node *np,
 		       struct of_mm_gpio_chip *mm_gc)
 {
@@ -165,11 +133,7 @@ int of_mm_gpiochip_add(struct device_node *np,
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
1.5.2.2
