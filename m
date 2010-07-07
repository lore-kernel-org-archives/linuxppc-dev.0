Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 654DBB6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Jul 2010 21:32:46 +1000 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] mpc52xx_gpio: support MPC52xx simple interrupt GPIO
MIME-Version: 1.0
Message-ID: <201007071332.38754.roman.fietze@telemotive.de>
Date: Wed, 7 Jul 2010 13:32:38 +0200
Content-Type: text/plain;
  charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Sascha, hello List Members,

I could not find a way to access the MPC5200(B) simple interrupt pins
using the 52xx platform GPIO driver. So I added the simple interrupt
pins when the mpc5200-gpio is probed. Is there something I overlooked?
If not, here's the patch.


=46rom 749b58686384275d253eeca8f3f0bd7a12daebe2 Mon Sep 17 00:00:00 2001
=46rom: Roman Fietze <roman.fietze@telemotive.de>
Date: Wed, 7 Jul 2010 13:21:12 +0200
Subject: [PATCH] mpc52xx_gpio: support MPC52xx simple interrupt GPIO

Add two OF GPIO chips when probing fsl,mpc5200-gpio, one for the 32
simple GPIO pins and one for the 8 simple interrupt GPIO pins.

The current order of driver registrations will cause the simple
interrupt GPIO pin numbers be below the ones of the simple GPIO pins,
so current code will not have to be changed, except if there are more
GPIO pins with dynamic pin numbers registered after the platform
driver.

Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
=2D--
 arch/powerpc/platforms/52xx/mpc52xx_gpio.c |  128=20
+++++++++++++++++++++++++++-
 1 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c=20
b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
index fda7c2a..d0a9fce 100644
=2D-- a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
@@ -308,7 +308,107 @@ mpc52xx_simple_gpio_dir_out(struct gpio_chip *gc,=20
unsigned int gpio, int val)
 	return 0;
 }
=20
=2Dstatic int __devinit mpc52xx_simple_gpiochip_probe(struct of_device *ofd=
ev,
+/*
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
+static int mpc52xx_sint_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpio __iomem *regs =3D mm_gc->regs;
+	unsigned int ret;
+
+	ret =3D (in_8(&regs->sint_ival) >> (7 - gpio)) & 1;
+
+	return ret;
+}
+
+static inline void
+__mpc52xx_sint_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpiochip *chip =3D container_of(mm_gc,
+						     struct mpc52xx_gpiochip,=20
mmchip);
+	struct mpc52xx_gpio __iomem *regs =3D mm_gc->regs;
+
+	if (val)
+		chip->shadow_dvo |=3D 1 << (7 - gpio);
+	else
+		chip->shadow_dvo &=3D ~(1 << (7 - gpio));
+	out_8(&regs->sint_dvo, chip->shadow_dvo);
+}
+
+static void
+mpc52xx_sint_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	__mpc52xx_sint_gpio_set(gc, gpio, val);
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+}
+
+static int mpc52xx_sint_gpio_dir_in(struct gpio_chip *gc, unsigned int gpi=
o)
+{
+	struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpiochip *chip =3D container_of(mm_gc,
+						     struct mpc52xx_gpiochip,=20
mmchip);
+	struct mpc52xx_gpio __iomem *regs =3D mm_gc->regs;
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
+mpc52xx_sint_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpiochip *chip =3D container_of(mm_gc,
+						     struct mpc52xx_gpiochip,=20
mmchip);
+	struct mpc52xx_gpio __iomem *regs =3D mm_gc->regs;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	/* First set initial value */
+	__mpc52xx_sint_gpio_set(gc, gpio, val);
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
+	return 0;
+}
+
+static int __devinit mpc52xx_simple_sint_gpiochip_probe(struct of_device=20
*ofdev,
 					const struct of_device_id *match)
 {
 	struct mpc52xx_gpiochip *chip;
@@ -316,6 +416,7 @@ static int __devinit mpc52xx_simple_gpiochip_probe(stru=
ct=20
of_device *ofdev,
 	struct mpc52xx_gpio __iomem *regs;
 	int ret;
=20
+	/* simple GPIO */
 	chip =3D kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
@@ -338,6 +439,29 @@ static int __devinit mpc52xx_simple_gpiochip_probe(str=
uct=20
of_device *ofdev,
 	chip->shadow_ddr =3D in_be32(&regs->simple_ddr);
 	chip->shadow_dvo =3D in_be32(&regs->simple_dvo);
=20
+	/* simple interrupt GPIO */
+	chip =3D kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	ofchip =3D &chip->mmchip.of_gc;
+
+	ofchip->gpio_cells          =3D 2;
+	ofchip->gc.ngpio            =3D 8;
+	ofchip->gc.direction_input  =3D mpc52xx_sint_gpio_dir_in;
+	ofchip->gc.direction_output =3D mpc52xx_sint_gpio_dir_out;
+	ofchip->gc.get              =3D mpc52xx_sint_gpio_get;
+	ofchip->gc.set              =3D mpc52xx_sint_gpio_set;
+
+	ret =3D of_mm_gpiochip_add(ofdev->node, &chip->mmchip);
+	if (ret)
+		return ret;
+
+	regs =3D chip->mmchip.regs;
+	chip->shadow_gpioe =3D in_8(&regs->sint_gpioe);
+	chip->shadow_ddr =3D in_8(&regs->sint_ddr);
+	chip->shadow_dvo =3D in_8(&regs->sint_dvo);
+
 	return 0;
 }
=20
@@ -351,7 +475,7 @@ static const struct of_device_id=20
mpc52xx_simple_gpiochip_match[] =3D {
 static struct of_platform_driver mpc52xx_simple_gpiochip_driver =3D {
 	.name =3D "gpio",
 	.match_table =3D mpc52xx_simple_gpiochip_match,
=2D	.probe =3D mpc52xx_simple_gpiochip_probe,
+	.probe =3D mpc52xx_simple_sint_gpiochip_probe,
 	.remove =3D mpc52xx_gpiochip_remove,
 };
=20
=2D-=20
1.7.1


=2D-=20
Roman Fietze              Telemotive AG Buero Muehlhausen
Breitwiesen                             73347 Muehlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
