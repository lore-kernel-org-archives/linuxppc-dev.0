Return-Path: <felix@embedded-sol.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DC390B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 15:57:48 +1000 (EST)
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 47997DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 15:57:47 +1000 (EST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Workaround MPC8572/MPC8536 GPIO 1 errata.
Date: Wed, 12 Aug 2009 08:57:39 +0300
Message-Id: <1250056659-420-1-git-send-email-felix@embedded-sol.com>
In-Reply-To: <>
References: <>
Cc: Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On MPC8572 and MPC8536 the status of GPIO pins configured
as output cannot be determined by reading GPDAT register.
Workaround by reading the status of input pins from GPDAT
and the status of output pins from a shadow register.

Signed-off-by: Felix Radensky <felix@embedded-sol.com>
---
 arch/powerpc/sysdev/mpc8xxx_gpio.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
index 103eace..ee1c0e1 100644
--- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
+++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
@@ -54,6 +54,22 @@ static void mpc8xxx_gpio_save_regs(struct of_mm_gpio_chip *mm)
 	mpc8xxx_gc->data = in_be32(mm->regs + GPIO_DAT);
 }
 
+/* Workaround GPIO 1 errata on MPC8572/MPC8536. The status of GPIOs
+ * defined as output cannot be determined by reading GPDAT register,
+ * so we use shadow data register instead. The status of input pins
+ * is determined by reading GPDAT register.
+ */
+static int mpc8572_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	u32 val;
+	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
+
+	val = in_be32(mm->regs + GPIO_DAT) & ~in_be32(mm->regs + GPIO_DIR);
+
+	return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
+}
+
 static int mpc8xxx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
@@ -136,7 +152,10 @@ static void __init mpc8xxx_add_controller(struct device_node *np)
 	gc->ngpio = MPC8XXX_GPIO_PINS;
 	gc->direction_input = mpc8xxx_gpio_dir_in;
 	gc->direction_output = mpc8xxx_gpio_dir_out;
-	gc->get = mpc8xxx_gpio_get;
+	if (of_device_is_compatible(np, "fsl,mpc8572-gpio"))
+		gc->get = mpc8572_gpio_get;
+	else
+		gc->get = mpc8xxx_gpio_get;
 	gc->set = mpc8xxx_gpio_set;
 
 	ret = of_mm_gpiochip_add(np, mm_gc);
-- 
1.5.4.3
