Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 684DCDDF33
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 22:20:28 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: cpm2: Fix race condition in CPM2 GPIO library.
Date: Tue, 19 Aug 2008 14:20:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808191420.24837.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The CPM2 GPIO library code uses the non thread-safe clrbits32/setbits32
macros. This patch protects them with a spinlock.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
---
 arch/powerpc/sysdev/cpm_common.c |   37 ++++++++++++++++++++++++++-----------
 1 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index 53da8a0..00d3d17 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -254,15 +254,11 @@ static int cpm2_gpio32_get(struct gpio_chip *gc, unsigned int gpio)
 	return !!(in_be32(&iop->dat) & pin_mask);
 }
 
-static void cpm2_gpio32_set(struct gpio_chip *gc, unsigned int gpio, int value)
+static void __cpm2_gpio32_set(struct of_mm_gpio_chip *mm_gc, u32 pin_mask,
+	int value)
 {
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
 	struct cpm2_gpio32_chip *cpm2_gc = to_cpm2_gpio32_chip(mm_gc);
 	struct cpm2_ioports __iomem *iop = mm_gc->regs;
-	unsigned long flags;
-	u32 pin_mask = 1 << (31 - gpio);
-
-	spin_lock_irqsave(&cpm2_gc->lock, flags);
 
 	if (value)
 		cpm2_gc->cpdata |= pin_mask;
@@ -270,6 +266,18 @@ static void cpm2_gpio32_set(struct gpio_chip *gc, unsigned int gpio, int value)
 		cpm2_gc->cpdata &= ~pin_mask;
 
 	out_be32(&iop->dat, cpm2_gc->cpdata);
+}
+
+static void cpm2_gpio32_set(struct gpio_chip *gc, unsigned int gpio, int value)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm2_gpio32_chip *cpm2_gc = to_cpm2_gpio32_chip(mm_gc);
+	unsigned long flags;
+	u32 pin_mask = 1 << (31 - gpio);
+
+	spin_lock_irqsave(&cpm2_gc->lock, flags);
+
+	__cpm2_gpio32_set(mm_gc, pin_mask, value);
 
 	spin_unlock_irqrestore(&cpm2_gc->lock, flags);
 }
@@ -277,14 +285,17 @@ static void cpm2_gpio32_set(struct gpio_chip *gc, unsigned int gpio, int value)
 static int cpm2_gpio32_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm2_gpio32_chip *cpm2_gc = to_cpm2_gpio32_chip(mm_gc);
 	struct cpm2_ioports __iomem *iop = mm_gc->regs;
-	u32 pin_mask;
+	unsigned long flags;
+	u32 pin_mask = 1 << (31 - gpio);
 
-	pin_mask = 1 << (31 - gpio);
+	spin_lock_irqsave(&cpm2_gc->lock, flags);
 
 	setbits32(&iop->dir, pin_mask);
+	__cpm2_gpio32_set(mm_gc, pin_mask, val);
 
-	cpm2_gpio32_set(gc, gpio, val);
+	spin_unlock_irqrestore(&cpm2_gc->lock, flags);
 
 	return 0;
 }
@@ -292,13 +303,17 @@ static int cpm2_gpio32_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 static int cpm2_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm2_gpio32_chip *cpm2_gc = to_cpm2_gpio32_chip(mm_gc);
 	struct cpm2_ioports __iomem *iop = mm_gc->regs;
-	u32 pin_mask;
+	unsigned long flags;
+	u32 pin_mask = 1 << (31 - gpio);
 
-	pin_mask = 1 << (31 - gpio);
+	spin_lock_irqsave(&cpm2_gc->lock, flags);
 
 	clrbits32(&iop->dir, pin_mask);
 
+	spin_unlock_irqrestore(&cpm2_gc->lock, flags);
+
 	return 0;
 }
 
-- 
1.5.0


-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
