Return-Path: <henk.stegeman@gmail.com>
Received: from mail-gx0-f174.google.com (mail-gx0-f174.google.com
	[209.85.217.174]) by ozlabs.org (Postfix) with ESMTP id EBD95DDDB6
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 22:20:26 +1100 (EST)
Received: by gxk22 with SMTP id 22so1514444gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Mar 2009 03:20:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ae4f76fd0903050315g571b327drc069938c0226f6a3@mail.gmail.com>
References: <ae4f76fd0903050315g571b327drc069938c0226f6a3@mail.gmail.com>
Date: Thu, 5 Mar 2009 12:20:24 +0100
Message-ID: <ae4f76fd0903050320j75200141we4d7c264dd387d2d@mail.gmail.com>
Subject: Re: support IRQ from GPIO trough OF and GPIOLIB
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

I forgot to include my  changes in arch/powerpc/include/asm/gpio.h:

diff --git a/arch/powerpc/include/asm/gpio.h b/arch/powerpc/include/asm/gpi=
o.h
index ea04632..38762ed 100644
--- a/arch/powerpc/include/asm/gpio.h
+++ b/arch/powerpc/include/asm/gpio.h
@@ -38,12 +38,9 @@ static inline int gpio_cansleep(unsigned int gpio)
 	return __gpio_cansleep(gpio);
 }

-/*
- * Not implemented, yet.
- */
 static inline int gpio_to_irq(unsigned int gpio)
 {
-	return -ENOSYS;
+	return __gpio_to_irq(gpio);
 }

 static inline int irq_to_gpio(unsigned int irq)


On Thu, Mar 5, 2009 at 12:15 PM, Henk Stegeman <henk.stegeman@gmail.com> wr=
ote:
> Hello,
>
> I have an SPI device that sends an IRQ to the CPU (MPC5200) via GPIO (GPT=
6):
>
> gpt6: timer@660 { =A0 =A0 =A0 // General Purpose Timer GPT6 in GPIO mode =
for
> SMC4000IO sample irq.
> =A0 =A0 =A0 =A0compatible =3D "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gp=
io";
> =A0 =A0 =A0 =A0cell-index =3D <6>;
> =A0 =A0 =A0 =A0reg =3D <0x660 0x10>;
> =A0 =A0 =A0 =A0interrupts =3D <1 15 0>;
> =A0 =A0 =A0 =A0interrupt-parent =3D <&mpc5200_pic>;
> =A0 =A0 =A0 =A0gpio-controller;
> =A0 =A0 =A0 =A0#gpio-cells =3D <2>;
> };
>
> spi@f00 {
> =A0 =A0 =A0 =A0#address-cells =3D <1>;
> =A0 =A0 =A0 =A0#size-cells =3D <0>;
> =A0 =A0 =A0 =A0compatible =3D "fsl,mpc5200b-spi","fsl,mpc5200-spi";
> =A0 =A0 =A0 =A0reg =3D <0xf00 0x20>;
> =A0 =A0 =A0 =A0interrupts =3D <2 13 0 2 14 0>;
> =A0 =A0 =A0 =A0interrupt-parent =3D <&mpc5200_pic>;
> =A0 =A0 =A0 =A0gpios =3D <&gpt4 0 0>;
>
> =A0 =A0 =A0 =A0io-controller@0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "microkey,smc4000io";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0linux,modalias =3D "of_smc4000io";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi-max-frequency =3D <1000000>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi-cpha;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0// gpios: first is IRQ to cpu
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpios =3D <&gpt6 0 0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0word-delay-us =3D <0>;
> =A0 =A0 =A0 =A0};
> };
>
> I've got it working for a mm_gpio, but it's probably not the right
> approach, I have the following questions to get to the right solution:
> - Should gpiolib's gpio_to_irq function indeed return the IRQ that was
> specified at the GPIO by the DTS (interrupts =3D <1 15 0>)?
> =A0The effect is that if the IRQ is not specified in the DTS the
> gpio_to_irq returns NO_IRQ.
> =A0(On the MPC5200 the IRQ is fixed for GPT6, so instead the cell-index
> could also be used to return a gpio's IRQ)
> - If a GPIO controller supports several GPIOs but one IRQ, is it
> defined what gpio_to_irq should return?
> - Is it okay for gpio_to_irq to return NO_IRQ? =A0(returned by
> irq_of_parse_and_map) if irq is not defined?
>
>
> Henk.
>
> diff --git a/drivers/of/gpio.c b/drivers/of/gpio.c
> index 6eea601..81927d7 100644
> --- a/drivers/of/gpio.c
> +++ b/drivers/of/gpio.c
> @@ -150,6 +150,17 @@ int of_gpio_simple_xlate(struct of_gpio_chip
> *of_gc, struct device_node *np,
> =A0}
> =A0EXPORT_SYMBOL(of_gpio_simple_xlate);
>
> +static int of_mm_gpio_to_irq(struct gpio_chip *gc, unsigned int gpio)
> +{
> + =A0 =A0 =A0 struct of_mm_gpio_chip *mm_gc;
> + =A0 =A0 =A0 struct of_gpio_chip *of_gc;
> +
> + =A0 =A0 =A0 of_gc =3D container_of(gc, struct of_gpio_chip, gc);
> + =A0 =A0 =A0 mm_gc =3D container_of(of_gc, struct of_mm_gpio_chip, of_gc=
);
> + =A0 =A0 =A0 return mm_gc->irq;
> +
> +}
> +
> =A0/**
> =A0* of_mm_gpiochip_add - Add memory mapped GPIO chip (bank)
> =A0* @np: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device node of the GPIO chip
> @@ -188,6 +199,9 @@ int of_mm_gpiochip_add(struct device_node *np,
>
> =A0 =A0 =A0 =A0gc->base =3D -1;
>
> + =A0 =A0 =A0 mm_gc->irq =3D irq_of_parse_and_map(np, 0);
> + =A0 =A0 =A0 gc->to_irq =3D of_mm_gpio_to_irq;
> +
> =A0 =A0 =A0 =A0if (!of_gc->xlate)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_gc->xlate =3D of_gpio_simple_xlate;
>
> diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
> index fc2472c..17fe9ed 100644
> --- a/include/linux/of_gpio.h
> +++ b/include/linux/of_gpio.h
> @@ -54,6 +54,7 @@ struct of_mm_gpio_chip {
> =A0 =A0 =A0 =A0struct of_gpio_chip of_gc;
> =A0 =A0 =A0 =A0void (*save_regs)(struct of_mm_gpio_chip *mm_gc);
> =A0 =A0 =A0 =A0void __iomem *regs;
> + =A0 =A0 =A0 int irq;
> =A0};
>
> =A0static inline struct of_mm_gpio_chip *to_of_mm_gpio_chip(struct gpio_c=
hip *gc)
>
