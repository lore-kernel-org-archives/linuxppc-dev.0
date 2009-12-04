Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 63775B7C00
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Dec 2009 06:43:47 +1100 (EST)
From: Peter Tyser <ptyser@xes-inc.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: mpc8xxx_gpio: Add ability to mask off unused GPIO
	pins
Date: Fri,  4 Dec 2009 13:43:40 -0600
Message-Id: <1259955820-28565-1-git-send-email-ptyser@xes-inc.com>
Cc: Peter Tyser <ptyser@xes-inc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This change resolves 2 issues:
- Different chips have a different number of GPIO pins per controller.
  For example, the MPC8347 has 32, the P2020 16, and the mpc8572 8.
  Previously, the mpc8xxx_gpio driver assumed every chip had 32 GPIO
  pins which resulted in some processors reporting an incorrect 'ngpio'
  field in /sys.  Additionally, users could export and "use" 32 GPIO
  pins, although in reality only a subset of the 32 pins had any real
  functionality.

- Some boards don't utilize all available GPIO pins.  Previously,
  unused GPIO pins could still be exported and "used", even though the
  pins had no real functionality.  This is somewhat confusing to a user
  and also allow a user to do something "bad", like change an unused
  floating output into a floating input.

Adding a new "fsl,gpio-mask" device tree property allows a dts file to
accurately describe what GPIO pins are available for use on a given
board.

Note that the 'ngpio' value reported in /sys will represent the
"highest" gpio pin accessible, not the total number of gpio pins
available.  For example, if a device only allowed the use of GPIO pin 3
(fsl,gpio-mask = 0x8), 'ngpio' would be reported as 4, although
only GPIO pin 3 could be exported and used.

Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
---
I don't know which GPIO pins are usable on Freescale boards.  Let me
know if the default mask for the reference boards should change.

Thanks,
Peter

 .../powerpc/dts-bindings/fsl/8xxx_gpio.txt         |   11 ++++++--
 arch/powerpc/boot/dts/mpc8377_rdb.dts              |    2 +
 arch/powerpc/boot/dts/mpc8377_wlan.dts             |    2 +
 arch/powerpc/boot/dts/mpc8378_rdb.dts              |    2 +
 arch/powerpc/boot/dts/mpc8379_rdb.dts              |    2 +
 arch/powerpc/boot/dts/p2020ds.dts                  |    1 +
 arch/powerpc/boot/dts/p2020rdb.dts                 |    1 +
 arch/powerpc/boot/dts/xcalibur1501.dts             |    1 +
 arch/powerpc/boot/dts/xpedite5301.dts              |    1 +
 arch/powerpc/boot/dts/xpedite5330.dts              |    1 +
 arch/powerpc/boot/dts/xpedite5370.dts              |    1 +
 arch/powerpc/sysdev/mpc8xxx_gpio.c                 |   24 ++++++++++++++++---
 12 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt b/Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt
index d015dce..a8fac7f 100644
--- a/Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt
@@ -11,9 +11,12 @@ Required properties:
   83xx, "fsl,mpc8572-gpio" for 85xx and "fsl,mpc8610-gpio" for 86xx.
 - #gpio-cells : Should be two. The first cell is the pin number and the
   second cell is used to specify optional parameters (currently unused).
- - interrupts : Interrupt mapping for GPIO IRQ (currently unused).
- - interrupt-parent : Phandle for the interrupt controller that
-   services interrupts for this device.
+- interrupts : Interrupt mapping for GPIO IRQ (currently unused).
+- interrupt-parent : Phandle for the interrupt controller that
+  services interrupts for this device.
+- fsl,gpio-mask: A bitmask representing which GPIO pins are availabe for
+  use.  For example, a value of 0x13 means GPIO pins 0, 1, and 4 are
+  usable.
 - gpio-controller : Marks the port as GPIO controller.
 
 Example of gpio-controller nodes for a MPC8347 SoC:
@@ -24,6 +27,7 @@ Example of gpio-controller nodes for a MPC8347 SoC:
 		reg = <0xc00 0x100>;
 		interrupts = <74 0x8>;
 		interrupt-parent = <&ipic>;
+		fsl,gpio-mask = <0xffffffff>;
 		gpio-controller;
 	};
 
@@ -33,6 +37,7 @@ Example of gpio-controller nodes for a MPC8347 SoC:
 		reg = <0xd00 0x100>;
 		interrupts = <75 0x8>;
 		interrupt-parent = <&ipic>;
+		fsl,gpio-mask = <0xffffffff>;
 		gpio-controller;
 	};
 
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 9e2264b..6152bfa 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -115,6 +115,7 @@
 			reg = <0xc00 0x100>;
 			interrupts = <74 0x8>;
 			interrupt-parent = <&ipic>;
+			fsl,gpio-mask = <0xffffffff>;
 			gpio-controller;
 		};
 
@@ -124,6 +125,7 @@
 			reg = <0xd00 0x100>;
 			interrupts = <75 0x8>;
 			interrupt-parent = <&ipic>;
+			fsl,gpio-mask = <0xffffffff>;
 			gpio-controller;
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8377_wlan.dts b/arch/powerpc/boot/dts/mpc8377_wlan.dts
index 9ea7830..a26535c 100644
--- a/arch/powerpc/boot/dts/mpc8377_wlan.dts
+++ b/arch/powerpc/boot/dts/mpc8377_wlan.dts
@@ -105,6 +105,7 @@
 			reg = <0xc00 0x100>;
 			interrupts = <74 0x8>;
 			interrupt-parent = <&ipic>;
+			fsl,gpio-mask = <0xffffffff>;
 			gpio-controller;
 		};
 
@@ -114,6 +115,7 @@
 			reg = <0xd00 0x100>;
 			interrupts = <75 0x8>;
 			interrupt-parent = <&ipic>;
+			fsl,gpio-mask = <0xffffffff>;
 			gpio-controller;
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 4e6a1a4..11ba39c 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -115,6 +115,7 @@
 			reg = <0xc00 0x100>;
 			interrupts = <74 0x8>;
 			interrupt-parent = <&ipic>;
+			fsl,gpio-mask = <0xffffffff>;
 			gpio-controller;
 		};
 
@@ -124,6 +125,7 @@
 			reg = <0xd00 0x100>;
 			interrupts = <75 0x8>;
 			interrupt-parent = <&ipic>;
+			fsl,gpio-mask = <0xffffffff>;
 			gpio-controller;
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 72336d5..975bdd7 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -113,6 +113,7 @@
 			reg = <0xc00 0x100>;
 			interrupts = <74 0x8>;
 			interrupt-parent = <&ipic>;
+			fsl,gpio-mask = <0x3ffffff>; /* mpc8379 has 26 gpio */
 			gpio-controller;
 		};
 
@@ -122,6 +123,7 @@
 			reg = <0xd00 0x100>;
 			interrupts = <75 0x8>;
 			interrupt-parent = <&ipic>;
+			fsl,gpio-mask = <0x3ffffff>; /* mpc8379 has 26 gpio */
 			gpio-controller;
 		};
 
diff --git a/arch/powerpc/boot/dts/p2020ds.dts b/arch/powerpc/boot/dts/p2020ds.dts
index 1101914..e64a936 100644
--- a/arch/powerpc/boot/dts/p2020ds.dts
+++ b/arch/powerpc/boot/dts/p2020ds.dts
@@ -277,6 +277,7 @@
 			reg = <0xf000 0x100>;
 			interrupts = <47 0x2>;
 			interrupt-parent = <&mpic>;
+			fsl,gpio-mask = <0xffff>; /* p2020 has 16 gpio*/
 			gpio-controller;
 		};
 
diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/p2020rdb.dts
index da4cb0d..53f75ca 100644
--- a/arch/powerpc/boot/dts/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/p2020rdb.dts
@@ -337,6 +337,7 @@
 			reg = <0xf000 0x100>;
 			interrupts = <47 0x2>;
 			interrupt-parent = <&mpic>;
+			fsl,gpio-mask = <0xffff>; /* p2020 has 16 gpio*/
 			gpio-controller;
 		};
 
diff --git a/arch/powerpc/boot/dts/xcalibur1501.dts b/arch/powerpc/boot/dts/xcalibur1501.dts
index ac0a617..858668c 100644
--- a/arch/powerpc/boot/dts/xcalibur1501.dts
+++ b/arch/powerpc/boot/dts/xcalibur1501.dts
@@ -598,6 +598,7 @@
 			interrupts = <47 2>;
 			interrupt-parent = <&mpic>;
 			#gpio-cells = <2>;
+			fsl,gpio-mask = <0xf0>; /* 4 LEDs */
 			gpio-controller;
 		};
 
diff --git a/arch/powerpc/boot/dts/xpedite5301.dts b/arch/powerpc/boot/dts/xpedite5301.dts
index db7faf5..944f08c 100644
--- a/arch/powerpc/boot/dts/xpedite5301.dts
+++ b/arch/powerpc/boot/dts/xpedite5301.dts
@@ -508,6 +508,7 @@
 			interrupts = <47 2>;
 			interrupt-parent = <&mpic>;
 			#gpio-cells = <2>;
+			fsl,gpio-mask = <0xf0>; /* 4 LEDs */
 			gpio-controller;
 		};
 
diff --git a/arch/powerpc/boot/dts/xpedite5330.dts b/arch/powerpc/boot/dts/xpedite5330.dts
index c364ca6..1dacacd 100644
--- a/arch/powerpc/boot/dts/xpedite5330.dts
+++ b/arch/powerpc/boot/dts/xpedite5330.dts
@@ -544,6 +544,7 @@
 			interrupts = <47 2>;
 			interrupt-parent = <&mpic>;
 			#gpio-cells = <2>;
+			fsl,gpio-mask = <0xf0>; /* 4 LEDs */
 			gpio-controller;
 		};
 
diff --git a/arch/powerpc/boot/dts/xpedite5370.dts b/arch/powerpc/boot/dts/xpedite5370.dts
index 7a8a4af..d783a50 100644
--- a/arch/powerpc/boot/dts/xpedite5370.dts
+++ b/arch/powerpc/boot/dts/xpedite5370.dts
@@ -506,6 +506,7 @@
 			interrupts = <47 2>;
 			interrupt-parent = <&mpic>;
 			#gpio-cells = <2>;
+			fsl,gpio-mask = <0xf0>; /* 4 LEDs */
 			gpio-controller;
 		};
 
diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
index 103eace..2c07052 100644
--- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
+++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
@@ -16,8 +16,6 @@
 #include <linux/of_gpio.h>
 #include <linux/gpio.h>
 
-#define MPC8XXX_GPIO_PINS	32
-
 #define GPIO_DIR		0x00
 #define GPIO_ODR		0x04
 #define GPIO_DAT		0x08
@@ -34,11 +32,12 @@ struct mpc8xxx_gpio_chip {
 	 * open drain mode safely
 	 */
 	u32 data;
+	u32 valid_pins; /* Bitmask of valid gpio pins */
 };
 
 static inline u32 mpc8xxx_gpio2mask(unsigned int gpio)
 {
-	return 1u << (MPC8XXX_GPIO_PINS - 1 - gpio);
+	return 0x80000000 >> gpio;
 }
 
 static inline struct mpc8xxx_gpio_chip *
@@ -111,12 +110,23 @@ static int mpc8xxx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val
 	return 0;
 }
 
+static int mpc8xxx_gpio_request(struct gpio_chip *gc, unsigned int gpio) {
+	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
+
+	if (mpc8xxx_gc->valid_pins & (1 << gpio))
+		return 0;
+
+	return -1;
+}
+
 static void __init mpc8xxx_add_controller(struct device_node *np)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc;
 	struct of_mm_gpio_chip *mm_gc;
 	struct of_gpio_chip *of_gc;
 	struct gpio_chip *gc;
+	const u32 *prop;
 	int ret;
 
 	mpc8xxx_gc = kzalloc(sizeof(*mpc8xxx_gc), GFP_KERNEL);
@@ -133,11 +143,17 @@ static void __init mpc8xxx_add_controller(struct device_node *np)
 
 	mm_gc->save_regs = mpc8xxx_gpio_save_regs;
 	of_gc->gpio_cells = 2;
-	gc->ngpio = MPC8XXX_GPIO_PINS;
+	prop = of_get_property(np, "fsl,gpio-mask", NULL);
+	if (prop)
+		mpc8xxx_gc->valid_pins = *prop;
+	else
+		mpc8xxx_gc->valid_pins = 0xffffffff;
+	gc->ngpio = fls(mpc8xxx_gc->valid_pins);
 	gc->direction_input = mpc8xxx_gpio_dir_in;
 	gc->direction_output = mpc8xxx_gpio_dir_out;
 	gc->get = mpc8xxx_gpio_get;
 	gc->set = mpc8xxx_gpio_set;
+	gc->request = mpc8xxx_gpio_request;
 
 	ret = of_mm_gpiochip_add(np, mm_gc);
 	if (ret)
-- 
1.6.2.1
