Return-Path: <sven.luther@wanadoo.fr>
Date: Tue, 8 Mar 2005 20:52:40 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050308195239.GA14126@pegasos>
References: <422C495B.8090805@katalix.com>
	<20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
	<20050307225401.GA31041@xyzzy> <20050308064945.GC27722@pegasos>
	<1110266832.13607.267.camel@gaston>
	<20050308192805.GA13884@pegasos>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
In-Reply-To: <20050308192805.GA13884@pegasos>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-embedded@ozlabs.org, Nicolas DET <det.nicolas@free.fr>
Subject: Re: [PATCH] final mv643xx_eth pegasos patch set ...
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

On Tue, Mar 08, 2005 at 08:28:05PM +0100, luther wrote:
> Hello,
> 
> Ok, thanks for your help, here is the final (hopefully) and cleaned up version
> of my patches :
> 
>   1) mv643xx-eth-pegasos.diff
>   This is the arch/ppc/platform diff, benh, could you look it over, and merge
>   it in ? It is not really usefull without the mv643xx_eth.c changes, but dale
>   is going to move those in together with his patches.
> 
>   2) linux-2.5-mv643xx-enet-pegasos.diff
>   This is just two small hunks against dale's linux-2.5-mv643xx-enet tree,
>   which include the SA_INTERRUPT -> SA_IRQ and the Kconfig change. Dale said
>   he would merge them with his stuff, hopefully for 2.6.12.
> 
>   3) mv643xx-eth.diff
>   This is the linux-2.5-mv643xx-enet diff against 2.6.11, together with the
>   linux-2.5-mv643xx-enet-pegasos.diff changes, for those who want to build
>   against 2.6.11.
> 
> So to build against the linux-2.5-mv643xx-enet tree, you need 1) and 2) and to
> build against 2.6.11 you need 1) and 3).
> 
> I am currently running the patches included in these changes, and will include
> them in the debian 2.6.11 kernels unless i hear otherwise. 

Oh well, with the patches this time :/

Friendly,

Sven Luther

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="mv643xx-eth-pegasos.diff"

--- linux-dale/arch/ppc/platforms/Makefile	2005-03-08 09:52:44.000000000 +0100
+++ kernel-source-2.6.11-marvell/arch/ppc/platforms/Makefile	2005-03-08 17:33:29.000000000 +0100
@@ -12,7 +12,7 @@
 obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
 					pmac_feature.o pmac_pci.o pmac_sleep.o \
 					pmac_low_i2c.o pmac_cache.o
-obj-$(CONFIG_PPC_CHRP)		+= chrp_setup.o chrp_time.o chrp_pci.o
+obj-$(CONFIG_PPC_CHRP)		+= chrp_setup.o chrp_time.o chrp_pci.o mv643xx_eth_pegasos.o
 obj-$(CONFIG_PPC_PREP)		+= prep_pci.o prep_setup.o
 ifeq ($(CONFIG_PPC_PMAC),y)
 obj-$(CONFIG_NVRAM)		+= pmac_nvram.o
--- linux-dale/arch/ppc/platforms/mv643xx_eth_pegasos.c	1970-01-01 01:00:00.000000000 +0100
+++ kernel-source-2.6.11-marvell/arch/ppc/platforms/mv643xx_eth_pegasos.c	2005-03-08 20:21:33.000000000 +0100
@@ -0,0 +1,112 @@
+/*
+ *  arch/ppc/platforms/mv643xx_eth_pegasos.c
+ *
+ *  Copyright (C) 2005 Sven Luther <sl@bplan-gmbh.de> 
+ *  Thanks to :
+ *	Dale Farnsworth <dale@farnsworth.org>
+ *	Mark A. Greer <mgreer@mvista.com>
+ *	Nicolas DET <nd@bplan-gmbh.de>
+ *	Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *  And anyone else who helped me on this.
+ */
+
+#include <linux/types.h>
+#include <asm/prom.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+#include <linux/mv643xx.h>
+#include <linux/pci_ids.h>
+
+/* Pegasos 2 specific Marvell MV 64361 gigabit ethernet port setup */
+static struct resource mv643xx_eth_shared_resources[] = {
+	[0] = {
+		.name	= "ethernet shared base",
+		.start	= 0xf1000000 + MV643XX_ETH_SHARED_REGS,
+		.end	= 0xf1000000 + MV643XX_ETH_SHARED_REGS +
+					MV643XX_ETH_SHARED_REGS_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device mv643xx_eth_shared_device = {
+	.name		= MV643XX_ETH_SHARED_NAME,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(mv643xx_eth_shared_resources),
+	.resource	= mv643xx_eth_shared_resources,
+};
+
+#ifdef CONFIG_MV643XX_ETH_0
+static struct resource mv643xx_eth0_resources[] = {
+	[0] = {
+		.name	= "eth0 irq",
+		.start	= 9,
+		.end	= 9,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mv643xx_eth_platform_data eth0_pd;
+
+static struct platform_device eth0_device = {
+	.name		= MV643XX_ETH_NAME,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(mv643xx_eth0_resources),
+	.resource	= mv643xx_eth0_resources,
+	.dev = {
+		.platform_data = &eth0_pd,
+	},
+};
+#endif
+
+#ifdef CONFIG_MV643XX_ETH_1
+static struct resource mv643xx_eth1_resources[] = {
+	[0] = {
+		.name	= "eth1 irq",
+		.start	= 9,
+		.end	= 9,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mv643xx_eth_platform_data eth1_pd;
+
+static struct platform_device eth1_device = {
+	.name		= MV643XX_ETH_NAME,
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(mv643xx_eth1_resources),
+	.resource	= mv643xx_eth1_resources,
+	.dev = {
+		.platform_data = &eth1_pd,
+	},
+};
+#endif
+
+static struct platform_device *mv643xx_eth_pd_devs[] __initdata = {
+	&mv643xx_eth_shared_device,
+#ifdef CONFIG_MV643XX_ETH_0
+	&eth0_device,
+#endif
+#ifdef CONFIG_MV643XX_ETH_1
+	&eth1_device,
+#endif
+};
+
+static int __init
+mv643xx_eth_add_pds(void)
+{
+	int ret = 0;
+	struct device_node *np;
+	np = find_devices("host");
+	if (np != NULL) {
+		unsigned short *vendorid = (unsigned short *) get_property (np, "vendor-id", NULL);
+		unsigned short *deviceid = (unsigned short *) get_property (np, "device-id", NULL);
+		
+		if (vendorid && *vendorid == PCI_VENDOR_ID_MARVELL &&
+		    deviceid && *deviceid == PCI_DEVICE_ID_MARVELL_MV64360)
+			ret = platform_add_devices(mv643xx_eth_pd_devs,
+				ARRAY_SIZE(mv643xx_eth_pd_devs));
+	}
+	return ret;
+}
+arch_initcall(mv643xx_eth_add_pds);

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="mv643xx-eth-pegasos.diff"

--- linux-dale/arch/ppc/platforms/Makefile	2005-03-08 09:52:44.000000000 +0100
+++ kernel-source-2.6.11-marvell/arch/ppc/platforms/Makefile	2005-03-08 17:33:29.000000000 +0100
@@ -12,7 +12,7 @@
 obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pmac_setup.o pmac_time.o \
 					pmac_feature.o pmac_pci.o pmac_sleep.o \
 					pmac_low_i2c.o pmac_cache.o
-obj-$(CONFIG_PPC_CHRP)		+= chrp_setup.o chrp_time.o chrp_pci.o
+obj-$(CONFIG_PPC_CHRP)		+= chrp_setup.o chrp_time.o chrp_pci.o mv643xx_eth_pegasos.o
 obj-$(CONFIG_PPC_PREP)		+= prep_pci.o prep_setup.o
 ifeq ($(CONFIG_PPC_PMAC),y)
 obj-$(CONFIG_NVRAM)		+= pmac_nvram.o
--- linux-dale/arch/ppc/platforms/mv643xx_eth_pegasos.c	1970-01-01 01:00:00.000000000 +0100
+++ kernel-source-2.6.11-marvell/arch/ppc/platforms/mv643xx_eth_pegasos.c	2005-03-08 20:21:33.000000000 +0100
@@ -0,0 +1,112 @@
+/*
+ *  arch/ppc/platforms/mv643xx_eth_pegasos.c
+ *
+ *  Copyright (C) 2005 Sven Luther <sl@bplan-gmbh.de> 
+ *  Thanks to :
+ *	Dale Farnsworth <dale@farnsworth.org>
+ *	Mark A. Greer <mgreer@mvista.com>
+ *	Nicolas DET <nd@bplan-gmbh.de>
+ *	Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *  And anyone else who helped me on this.
+ */
+
+#include <linux/types.h>
+#include <asm/prom.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+#include <linux/mv643xx.h>
+#include <linux/pci_ids.h>
+
+/* Pegasos 2 specific Marvell MV 64361 gigabit ethernet port setup */
+static struct resource mv643xx_eth_shared_resources[] = {
+	[0] = {
+		.name	= "ethernet shared base",
+		.start	= 0xf1000000 + MV643XX_ETH_SHARED_REGS,
+		.end	= 0xf1000000 + MV643XX_ETH_SHARED_REGS +
+					MV643XX_ETH_SHARED_REGS_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device mv643xx_eth_shared_device = {
+	.name		= MV643XX_ETH_SHARED_NAME,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(mv643xx_eth_shared_resources),
+	.resource	= mv643xx_eth_shared_resources,
+};
+
+#ifdef CONFIG_MV643XX_ETH_0
+static struct resource mv643xx_eth0_resources[] = {
+	[0] = {
+		.name	= "eth0 irq",
+		.start	= 9,
+		.end	= 9,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mv643xx_eth_platform_data eth0_pd;
+
+static struct platform_device eth0_device = {
+	.name		= MV643XX_ETH_NAME,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(mv643xx_eth0_resources),
+	.resource	= mv643xx_eth0_resources,
+	.dev = {
+		.platform_data = &eth0_pd,
+	},
+};
+#endif
+
+#ifdef CONFIG_MV643XX_ETH_1
+static struct resource mv643xx_eth1_resources[] = {
+	[0] = {
+		.name	= "eth1 irq",
+		.start	= 9,
+		.end	= 9,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mv643xx_eth_platform_data eth1_pd;
+
+static struct platform_device eth1_device = {
+	.name		= MV643XX_ETH_NAME,
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(mv643xx_eth1_resources),
+	.resource	= mv643xx_eth1_resources,
+	.dev = {
+		.platform_data = &eth1_pd,
+	},
+};
+#endif
+
+static struct platform_device *mv643xx_eth_pd_devs[] __initdata = {
+	&mv643xx_eth_shared_device,
+#ifdef CONFIG_MV643XX_ETH_0
+	&eth0_device,
+#endif
+#ifdef CONFIG_MV643XX_ETH_1
+	&eth1_device,
+#endif
+};
+
+static int __init
+mv643xx_eth_add_pds(void)
+{
+	int ret = 0;
+	struct device_node *np;
+	np = find_devices("host");
+	if (np != NULL) {
+		unsigned short *vendorid = (unsigned short *) get_property (np, "vendor-id", NULL);
+		unsigned short *deviceid = (unsigned short *) get_property (np, "device-id", NULL);
+		
+		if (vendorid && *vendorid == PCI_VENDOR_ID_MARVELL &&
+		    deviceid && *deviceid == PCI_DEVICE_ID_MARVELL_MV64360)
+			ret = platform_add_devices(mv643xx_eth_pd_devs,
+				ARRAY_SIZE(mv643xx_eth_pd_devs));
+	}
+	return ret;
+}
+arch_initcall(mv643xx_eth_add_pds);

--x+6KMIRAuhnl3hBn
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="mv643xx-eth.diff.gz"
Content-Transfer-Encoding: base64

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
5W9Y79sZfQbFNmEe/n+ZQTFUegoDAA==

--x+6KMIRAuhnl3hBn--
