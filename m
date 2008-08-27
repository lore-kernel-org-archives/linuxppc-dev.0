Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 4B9F1DDEEE
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2008 20:31:54 +1000 (EST)
Message-ID: <48B52D39.6000706@scram.de>
Date: Wed, 27 Aug 2008 12:32:25 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] cpm1: Fix race condition in CPM1 GPIO library.
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The CPM1 GPIO library code uses the non thread-safe clrbits32/setbits32
macros. This patch protects them with a spinlock.

Based on the CPM2 patch from Laurent Pinchart <laurentp@cse-semaphore.com>,
commit 639d64456e20cbfc866b18dc03cf9f9babc9c7cd.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/sysdev/cpm1.c |   74 +++++++++++++++++++++++++++++++-------------
 1 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index 4a04823..490473c 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -546,15 +546,11 @@ static int cpm1_gpio16_get(struct gpio_chip *gc, unsigned int gpio)
 	return !!(in_be16(&iop->dat) & pin_mask);
 }

-static void cpm1_gpio16_set(struct gpio_chip *gc, unsigned int gpio, int value)
+static void __cpm1_gpio16_set(struct of_mm_gpio_chip *mm_gc, u16 pin_mask,
+	int value)
 {
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
 	struct cpm1_gpio16_chip *cpm1_gc = to_cpm1_gpio16_chip(mm_gc);
 	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
-	unsigned long flags;
-	u16 pin_mask = 1 << (15 - gpio);
-
-	spin_lock_irqsave(&cpm1_gc->lock, flags);

 	if (value)
 		cpm1_gc->cpdata |= pin_mask;
@@ -562,6 +558,18 @@ static void cpm1_gpio16_set(struct gpio_chip *gc, unsigned int gpio, int value)
 		cpm1_gc->cpdata &= ~pin_mask;

 	out_be16(&iop->dat, cpm1_gc->cpdata);
+}
+
+static void cpm1_gpio16_set(struct gpio_chip *gc, unsigned int gpio, int value)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm1_gpio16_chip *cpm1_gc = to_cpm1_gpio16_chip(mm_gc);
+	unsigned long flags;
+	u16 pin_mask = 1 << (15 - gpio);
+
+	spin_lock_irqsave(&cpm1_gc->lock, flags);
+
+	__cpm1_gpio16_set(mm_gc, pin_mask, value);

 	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
 }
@@ -569,14 +577,17 @@ static void cpm1_gpio16_set(struct gpio_chip *gc, unsigned int gpio, int value)
 static int cpm1_gpio16_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm1_gpio16_chip *cpm1_gc = to_cpm1_gpio16_chip(mm_gc);
 	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
-	u16 pin_mask;
+	unsigned long flags;
+	u16 pin_mask = 1 << (15 - gpio);

-	pin_mask = 1 << (15 - gpio);
+	spin_lock_irqsave(&cpm1_gc->lock, flags);

 	setbits16(&iop->dir, pin_mask);
+	__cpm1_gpio16_set(mm_gc, pin_mask, val);

-	cpm1_gpio16_set(gc, gpio, val);
+	spin_unlock_irqrestore(&cpm1_gc->lock, flags);

 	return 0;
 }
@@ -584,13 +595,17 @@ static int cpm1_gpio16_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 static int cpm1_gpio16_dir_in(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm1_gpio16_chip *cpm1_gc = to_cpm1_gpio16_chip(mm_gc);
 	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
-	u16 pin_mask;
+	unsigned long flags;
+	u16 pin_mask = 1 << (15 - gpio);

-	pin_mask = 1 << (15 - gpio);
+	spin_lock_irqsave(&cpm1_gc->lock, flags);

 	clrbits16(&iop->dir, pin_mask);

+	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
+
 	return 0;
 }

@@ -655,15 +670,11 @@ static int cpm1_gpio32_get(struct gpio_chip *gc, unsigned int gpio)
 	return !!(in_be32(&iop->dat) & pin_mask);
 }

-static void cpm1_gpio32_set(struct gpio_chip *gc, unsigned int gpio, int value)
+static void __cpm1_gpio32_set(struct of_mm_gpio_chip *mm_gc, u32 pin_mask,
+	int value)
 {
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
 	struct cpm1_gpio32_chip *cpm1_gc = to_cpm1_gpio32_chip(mm_gc);
 	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
-	unsigned long flags;
-	u32 pin_mask = 1 << (31 - gpio);
-
-	spin_lock_irqsave(&cpm1_gc->lock, flags);

 	if (value)
 		cpm1_gc->cpdata |= pin_mask;
@@ -671,6 +682,18 @@ static void cpm1_gpio32_set(struct gpio_chip *gc, unsigned int gpio, int value)
 		cpm1_gc->cpdata &= ~pin_mask;

 	out_be32(&iop->dat, cpm1_gc->cpdata);
+}
+
+static void cpm1_gpio32_set(struct gpio_chip *gc, unsigned int gpio, int value)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm1_gpio32_chip *cpm1_gc = to_cpm1_gpio32_chip(mm_gc);
+	unsigned long flags;
+	u32 pin_mask = 1 << (31 - gpio);
+
+	spin_lock_irqsave(&cpm1_gc->lock, flags);
+
+	__cpm1_gpio32_set(mm_gc, pin_mask, value);

 	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
 }
@@ -678,14 +701,17 @@ static void cpm1_gpio32_set(struct gpio_chip *gc, unsigned int gpio, int value)
 static int cpm1_gpio32_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm1_gpio32_chip *cpm1_gc = to_cpm1_gpio32_chip(mm_gc);
 	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
-	u32 pin_mask;
+	unsigned long flags;
+	u32 pin_mask = 1 << (31 - gpio);

-	pin_mask = 1 << (31 - gpio);
+	spin_lock_irqsave(&cpm1_gc->lock, flags);

 	setbits32(&iop->dir, pin_mask);
+	__cpm1_gpio32_set(mm_gc, pin_mask, val);

-	cpm1_gpio32_set(gc, gpio, val);
+	spin_unlock_irqrestore(&cpm1_gc->lock, flags);

 	return 0;
 }
@@ -693,13 +719,17 @@ static int cpm1_gpio32_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 static int cpm1_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm1_gpio32_chip *cpm1_gc = to_cpm1_gpio32_chip(mm_gc);
 	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
-	u32 pin_mask;
+	unsigned long flags;
+	u32 pin_mask = 1 << (31 - gpio);

-	pin_mask = 1 << (31 - gpio);
+	spin_lock_irqsave(&cpm1_gc->lock, flags);

 	clrbits32(&iop->dir, pin_mask);

+	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
+
 	return 0;
 }

-- 
1.5.6.3
