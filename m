Return-Path: <henk.stegeman@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id D4E4ADDDF3
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 22:22:12 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so2012443yxb.39
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Mar 2009 03:22:10 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 5 Mar 2009 12:15:06 +0100
Message-ID: <ae4f76fd0903050315g571b327drc069938c0226f6a3@mail.gmail.com>
Subject: support IRQ from GPIO trough OF and GPIOLIB
From: Henk Stegeman <henk.stegeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I have an SPI device that sends an IRQ to the CPU (MPC5200) via GPIO (GPT6):

gpt6: timer@660 {	// General Purpose Timer GPT6 in GPIO mode for
SMC4000IO sample irq.
	compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
	cell-index = <6>;
	reg = <0x660 0x10>;
	interrupts = <1 15 0>;
	interrupt-parent = <&mpc5200_pic>;
	gpio-controller;
	#gpio-cells = <2>;
};

spi@f00 {
	#address-cells = <1>;
	#size-cells = <0>;
	compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
	reg = <0xf00 0x20>;
	interrupts = <2 13 0 2 14 0>;
	interrupt-parent = <&mpc5200_pic>;
	gpios = <&gpt4 0 0>;

	io-controller@0 {
		compatible = "microkey,smc4000io";
		linux,modalias = "of_smc4000io";
		spi-max-frequency = <1000000>;
		spi-cpha;
		reg = <0>;
		// gpios: first is IRQ to cpu
		gpios = <&gpt6 0 0>;
		word-delay-us = <0>;
	};
};

I've got it working for a mm_gpio, but it's probably not the right
approach, I have the following questions to get to the right solution:
- Should gpiolib's gpio_to_irq function indeed return the IRQ that was
specified at the GPIO by the DTS (interrupts = <1 15 0>)?
 The effect is that if the IRQ is not specified in the DTS the
gpio_to_irq returns NO_IRQ.
 (On the MPC5200 the IRQ is fixed for GPT6, so instead the cell-index
could also be used to return a gpio's IRQ)
- If a GPIO controller supports several GPIOs but one IRQ, is it
defined what gpio_to_irq should return?
- Is it okay for gpio_to_irq to return NO_IRQ?  (returned by
irq_of_parse_and_map) if irq is not defined?


Henk.

diff --git a/drivers/of/gpio.c b/drivers/of/gpio.c
index 6eea601..81927d7 100644
--- a/drivers/of/gpio.c
+++ b/drivers/of/gpio.c
@@ -150,6 +150,17 @@ int of_gpio_simple_xlate(struct of_gpio_chip
*of_gc, struct device_node *np,
 }
 EXPORT_SYMBOL(of_gpio_simple_xlate);

+static int of_mm_gpio_to_irq(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc;
+	struct of_gpio_chip *of_gc;
+
+	of_gc = container_of(gc, struct of_gpio_chip, gc);	
+	mm_gc = container_of(of_gc, struct of_mm_gpio_chip, of_gc);	
+	return mm_gc->irq;	
+	
+}
+
 /**
  * of_mm_gpiochip_add - Add memory mapped GPIO chip (bank)
  * @np:		device node of the GPIO chip
@@ -188,6 +199,9 @@ int of_mm_gpiochip_add(struct device_node *np,

 	gc->base = -1;

+	mm_gc->irq = irq_of_parse_and_map(np, 0);
+	gc->to_irq = of_mm_gpio_to_irq;
+
 	if (!of_gc->xlate)
 		of_gc->xlate = of_gpio_simple_xlate;

diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index fc2472c..17fe9ed 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -54,6 +54,7 @@ struct of_mm_gpio_chip {
 	struct of_gpio_chip of_gc;
 	void (*save_regs)(struct of_mm_gpio_chip *mm_gc);
 	void __iomem *regs;
+	int irq;
 };

 static inline struct of_mm_gpio_chip *to_of_mm_gpio_chip(struct gpio_chip *gc)
