Return-Path: <smaclennan@pikatech.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 912C5B7069
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 07:22:58 +1000 (EST)
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 674EFDDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 07:22:55 +1000 (EST)
Date: Sun, 28 Jun 2009 17:22:51 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Josh Boyer
	<jwboyer@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Have Warp take advantage of GPIO LEDs
	default-state = keep
Message-ID: <20090628172251.7bc0c8e0@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes, it's me again. The GPIO LEDs default-state = keep patch was
accepted into the kernel. This patch takes advantage of that patch. 

It would be nice if the patch made it into 2.6.31 since this was my last
outstanding patch. I really didn't think the "keep" patch would be
accepted in this release.

But at minimum, it would be nice if the DTS change went in. I actually
held back on a change to warp.c that made the LEDS work correctly if
AD7414 was not configured. The "keep" makes that change unnecessary...
but you need the dts fix.

The DTS fix is just two lines and is fully backwards compatible. The
warp.c patch just removes the hardcoding of the two LEDs.

Now I have to get used to the LED not glitching on startup ;)

Cheers,
   Sean

The GPIO LEDS driver now has a default-state of keep. Since u-boot sets the initial
LED state on the Warp, take advantage of this new state.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/boot/dts/warp.dts b/arch/powerpc/boot/dts/warp.dts
index 01bfb56..31605ee 100644
--- a/arch/powerpc/boot/dts/warp.dts
+++ b/arch/powerpc/boot/dts/warp.dts
@@ -261,10 +261,11 @@
 				compatible = "gpio-leds";
 				green {
 					gpios = <&GPIO1 0 0>;
-					default-state = "on";
+					default-state = "keep";
 				};
 				red {
 					gpios = <&GPIO1 1 0>;
+					default-state = "keep";
 				};
 			};
 
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index 0362c88..9916b39 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -64,8 +64,6 @@ define_machine(warp) {
 };
 
 
-static u32 post_info;
-
 static int __init warp_post_info(void)
 {
 	struct device_node *np;
@@ -87,10 +85,9 @@ static int __init warp_post_info(void)
 
 	iounmap(fpga);
 
-	if (post1 || post2) {
+	if (post1 || post2)
 		printk(KERN_INFO "Warp POST %08x %08x\n", post1, post2);
-		post_info = 1;
-	} else
+	else
 		printk(KERN_INFO "Warp POST OK\n");
 
 	return 0;
@@ -179,15 +176,10 @@ static int pika_setup_leds(void)
 	}
 
 	for_each_child_of_node(np, child)
-		if (strcmp(child->name, "green") == 0) {
+		if (strcmp(child->name, "green") == 0)
 			green_led = of_get_gpio(child, 0);
-			/* Turn back on the green LED */
-			gpio_set_value(green_led, 1);
-		} else if (strcmp(child->name, "red") == 0) {
+		else if (strcmp(child->name, "red") == 0)
 			red_led = of_get_gpio(child, 0);
-			/* Set based on post */
-			gpio_set_value(red_led, post_info);
-		}
 
 	of_node_put(np);
 
