Return-Path: <galak@somerset.sps.mot.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 302602BF16
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 18:43:23 +1100 (EST)
Received: from il06exr06.mot.com (il06exr06.mot.com [129.188.137.136])
	by motgate8.mot.com (Motorola/Motgate8) with ESMTP id j0C7j6JD029068
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 00:45:06 -0700 (MST)
Received: from postal.somerset.sps.mot.com (postal.somerset.sps.mot.com
	[163.12.132.5])
	by il06exr06.mot.com (Motorola/il06exr06) with ESMTP id j0C7hB63030485
	for <linuxppc-embedded@ozlabs.org>; Wed, 12 Jan 2005 01:43:13 -0600
Date: Wed, 12 Jan 2005 01:43:09 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: trini@kernel.crashing.org, linuxppc-embedded@ozlabs.org,
	mporter@kernel.crashing.org, jason.mcmullan@timesys.com, ebs@ebshome.net
Message-ID: <Pine.LNX.4.61.0501120133080.21665@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: RFC: [PATCH] platform device driver model support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All,

Please take a look at the following patch.  It adds driver model support 
via platform devices to 85xx.  This is originally based on patches from 
Jason M. 

The idea behind the code is that for a give family: 4xx, 8xx, 82xx, 83xx, 
85xx, 86xx we will have structure defns for the following:

enum ppc_soc_devices 
in asm-ppc/<family.h>:
  list of all unique devices in the family

struct platform_device soc_platform_devices[]
in arch/ppc/platforms/<family>/<family>_devices.c:
  describes all platform devices that exist in the family

struct soc_spec soc_specs[]
in arch/ppc/platforms/<family>/<family>_soc.c:
  describes each unique chip in the family and what devices it has

Plus the following functions:

identify_soc_by_id() -- determine soc by an int id
identify_soc_by_name() -- determin soc by name (useful in some 82xx cases)
ppc_soc_get_pdata() -- get platform_data pointer so board code can modify
ppc_soc_update_paddr() -- update iomem resources with a given paddr

Please provide feedback, I want to get this into 2.6.11 for 85xx.

thanks

- kumar

--

diff -Nru a/arch/ppc/platforms/85xx/Makefile b/arch/ppc/platforms/85xx/Makefile
--- a/arch/ppc/platforms/85xx/Makefile	2005-01-12 01:31:07 -06:00
+++ b/arch/ppc/platforms/85xx/Makefile	2005-01-12 01:31:07 -06:00
@@ -1,6 +1,7 @@
 #
 # Makefile for the PowerPC 85xx linux kernel.
 #
+obj-$(CONFIG_85xx)		+= mpc85xx_soc.o mpc85xx_devices.o
 
 obj-$(CONFIG_MPC8540_ADS)	+= mpc85xx_ads_common.o mpc8540_ads.o
 obj-$(CONFIG_MPC8555_CDS)	+= mpc85xx_cds_common.o
diff -Nru a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/platforms/85xx/mpc8540_ads.c
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-01-12 01:31:07 -06:00
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-01-12 01:31:07 -06:00
@@ -32,6 +32,7 @@
 #include <linux/serial_core.h>
 #include <linux/initrd.h>
 #include <linux/module.h>
+#include <linux/fsl_devices.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -49,45 +50,12 @@
 #include <asm/immap_85xx.h>
 #include <asm/kgdb.h>
 #include <asm/ocp.h>
+#include <asm/soctable.h>
 #include <mm/mmu_decl.h>
 
 #include <syslib/ppc85xx_common.h>
 #include <syslib/ppc85xx_setup.h>
 
-struct ocp_gfar_data mpc85xx_tsec1_def = {
-	.interruptTransmit = MPC85xx_IRQ_TSEC1_TX,
-	.interruptError = MPC85xx_IRQ_TSEC1_ERROR,
-	.interruptReceive = MPC85xx_IRQ_TSEC1_RX,
-	.interruptPHY = MPC85xx_IRQ_EXT5,
-	.flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR
-			| GFAR_HAS_RMON
-			| GFAR_HAS_PHY_INTR | GFAR_HAS_COALESCE),
-	.phyid = 0,
-	.phyregidx = 0,
-};
-
-struct ocp_gfar_data mpc85xx_tsec2_def = {
-	.interruptTransmit = MPC85xx_IRQ_TSEC2_TX,
-	.interruptError = MPC85xx_IRQ_TSEC2_ERROR,
-	.interruptReceive = MPC85xx_IRQ_TSEC2_RX,
-	.interruptPHY = MPC85xx_IRQ_EXT5,
-	.flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR
-			| GFAR_HAS_RMON
-			| GFAR_HAS_PHY_INTR | GFAR_HAS_COALESCE),
-	.phyid = 1,
-	.phyregidx = 0,
-};
-
-struct ocp_gfar_data mpc85xx_fec_def = {
-	.interruptTransmit = MPC85xx_IRQ_FEC,
-	.interruptError = MPC85xx_IRQ_FEC,
-	.interruptReceive = MPC85xx_IRQ_FEC,
-	.interruptPHY = MPC85xx_IRQ_EXT5,
-	.flags = 0,
-	.phyid = 3,
-	.phyregidx = 0,
-};
-
 struct ocp_fs_i2c_data mpc85xx_i2c1_def = {
 	.flags = FS_I2C_SEPARATE_DFSRR,
 };
@@ -100,10 +68,11 @@
 static void __init
 mpc8540ads_setup_arch(void)
 {
-	struct ocp_def *def;
-	struct ocp_gfar_data *einfo;
 	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
+	struct gianfar_platform_data *pdata;
+
+	identify_soc_by_id(mfspr(SVR));
 
 	/* get the core frequency */
 	freq = binfo->bi_intfreq;
@@ -130,23 +99,30 @@
 	invalidate_tlbcam_entry(NUM_TLBCAMS - 1);
 #endif
 
-	def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 0);
-	if (def) {
-		einfo = (struct ocp_gfar_data *) def->additions;
-		memcpy(einfo->mac_addr, binfo->bi_enetaddr, 6);
-	}
-
-	def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 1);
-	if (def) {
-		einfo = (struct ocp_gfar_data *) def->additions;
-		memcpy(einfo->mac_addr, binfo->bi_enet1addr, 6);
-	}
-
-	def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 2);
-	if (def) {
-		einfo = (struct ocp_gfar_data *) def->additions;
-		memcpy(einfo->mac_addr, binfo->bi_enet2addr, 6);
-	}
+	/* setup the board related information for the enet controllers */
+	pdata = (struct gianfar_platform_data *) ppc_soc_get_pdata(MPC85xx_TSEC1);
+	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+	pdata->phyid = 0;
+	/* fixup phy address */
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+
+	pdata = (struct gianfar_platform_data *) ppc_soc_get_pdata(MPC85xx_TSEC2);
+	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+	pdata->phyid = 1;
+	/* fixup phy address */
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	
+	pdata = (struct gianfar_platform_data *) ppc_soc_get_pdata(MPC85xx_FEC);
+	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+	pdata->phyid = 3;
+	/* fixup phy address */
+	pdata->phy_reg_addr += binfo->bi_immr_base;
+	memcpy(pdata->mac_addr, binfo->bi_enet2addr, 6);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_devices.c b/arch/ppc/platforms/85xx/mpc85xx_devices.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/85xx/mpc85xx_devices.c	2005-01-12 01:31:07 -06:00
@@ -0,0 +1,245 @@
+/*
+ * arch/ppc/platforms/85xx/mpc85xx_devices.c
+ *
+ * MPC85xx Device descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/fsl_devices.h>
+#include <asm/mpc85xx.h>
+#include <asm/soctable.h>
+
+/* We use offsets for IORESOURCE_MEM since we do not know at compile time
+ * what CCSRBAR is, platform code should fix this up in setup_arch
+ */
+
+static struct gianfar_platform_data mpc85xx_tsec1_pdata = {
+	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
+		FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
+		FSL_GIANFAR_DEV_HAS_MULTI_INTR,
+	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
+};
+
+static struct gianfar_platform_data mpc85xx_tsec2_pdata = {
+	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
+		FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
+		FSL_GIANFAR_DEV_HAS_MULTI_INTR,
+	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
+};
+
+static struct gianfar_platform_data mpc85xx_fec_pdata = {
+	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
+};
+
+static struct fsl_i2c_platform_data mpc85xx_fsl_i2c_pdata = {
+	.device_flags = FSL_I2C_DEV_SEPARATE_DFSRR,
+};
+
+struct platform_device soc_platform_devices[] = {
+	[MPC85xx_TSEC1] = {
+		.name = "fsl-gianfar",
+		.id	= 1,
+		.dev.platform_data = &mpc85xx_tsec1_pdata,
+		.num_resources	 = 4,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_ENET1_OFFSET,
+				.end	= MPC85xx_ENET1_OFFSET +
+						MPC85xx_ENET1_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "tx",
+				.start	= MPC85xx_IRQ_TSEC1_TX,
+				.end	= MPC85xx_IRQ_TSEC1_TX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "rx",
+				.start	= MPC85xx_IRQ_TSEC1_RX,
+				.end	= MPC85xx_IRQ_TSEC1_RX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "error",
+				.start	= MPC85xx_IRQ_TSEC1_ERROR,
+				.end	= MPC85xx_IRQ_TSEC1_ERROR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_TSEC2] = {
+		.name = "fsl-gianfar",
+		.id	= 2,
+		.dev.platform_data = &mpc85xx_tsec2_pdata,
+		.num_resources	 = 4,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_ENET2_OFFSET,
+				.end	= MPC85xx_ENET2_OFFSET +
+						MPC85xx_ENET2_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "tx",
+				.start	= MPC85xx_IRQ_TSEC2_TX,
+				.end	= MPC85xx_IRQ_TSEC2_TX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "rx",
+				.start	= MPC85xx_IRQ_TSEC2_RX,
+				.end	= MPC85xx_IRQ_TSEC2_RX,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "error",
+				.start	= MPC85xx_IRQ_TSEC2_ERROR,
+				.end	= MPC85xx_IRQ_TSEC2_ERROR,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_FEC] =	{
+		.name = "fsl-gianfar",
+		.id	= 3,
+		.dev.platform_data = &mpc85xx_fec_pdata,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_ENET3_OFFSET,
+				.end	= MPC85xx_ENET3_OFFSET +
+						MPC85xx_ENET3_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+
+			},
+			{
+				.start	= MPC85xx_IRQ_FEC,
+				.end	= MPC85xx_IRQ_FEC,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_IIC1] = {
+		.name = "fsl-i2c",
+		.id	= 1,
+		.dev.platform_data = &mpc85xx_fsl_i2c_pdata,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_IIC1_OFFSET,
+				.end	= MPC85xx_IIC1_OFFSET +
+						MPC85xx_IIC1_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC85xx_IRQ_IIC1,
+				.end	= MPC85xx_IRQ_IIC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_DMA0] = {
+		.name = "fsl-dma",
+		.id	= 0,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_DMA0_OFFSET,
+				.end	= MPC85xx_DMA0_OFFSET +
+						MPC85xx_DMA0_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC85xx_IRQ_DMA0,
+				.end	= MPC85xx_IRQ_DMA0,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_DMA1] = {
+		.name = "fsl-dma",
+		.id	= 1,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_DMA1_OFFSET,
+				.end	= MPC85xx_DMA1_OFFSET +
+						MPC85xx_DMA1_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC85xx_IRQ_DMA1,
+				.end	= MPC85xx_IRQ_DMA1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_DMA2] = {
+		.name = "fsl-dma",
+		.id	= 2,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_DMA2_OFFSET,
+				.end	= MPC85xx_DMA2_OFFSET +
+						MPC85xx_DMA2_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC85xx_IRQ_DMA2,
+				.end	= MPC85xx_IRQ_DMA2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC85xx_DMA3] = {
+		.name = "fsl-dma",
+		.id	= 3,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC85xx_DMA3_OFFSET,
+				.end	= MPC85xx_DMA3_OFFSET +
+						MPC85xx_DMA3_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC85xx_IRQ_DMA3,
+				.end	= MPC85xx_IRQ_DMA3,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+};
+
+static int __init mach_mpc85xx_init(void)
+{
+	unsigned int i, dev_id, ret = 0;
+
+	BUG_ON(cur_soc_spec == NULL);
+
+	for (i = 0; i < cur_soc_spec->num_devices; i++) {
+		dev_id = cur_soc_spec->device_list[i];
+		ppc_soc_update_paddr(&soc_platform_devices[dev_id], CCSRBAR);
+		if (platform_device_register(&soc_platform_devices[dev_id])) {
+			ret = 1;
+			printk (KERN_ERR "unable to register device %d\n", dev_id);
+		}
+	};
+
+	return ret;
+}
+
+subsys_initcall(mach_mpc85xx_init);
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_soc.c b/arch/ppc/platforms/85xx/mpc85xx_soc.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/85xx/mpc85xx_soc.c	2005-01-12 01:31:07 -06:00
@@ -0,0 +1,50 @@
+/*
+ * arch/ppc/platforms/85xx/mpc85xx_soc.c
+ *
+ * MPC85xx SOC descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <asm/soctable.h>
+
+struct soc_spec* cur_soc_spec;
+struct soc_spec soc_specs[] = {
+	{
+		.soc_name	= "MPC8540",
+		.soc_mask 	= 0xFFFF0000,
+		.soc_value 	= 0x80300000,
+		.num_devices	= 8,
+		.device_list	= (enum ppc_soc_devices[]) 
+		{ 
+			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_FEC, MPC85xx_IIC1, 
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3, 
+		},
+	},
+	{
+		.soc_name	= "MPC8560",
+		.soc_mask 	= 0xFFFF0000,
+		.soc_value 	= 0x80700000,
+		.num_devices	= 7,
+		.device_list	= (enum ppc_soc_devices[]) 
+		{ 
+			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1, 
+			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3, 
+		},
+	},
+	{	/* default match */
+		.soc_name	= "",
+		.soc_mask 	= 0x00000000,
+		.soc_value 	= 0x00000000,
+	},
+};
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2005-01-12 01:31:07 -06:00
+++ b/arch/ppc/syslib/Makefile	2005-01-12 01:31:07 -06:00
@@ -92,7 +92,8 @@
 obj-$(CONFIG_MPC10X_OPENPIC)	+= open_pic.o
 obj-$(CONFIG_40x)		+= dcr.o
 obj-$(CONFIG_BOOKE)		+= dcr.o
-obj-$(CONFIG_85xx)		+= open_pic.o ppc85xx_common.o ppc85xx_setup.o
+obj-$(CONFIG_85xx)		+= open_pic.o ppc85xx_common.o ppc85xx_setup.o \
+					soc.o
 ifeq ($(CONFIG_85xx),y)
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o
 endif
diff -Nru a/arch/ppc/syslib/soc.c b/arch/ppc/syslib/soc.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/soc.c	2005-01-12 01:31:07 -06:00
@@ -0,0 +1,59 @@
+/*
+ * arch/ppc/syslib/soc.c
+ *
+ * System-on-chip (SOC) library functions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <asm/soctable.h>
+
+void __init
+identify_soc_by_id(unsigned int id)
+{
+	unsigned int i = 0;
+	while (1) {
+		if ((soc_specs[i].soc_mask & id) == soc_specs[i].soc_value)
+			break;
+		i++;
+	};
+
+	cur_soc_spec = &soc_specs[i];
+
+	return;
+}
+
+void __init
+identify_soc_by_name(char *name)
+{
+	/* TODO */
+	return;
+}
+
+/* Update all memory resources by paddr, call before platform_device_register */
+void __init
+ppc_soc_update_paddr(struct platform_device *pdev, phys_addr_t paddr)
+{
+	int i;
+	for (i = 0; i < pdev->num_resources; i++) {
+		struct resource *r = &pdev->resource[i];
+		if ((r->flags & IORESOURCE_MEM) == IORESOURCE_MEM) {
+			r->start += paddr;
+			r->end += paddr;
+		};
+	};
+}
+
+/* Get platform_data pointer out of platform device, call before platform_device_register */
+void * __init
+ppc_soc_get_pdata(enum ppc_soc_devices dev)
+{
+	return soc_platform_devices[dev].dev.platform_data;
+}
diff -Nru a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
--- a/include/asm-ppc/mpc85xx.h	2005-01-12 01:31:07 -06:00
+++ b/include/asm-ppc/mpc85xx.h	2005-01-12 01:31:07 -06:00
@@ -103,6 +103,14 @@
 #define MPC85xx_CPM_SIZE	(0x40000)
 #define MPC85xx_DMA_OFFSET	(0x21000)
 #define MPC85xx_DMA_SIZE	(0x01000)
+#define MPC85xx_DMA0_OFFSET	(0x21100)
+#define MPC85xx_DMA0_SIZE	(0x00080)
+#define MPC85xx_DMA1_OFFSET	(0x21180)
+#define MPC85xx_DMA1_SIZE	(0x00080)
+#define MPC85xx_DMA2_OFFSET	(0x21200)
+#define MPC85xx_DMA2_SIZE	(0x00080)
+#define MPC85xx_DMA3_OFFSET	(0x21280)
+#define MPC85xx_DMA3_SIZE	(0x00080)
 #define MPC85xx_ENET1_OFFSET	(0x24000)
 #define MPC85xx_ENET1_SIZE	(0x01000)
 #define MPC85xx_ENET2_OFFSET	(0x25000)
@@ -138,6 +146,17 @@
 #else
 #define CCSRBAR BOARD_CCSRBAR
 #endif
+
+enum ppc_soc_devices {
+	MPC85xx_TSEC1,
+	MPC85xx_TSEC2,
+	MPC85xx_FEC,
+	MPC85xx_IIC1,
+	MPC85xx_DMA0,
+	MPC85xx_DMA1,
+	MPC85xx_DMA2,
+	MPC85xx_DMA3,
+};
 
 #endif /* CONFIG_85xx */
 #endif /* __ASM_MPC85xx_H__ */
diff -Nru a/include/asm-ppc/soctable.h b/include/asm-ppc/soctable.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-ppc/soctable.h	2005-01-12 01:31:07 -06:00
@@ -0,0 +1,56 @@
+/*
+ * include/asm-ppc/soctable.h
+ *
+ * SOC definitions and library functions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_PPC_SOCTABLE_H
+#define __ASM_PPC_SOCTABLE_H
+
+#include <linux/init.h>
+#include <linux/device.h>
+#if defined(CONFIG_85xx)
+#include <asm/mpc85xx.h>
+#else
+#error "need definition of ppc_soc_devices"
+#endif
+
+struct soc_spec {
+	/* SOC is matched via (ID & soc_mask) == soc_value, id could be
+	 * PVR, SVR, IMMR, * etc. */
+	unsigned int		soc_mask;
+	unsigned int		soc_value;
+	unsigned int		num_devices;
+	char			*soc_name;
+	enum ppc_soc_devices	*device_list;
+};
+
+/* describes all specific chips and which devices they have on them */
+extern struct soc_spec		soc_specs[];
+extern struct soc_spec		*cur_soc_spec;
+
+/* determine which specific SOC we are */
+extern void identify_soc_by_id(unsigned int id) __init;
+extern void identify_soc_by_name(char *name) __init;
+
+/* describes all devices that may exist in a given family of processors */
+extern struct platform_device soc_platform_devices[];
+
+/* Update all memory resources by paddr, call before platform_device_register */
+extern void ppc_soc_update_paddr(struct platform_device *pdev, phys_addr_t paddr) __init;
+
+/* Get platform_data pointer out of platform device, call before platform_device_register */
+extern void * ppc_soc_get_pdata(enum ppc_soc_devices dev) __init;
+
+#endif /* __ASM_PPC_SOCTABLE_H */
+#endif /* __KERNEL__ */
diff -Nru a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/fsl_devices.h	2005-01-12 01:31:07 -06:00
@@ -0,0 +1,77 @@
+/*
+ * include/linux/fsl_devices.h
+ *
+ * Definitions for any platform device related flags or structures for 
+ * Freescale processor devices
+ *
+ * Maintainer: Kumar Gala (kumar.gala@freescale.com)
+ *
+ * Copyright 2004 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _FSL_DEVICE_H_
+#define _FSL_DEVICE_H_
+
+/* 
+ * Some conventions on how we handle peripherals on Freescale chips
+ *
+ * unique device: a platform_device entry in fsl_plat_devs[] plus 
+ * associated device information in its platform_data structure.
+ *
+ * A chip is described by a set of unique devices.
+ *
+ * Each sub-arch has its own master list of unique devices and
+ * enumerates them by enum fsl_devices in a sub-arch specific header
+ *
+ * The platform data structure is broken into two parts.  The
+ * first is device specific information that help identify any
+ * unique features of a peripheral.  The second is any
+ * information that may be defined by the board or how the device
+ * is connected externally of the chip.
+ *
+ * naming conventions:
+ * - platform data structures: <driver>_platform_data
+ * - platform data device flags: FSL_<driver>_DEV_<FLAG>
+ * - platform data board flags: FSL_<driver>_BRD_<FLAG>
+ * 
+ *
+ */
+
+struct gianfar_platform_data {
+	/* device specific information */
+	u32 device_flags;
+	u32 phy_reg_addr;
+
+	/* board specific information */
+	u32 board_flags;
+	u32 phyid;
+	u32 interruptPHY;
+	u8 mac_addr[6];
+};
+
+/* Flags related to gianfar device features */
+#define FSL_GIANFAR_DEV_HAS_GIGABIT		0x00000001
+#define FSL_GIANFAR_DEV_HAS_COALESCE		0x00000002
+#define FSL_GIANFAR_DEV_HAS_RMON		0x00000004
+#define FSL_GIANFAR_DEV_HAS_MULTI_INTR		0x00000008
+
+/* Flags in gianfar_platform_data */
+#define FSL_GIANFAR_BRD_HAS_PHY_INTR	0x00000001	/* if not set use a timer */
+
+struct fsl_i2c_platform_data {
+	/* device specific information */
+	u32 device_flags;
+};
+
+/* Flags related to I2C device features */
+#define FSL_I2C_DEV_SEPARATE_DFSRR	0x00000001
+#define FSL_I2C_DEV_CLOCK_5200		0x00000002
+
+#endif	/* _FSL_DEVICE_H_ */
+#endif	/* __KERNEL__ */
