Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 79FB1DDEDA
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 10:15:12 +1000 (EST)
Subject: [PATCH] Fix I8042 IRQs on MPC8641 HPCN
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Tue, 19 Jun 2007 17:15:09 -0700
Message-Id: <1182298509.5674.356.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The I8042 mouse on the MPC8641 HPCN needs to use IRQ 12, which is
currently in use by some PCI devices.  This moves those devices to IRQ
11 and reserves IRQ 12 for the mouse.

Also, set IRQ 1 and IRQ 12 as legacy IRQs in the ULI 1575 legacy bridge
in order to make the I8042 devices functional.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---

Note that the previous version of this patch also set up the Super I/O
registers.  I have removed that setup code, as there was some
reservations about doing such low-level setup in the kernel.

 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |    4 ++--
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   14 +++++++-------


Index: linux-2.6-powerpc-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
===================================================================
--- linux-2.6-powerpc-8641.orig/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ linux-2.6-powerpc-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -268,7 +268,7 @@
 				/* IDSEL 0x1c */
 				e000 0 0 1 &i8259 9 2
 				e000 0 0 2 &i8259 a 2
-				e000 0 0 3 &i8259 c 2
+				e000 0 0 3 &i8259 b 2
 				e000 0 0 4 &i8259 7 2
 
 				/* IDSEL 0x1d */
@@ -278,7 +278,7 @@
 				e800 0 0 4 &i8259 0 0
 
 				/* IDSEL 0x1e */
-				f000 0 0 1 &i8259 c 2
+				f000 0 0 1 &i8259 b 2
 				f000 0 0 2 &i8259 0 0
 				f000 0 0 3 &i8259 0 0
 				f000 0 0 4 &i8259 0 0
Index: linux-2.6-powerpc-8641/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
===================================================================
--- linux-2.6-powerpc-8641.orig/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ linux-2.6-powerpc-8641/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
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
 
