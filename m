Return-Path: <acurtis@onz.com>
Received: from dell2650.onz.com (onz.com [67.121.61.113])
	by ozlabs.org (Postfix) with ESMTP id 2E7A6679E1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 04:19:03 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by dell2650.onz.com (Postfix) with ESMTP id D918F2B4157
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Jun 2005 11:18:59 -0700 (PDT)
Received: from dell2650.onz.com ([127.0.0.1])
	by localhost (dell2650.onz.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 29696-01 for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Jun 2005 11:18:58 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by dell2650.onz.com (Postfix) with ESMTP id AA9242B413C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Jun 2005 11:18:58 -0700 (PDT)
From: Allen Curtis <acurtis@onz.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="=-6bcmCxSNMjtTbDwF5FUA"
Message-Id: <1118773086.29515.10.camel@dell2650.onz.com>
Mime-Version: 1.0
Date: Tue, 14 Jun 2005 11:18:06 -0700
Subject: RFC: cpm2_devices.c
Reply-To: acurtis@onz.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-6bcmCxSNMjtTbDwF5FUA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Please review and comment on the following.

My comments regarding the implementation:
1. This implementation uses the cpm_map_t structure definition to derive
the IORESOURCE_MEM regions. This seems to be more adaptible to CPM
address differences but it assumes that there are unique structures for
each processor type.

2. ppc_sys_spec appears to identify the CPM elements which are
applicable to a particular processor. So this structure, not the
cpm_map_t structure identifies the CPM resources. This implementation
addresses the the CPU differences but assumes that a CPM resource is
always at the same IMMAP address. The FCC, DPRAM usage is an example of
an exception to this rule.

Note: The attachment was generated via cg-diff, please let me know if
there is a preferred format.

Thanks


--=-6bcmCxSNMjtTbDwF5FUA
Content-Disposition: attachment; filename=cpm2_devices.patch
Content-Type: text/x-patch; name=cpm2_devices.patch; charset=
Content-Transfer-Encoding: 7bit

diff --git a/arch/ppc/syslib/cpm2_devices.c b/arch/ppc/syslib/cpm2_devices.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/syslib/cpm2_devices.c
@@ -0,0 +1,460 @@
+/*
+ * arch/ppc/platforms/cpm2_devices.c
+ *
+ * General CPM2 Device descriptions
+ *
+ * Maintainer: Allen Curtis <acurtis@onz.com>
+ * Derived from mpc83xx_devices.c by Kumar Gala
+ *
+ * Copyright 2005 Ones and Zeros Inc.
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
+#include <asm/cpm2.h>
+#include <asm/irq.h>
+#include <asm/ppc_sys.h>
+
+/* We use offsets for IORESOURCE_MEM since we do not know at compile time
+ * what IMMRBAR is, will get fixed up by mach_mpc83xx_fixup
+ */
+
+#define CPM2_STARTOF(m)		(offsetof(cpm2_map_t,(m)))
+#define CCPM2_ENDOF(m)		(CPM_STARTOF(m)+sizeof(m)-1)
+
+/* Define the CPM2 platform devices
+ */
+struct platform_device ppc_sys_platform_devices[] = {
+	[CPM2_FCC1] = {
+		.name = "fsl-cpm-fcc",
+		.id	= 1,
+		.dev.platform_data = ,
+		.num_resources	 = 5,
+		.resource = (struct resource[]) {
+			{
+				.name	= "fcc_regs",
+				.start	= CPM2_STARTOF(im_fcc[0]),
+				.end	= CPM2_ENDOF(im_fcc[0]),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_regs_c",
+				.start	= CPM2_STARTOF(im_fcc_c[0]),
+				.end	= CPM2_ENDOF(im_fcc_c[0]),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_pram",
+				.start	= PROFF_FCC1,
+				.end	= PROFF_FCC1 + PROFF_FCC_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			/* fcc_mem
+			 * This should be allocated from DPRAM, not part
+			 * of this structure definition.
+			 */
+			{
+				.name	= "fcc_mem",
+				.start	= PROFF_FCC1_MEM_BASE,
+				.end	= PROFF_FCC1_MEM_BASE + PROFF_FCC_MEM_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_FCC1,
+				.end	= SIU_INT_FCC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[CPM2_FCC2] = {
+		.name = "fsl-cpm-fcc",
+		.id	= 2,
+		.dev.platform_data = ,
+		.num_resources	 = 5,
+		.resource = (struct resource[]) {
+			{
+				.name	= "fcc_regs",
+				.start	= CPM2_STARTOF(im_fcc[1]),
+				.end	= CPM2_ENDOF(im_fcc[1]),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_regs_c",
+				.start	= CPM2_STARTOF(im_fcc_c[1]),
+				.end	= CPM2_ENDOF(im_fcc_c[1]),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_pram",
+				.start	= PROFF_FCC2,
+				.end	= PROFF_FCC2 + PROFF_FCC_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			/* fcc_mem
+			 * This should be allocated from DPRAM, not part
+			 * of this structure definition.
+			 */
+			{
+				.name	= "fcc_mem",
+				.start	= PROFF_FCC2_MEM_BASE,
+				.end	= PROFF_FCC2_MEM_BASE + PROFF_FCC_MEM_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_FCC2,
+				.end	= SIU_INT_FCC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[CPM2_FCC3] = {
+		.name = "fsl-cpm-fcc",
+		.id	= 3,
+		.dev.platform_data = ,
+		.num_resources	 = 5,
+		.resource = (struct resource[]) {
+			{
+				.name	= "fcc_regs",
+				.start	= CPM2_STARTOF(im_fcc[2]),
+				.end	= CPM2_ENDOF(im_fcc[2]),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_regs_c",
+				.start	= CPM2_STARTOF(im_fcc_c[2]),
+				.end	= CPM2_ENDOF(im_fcc_c[2]),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_pram",
+				.start	= PROFF_FCC3,
+				.end	= PROFF_FCC3 + PROFF_FCC_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			/* fcc_mem
+			 * This should be allocated from DPRAM, not part
+			 * of this structure definition.
+			 */
+			{
+				.name	= "fcc_mem",
+				.start	= PROFF_FCC3_MEM_BASE,
+				.end	= PROFF_FCC3_MEM_BASE + PROFF_FCC_MEM_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_FCC3,
+				.end	= SIU_INT_FCC3,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[CPM2_SCC1] = {
+		.name = "fsl-cpm-scc",
+		.id	= 1,
+		.dev.platform_data = ,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "scc_regs",
+				.start	= CPM2_STARTOF(im_scc[0]),
+				.end	= CPM2_ENDOF(im_scc[0]),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "scc_pram",
+				.start	= PROFF_SCC1,
+				.end	= PROFF_SCC1 + PROFF_SCC_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_SCC1,
+				.end	= SIU_INT_SCC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[CPM2_SCC2] = {
+		.name = "fsl-cpm-scc",
+		.id	= 2,
+		.dev.platform_data = ,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "scc_regs",
+				.start	= CPM2_STARTOF(im_scc[1]),
+				.end	= CPM2_ENDOF(im_scc[1]),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "scc_pram",
+				.start	= PROFF_SCC2,
+				.end	= PROFF_SCC2 + PROFF_SCC_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_SCC2,
+				.end	= SIU_INT_SCC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[CPM2_SCC3] = {
+		.name = "fsl-cpm-scc",
+		.id	= 3,
+		.dev.platform_data = ,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "scc_regs",
+				.start	= CPM2_STARTOF(im_scc[2]),
+				.end	= CPM2_ENDOF(im_scc[2]),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "scc_pram",
+				.start	= PROFF_SCC3,
+				.end	= PROFF_SCC3 + PROFF_SCC_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_SCC3,
+				.end	= SIU_INT_SCC3,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[CPM2_SCC4] = {
+		.name = "fsl-cpm-scc",
+		.id	= 4,
+		.dev.platform_data = ,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "scc_regs",
+				.start	= CPM2_STARTOF(im_scc[3]),
+				.end	= CPM2_ENDOF(im_scc[3]),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "scc_pram",
+				.start	= PROFF_SCC4,
+				.end	= PROFF_SCC4 + PROFF_SCC_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_SCC4,
+				.end	= SIU_INT_SCC4,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[CPM2_SMC1] = {
+		.name = "fsl-cpm-smc",
+		.id	= 1,
+		.dev.platform_data = ,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "smc_regs",
+				.start	= CPM2_STARTOF(im_smc[0]),
+				.end	= CPM2_ENDOF(im_smc[0]),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "smc_pram",
+				.start	= PROFF_SMC1_BASE,
+				.end	= PROFF_SMC1_BASE + PROFF_SMC_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_SMC1,
+				.end	= SIU_INT_SMC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[CPM2_SMC2] = {
+		.name = "fsl-cpm-smc",
+		.id	= 2,
+		.dev.platform_data = ,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "smc_regs",
+				.start	= CPM2_STARTOF(im_smc[1]),
+				.end	= CPM2_ENDOF(im_smc[1]),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "smc_pram",
+				.start	= PROFF_SMC2_BASE,
+				.end	= PROFF_SMC2_BASE + PROFF_SMC_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_SMC2,
+				.end	= SIU_INT_SMC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[CPM2_I2C] = {
+		.name = "fsl-cpm-i2c",
+		.id	= 1,
+		.dev.platform_data = ,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "i2c_regs",
+				.start	= CPM2_STARTOF(im_i2c),
+				.end	= CPM2_ENDOF(im_i2c),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "i2c_pram",
+				.start	= PROFF_I2C_BASE,
+				.end	= PROFF_I2C_BASE + PROFF_I2C_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_I2C,
+				.end	= SIU_INT_I2C,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[CPM2_SPI] = {
+		.name = "fsl-cpm-spi",
+		.id	= 1,
+		.dev.platform_data = ,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "spi_regs",
+				.start	= CPM2_STARTOF(im_spi),
+				.end	= CPM2_ENDOF(im_spi),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "spi_pram",
+				.start	= PROFF_SPI_BASE,
+				.end	= PROFF_SPI_BASE + PROFF_SPI_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_SPI,
+				.end	= SIU_INT_SPI,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[CPM2_CPM] = {
+		.name = "fsl-cpm-cpm",
+		.id	= 1,
+		.dev.platform_data = ,
+		.num_resources	 = 2,
+		.resource = (struct resource[]) {
+			{
+				.name	= "cpm_regs",
+				.start	= CPM2_STARTOF(im_cpm),
+				.end	= CPM2_ENDOF(im_cpm),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "cpm_mux",
+				.start	= CPM2_STARTOF(im_cpmux),
+				.end	= CPM2_ENDOF(im_cpmux),
+				.flags	= IORESOURCE_MEM,
+			},
+		},
+	},
+#if !defined(CONFIG_8272) && !defined(CONFIG_MPC8555)
+	[CPM2_MMC1] = {
+		.name = "fsl-cpm-mmc",
+		.id	= 1,
+		.dev.platform_data = ,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "mmc_regs",
+				.start	= CPM2_STARTOF(im_mmc1),
+				.end	= CPM2_ENDOF(im_mmc1),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "mmc_pram",
+				.start	= PROFF_MMC1,
+				.end	= PROFF_MMC1 + PROFF_MMC_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_MMC1,
+				.end	= SIU_INT_MMC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[CPM2_MMC2] = {
+		.name = "fsl-cpm-mmc",
+		.id	= 2,
+		.dev.platform_data = ,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "mmc_regs",
+				.start	= CPM2_STARTOF(im_mmc2),
+				.end	= CPM2_ENDOF(im_mmc2),
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "mmc_pram",
+				.start	= PROFF_MMC2,
+				.end	= PROFF_MMC2 + PROFF_MMC_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_MMC2,
+				.end	= SIU_INT_MMC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+#endif
+
+	
+static int __init mach_cpm2_fixup(struct platform_device *pdev)
+{
+	ppc_sys_fixup_mem_resource(pdev, CPM_MAP_ADDR);
+	return 0;
+}
+
+static int __init mach_cpm2_init(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("mach_cpm2_init:enter", 0);
+	ppc_sys_device_fixup = mach_cpm2_fixup;
+	return 0;
+}
+
+postcore_initcall(mach_cpm2_init);
+	
\ No newline at end of file
diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -170,6 +170,20 @@ typedef struct cpm_buf_desc {
 #define PROFF_I2C_BASE		((uint)0x8afc)
 #define PROFF_IDMA4_BASE	((uint)0x8afe)
 
+#define PROFF_FCC_SIZE		((uint))256)
+#define PROFF_SCC_SIZE		((uint))256)
+#define PROFF_SMC_SIZE		((uint)2)
+#define PROFF_IDMA_SIZE		((uint)2)
+#define PROFF_SPI_SIZE		((uint)2)
+#define PROFF_I2C_SIZE		((uint)2)
+#define PROFF_MMC_SIZE		((uint)124)
+#define PROFF_USB_SIZE		((uint)256)
+
+#define PROFF_FCC_MEM_SIZE	((uint)128)
+#define PROFF_FCC1_MEM_BASE	(CPM_FCC_SPECIAL_BASE+(PROFF_FCC_MEM_SIZE*0))
+#define PROFF_FCC2_MEM_BASE	(CPM_FCC_SPECIAL_BASE+(PROFF_FCC_MEM_SIZE*1))
+#define PROFF_FCC3_MEM_BASE	(CPM_FCC_SPECIAL_BASE+(PROFF_FCC_MEM_SIZE*2))
+
 /* The SMCs are relocated to any of the first eight DPRAM pages.
  * We will fix these at the first locations of DPRAM, until we
  * get some microcode patches :-).
@@ -1084,6 +1098,40 @@ typedef struct im_idma {
 #define SCCR_PCIDF_MSK	0x00000078	/* PCI division factor	*/
 #define SCCR_PCIDF_SHIFT 3
 
+/*-----------------------------------------------------------------------
+ * Enumeration of PPC/CPM2 devices for platform initialization
+ */
+
+/* It says this should be an enumeration. If it was #defines then the
+ * cpm2_devices array definition could be conditionally compiled.
+ *
+ * Another approach would be to add all devices and have a flags field
+ * for the different CPM configuration options.
+ */
+enum ppc_sys_devices {
+	CPM2_FCC1,
+	CPM2_FCC2,
+	CPM2_FCC3,
+	CPM2_SCC1,
+	CPM2_SCC2,
+	CPM2_SCC3,
+	CPM2_SCC4,
+	CPM2_SMC1,
+	CPM2_SMC2,
+	CPM2_I2C,
+	CPM2_SPI,
+/*	CPM2_DMA,	think about this more, separate SDMA and IDMA? */
+	CPM2_CPM,
+/*	CPM2_SI2,	*/
+#if !defined(CONFIG_8272) && !defined(CONFIG_MPC8555)
+	CPM2_SI1,
+	CPM2_MMC1,
+	CPM2_MMC2,
+#else
+	CPM2_USB,
+#endf	
+};
+
 
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */

--=-6bcmCxSNMjtTbDwF5FUA--
