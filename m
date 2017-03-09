Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vf55b2LS3zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 20:42:09 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: Adding support of IRQ in MPC8xx GPIO
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170309094204.ACF5567992@localhost.localdomain>
Date: Thu,  9 Mar 2017 10:42:04 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch allows the use of IRQ to notify the change of GPIO status
on MPC8xx CPM IO ports. This then allows to associate IRQs to GPIOs
in the Device Tree.

Ex:
	CPM1_PIO_C: gpio-controller@960 {
		#gpio-cells = <2>;
		compatible = "fsl,cpm1-pario-bank-c";
		reg = <0x960 0x10>;
		interrupts = <1 2 6 9 10 11 14 15 23 24 26 31>;
		interrupts-mask = <0x0fff>;
		interrupt-parent = <&CPM_PIC>;
		gpio-controller;
	};

The property 'interrupts-mask' defines which of the 16 GPIOs have
the associated interrupts defined in the 'interrupts' property.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/cpm1.h |  2 ++
 arch/powerpc/sysdev/cpm1.c      | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/powerpc/include/asm/cpm1.h b/arch/powerpc/include/asm/cpm1.h
index 8ee4211ca0c6..14ad37865000 100644
--- a/arch/powerpc/include/asm/cpm1.h
+++ b/arch/powerpc/include/asm/cpm1.h
@@ -560,6 +560,8 @@ typedef struct risc_timer_pram {
 #define CPM_PIN_SECONDARY 2
 #define CPM_PIN_GPIO      4
 #define CPM_PIN_OPENDRAIN 8
+#define CPM_PIN_FALLEDGE  16
+#define CPM_PIN_ANYEDGE   0
 
 enum cpm_port {
 	CPM_PORTA,
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index 986cd111d4df..dc3653da6dd1 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -377,6 +377,10 @@ static void cpm1_set_pin16(int port, int pin, int flags)
 			setbits16(&iop->odr_sor, pin);
 		else
 			clrbits16(&iop->odr_sor, pin);
+		if (flags & CPM_PIN_FALLEDGE)
+			setbits16(&iop->intr, pin);
+		else
+			clrbits16(&iop->intr, pin);
 	}
 }
 
@@ -528,6 +532,9 @@ struct cpm1_gpio16_chip {
 
 	/* shadowed data register to clear/set bits safely */
 	u16 cpdata;
+
+	/* IRQ associated with Pins when relevant */
+	int irq[16];
 };
 
 static void cpm1_gpio16_save_regs(struct of_mm_gpio_chip *mm_gc)
@@ -578,6 +585,14 @@ static void cpm1_gpio16_set(struct gpio_chip *gc, unsigned int gpio, int value)
 	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
 }
 
+static int cpm1_gpio16_to_irq(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
+
+	return cpm1_gc->irq[gpio] ? : -ENXIO;
+}
+
 static int cpm1_gpio16_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
@@ -618,6 +633,7 @@ int cpm1_gpiochip_add16(struct device_node *np)
 	struct cpm1_gpio16_chip *cpm1_gc;
 	struct of_mm_gpio_chip *mm_gc;
 	struct gpio_chip *gc;
+	u16 mask;
 
 	cpm1_gc = kzalloc(sizeof(*cpm1_gc), GFP_KERNEL);
 	if (!cpm1_gc)
@@ -625,6 +641,14 @@ int cpm1_gpiochip_add16(struct device_node *np)
 
 	spin_lock_init(&cpm1_gc->lock);
 
+	if (!of_property_read_u16(np, "interrupts-mask", &mask)) {
+		int i, j;
+
+		for (i = 0, j = 0; i < 16; i++)
+			if (mask & (1 << (15 - i)))
+				cpm1_gc->irq[i] = irq_of_parse_and_map(np, j++);
+	}
+
 	mm_gc = &cpm1_gc->mm_gc;
 	gc = &mm_gc->gc;
 
@@ -634,6 +658,7 @@ int cpm1_gpiochip_add16(struct device_node *np)
 	gc->direction_output = cpm1_gpio16_dir_out;
 	gc->get = cpm1_gpio16_get;
 	gc->set = cpm1_gpio16_set;
+	gc->to_irq = cpm1_gpio16_to_irq;
 
 	return of_mm_gpiochip_add_data(np, mm_gc, cpm1_gc);
 }
-- 
2.12.0
