Return-Path: <tnt@246tNt.com>
Received: from outmx026.isp.belgacom.be (outmx026.isp.belgacom.be
	[195.238.2.91]) by ozlabs.org (Postfix) with ESMTP id 319A567A7A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Mar 2005 09:49:07 +1000 (EST)
Received: from outmx026.isp.belgacom.be (localhost [127.0.0.1])
	by outmx026.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2QNn4Uc007567
	for <linuxppc-embedded@ozlabs.org>; Sun, 27 Mar 2005 00:49:05 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4.20050327_004704.tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
In-Reply-To: <0.20050327_004704.tnt@patchsend.246tNt.com>
References: <0.20050327_004704.tnt@patchsend.246tNt.com>
Date: Sun, 27 Mar 2005 00:46:43 +0100 (CET)
Cc: Sylvain Munaut <tnt@246tNt.com>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 4/6] ppc32: Use platform bus / ppc_sys model for Freescale
	MPC52xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32: Use platform bus / ppc_sys model for Freescale MPC52xx

This patch makes all platform based around the Freescale MPC52xx use
the platform bus and more precisly the ppc_sys model put in
place by Kumar Gala.


Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---
diff -Nru a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
--- a/arch/ppc/platforms/lite5200.c	2005-03-26 19:56:21 +01:00
+++ b/arch/ppc/platforms/lite5200.c	2005-03-26 19:56:21 +01:00
@@ -34,6 +34,7 @@
 #include <asm/bootinfo.h>
 #include <asm/io.h>
 #include <asm/mpc52xx.h>
+#include <asm/ppc_sys.h>
 
 #include <syslib/mpc52xx_pci.h>
 
@@ -49,6 +50,17 @@
 /* Platform specific code                                                   */
 /* ======================================================================== */
 
+/* Supported PSC function in "preference" order */
+struct mpc52xx_psc_func mpc52xx_psc_functions[] = {
+		{       .id     = 0,
+			.func   = "uart",
+		},
+		{       .id     = -1,   /* End entry */
+			.func   = NULL,
+		}
+	};
+
+
 static int
 lite5200_show_cpuinfo(struct seq_file *m)
 {
@@ -147,6 +159,9 @@
 			strcpy(cmd_line, (char *)(r6+KERNELBASE));
 		}
 	}
+
+	/* PPC Sys identification */
+	identify_ppc_sys_by_id(mfspr(SPRN_SVR));
 
 	/* BAT setup */
 	mpc52xx_set_bat();
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2005-03-26 19:56:21 +01:00
+++ b/arch/ppc/syslib/Makefile	2005-03-26 19:56:21 +01:00
@@ -106,7 +106,8 @@
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o
 endif
 obj-$(CONFIG_MPC8555_CDS)	+= todc_time.o
-obj-$(CONFIG_PPC_MPC52xx)	+= mpc52xx_setup.o mpc52xx_pic.o
+obj-$(CONFIG_PPC_MPC52xx)	+= mpc52xx_setup.o mpc52xx_pic.o \
+					mpc52xx_sys.o mpc52xx_devices.o ppc_sys.o
 ifeq ($(CONFIG_PPC_MPC52xx),y)
 obj-$(CONFIG_PCI)		+= mpc52xx_pci.o
 endif
diff -Nru a/arch/ppc/syslib/mpc52xx_devices.c b/arch/ppc/syslib/mpc52xx_devices.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/mpc52xx_devices.c	2005-03-26 19:56:21 +01:00
@@ -0,0 +1,318 @@
+/*
+ * arch/ppc/syslib/mpc52xx_devices.c
+ *
+ * Freescale MPC52xx device descriptions
+ *
+ *
+ * Maintainer : Sylvain Munaut <tnt@246tNt.com>
+ *
+ * Copyright (C) 2005 Sylvain Munaut <tnt@246tNt.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/fsl_devices.h>
+#include <linux/resource.h>
+#include <asm/mpc52xx.h>
+#include <asm/ppc_sys.h>
+
+
+static u64 mpc52xx_dma_mask = 0xffffffffULL;
+
+static struct fsl_i2c_platform_data mpc52xx_fsl_i2c_pdata = {
+	.device_flags = FSL_I2C_DEV_CLOCK_5200,
+};
+
+
+/* We use relative offsets for IORESOURCE_MEM to be independent from the
+ * MBAR location at compile time
+ */
+
+/* TODO Add the BestComm initiator channel to the device definitions,
+   possibly using IORESOURCE_DMA. But that's when BestComm is ready ... */
+
+struct platform_device ppc_sys_platform_devices[] = {
+	[MPC52xx_MSCAN1] = {
+		.name		= "mpc52xx-mscan",
+		.id		= 0,
+		.num_resources	= 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x0900,
+				.end	= 0x097f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC52xx_MSCAN1_IRQ,
+				.end	= MPC52xx_MSCAN1_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC52xx_MSCAN2] = {
+		.name		= "mpc52xx-mscan",
+		.id		= 1,
+		.num_resources	= 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x0980,
+				.end	= 0x09ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC52xx_MSCAN2_IRQ,
+				.end	= MPC52xx_MSCAN2_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC52xx_SPI] = {
+		.name		= "mpc52xx-spi",
+		.id		= -1,
+		.num_resources	= 3,
+		.resource	= (struct resource[]) {
+			{
+				.start	= 0x0f00,
+				.end	= 0x0f1f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "modf",
+				.start	= MPC52xx_SPI_MODF_IRQ,
+				.end	= MPC52xx_SPI_MODF_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+			{
+				.name	= "spif",
+				.start	= MPC52xx_SPI_SPIF_IRQ,
+				.end	= MPC52xx_SPI_SPIF_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC52xx_USB] = {
+		.name		= "ppc-soc-ohci",
+		.id		= -1,
+		.num_resources	= 2,
+		.dev.dma_mask	= &mpc52xx_dma_mask,
+		.dev.coherent_dma_mask = 0xffffffffULL,
+		.resource	= (struct resource[]) {
+			{
+				.start	= 0x1000,
+				.end	= 0x10ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC52xx_USB_IRQ,
+				.end	= MPC52xx_USB_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC52xx_BDLC] = {
+		.name		= "mpc52xx-bdlc",
+		.id		= -1,
+		.num_resources	= 2,
+		.resource	= (struct resource[]) {
+			{
+				.start	= 0x1300,
+				.end	= 0x130f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC52xx_BDLC_IRQ,
+				.end	= MPC52xx_BDLC_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC52xx_PSC1] = {
+		.name		= "mpc52xx-psc",
+		.id		= 0,
+		.num_resources	= 2,
+		.resource	= (struct resource[]) {
+			{
+				.start	= 0x2000,
+				.end	= 0x209f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC52xx_PSC1_IRQ,
+				.end	= MPC52xx_PSC1_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC52xx_PSC2] = {
+		.name		= "mpc52xx-psc",
+		.id		= 1,
+		.num_resources	= 2,
+		.resource	= (struct resource[]) {
+			{
+				.start	= 0x2200,
+				.end	= 0x229f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC52xx_PSC2_IRQ,
+				.end	= MPC52xx_PSC2_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC52xx_PSC3] = {
+		.name		= "mpc52xx-psc",
+		.id		= 2,
+		.num_resources	= 2,
+		.resource	= (struct resource[]) {
+			{
+				.start	= 0x2400,
+				.end	= 0x249f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC52xx_PSC3_IRQ,
+				.end	= MPC52xx_PSC3_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC52xx_PSC4] = {
+		.name		= "mpc52xx-psc",
+		.id		= 3,
+		.num_resources	= 2,
+		.resource	= (struct resource[]) {
+			{
+				.start	= 0x2600,
+				.end	= 0x269f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC52xx_PSC4_IRQ,
+				.end	= MPC52xx_PSC4_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC52xx_PSC5] = {
+		.name		= "mpc52xx-psc",
+		.id		= 4,
+		.num_resources	= 2,
+		.resource	= (struct resource[]) {
+			{
+				.start	= 0x2800,
+				.end	= 0x289f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC52xx_PSC5_IRQ,
+				.end	= MPC52xx_PSC5_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC52xx_PSC6] = {
+		.name		= "mpc52xx-psc",
+		.id		= 5,
+		.num_resources	= 2,
+		.resource	= (struct resource[]) {
+			{
+				.start	= 0x2c00,
+				.end	= 0x2c9f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC52xx_PSC6_IRQ,
+				.end	= MPC52xx_PSC6_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC52xx_FEC] = {
+		.name		= "mpc52xx-fec",
+		.id		= -1,
+		.num_resources	= 2,
+		.resource	= (struct resource[]) {
+			{
+				.start	= 0x3000,
+				.end	= 0x33ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC52xx_FEC_IRQ,
+				.end	= MPC52xx_FEC_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC52xx_ATA] = {
+		.name		= "mpc52xx-ata",
+		.id		= -1,
+		.num_resources	= 2,
+		.resource	= (struct resource[]) {
+			{
+				.start	= 0x3a00,
+				.end	= 0x3aff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC52xx_ATA_IRQ,
+				.end	= MPC52xx_ATA_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC52xx_I2C1] = {
+		.name		= "fsl-i2c",
+		.id		= 0,
+		.dev.platform_data = &mpc52xx_fsl_i2c_pdata,
+		.num_resources	= 2,
+		.resource	= (struct resource[]) {
+			{
+				.start	= 0x3d00,
+				.end	= 0x3d1f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC52xx_I2C1_IRQ,
+				.end	= MPC52xx_I2C1_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC52xx_I2C2] = {
+		.name		= "fsl-i2c",
+		.id		= 1,
+		.dev.platform_data = &mpc52xx_fsl_i2c_pdata,
+		.num_resources	= 2,
+		.resource	= (struct resource[]) {
+			{
+				.start	= 0x3d40,
+				.end	= 0x3d5f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= MPC52xx_I2C2_IRQ,
+				.end	= MPC52xx_I2C2_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+};
+
+
+static int __init mach_mpc52xx_fixup(struct platform_device *pdev)
+{
+	ppc_sys_fixup_mem_resource(pdev, MPC52xx_MBAR);
+	return 0;
+}
+
+static int __init mach_mpc52xx_init(void)
+{
+	ppc_sys_device_fixup = mach_mpc52xx_fixup;
+	return 0;
+}
+
+postcore_initcall(mach_mpc52xx_init);
diff -Nru a/arch/ppc/syslib/mpc52xx_setup.c b/arch/ppc/syslib/mpc52xx_setup.c
--- a/arch/ppc/syslib/mpc52xx_setup.c	2005-03-26 19:56:21 +01:00
+++ b/arch/ppc/syslib/mpc52xx_setup.c	2005-03-26 19:56:21 +01:00
@@ -215,3 +215,16 @@
 	tb_ticks_per_jiffy = xlbfreq / HZ / divisor;
 	tb_to_us = mulhwu_scale_factor(xlbfreq / divisor, 1000000);
 }
+
+int mpc52xx_match_psc_function(int psc_idx, const char *func)
+{
+	struct mpc52xx_psc_func *cf = mpc52xx_psc_functions;
+
+	while ((cf->id != -1) && (cf->func != NULL)) {
+		if ((cf->id == psc_idx) && !strcmp(cf->func,func))
+			return 1;
+		cf++;
+	}
+
+	return 0;
+}
diff -Nru a/arch/ppc/syslib/mpc52xx_sys.c b/arch/ppc/syslib/mpc52xx_sys.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/mpc52xx_sys.c	2005-03-26 19:56:21 +01:00
@@ -0,0 +1,38 @@
+/*
+ * arch/ppc/syslib/mpc52xx_sys.c
+ *
+ * Freescale MPC52xx system descriptions
+ *
+ *
+ * Maintainer : Sylvain Munaut <tnt@246tNt.com>
+ *
+ * Copyright (C) 2005 Sylvain Munaut <tnt@246tNt.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <asm/ppc_sys.h>
+
+struct ppc_sys_spec *cur_ppc_sys_spec;
+struct ppc_sys_spec ppc_sys_specs[] = {
+	{
+		.ppc_sys_name	= "5200",
+		.mask		= 0xffff0000,
+		.value		= 0x80110000,
+		.num_devices	= 15,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC52xx_MSCAN1, MPC52xx_MSCAN2, MPC52xx_SPI,
+			MPC52xx_USB, MPC52xx_BDLC, MPC52xx_PSC1, MPC52xx_PSC2,
+			MPC52xx_PSC3, MPC52xx_PSC4, MPC52xx_PSC5, MPC52xx_PSC6,
+			MPC52xx_FEC, MPC52xx_ATA, MPC52xx_I2C1, MPC52xx_I2C2,
+		},
+	},
+	{	/* default match */
+		.ppc_sys_name	= "",
+		.mask		= 0x00000000,
+		.value		= 0x00000000,
+	},
+};
diff -Nru a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
--- a/include/asm-ppc/mpc52xx.h	2005-03-26 19:56:21 +01:00
+++ b/include/asm-ppc/mpc52xx.h	2005-03-26 19:56:21 +01:00
@@ -30,6 +30,29 @@
 
 
 /* ======================================================================== */
+/* PPC Sys devices definition                                               */
+/* ======================================================================== */
+
+enum ppc_sys_devices {
+	MPC52xx_MSCAN1,
+	MPC52xx_MSCAN2,
+	MPC52xx_SPI,
+	MPC52xx_USB,
+	MPC52xx_BDLC,
+	MPC52xx_PSC1,
+	MPC52xx_PSC2,
+	MPC52xx_PSC3,
+	MPC52xx_PSC4,
+	MPC52xx_PSC5,
+	MPC52xx_PSC6,
+	MPC52xx_FEC,
+	MPC52xx_ATA,
+	MPC52xx_I2C1,
+	MPC52xx_I2C2,
+};
+
+
+/* ======================================================================== */
 /* Main registers/struct addresses                                          */
 /* ======================================================================== */
 
@@ -391,6 +414,17 @@
 extern void mpc52xx_calibrate_decr(void);
 
 extern void mpc52xx_find_bridges(void);
+
+
+	/* Matching of PSC function */
+struct mpc52xx_psc_func {
+	int id;
+	char *func;
+};
+
+extern int mpc52xx_match_psc_function(int psc_idx, const char *func);
+extern struct  mpc52xx_psc_func mpc52xx_psc_functions[];
+	/* This array is to be defined in platform file */
 
 #endif /* __ASSEMBLY__ */
 
diff -Nru a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
--- a/include/asm-ppc/ppc_sys.h	2005-03-26 19:56:21 +01:00
+++ b/include/asm-ppc/ppc_sys.h	2005-03-26 19:56:21 +01:00
@@ -25,6 +25,8 @@
 #include <asm/mpc83xx.h>
 #elif defined(CONFIG_85xx)
 #include <asm/mpc85xx.h>
+#elif defined(CONFIG_PPC_MPC52xx)
+#include <asm/mpc52xx.h>
 #else
 #error "need definition of ppc_sys_devices"
 #endif
