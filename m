Return-Path: <sven.luther@wanadoo.fr>
Date: Mon, 7 Mar 2005 14:20:03 +0100
To: Nicolas DET <det.nicolas@free.fr>
Message-ID: <20050307132003.GA21030@pegasos>
References: <422C495B.8090805@katalix.com>
	<20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
In-Reply-To: <20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Re: mv64x60 updates
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

On Mon, Mar 07, 2005 at 01:57:39PM +0100, Nicolas DET wrote:
> Hello James,
> 
> On 07/03/2005, you wrote:
> > Hi Nicolas,
> 
> > A few general comments:-
> 
> > - mv64x60 stuff is best posted to linuxppc-embedded
> 
> ok.
> I would just add that our platform (Pegasos II) is using MV64361 from
> Marvell and is a complete computer.

Cross-posting to linuxppc-embedded to reach everyone. In particular comments
from Mark and Dale are welcome.

> > - you change several generic files to support your platform. It should
> >    be possible to support new mv64x60 platforms by writing a new
> >    xxx_setup.c file in arch/ppc/platforms with no other generic changes.
> >    It is a goal that all mv64x60 boards can be supported by the generic
> >    code in arch/ppc/syslib. If some changes need to be made outside
> >    arch/ppc/platforms to support your board, try to make them generic so
> >    that other similar boards would be able to use them. I suggest you
> >    clone chrp_setup.c or katana.c rather than adding conditionals in
> >    chrp_setup.c for your board. Then use code in your board specific
> >    setup file to call arch/ppc/syslib mv64x60 routines as appropriate.
> 
> There is almost no changes compare to 2.6.11 (from kernel.org).

I have appended a (slightly revised) version of the patch, which is against a
saturday/sunday checkout of bk://dfarnsworth.bkbits.net/linux-2.5-mv643xx-enet, 
which is what Mark and Dale are working on. Viewed like that the patch is
against to really manageable size, altough it may need some fine-tuning. The
rest of your comments probably apply to Dale's and Mark's work in the above
tree though.

Friendly,

Sven Luther

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="nico2.diff"

--- linux-2.5-mv643xx-enet/arch/ppc/boot/simple/Makefile	2005-03-07 14:15:29.000000000 +0100
+++ kernel-source-2.6.11/arch/ppc/boot/simple/Makefile	2005-03-07 14:13:14.000000000 +0100
@@ -162,7 +162,7 @@
 boot-$(CONFIG_8260)		+= embed_config.o
 boot-$(CONFIG_BSEIP)		+= iic.o
 boot-$(CONFIG_MBX)		+= iic.o pci.o qspan_pci.o
-boot-$(CONFIG_MV64X60)		+= misc-mv64x60.o
+boot-$(CONFIG_MV64X60)		+= misc-mv64x60.o mv64x60_stub.o
 boot-$(CONFIG_RPXCLASSIC)	+= iic.o pci.o qspan_pci.o
 boot-$(CONFIG_RPXLITE)		+= iic.o
 # Different boards need different serial implementations.
--- linux-2.5-mv643xx-enet/arch/ppc/platforms/chrp_setup.c	2005-03-07 14:15:29.000000000 +0100
+++ kernel-source-2.6.11/arch/ppc/platforms/chrp_setup.c	2005-03-07 14:13:14.000000000 +0100
@@ -217,8 +217,13 @@
 	}
 }
 
+#ifdef CONFIG_MV64X60
+#include <linux/mv643xx.h>
+#include <asm/mv64x60.h>
+#endif
+
 
-static void __init pegasos_set_l2cr(void)
+static void __init pegasos_stuff(void)
 {
 	struct device_node *np;
 
@@ -242,6 +247,19 @@
 			_set_L2CR((*l2cr) | 0x80000000);
 		}
 	}
+
+#ifdef CONFIG_MV64X60
+	// Pegasos II (MV64361)
+	// We have to call mv64x60_init() in arch/ppc/syslib/mv64x60.c 
+	// This call will do NOTHING but set the correct value for IRQ & reg base...
+	// This is needed because new Marvell ethernet driver get theses info from
+	// there
+	{
+		static struct mv64x60_handle bh;
+		static struct mv64x60_setup_info si;
+		mv64x60_init(&bh, &si);
+	}
+#endif
 }
 
 void __init chrp_setup_arch(void)
@@ -262,7 +280,7 @@
 		ROOT_DEV = Root_SDA2; /* sda2 (sda1 is for the kernel) */
 
 	/* On pegasos, enable the L2 cache if not already done by OF */
-	pegasos_set_l2cr();
+	pegasos_stuff();
 
 	/* Lookup PCI host bridges */
 	chrp_find_bridges();
--- linux-2.5-mv643xx-enet/arch/ppc/syslib/Makefile	2005-03-07 14:15:29.000000000 +0100
+++ kernel-source-2.6.11/arch/ppc/syslib/Makefile	2005-03-07 14:13:14.000000000 +0100
@@ -59,8 +59,8 @@
 					open_pic.o i8259.o hawk_common.o
 obj-$(CONFIG_MENF1)		+= todc_time.o i8259.o mpc10x_common.o \
 					pci_auto.o indirect_pci.o
-obj-$(CONFIG_MV64360)		+= mv64360_pic.o
-obj-$(CONFIG_MV64X60)		+= mv64x60.o mv64x60_win.o indirect_pci.o
+obj-$(CONFIG_MV64360)		+=
+obj-$(CONFIG_MV64X60)		+= mv64x60.o mv64x60_win.o indirect_pci.o mv64360_pic.o
 obj-$(CONFIG_MVME5100)		+= open_pic.o todc_time.o indirect_pci.o \
 					pci_auto.o hawk_common.o
 obj-$(CONFIG_MVME5100_IPMC761_PRESENT)	+= i8259.o
--- linux-2.5-mv643xx-enet/arch/ppc/syslib/mv64360_pic.c	2005-03-07 14:15:29.000000000 +0100
+++ kernel-source-2.6.11/arch/ppc/syslib/mv64360_pic.c	2005-03-07 14:13:14.000000000 +0100
@@ -369,6 +369,10 @@
 	u32	mask;
 	int	rc;
 
+	if ( mv64360_ispegasos2() ) return 0;
+
+	printk("not pegasos\n");
+
 	/* Clear old errors and register CPU interface error intr handler */
 	mv64x60_write(&bh, MV64x60_CPU_ERR_CAUSE, 0);
 	if ((rc = request_irq(MV64x60_IRQ_CPU_ERR,
--- linux-2.5-mv643xx-enet/arch/ppc/syslib/mv64x60.c	2005-03-07 14:15:29.000000000 +0100
+++ kernel-source-2.6.11/arch/ppc/syslib/mv64x60.c	2005-03-07 14:21:04.000000000 +0100
@@ -314,15 +314,15 @@
 static struct resource mv64x60_eth_shared_resources[] = {
 	[0] = {
 		.name	= "ethernet shared base",
-		.start	= MV64340_ETH_SHARED_REGS,
-		.end	= MV64340_ETH_SHARED_REGS +
-					MV64340_ETH_SHARED_REGS_SIZE - 1,
+		.start	= MV643XX_ETH_SHARED_REGS,
+		.end	= MV643XX_ETH_SHARED_REGS +
+					MV643XX_ETH_SHARED_REGS_SIZE - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 };
 
 static struct platform_device mv64x60_eth_shared_device = {
-	.name		= MV64XXX_ETH_SHARED_NAME,
+	.name		= MV643XX_ETH_SHARED_NAME,
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(mv64x60_eth_shared_resources),
 	.resource	= mv64x60_eth_shared_resources,
@@ -341,7 +341,7 @@
 static struct mv64xxx_eth_platform_data eth0_pd;
 
 static struct platform_device eth0_device = {
-	.name		= MV64XXX_ETH_NAME,
+	.name		= MV643XX_ETH_NAME,
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(mv64x60_eth0_resources),
 	.resource	= mv64x60_eth0_resources,
@@ -361,10 +361,10 @@
 	},
 };
 
-static struct mv64xxx_eth_platform_data eth1_pd;
+static struct mv643xx_eth_platform_data eth1_pd;
 
 static struct platform_device eth1_device = {
-	.name		= MV64XXX_ETH_NAME,
+	.name		= MV643XX_ETH_NAME,
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(mv64x60_eth1_resources),
 	.resource	= mv64x60_eth1_resources,
@@ -475,17 +475,58 @@
 {
 	u32	mem_windows[MV64x60_CPU2MEM_WINDOWS][2];
 
-	if (ppc_md.progress)
-		ppc_md.progress("mv64x60 initialization", 0x0);
+	if (ppc_md.progress) ppc_md.progress("mv64x60 initialization", 0x0);
+
+#if defined(CONFIG_PPC_MULTIPLATFORM)
+	if (mv64360_ispegasos2())
+	{
+		// Pegasos II stuff
+
+		if (ppc_md.progress)
+			ppc_md.progress("mv64x60: Pegasos II Detected, skiping most of the init code & patching the ressources tables", 0x0);
+
+		spin_lock_init(&mv64x60_lock);
+
+		if (mv64x60_get_type(bh) || mv64x60_setup_for_chip(bh))
+		{
+			if (ppc_md.progress) ppc_md.progress("mv64x60_init: Init error", 0x0);
+			return -1;
+		}
+
+		// Pegasos II use IRQ 9 for every port
+		// Also notice that the ethernet driver (& others) have to 
+		// use SA_SHIRQ instead of SA_INTERRUPT
+		// Also the Pegasos II has only port 0 & 1 available (MV64361)
+		
+#ifdef CONFIG_MV643XX_ETH_0
+		mv64x60_eth0_resources[0].start = 9;
+		mv64x60_eth0_resources[0].end = 9;
+#endif
 
+#ifdef CONFIG_MV643XX_ETH_1
+		mv64x60_eth1_resources[0].start = 9;
+		mv64x60_eth1_resources[0].end = 9;
+#endif
+
+		// Marvell register is at 0xf1000000 on Pegasos II
+		mv64x60_eth_shared_resources[0].start = 0xf1000000 + MV643XX_ETH_SHARED_REGS;
+		mv64x60_eth_shared_resources[0].end = 0xf1000000 + MV643XX_ETH_SHARED_REGS + MV643XX_ETH_SHARED_REGS_SIZE - 1;
+	
+		// For Pegasos II, we stop here
+		// Indeed, we only need the resources info for
+		// the ethernet driver ATM
+		if (ppc_md.progress) ppc_md.progress("mv64x60: End", 0x0);
+		return 0;
+	}
+#endif
+	
 	spin_lock_init(&mv64x60_lock);
 	mv64x60_early_init(bh, si);
 
 	if (mv64x60_get_type(bh) || mv64x60_setup_for_chip(bh)) {
 		iounmap(bh->v_base);
 		bh->v_base = 0;
-		if (ppc_md.progress)
-			ppc_md.progress("mv64x60_init: Can't determine chip",0);
+		if (ppc_md.progress) ppc_md.progress("mv64x60_init: Can't determine chip",0);
 		return -1;
 	}
 
@@ -823,6 +864,18 @@
 	u16	val;
 	u8	save_exclude;
 
+#if defined(CONFIG_PPC_MULTIPLATFORM)
+	if (mv64360_ispegasos2())
+	{
+		// we could use the OF pci stuff
+		// but we know Pegasos II use the MV64361 chipset
+		// If people think it's not nice enough I could add some PCI code
+		// to detect that using OF
+		bh->type = MV64x60_TYPE_MV64360;
+		return 0;
+	}
+#endif
+
 	memset(&hose, 0, sizeof(hose));
 	setup_indirect_pci_nomap(&hose, bh->v_base + MV64x60_PCI0_CONFIG_ADDR,
 		bh->v_base + MV64x60_PCI0_CONFIG_DATA);
--- linux-2.5-mv643xx-enet/drivers/net/Kconfig	2005-03-07 14:15:29.000000000 +0100
+++ kernel-source-2.6.11/drivers/net/Kconfig	2005-03-07 14:13:14.000000000 +0100
@@ -2094,11 +2094,11 @@
 
 config MV643XX_ETH
 	tristate "MV-643XX Ethernet support"
-	depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MV64360
+	depends on MOMENCO_OCELOT_CA || MOMENCO_JAGUAR_ATX || MV64X60
 	help
 	  This driver supports the gigabit Ethernet on the Marvell MV643XX
-	  chipset which is used in the Momenco Ocelot C and Jaguar ATX and
-	  Pegasos II, amongst other PPC and MIPS boards.
+	  chipset which is used in the Momenco Ocelot C, Jaguar ATX and
+	  bPlan Pegasos II computer.
 
 config MV643XX_ETH_0
 	bool "MV-643XX Port 0"
--- linux-2.5-mv643xx-enet/drivers/net/mv643xx_eth.c	2005-03-07 14:15:29.000000000 +0100
+++ kernel-source-2.6.11/drivers/net/mv643xx_eth.c	2005-03-07 14:25:38.000000000 +0100
@@ -44,6 +44,7 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/delay.h>
+#include <asm/mv64x60.h>
 #include "mv643xx_eth.h"
 
 /*
@@ -664,11 +665,16 @@
 	struct mv643xx_private *mp = netdev_priv(dev);
 	unsigned int port_num = mp->port_num;
 	int err;
-
+#if defined(CONFIG_PPC_MULTIPLATFORM)
+	int IRQ_Flags = mv64360_ispegasos2() ? SA_SHIRQ : SA_INTERRUPT;
+#else
+	int IRQ_Flags = SA_INTERRUPT;
+#endif
+	
 	spin_lock_irq(&mp->lock);
 
 	err = request_irq(dev->irq, mv643xx_eth_int_handler,
-			SA_INTERRUPT | SA_SAMPLE_RANDOM, dev->name, dev);
+			IRQ_Flags | SA_SAMPLE_RANDOM, dev->name, dev);
 
 	if (err) {
 		printk(KERN_ERR "Can not assign IRQ number to MV643XX_eth%d\n",
@@ -1383,6 +1389,8 @@
 	BUG_ON(!res);
 	dev->irq = res->start;
 
+	printk(KERN_INFO "%s: Using IRQ %d\n", __func__, dev->irq);
+
 	mp->port_num = port_num;
 
 	dev->open = mv643xx_eth_open;
@@ -1587,6 +1595,8 @@
 		if (rc)
 			driver_unregister(&mv643xx_eth_shared_driver);
 	}
+
+	printk("%s: return %d\n", __func__, rc);
 	return rc;
 }
 
--- linux-2.5-mv643xx-enet/include/asm-ppc/mv64x60.h	2005-03-07 14:15:29.000000000 +0100
+++ kernel-source-2.6.11/include/asm-ppc/mv64x60.h	2005-03-07 14:18:27.000000000 +0100
@@ -27,6 +27,19 @@
 #include <asm/pci-bridge.h>
 #include <asm/mv64x60_defs.h>
 
+/*
+ * return 1 if you are on a Pegasos II, 0 otherwise
+ * this code is useful to execute the correct code 
+ * on the correct machine
+ * 
+*/
+#if defined(CONFIG_PPC_MULTIPLATFORM)
+extern inline int mv64360_ispegasos2(void)
+{
+	return ((_machine == _MACH_chrp) && (_chrp_type == _CHRP_Pegasos)) ? 1 : 0;
+}
+#endif
+
 extern u8	mv64x60_pci_exclude_bridge;
 
 extern spinlock_t mv64x60_lock;

--PEIAKu/WMn1b1Hv9--
