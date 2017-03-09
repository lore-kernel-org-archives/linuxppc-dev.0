Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vf55c5f9bzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 20:42:12 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: sysdev: cpm1: Optimise gpio bit calculation
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170309094206.A832167992@localhost.localdomain>
Date: Thu,  9 Mar 2017 10:42:06 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Help a bit the compiler to provide better code:

unsigned int f(int i)
{
	return 1 << (31 - i);
}

unsigned int g(int i)
{
	return 0x80000000 >> i;
}

Disassembly of section .text:

00000000 <f>:
   0:	20 63 00 1f 	subfic  r3,r3,31
   4:	39 20 00 01 	li      r9,1
   8:	7d 23 18 30 	slw     r3,r9,r3
   c:	4e 80 00 20 	blr

00000010 <g>:
  10:	3d 20 80 00 	lis     r9,-32768
  14:	7d 23 1c 30 	srw     r3,r9,r3
  18:	4e 80 00 20 	blr

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/sysdev/cpm1.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index dc3653da6dd1..2b0bb55612d2 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -307,7 +307,7 @@ struct cpm_ioport32e {
 static void cpm1_set_pin32(int port, int pin, int flags)
 {
 	struct cpm_ioport32e __iomem *iop;
-	pin = 1 << (31 - pin);
+	pin = 0x80000000 >> pin;
 
 	if (port == CPM_PORTB)
 		iop = (struct cpm_ioport32e __iomem *)
@@ -351,7 +351,7 @@ static void cpm1_set_pin16(int port, int pin, int flags)
 	struct cpm_ioport16 __iomem *iop =
 		(struct cpm_ioport16 __iomem *)&mpc8xx_immr->im_ioport;
 
-	pin = 1 << (15 - pin);
+	pin = 0x8000 >> pin;
 
 	if (port != 0)
 		iop += port - 1;
@@ -550,9 +550,7 @@ static int cpm1_gpio16_get(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
 	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
-	u16 pin_mask;
-
-	pin_mask = 1 << (15 - gpio);
+	u16 pin_mask = pin_mask = 0x8000 >> gpio;
 
 	return !!(in_be16(&iop->dat) & pin_mask);
 }
@@ -576,7 +574,7 @@ static void cpm1_gpio16_set(struct gpio_chip *gc, unsigned int gpio, int value)
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
 	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
 	unsigned long flags;
-	u16 pin_mask = 1 << (15 - gpio);
+	u16 pin_mask = 0x8000 >> gpio;
 
 	spin_lock_irqsave(&cpm1_gc->lock, flags);
 
@@ -599,7 +597,7 @@ static int cpm1_gpio16_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
 	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
 	unsigned long flags;
-	u16 pin_mask = 1 << (15 - gpio);
+	u16 pin_mask = 0x8000 >> gpio;
 
 	spin_lock_irqsave(&cpm1_gc->lock, flags);
 
@@ -617,7 +615,7 @@ static int cpm1_gpio16_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
 	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
 	unsigned long flags;
-	u16 pin_mask = 1 << (15 - gpio);
+	u16 pin_mask = 0x8000 >> gpio;
 
 	spin_lock_irqsave(&cpm1_gc->lock, flags);
 
@@ -684,9 +682,7 @@ static int cpm1_gpio32_get(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
 	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
-	u32 pin_mask;
-
-	pin_mask = 1 << (31 - gpio);
+	u32 pin_mask = 0x80000000 >> gpio;
 
 	return !!(in_be32(&iop->dat) & pin_mask);
 }
@@ -710,7 +706,7 @@ static void cpm1_gpio32_set(struct gpio_chip *gc, unsigned int gpio, int value)
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
 	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
 	unsigned long flags;
-	u32 pin_mask = 1 << (31 - gpio);
+	u32 pin_mask = 0x80000000 >> gpio;
 
 	spin_lock_irqsave(&cpm1_gc->lock, flags);
 
@@ -725,7 +721,7 @@ static int cpm1_gpio32_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
 	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
 	unsigned long flags;
-	u32 pin_mask = 1 << (31 - gpio);
+	u32 pin_mask = 0x80000000 >> gpio;
 
 	spin_lock_irqsave(&cpm1_gc->lock, flags);
 
@@ -743,7 +739,7 @@ static int cpm1_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
 	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
 	unsigned long flags;
-	u32 pin_mask = 1 << (31 - gpio);
+	u32 pin_mask = 0x80000000 >> gpio;
 
 	spin_lock_irqsave(&cpm1_gc->lock, flags);
 
-- 
2.12.0
