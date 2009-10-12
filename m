Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 84451B7088
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 23:32:23 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9CCSf2x021372
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 08:28:41 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9CCWHUf257522
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 08:32:19 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9CCWG8N013890
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 08:32:17 -0400
Date: Mon, 12 Oct 2009 08:32:13 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Niklaus Giger <niklaus.giger@member.fsf.org>
Subject: Re: [PATCH 1/1] powerpc/40x: Add new PPC440EPx based board HCU5 of
	Netstal Maschinen
Message-ID: <20091012123213.GD22408@zod.rchland.ibm.com>
References: <1255075865-4025-1-git-send-email-niklaus.giger@member.fsf.org>
	<1255075865-4025-2-git-send-email-niklaus.giger@member.fsf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1255075865-4025-2-git-send-email-niklaus.giger@member.fsf.org>
Cc: linuxppc-dev@ozlabs.org, niklaus.giger@netstal.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 09, 2009 at 10:11:05AM +0200, Niklaus Giger wrote:
>Adds support for a HCU5 PPC405EPx based board from Netstal Maschinen AG.

Should be 440EPx, no?

Also, the subject should probably be "powerpc/44x".  These are minor things,
not really a big deal.  Overall, nice patch.  See below for a few more
comments.



>+			UART0: serial@ef600300 {
>+		   		device_type = "serial";
>+		   		compatible = "ns16550";
>+		   		reg = <0xef600300 0x00000008>;
>+		   		virtual-reg = <0xef600300>;
>+		   		clock-frequency = <0>; /* Filled in by U-Boot */
>+		   		current-speed = <0>; /* Filled in by U-Boot */

I've been considering dropping the current-speed property entirely in most
4xx boards.  Given that you have a bootargs specified in chosen that explicitly
tells the kernel to use 115200, do you think you could drop this property and
see how things work?

>+		   		interrupt-parent = <&UIC0>;
>+		   		interrupts = <0x0 0x4>;
>+	   		};
>+
>+			IIC0: i2c@ef600700 {
>+				#address-cells = <1>;
>+				#size-cells = <0>;
>+				compatible = "ibm,iic-440epx", "ibm,iic";
>+				reg = <0xef600700 0x00000014>;
>+				interrupt-parent = <&UIC0>;
>+				interrupts = <0x2 0x4>;
>+			};
>+
>+			IIC1: i2c@ef600800 {
>+				#address-cells = <1>;
>+				#size-cells = <0>;
>+				compatible = "ibm,iic-440epx", "ibm,iic";
>+				reg = <0xef600800 0x00000014>;
>+				interrupt-parent = <&UIC0>;
>+				interrupts = <0x7 0x4>;
>+			};
>+
>+
>+			ZMII0: emac-zmii@ef600d00 {
>+				compatible = "ibm,zmii-440epx", "ibm,zmii";
>+				reg = <0xef600d00 0x0000000c>;
>+			};
>+
>+			SMII0: emac-smii@ef601000 {
>+					compatible = "ibm,smii-440epx", "ibm,smmii";
>+					reg = <0xef601000 0x00000008>;
>+					has-mdio;
>+				};
>+
>+			EMAC0: ethernet@ef600e00 {
>+				device_type = "network";
>+				compatible = "ibm,emac-440epx", "ibm,emac4";
>+				interrupt-parent = <&EMAC0>;
>+				interrupts = <0x0 0x1>;
>+				#interrupt-cells = <1>;
>+				#address-cells = <0>;
>+				#size-cells = <0>;
>+				interrupt-map = </*Status*/ 0x0 &UIC0 0x18 0x4
>+				/*Wake*/  0x1 &UIC1 0x1d 0x4>;
>+				reg = <0xef600e00 0x00000074>;
>+				local-mac-address = [000000000000];
>+				mal-device = <&MAL0>;
>+				mal-tx-channel = <0>;
>+				mal-rx-channel = <0>;
>+				cell-index = <0>;
>+				max-frame-size = <9000>;
>+				rx-fifo-size = <4096>;
>+				tx-fifo-size = <2048>;
>+				phy-mode = "smii";
>+				phy-map = <1>;
>+				zmii-device = <&ZMII0>;
>+				zmii-channel = <0>;
>+				has-inverted-stacr-oc;
>+				has-new-stacr-staopc;
>+			};
>+
>+			CPLD: cpld@0xcd000000 {
>+				reg = <0xcd000000 0x00000100>;
>+				interval = "1000";
>+				device_type = "cpld";

Should drop the device_type.

>+				interrupt-parent = <&UIC1>;
>+				interrupts = <28 8>; /* 8 is IRQ_TYPE_LEVEL_LOW */
>+			};
>+
>+			/* The HCU5 has two Intel CAN SCC82527 controllers */
>+			CAN1: can0@0xc8000000 {
>+				device_type = "can1";

Same comment here and for the one below as well.

>+				compatible = "intel,82527";
>+				reg = <0xc800000 0x00000100>;
>+				interrupt-parent = <&UIC2>;
>+				interrupts = <3 8>; /* 8 is IRQ_TYPE_LEVEL_LOW */
>+			};
>+
>+			CAN2: can1@0xc8000100 {
>+				device_type = "can2";
>+				compatible = "intel,82527";
>+				reg = <0xc8000100 0x00000100>;
>+				interrupt-parent = <&UIC2>;
>+				interrupts = <4 8>; /* 8 is IRQ_TYPE_LEVEL_LOW */
>+			};
>+
>+		};
>+
>+	};
>+
>+	chosen {
>+		linux,stdout-path = "/plb/opb/serial@ef600300";
>+		bootargs = "console=ttyS0,115200";
>+	};
>+};

>+# Platform support
>+#
>+# CONFIG_PPC_CELL is not set
>+# CONFIG_PPC_CELL_NATIVE is not set
>+# CONFIG_PQ2ADS is not set
>+CONFIG_BAMBOO=y
>+# CONFIG_EBONY is not set
>+CONFIG_HCU5=y

You have both bamboo and hcu5 enabled...

>+# CONFIG_SAM440EP is not set
>+# CONFIG_SEQUOIA is not set
>+# CONFIG_TAISHAN is not set
>+# CONFIG_KATMAI is not set
>+# CONFIG_RAINIER is not set
>+# CONFIG_WARP is not set
>+# CONFIG_ARCHES is not set
>+# CONFIG_CANYONLANDS is not set
>+# CONFIG_GLACIER is not set
>+# CONFIG_REDWOOD is not set
>+# CONFIG_EIGER is not set
>+# CONFIG_YOSEMITE is not set
>+# CONFIG_XILINX_VIRTEX440_GENERIC_BOARD is not set
>+CONFIG_PPC44x_SIMPLE=y
>+# CONFIG_PPC4xx_GPIO is not set
>+CONFIG_440EP=y
>+CONFIG_440EPX=y
>+CONFIG_IBM440EP_ERR42=y

And both 440EP and 440EPx?  Just curious as to why.

>+#
>+# Bus options
>+#
>+CONFIG_ZONE_DMA=y
>+CONFIG_PPC_INDIRECT_PCI=y
>+CONFIG_4xx_SOC=y
>+CONFIG_PPC_PCI_CHOICE=y
>+CONFIG_PCI=y
>+CONFIG_PCI_DOMAINS=y
>+CONFIG_PCI_SYSCALL=y

You have PCI enabled, but no PCI device nodes in your DTS.

>diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
>index 7486bff..cbf3601 100644
>--- a/arch/powerpc/platforms/44x/Kconfig
>+++ b/arch/powerpc/platforms/44x/Kconfig
>@@ -18,6 +18,15 @@ config EBONY
> 	help
> 	  This option enables support for the IBM PPC440GP evaluation board.
>
>+config HCU5
>+	bool "Hcu5"
>+	depends on 44x
>+	default n
>+	select PPC44x_SIMPLE

I don't think you need to select this here.  PPC44x_SIMPLE is for boards that
don't have their own .c file.

>+	select 440EPX
>+	help
>+	  This option enables support for the Netstal Maschinen HCU5 board.
>+
> config SAM440EP
>         bool "Sam440ep"
> 	depends on 44x
>diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
>index ee6185a..5263595 100644
>--- a/arch/powerpc/platforms/44x/Makefile
>+++ b/arch/powerpc/platforms/44x/Makefile
>@@ -1,6 +1,7 @@
> obj-$(CONFIG_44x)	:= misc_44x.o idle.o
> obj-$(CONFIG_PPC44x_SIMPLE) += ppc44x_simple.o
> obj-$(CONFIG_EBONY)	+= ebony.o
>+obj-$(CONFIG_HCU5)	+= hcu5.o
> obj-$(CONFIG_SAM440EP) 	+= sam440ep.o
> obj-$(CONFIG_WARP)	+= warp.o
> obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
>diff --git a/arch/powerpc/platforms/44x/hcu5.c b/arch/powerpc/platforms/44x/hcu5.c
>new file mode 100644
>index 0000000..1248a84
>--- /dev/null
>+++ b/arch/powerpc/platforms/44x/hcu5.c
>@@ -0,0 +1,153 @@
>+/*
>+ * arch/ppc/platforms/4xx/hcu5.c
>+ *
>+ * HCU5 board specific routines
>+ *
>+ * Copyright (c) 2009 Niklaus Giger <niklaus.giger@member.fsf.org>
>+ *
>+ * Copyright 2006-2007 DENX Software Engineering, Stefan Roese <sr@denx.de>
>+ *
>+ * Based on bamboo.c from Wade Farnsworth <wfarnsworth@mvista.com>
>+ *	Copyright 2004 MontaVista Software Inc.
>+ *	Copyright 2006 AMCC
>+ *
>+ * This program is free software; you can redistribute  it and/or modify it
>+ * under  the terms of  the GNU General  Public License as published by the
>+ * Free Software Foundation;  either version 2 of the  License, or (at your
>+ * option) any later version.
>+ *
>+ */
>+
>+#include <asm/machdep.h>
>+#include <asm/pci-bridge.h>
>+#include <asm/ppc4xx.h>
>+#include <asm/prom.h>
>+#include <asm/time.h>
>+#include <asm/udbg.h>
>+#include <asm/uic.h>
>+
>+#include <linux/init.h>
>+#include <linux/of_platform.h>
>+#include <linux/of_device.h>
>+#include <asm/irq.h>
>+#include <linux/types.h>
>+#include <linux/interrupt.h>
>+#include <asm/device.h>
>+
>+static int __init hcu5_probe(void);
>+#define debug printk

We have a pr_debug already.  Could you use that?  As it stands now this does
nothing more than s/printk/debug, which seems unecessary unless you meant for
it to be switchable.

>+/* HCU5 tick-status und tick-ontrol-register definitions */
>+#define CFG_CS_2  0xCC000000
>+#define CFG_CPLD  CFG_CS_2
>+#define HCU_TICK_CONTROL_REGISTER_ADDRESS	(CFG_CPLD + 0x1000000)
>+
>+#define TICK_INTERRUPT_ON_HCU5 60	/* UIC1, 28, GPIO40, IRQ0 */
>+#define CAN1_INTERRUPT_ON_HCU5 67	/* UIC2,  3  GPIO42  IRQ2 */
>+#define CAN2_INTERRUPT_ON_HCU5 68	/* UIC3,  4  GPIO43  IRQ3 */
>+
>+#define TICK_INT_ENABLE       0x01
>+#define TICK_INT_RESET        0x02
>+#define TICK_INT_PENDING      0x04
>+#define TICK_START            0x08
>+
>+#define TICK_INTERVAL_250_US  0x00
>+#define TICK_INTERVAL_500_US  0x10
>+#define TICK_INTERVAL_1000_US 0x20
>+#define TICK_INTERVAL_2000_US 0x30
>+
>+static u16 __iomem *tickAddr;
>+
>+static irqreturn_t cpld_interrupt(int irq, void *dev_id)
>+{
>+	/*
>+	out_be16(HCU_TICK_CONTROL_REGISTER_ADDRESS,
>+	TICK_INT_ENABLE | TICK_INT_RESET | TICK_START |
>+	TICK_INTERVAL_1000_US);
>+	*/
>+	return 0;
>+}
>+
>+static irqreturn_t can1_interrupt(int irq, void *dev_id)
>+{
>+	return 0;
>+}
>+
>+static irqreturn_t can2_interrupt(int irq, void *dev_id)
>+{
>+	return 0;
>+}
>+
>+static int map_one_irq(const char *typeName, void *proc)
>+{
>+	struct device_node *np;
>+	int irq = 0;
>+	int rc;
>+
>+	np = of_find_node_by_type(NULL, typeName);

Use of_find_compatible_node and specify proper compatible properties instead.

>+	debug(KERN_INFO "%s: %s np %p\n", __func__, typeName, np);
>+	if (!np) {
>+		printk(KERN_INFO "\n\nNo %s found in device tree\n", typeName);
>+		return -1;
>+	}
>+
>+	irq = irq_of_parse_and_map(np, 0);
>+	debug(KERN_INFO "%s: %s with irq %d\n",  __func__, typeName, irq);
>+	if (irq == NO_IRQ) {
>+		printk(KERN_ERR "%s: irq_of_parse_and_map failed\n", typeName);
>+		of_node_put(np);
>+		return -ENODEV;
>+	}
>+	rc = request_irq(irq, proc, IRQF_TRIGGER_LOW,
>+			  typeName, NULL);
>+	debug(KERN_INFO"%s: %s %d rc %d\n",
>+		__func__, typeName, irq, rc);
>+	return 0;
>+}
>+
>+static __initdata struct of_device_id hcu5_of_bus[] = {
>+	{ .compatible = "ibm,plb4", },
>+	{ .compatible = "ibm,opb", },
>+	{ .compatible = "ibm,ebc", },
>+	{ .compatible = "simple-bus", },
>+	{},
>+};
>+
>+static int __init hcu5_device_probe(void)
>+{
>+	of_platform_bus_probe(NULL, hcu5_of_bus, NULL);
>+	tickAddr = ioremap(HCU_TICK_CONTROL_REGISTER_ADDRESS, 0x100);
>+	printk(KERN_INFO "%s: tickAddr is at %p from 0x%x\n", __func__,
>+		tickAddr, HCU_TICK_CONTROL_REGISTER_ADDRESS);
>+	map_one_irq("cpld", cpld_interrupt);
>+	map_one_irq("can1", can1_interrupt);
>+	map_one_irq("can2", can2_interrupt);
>+
>+	return 0;
>+}
>+
>+machine_device_initcall(hcu5, hcu5_device_probe);
>+
>+/*
>+* Called very early, MMU is off, device-tree isn't unflattened
>+*/
>+static int __init hcu5_probe(void)
>+{
>+	unsigned long root = of_get_flat_dt_root();
>+
>+	if (!of_flat_dt_is_compatible(root, "netstal,hcu5"))
>+		return 0;
>+	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;

Do you need this line at all?  You don't have PCI nodes...

>+	return 1;
>+}
>+

josh
