Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 8C75FDDF16
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 02:32:12 +1000 (EST)
Received: from [10.50.1.88] (rhino.az.mvista.com [10.50.1.88])
	by hermes.mvista.com (Postfix) with ESMTP id 90A1F1D29E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 09:32:11 -0700 (PDT)
Subject: Re: [PATCH 3/5] Support for the LPC47M192 SuperIO on the MPC8641 HPCN
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
In-Reply-To: <1179245829.8132.100.camel@rhino>
References: <1179245829.8132.100.camel@rhino>
Content-Type: text/plain
Date: Tue, 15 May 2007 09:32:11 -0700
Message-Id: <1179246731.8132.117.camel@rhino>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds support for the LPC47M192 SuperIO on the MPC8641 HPCN.
Specifically this adds support for the I8042 Keyboard/Mouse and the GPIO
on the chip.

Also, the mouse needs to use IRQ 12, which is currently in use by some
PCI devices.  Move those devices to IRQ 11.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---

 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |    4 -
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   43 +++++++++++++++----
 2 files changed, 38 insertions(+), 9 deletions(-)


Index: linux-2.6-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
===================================================================
--- linux-2.6-8641.orig/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ linux-2.6-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -264,7 +264,7 @@
 				/* IDSEL 0x1c */
 				e000 0 0 1 &i8259 9 2
 				e000 0 0 2 &i8259 a 2
-				e000 0 0 3 &i8259 c 2
+				e000 0 0 3 &i8259 b 2
 				e000 0 0 4 &i8259 7 2
 
 				/* IDSEL 0x1d */
@@ -274,7 +274,7 @@
 				e800 0 0 4 &i8259 0 0
 
 				/* IDSEL 0x1e */
-				f000 0 0 1 &i8259 c 2
+				f000 0 0 1 &i8259 b 2
 				f000 0 0 2 &i8259 0 0
 				f000 0 0 3 &i8259 0 0
 				f000 0 0 4 &i8259 0 0
Index: linux-2.6-8641/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
===================================================================
--- linux-2.6-8641.orig/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ linux-2.6-8641/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -141,7 +141,7 @@ const unsigned char uli1575_irq_route_ta
 	0x1,	/* 9: 0b0001 */
 	0x3,	/* 10: 0b0011 */
 	0x9,	/* 11: 0b1001 */
-	0xb,	/* 12: 0b1011 */
+	0,	/* 12: Reserved */
 	0, 	/* 13: Reserved */
 	0xd,	/* 14, 0b1101 */
 	0xf,	/* 15, 0b1111 */
@@ -211,7 +211,7 @@ static void __devinit quirk_uli1575(stru
 			pirq_map_word |= (uli1575_irq_route_table[i] & 0xf)
 				<< ((irq2pin[i] - PIRQA) * 4);
 
-	/* ULI1575 IRQ mapping conf register default value is 0xb9317542 */
+	/* ULI1575 IRQ mapping conf register default value is 0x09317542 */
 	DBG("Setup ULI1575 IRQ mapping configuration register value = 0x%x\n",
 			pirq_map_word);
 	pci_write_config_dword(dev, 0x48, pirq_map_word);
@@ -266,9 +266,9 @@ static void __devinit quirk_uli1575(stru
 	pci_write_config_byte(dev, 0x44, 0x30 | uli1575_irq_route_table[14]);
 	pci_write_config_byte(dev, 0x75, uli1575_irq_route_table[15]);
 
-	/* Set IRQ14 and IRQ15 to legacy IRQs */
+	/* Set IRQ1, IRQ12, IRQ14 and IRQ15 to legacy IRQs */
 	pci_read_config_word(dev, 0x46, &temp);
-	temp |= 0xc000;
+	temp |= 0xd002;
 	pci_write_config_word(dev, 0x46, temp);
 
 	/* Set i8259 interrupt trigger
@@ -280,12 +280,12 @@ static void __devinit quirk_uli1575(stru
 	 * IRQ 9:  Level
 	 * IRQ 10: Level
 	 * IRQ 11: Level
-	 * IRQ 12: Level
+	 * IRQ 12: Edge
 	 * IRQ 14: Edge
 	 * IRQ 15: Edge
 	 */
-	outb(0xfa, 0x4d0);
-	outb(0x1e, 0x4d1);
+	outb(0xf8, 0x4d0);
+	outb(0x0e, 0x4d1);
 
 #undef ULI1575_SET_DEV_IRQ
 
@@ -293,6 +293,35 @@ static void __devinit quirk_uli1575(stru
 	pci_read_config_byte(dev, 0xb8, &c);
 	c &= 0x7f;
 	pci_write_config_byte(dev, 0xb8, c);
+
+	/* enable superio @ 0x4e and keyboard/mouse address decoding */
+	pci_write_config_byte(dev, 0x63, 0x90);
+
+	/* LPC47M192 Super I/O configuration */
+	outb(0x55, 0x4e);	/* enter superio config mode */
+
+	/* Enable keyboard and mouse */
+	outb(0x07, 0x4e);	/* device selector register */
+	outb(0x07, 0x4f);	/* select keyboard registers (device 7) */
+	outb(0x30, 0x4e);	/* keyboard activation register */
+	outb(0x01, 0x4f);	/* activate keyboard */
+	outb(0x70, 0x4e);	/* keyboard IRQ register */
+	outb(0x01, 0x4f);	/* IRQ1 for keyboard */
+	outb(0x72, 0x4e);	/* mouse IRQ register */
+	outb(0x0c, 0x4f);	/* IRQ12 for mouse */
+
+	/* Enable superio runtime registers for gpio in pci i/o space */
+	outb(0x20, 0x4e);	/* device id register */
+	outb(0x07, 0x4e);	/* device selector register */
+	outb(0x0a, 0x4f);	/* select runtime registers (device A) */
+	outb(0x60, 0x4e);	/* select runtime register address high byte */
+	outb(0x04, 0x4f);	/* runtime register address high byte */
+	outb(0x61, 0x4e);	/* select runtime register address low byte */
+	outb(0x01, 0x4f);	/* runtime register address low byte */
+	outb(0x30, 0x4e);	/* runtime registers activation register */
+	outb(0x01, 0x4f);	/* activate runtime registers */
+
+	outb(0xaa, 0x4e);	/* exit superio config mode */
 }
 
 static void __devinit quirk_uli5288(struct pci_dev *dev)
