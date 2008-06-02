Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A8B9DDF24
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2008 19:59:07 +1000 (EST)
To: torvalds@linux-foundation.org
Subject: [PATCH] mpc52xx_gpio iomem annotations
Message-Id: <E1K36og-0007Yp-He@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 02 Jun 2008 10:59:02 +0100
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
index 48da5df..8a455eb 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
@@ -100,7 +100,7 @@ static int mpc52xx_wkup_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
 	struct mpc52xx_gpiochip *chip = container_of(mm_gc,
 			struct mpc52xx_gpiochip, mmchip);
-	struct mpc52xx_gpio_wkup *regs = mm_gc->regs;
+	struct mpc52xx_gpio_wkup __iomem *regs = mm_gc->regs;
 	unsigned long flags;
 
 	spin_lock_irqsave(&gpio_lock, flags);
@@ -122,7 +122,7 @@ static int
 mpc52xx_wkup_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct mpc52xx_gpio_wkup *regs = mm_gc->regs;
+	struct mpc52xx_gpio_wkup __iomem *regs = mm_gc->regs;
 	struct mpc52xx_gpiochip *chip = container_of(mm_gc,
 			struct mpc52xx_gpiochip, mmchip);
 	unsigned long flags;
@@ -150,7 +150,7 @@ static int __devinit mpc52xx_wkup_gpiochip_probe(struct of_device *ofdev,
 					const struct of_device_id *match)
 {
 	struct mpc52xx_gpiochip *chip;
-	struct mpc52xx_gpio_wkup *regs;
+	struct mpc52xx_gpio_wkup __iomem *regs;
 	struct of_gpio_chip *ofchip;
 	int ret;
 
@@ -260,7 +260,7 @@ static int mpc52xx_simple_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
 	struct mpc52xx_gpiochip *chip = container_of(mm_gc,
 			struct mpc52xx_gpiochip, mmchip);
-	struct mpc52xx_gpio *regs = mm_gc->regs;
+	struct mpc52xx_gpio __iomem *regs = mm_gc->regs;
 	unsigned long flags;
 
 	spin_lock_irqsave(&gpio_lock, flags);
@@ -284,7 +284,7 @@ mpc52xx_simple_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
 	struct mpc52xx_gpiochip *chip = container_of(mm_gc,
 			struct mpc52xx_gpiochip, mmchip);
-	struct mpc52xx_gpio *regs = mm_gc->regs;
+	struct mpc52xx_gpio __iomem *regs = mm_gc->regs;
 	unsigned long flags;
 
 	spin_lock_irqsave(&gpio_lock, flags);
@@ -312,7 +312,7 @@ static int __devinit mpc52xx_simple_gpiochip_probe(struct of_device *ofdev,
 {
 	struct mpc52xx_gpiochip *chip;
 	struct of_gpio_chip *ofchip;
-	struct mpc52xx_gpio *regs;
+	struct mpc52xx_gpio __iomem *regs;
 	int ret;
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
@@ -387,7 +387,7 @@ mpc52xx_gpt_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 static int mpc52xx_gpt_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct mpc52xx_gpt *regs = mm_gc->regs;
+	struct mpc52xx_gpt __iomem *regs = mm_gc->regs;
 
 	out_be32(&regs->mode, 0x04);
 
