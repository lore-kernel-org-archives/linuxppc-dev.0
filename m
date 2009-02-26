Return-Path: <roman.fietze@telemotive.de>
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id 5EADADDE22
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 01:31:05 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 6B8B2A2778
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 15:24:52 +0100 (CET)
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add MPC52xx simple interrupt GPIO support
From: Roman Fietze <roman.fietze@telemotive.de>
MIME-Version: 1.0
Message-ID: <200902261524.51750.roman.fietze@telemotive.de>
Date: Thu, 26 Feb 2009 15:24:51 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I've got a target derived from the Lite5200 that needs to use simple
interrupt GPIO pins. I created a patch to support this kind of GPIO.

I would need your opinion and like to hear any criticism. Esp. the
facts that I ad to split up struct mpc52xx_gpio and that the GPIO
numbering might get mixed up concern me.

Because I'm somewhat new to git, at least when it comes to create and
incorporate patches via mail, you have to point out those errors as
well. The first thing I found lready out ist, that my patch isn't
signed off. I'll do that with an final version if I get the chance to
deliver one.


And here the patch:


Add MPC52xx simple interrupt GPIO support

Split of struct mpc52xx_sint_gpio from struct mpc52xx_gpio to allow a
different reg base address in the device tree.
Add the appropriate functions.
Update Documentation.
=2D--
 .../powerpc/mpc52xx-device-tree-bindings.txt       |    2 +
 arch/powerpc/include/asm/mpc52xx.h                 |   40 +++--
 arch/powerpc/platforms/52xx/mpc52xx_gpio.c         |  164=20
+++++++++++++++++++-
 3 files changed, 185 insertions(+), 21 deletions(-)

diff --git a/Documentation/powerpc/mpc52xx-device-tree-bindings.txt=20
b/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
index 6f12f1c..b5b31b2 100644
=2D-- a/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
+++ b/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
@@ -190,6 +190,8 @@ gpt@<addr>	gpt		fsl,mpc5200-gpt-gpio	General purpose
 							timers in GPIO mode
 gpio@<addr>			fsl,mpc5200-gpio	MPC5200 simple gpio
 							controller
+gpio@<addr>			fsl,mpc5200-gpio-sint	MPC5200 simple interrupt
+							gpio controller
 gpio@<addr>			fsl,mpc5200-gpio-wkup	MPC5200 wakeup gpio
 							controller
 rtc@<addr>	rtc		mpc5200-rtc	  Real time clock
diff --git a/arch/powerpc/include/asm/mpc52xx.h=20
b/arch/powerpc/include/asm/mpc52xx.h
index 7655504..01abe61 100644
=2D-- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -126,24 +126,28 @@ struct mpc52xx_gpio {
 	u8 reserved1[3];	/* GPIO + 0x19 */
 	u8 outo_dvo;		/* GPIO + 0x1c */
 	u8 reserved2[3];	/* GPIO + 0x1d */
=2D	u8 sint_gpioe;		/* GPIO + 0x20 */
=2D	u8 reserved3[3];	/* GPIO + 0x21 */
=2D	u8 sint_ode;		/* GPIO + 0x24 */
=2D	u8 reserved4[3];	/* GPIO + 0x25 */
=2D	u8 sint_ddr;		/* GPIO + 0x28 */
=2D	u8 reserved5[3];	/* GPIO + 0x29 */
=2D	u8 sint_dvo;		/* GPIO + 0x2c */
=2D	u8 reserved6[3];	/* GPIO + 0x2d */
=2D	u8 sint_inten;		/* GPIO + 0x30 */
=2D	u8 reserved7[3];	/* GPIO + 0x31 */
=2D	u16 sint_itype;		/* GPIO + 0x34 */
=2D	u16 reserved8;		/* GPIO + 0x36 */
=2D	u8 gpio_control;	/* GPIO + 0x38 */
=2D	u8 reserved9[3];	/* GPIO + 0x39 */
=2D	u8 sint_istat;		/* GPIO + 0x3c */
=2D	u8 sint_ival;		/* GPIO + 0x3d */
=2D	u8 bus_errs;		/* GPIO + 0x3e */
=2D	u8 reserved10;		/* GPIO + 0x3f */
+};
+
+/* Simple Interrupt GPIO */
+struct mpc52xx_sint_gpio {
+	u8 sint_gpioe;		/* GPIO + 0x00 */
+	u8 reserved3[3];	/* GPIO + 0x01 */
+	u8 sint_ode;		/* GPIO + 0x04 */
+	u8 reserved4[3];	/* GPIO + 0x05 */
+	u8 sint_ddr;		/* GPIO + 0x08 */
+	u8 reserved5[3];	/* GPIO + 0x09 */
+	u8 sint_dvo;		/* GPIO + 0x0c */
+	u8 reserved6[3];	/* GPIO + 0x0d */
+	u8 sint_inten;		/* GPIO + 0x10 */
+	u8 reserved7[3];	/* GPIO + 0x11 */
+	u16 sint_itype;		/* GPIO + 0x14 */
+	u16 reserved8;		/* GPIO + 0x16 */
+	u8 gpio_control;	/* GPIO + 0x18 */
+	u8 reserved9[3];	/* GPIO + 0x19 */
+	u8 sint_istat;		/* GPIO + 0x1c */
+	u8 sint_ival;		/* GPIO + 0x1d */
+	u8 bus_errs;		/* GPIO + 0x1e */
+	u8 reserved10;		/* GPIO + 0x1f */
 };
=20
 #define MPC52xx_GPIO_PSC_CONFIG_UART_WITHOUT_CD	4
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c=20
b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
index 07f89ae..8595aad 100644
=2D-- a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
@@ -31,9 +31,9 @@ static DEFINE_SPINLOCK(gpio_lock);
=20
 struct mpc52xx_gpiochip {
 	struct of_mm_gpio_chip mmchip;
=2D	unsigned int shadow_dvo;
=2D	unsigned int shadow_gpioe;
=2D	unsigned int shadow_ddr;
+	uint32_t shadow_dvo;
+	uint32_t shadow_gpioe;
+	uint32_t shadow_ddr;
 };
=20
 /*
@@ -355,6 +355,161 @@ static struct of_platform_driver=20
mpc52xx_simple_gpiochip_driver =3D {
 };
=20
 /*
+ * GPIO LIB API implementation for simple interrupt GPIOs
+ *
+ * There's a maximum of 8 simple interrupt GPIOs. Which of these are
+ * available for use depends on your board setup.  The numbering
+ * reflects the bit numbering in the port registers:
+ *
+ *  0.. 3 > ETH_16..ETH_13
+ *  4     > USB1_9
+ *  5     > PSC3_8
+ *  6.. 7 > PSC3_5..PSC3_4
+ */
+static int mpc52xx_simple_interrupt_gpio_get(struct gpio_chip *gc, unsigne=
d=20
int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
+	struct mpc52xx_sint_gpio __iomem *regs =3D mm_gc->regs;
+	unsigned int ret;
+
+	ret =3D (in_8(&regs->sint_ival) >> (7 - gpio)) & 1;
+
+	pr_info("%s(..,%u) data=3D0x%02x ret=3D%d\n", __func__, gpio, in_8
(&regs->sint_ival), ret);
+
+	return ret;
+}
+
+static inline void
+__mpc52xx_simple_interrupt_gpio_set(struct gpio_chip *gc, unsigned int gpi=
o,=20
int val)
+{
+	struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpiochip *chip =3D container_of(mm_gc,
+			struct mpc52xx_gpiochip, mmchip);
+	struct mpc52xx_sint_gpio __iomem *regs =3D mm_gc->regs;
+
+	if (val)
+		chip->shadow_dvo |=3D 1 << (7 - gpio);
+	else
+		chip->shadow_dvo &=3D ~(1 << (7 - gpio));
+	out_8(&regs->sint_dvo, chip->shadow_dvo);
+}
+
+static void
+mpc52xx_simple_interrupt_gpio_set(struct gpio_chip *gc, unsigned int gpio,=
=20
int val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	__mpc52xx_simple_interrupt_gpio_set(gc, gpio, val);
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+}
+
+static int mpc52xx_simple_interrupt_gpio_dir_in(struct gpio_chip *gc,=20
unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpiochip *chip =3D container_of(mm_gc,
+			struct mpc52xx_gpiochip, mmchip);
+	struct mpc52xx_sint_gpio __iomem *regs =3D mm_gc->regs;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	/* set the direction */
+	chip->shadow_ddr &=3D ~(1 << (7 - gpio));
+	out_8(&regs->sint_ddr, chip->shadow_ddr);
+
+	/* and enable the pin */
+	chip->shadow_gpioe |=3D 1 << (7 - gpio);
+	out_8(&regs->sint_gpioe, chip->shadow_gpioe);
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	return 0;
+}
+
+static int
+mpc52xx_simple_interrupt_gpio_dir_out(struct gpio_chip *gc, unsigned int=20
gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpiochip *chip =3D container_of(mm_gc,
+			struct mpc52xx_gpiochip, mmchip);
+	struct mpc52xx_sint_gpio __iomem *regs =3D mm_gc->regs;
+	unsigned long flags;
+
+	pr_info("%s(...,%u,%d)\n", __func__, gpio, val);
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	/* First set initial value */
+	__mpc52xx_simple_interrupt_gpio_set(gc, gpio, val);
+
+	/* Then set direction */
+	chip->shadow_ddr |=3D 1 << (7 - gpio);
+	out_8(&regs->sint_ddr, chip->shadow_ddr);
+
+	/* Finally enable the pin */
+	chip->shadow_gpioe |=3D 1 << (7 - gpio);
+	out_8(&regs->sint_gpioe, chip->shadow_gpioe);
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	pr_info("%s: gpio: %d val: %d\n", __func__, gpio, val);
+
+	return 0;
+}
+
+static int __devinit mpc52xx_simple_interrupt_gpiochip_probe(struct of_dev=
ice=20
*ofdev,
+							     const struct of_device_id *match)
+{
+	struct mpc52xx_gpiochip *chip;
+	struct of_gpio_chip *ofchip;
+	struct mpc52xx_sint_gpio __iomem *regs;
+	int ret;
+
+	chip =3D kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	ofchip =3D &chip->mmchip.of_gc;
+
+	ofchip->gpio_cells          =3D 2;
+	ofchip->gc.ngpio            =3D 8;
+	ofchip->gc.direction_input  =3D mpc52xx_simple_interrupt_gpio_dir_in;
+	ofchip->gc.direction_output =3D mpc52xx_simple_interrupt_gpio_dir_out;
+	ofchip->gc.get              =3D mpc52xx_simple_interrupt_gpio_get;
+	ofchip->gc.set              =3D mpc52xx_simple_interrupt_gpio_set;
+
+	ret =3D of_mm_gpiochip_add(ofdev->node, &chip->mmchip);
+	if (ret)
+		return ret;
+
+	regs =3D chip->mmchip.regs;
+	pr_info("%s() regs=3D%p\n", __func__, regs);
+
+	chip->shadow_gpioe =3D in_8(&regs->sint_gpioe);
+	chip->shadow_ddr =3D in_8(&regs->sint_ddr);
+	chip->shadow_dvo =3D in_8(&regs->sint_dvo);
+
+	return 0;
+}
+
+static const struct of_device_id mpc52xx_simple_interrupt_gpiochip_match[]=
 =3D=20
{
+	{
+		.compatible =3D "fsl,mpc5200-gpio-sint",
+	},
+	{}
+};
+
+static struct of_platform_driver mpc52xx_simple_interrupt_gpiochip_driver =
=3D {
+	.name =3D "gpio_sint",
+	.match_table =3D mpc52xx_simple_interrupt_gpiochip_match,
+	.probe =3D mpc52xx_simple_interrupt_gpiochip_probe,
+	.remove =3D mpc52xx_gpiochip_remove,
+};
+
+/*
  * GPIO LIB API implementation for gpt GPIOs.
  *
  * Each gpt only has a single GPIO.
@@ -444,6 +599,9 @@ static int __init mpc52xx_gpio_init(void)
 	if (of_register_platform_driver(&mpc52xx_simple_gpiochip_driver))
 		printk(KERN_ERR "Unable to register simple GPIO driver\n");
=20
+	if (of_register_platform_driver(&mpc52xx_simple_interrupt_gpiochip_driver=
))
+		printk(KERN_ERR "Unable to register simple interrupt GPIO driver\n");
+
 	if (of_register_platform_driver(&mpc52xx_gpt_gpiochip_driver))
 		printk(KERN_ERR "Unable to register gpt GPIO driver\n");
=20
=2D-=20
1.6.1.2




Roman

=2D-=20
Roman Fietze  Telemotive AG  B=FCro M=FChlhausen
