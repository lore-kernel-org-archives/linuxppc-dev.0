Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGbyC27n8zDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 17:43:31 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/8xx: Adding support of IRQ in MPC8xx GPIO
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Message-Id: <20170501073813.7567549BED@pc13941vm.idsi0.si.c-s.fr>
Date: Mon,  1 May 2017 09:38:13 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
		#gpio-cells =3D <2>;
		compatible =3D "fsl,cpm1-pario-bank-c";
		reg =3D <0x960 0x10>;
		fsl,cpm1-gpio-irq-mask =3D <0x0fff>;
		interrupts =3D <1 2 6 9 10 11 14 15 23 24 26 31>;
		interrupt-parent =3D <&CPM_PIC>;
		gpio-controller;
	};

The property 'fsl,cpm1-gpio-irq-mask' defines which of the 16 GPIOs
have the associated interrupts defined in the 'interrupts' property.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Updated the binding ; changed property 'interrupt-mask' to 'fsl,cpm1-g=
pio-irq-mask'

 .../devicetree/bindings/soc/fsl/cpm_qe/gpio.txt    | 21 +++++++++++++++++-=

 arch/powerpc/include/asm/cpm1.h                    |  2 ++
 arch/powerpc/sysdev/cpm1.c                         | 25 ++++++++++++++++++=
++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/gpio.txt b/Do=
cumentation/devicetree/bindings/soc/fsl/cpm_qe/gpio.txt
index 349f79f..1bcb151 100644
--- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/gpio.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/gpio.txt
@@ -13,8 +13,17 @@ Required properties:
 - #gpio-cells : Should be two. The first cell is the pin number and the
   second cell is used to specify optional parameters (currently unused).
 - gpio-controller : Marks the port as GPIO controller.
+Optional property:
+- fsl,cpm1-gpio-irq-mask : For banks having interrupt capability (like por=
t C
+  on CPM1), this item tells which ports have an associated interrupt (port=
s are
+  listed in the same order as in PCINT register)
+- interrupts : This property provides the list of interrupt for each GPIO =
having
+  one as described by the fsl,cpm1-gpio-irq-mask property. There should be=
 as
+  many interrupts as number of ones in the mask property. The first interr=
upt in
+  the list corresponds to the most significant bit of the mask.
+- interrupt-parent : Parent for the above interrupt property.
 
-Example of three SOC GPIO banks defined as gpio-controller nodes:
+Example of four SOC GPIO banks defined as gpio-controller nodes:
 
 	CPM1_PIO_A: gpio-controller@950 {
 		#gpio-cells =3D <2>;
@@ -30,6 +39,16 @@ Example of three SOC GPIO banks defined as gpio-controll=
er nodes:
 		gpio-controller;
 	};
 
+	CPM1_PIO_C: gpio-controller@960 {
+		#gpio-cells =3D <2>;
+		compatible =3D "fsl,cpm1-pario-bank-c";
+		reg =3D <0x960 0x10>;
+		fsl,cpm1-gpio-irq-mask =3D <0x0fff>;
+		interrupts =3D <1 2 6 9 10 11 14 15 23 24 26 31>;
+		interrupt-parent =3D <&CPM_PIC>;
+		gpio-controller;
+	};
+
 	CPM1_PIO_E: gpio-controller@ac8 {
 		#gpio-cells =3D <2>;
 		compatible =3D "fsl,cpm1-pario-bank-e";
diff --git a/arch/powerpc/include/asm/cpm1.h b/arch/powerpc/include/asm/cpm=
1.h
index 8ee4211..14ad378 100644
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
index 986cd11..c651e66 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -377,6 +377,10 @@ static void cpm1_set_pin16(int port, int pin, int flag=
s)
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
@@ -578,6 +585,14 @@ static void cpm1_gpio16_set(struct gpio_chip *gc, unsi=
gned int gpio, int value)
 	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
 }
 
+static int cpm1_gpio16_to_irq(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
+	struct cpm1_gpio16_chip *cpm1_gc =3D gpiochip_get_data(&mm_gc->gc);
+
+	return cpm1_gc->irq[gpio] ? : -ENXIO;
+}
+
 static int cpm1_gpio16_dir_out(struct gpio_chip *gc, unsigned int gpio, in=
t val)
 {
 	struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
@@ -618,6 +633,7 @@ int cpm1_gpiochip_add16(struct device_node *np)
 	struct cpm1_gpio16_chip *cpm1_gc;
 	struct of_mm_gpio_chip *mm_gc;
 	struct gpio_chip *gc;
+	u16 mask;
 
 	cpm1_gc =3D kzalloc(sizeof(*cpm1_gc), GFP_KERNEL);
 	if (!cpm1_gc)
@@ -625,6 +641,14 @@ int cpm1_gpiochip_add16(struct device_node *np)
 
 	spin_lock_init(&cpm1_gc->lock);
 
+	if (!of_property_read_u16(np, "fsl,cpm1-gpio-irq-mask", &mask)) {
+		int i, j;
+
+		for (i =3D 0, j =3D 0; i < 16; i++)
+			if (mask & (1 << (15 - i)))
+				cpm1_gc->irq[i] =3D irq_of_parse_and_map(np, j++);
+	}
+
 	mm_gc =3D &cpm1_gc->mm_gc;
 	gc =3D &mm_gc->gc;
 
@@ -634,6 +658,7 @@ int cpm1_gpiochip_add16(struct device_node *np)
 	gc->direction_output =3D cpm1_gpio16_dir_out;
 	gc->get =3D cpm1_gpio16_get;
 	gc->set =3D cpm1_gpio16_set;
+	gc->to_irq =3D cpm1_gpio16_to_irq;
 
 	return of_mm_gpiochip_add_data(np, mm_gc, cpm1_gc);
 }
-- 
2.2.2


---
L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=C3=
=A9rifi=C3=A9e par le logiciel antivirus Avast.
https://www.avast.com/antivirus
