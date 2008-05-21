Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4190FDE50F
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 01:41:47 +1000 (EST)
Date: Wed, 21 May 2008 19:41:45 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 4/4] [POWERPC] 86xx: mpc8610_hpcd: support for MMC-over-SPI
	and PIXIS' GPIOs
Message-ID: <20080521154145.GD4566@polina.dev.rtsoft.ru>
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080521154103.GA32577@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch implements support for PIXIS' GPIOs and adds appropriate
nodes to support MMC-over-SPI.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8610_hpcd.dts     |   32 ++++++++
 arch/powerpc/platforms/86xx/Kconfig        |    2 +
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |  119 ++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 44e9287..e3bf5e6 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -100,8 +100,18 @@
 		};
 
 		board-control@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			compatible = "fsl,fpga-pixis";
+			ranges = <0 3 0 0x20>;
 			reg = <3 0 0x20>;
+
+			sdcsr_pio: gpio-controller@a {
+				#gpio-cells = <2>;
+				compatible = "fsl,fpga-pixis-pio";
+				reg = <0xa 1>;
+				gpio-controller;
+			};
 		};
 	};
 
@@ -193,6 +203,28 @@
 			reg = <0xe4000 0x100>;
 		};
 
+		spi@7000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc8610-spi", "fsl,spi", "simple-bus";
+			cell-index = <0>;
+			reg = <0x7000 0x40>;
+			interrupts = <59 2>;
+			interrupt-parent = <&mpic>;
+			mode = "cpu";
+			/* gpios = <&sdcsr_pio 0 1>; */
+
+			mmc-slot@0 {
+				compatible = "linux,mmc-spi";
+				linux,modalias = "mmc_spi";
+				reg = <0>;
+				max-speed = <50000000>;
+				mmc,ocr-mask = <0x00200000>;
+				gpios = <&sdcsr_pio 6 0   /*  WP */
+					 &sdcsr_pio 7 1>; /* nCD */
+			};
+		};
+
 		i2s@16000 {
 			compatible = "fsl,mpc8610-ssi";
 			cell-index = <0>;
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 39c02af..a7eb89c 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -22,6 +22,8 @@ config MPC8610_HPCD
 	bool "Freescale MPC8610 HPCD"
 	select DEFAULT_UIMAGE
 	select FSL_ULI1575
+	select GENERIC_GPIO
+	select HAVE_GPIO_LIB
 	help
 	  This option enables support for the MPC8610 HPCD board.
 
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index fe163d4..9c1a56b 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -23,6 +23,9 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -42,6 +45,122 @@
 
 static unsigned char *pixis_bdcfg0, *pixis_arch;
 
+struct px_gpio_chip {
+	struct of_mm_gpio_chip mm_gc;
+	spinlock_t lock;
+
+	/* mask for active-low pins */
+	u8 active_low;
+};
+
+static inline struct px_gpio_chip *
+to_px_gpio_chip(struct of_mm_gpio_chip *mm_gc)
+{
+	return container_of(mm_gc, struct px_gpio_chip, mm_gc);
+}
+
+static int px_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct px_gpio_chip *px_gc = to_px_gpio_chip(mm_gc);
+	u8 __iomem *regs = mm_gc->regs;
+	u32 pin_mask = 1 << gpio;
+
+	return (in_8(regs) ^ px_gc->active_low) & pin_mask;
+}
+
+static void px_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct px_gpio_chip *px_gc = to_px_gpio_chip(mm_gc);
+	u8 __iomem *regs = mm_gc->regs;
+	unsigned long flags;
+	u32 pin_mask = 1 << gpio;
+
+	spin_lock_irqsave(&px_gc->lock, flags);
+
+	if (((!!val << gpio) ^ px_gc->active_low) & pin_mask)
+		setbits8(regs, pin_mask);
+	else
+		clrbits8(regs, pin_mask);
+
+	spin_unlock_irqrestore(&px_gc->lock, flags);
+}
+
+static int px_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	return 0;
+}
+
+static int px_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	px_gpio_set(gc, gpio, val);
+	return 0;
+}
+
+#define PX_GPIO_FLAG_ACTIVE_LOW	(1 << 0)
+
+int px_gpio_xlate(struct of_gpio_chip *of_gc, struct device_node *np,
+		  const void *gpio_spec)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(&of_gc->gc);
+	struct px_gpio_chip *px_gc = to_px_gpio_chip(mm_gc);
+	const u32 *gpio = gpio_spec;
+
+	if (*gpio > of_gc->gc.ngpio)
+		return -EINVAL;
+
+	if (gpio[1] & PX_GPIO_FLAG_ACTIVE_LOW)
+		px_gc->active_low |= 1 << *gpio;
+
+	return *gpio;
+}
+
+static int __init pixis_gpio_init(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "fsl,fpga-pixis-pio") {
+		int ret;
+		struct px_gpio_chip *px_gc;
+		struct of_mm_gpio_chip *mm_gc;
+		struct of_gpio_chip *of_gc;
+		struct gpio_chip *gc;
+
+		px_gc = kzalloc(sizeof(*px_gc), GFP_KERNEL);
+		if (!px_gc) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		spin_lock_init(&px_gc->lock);
+
+		mm_gc = &px_gc->mm_gc;
+		of_gc = &mm_gc->of_gc;
+		gc = &of_gc->gc;
+
+		of_gc->gpio_cells = 2;
+		of_gc->xlate = px_gpio_xlate;
+		gc->ngpio = 8;
+		gc->direction_input = px_gpio_dir_in;
+		gc->direction_output = px_gpio_dir_out;
+		gc->get = px_gpio_get;
+		gc->set = px_gpio_set;
+
+		ret = of_mm_gpiochip_add(np, mm_gc);
+		if (ret)
+			goto err;
+		continue;
+err:
+		pr_err("%s: registration failed with status %d\n",
+		       np->full_name, ret);
+		kfree(px_gc);
+		/* try others anyway */
+	}
+	return 0;
+}
+machine_arch_initcall(mpc86xx_hpcd, pixis_gpio_init);
+
 static struct of_device_id __initdata mpc8610_ids[] = {
 	{ .compatible = "fsl,mpc8610-immr", },
 	{ .compatible = "simple-bus", },
-- 
1.5.5.1
