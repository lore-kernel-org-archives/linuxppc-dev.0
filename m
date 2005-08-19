Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 08917680AE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 22:44:28 +1000 (EST)
Message-ID: <4305D42A.2080803@ru.mvista.com>
Date: Fri, 19 Aug 2005 16:44:26 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@freescale.com>
Content-Type: multipart/mixed; boundary="------------010703080902010606020804"
Cc: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [RFC][PATCH] [1/2] 8xx platform definitions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010703080902010606020804
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

This is preliminary version of 8xx platform definitions. Currently sys 
section contains only MPC885 and MPC866. Working example of 
board-specific setup will follow.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

-- 
Sincerely,
Vitaly

--------------010703080902010606020804
Content-Type: text/x-patch;
 name="8xx_platform_devices.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8xx_platform_devices.patch"

8xx platform stuff

---
commit e4c1c9d34899352dd332c63dea090e8ba9bbe757
tree 1b6484c6cac83d6e851854fe5c73357e014f2819
parent 7e49f04f36830c7d1ee442447e46dba3a0a1b58d
author Vitaly Bordug <vbordug@ru.mvista.com> Fri, 19 Aug 2005 16:37:50 +0400
committer Vitaly Bordug <vbordug@ru.mvista.com> Fri, 19 Aug 2005 16:37:50 +0400

 arch/ppc/syslib/Makefile         |    3 
 arch/ppc/syslib/mpc8xx_devices.c |  274 ++++++++++++++++++++++++++++++++++++++
 arch/ppc/syslib/mpc8xx_sys.c     |   61 ++++++++
 include/asm-ppc/mpc8xx.h         |   20 +++
 include/asm-ppc/ppc_sys.h        |    2 
 5 files changed, 359 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -34,7 +34,8 @@ ifeq ($(CONFIG_40x),y)
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o ppc405_pci.o
 endif
 endif
-obj-$(CONFIG_8xx)		+= m8xx_setup.o ppc8xx_pic.o $(wdt-mpc8xx-y)
+obj-$(CONFIG_8xx)		+= m8xx_setup.o ppc8xx_pic.o $(wdt-mpc8xx-y) \
+				   ppc_sys.o mpc8xx_devices.o mpc8xx_sys.o
 ifeq ($(CONFIG_8xx),y)
 obj-$(CONFIG_PCI)		+= qspan_pci.o i8259.o
 endif
diff --git a/arch/ppc/syslib/mpc8xx_devices.c b/arch/ppc/syslib/mpc8xx_devices.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/syslib/mpc8xx_devices.c
@@ -0,0 +1,274 @@
+/*
+ * arch/ppc/syslib/mpc8xx_devices.c
+ *
+ * MPC8xx Device descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 MontaVista Software, Inc. by Vitaly Bordug<vbordug@ru.mvista.com>
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
+#include <linux/serial_8250.h>
+#include <linux/fsl_devices.h>
+#include <linux/fs_enet_pd.h>
+#include <linux/mii.h>
+#include <asm/commproc.h>
+#include <asm/mpc8xx.h>
+#include <asm/irq.h>
+#include <asm/ppc_sys.h>
+
+/* access ports */
+#define setbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) |  (_v))
+#define clrbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) & ~(_v))
+
+#define setbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) |  (_v))
+#define clrbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) & ~(_v))
+
+#define MPC8xx_INT_FEC1		SIU_LEVEL1
+#define MPC8xx_INT_FEC2		SIU_LEVEL3
+
+#define MPC8xx_INT_SCC1		(CPM_IRQ_OFFSET + CPMVEC_SCC1)
+#define MPC8xx_INT_SCC2		(CPM_IRQ_OFFSET + CPMVEC_SCC2)
+#define MPC8xx_INT_SCC3		(CPM_IRQ_OFFSET + CPMVEC_SCC3)
+#define MPC8xx_INT_SCC4		(CPM_IRQ_OFFSET + CPMVEC_SCC4)
+#define MPC8xx_INT_SMC1		(CPM_IRQ_OFFSET + CPMVEC_SMC1)
+#define MPC8xx_INT_SMC2		(CPM_IRQ_OFFSET + CPMVEC_SMC2)
+
+/* Offset from IMMAP base address */
+#define MPC8xx_SCC1_OFFSET	(0xa00)
+#define MPC8xx_SCC1_SIZE	(0x18)
+#define MPC8xx_SCC2_OFFSET	(0xa20)
+#define MPC8xx_SCC2_SIZE	(0x18)
+#define MPC8xx_SCC3_OFFSET	(0xa40)
+#define MPC8xx_SCC3_SIZE	(0x18)
+#define MPC8xx_SCC4_OFFSET	(0xa60)
+#define MPC8xx_SCC4_SIZE	(0x18)
+#define MPC8xx_SMC1_OFFSET	(0xa82)
+#define MPC8xx_SMC1_SIZE	(0x0f)
+#define MPC8xx_SMC2_OFFSET	(0xa92)
+#define MPC8xx_SMC2_SIZE	(0x0d)
+#define MPC8xx_FEC1_OFFSET	(0xe00)
+#define MPC8xx_FEC1_SIZE	(0x88)
+#define MPC8xx_FEC2_OFFSET	(0x1e00)
+#define MPC8xx_FEC2_SIZE	(0x88)
+
+#define MPC8xx_DPARAM_SCC1_OFFSET	(0x3C00)
+#define MPC8xx_DPARAM_SCC1_SIZE	(0x80)
+#define MPC8xx_DPARAM_SCC2_OFFSET	(0x3D00)
+#define MPC8xx_DPARAM_SCC2_SIZE	(0x80)
+#define MPC8xx_DPARAM_SCC3_OFFSET	(0x3E00)
+#define MPC8xx_DPARAM_SCC3_SIZE	(0x80)
+#define MPC8xx_DPARAM_SCC4_OFFSET	(0x3F00)
+#define MPC8xx_DPARAM_SCC4_SIZE	(0x80)
+#define MPC8xx_DPARAM_SMC1_OFFSET	(0x3E80)
+#define MPC8xx_DPARAM_SMC1_SIZE	(0x40)
+#define MPC8xx_DPARAM_SMC2_OFFSET	(0x3F80)
+#define MPC8xx_DPARAM_SMC2_SIZE	(0x40)
+
+/* We use offsets for IORESOURCE_MEM to do not set dependences at compile time.
+ * They will get fixed up by mach_mpc8xx_fixup
+ */
+
+struct platform_device ppc_sys_platform_devices[] = {
+	[MPC8xx_CPM_FEC1] =	{
+		.name = "fsl-cpm-fec",
+		.id	= 1,
+		.num_resources = 2,
+		.resource = (struct resource[])	{
+			{
+				.name 	= "regs",
+				.start	= MPC8xx_FEC1_OFFSET,
+				.end	= MPC8xx_FEC1_OFFSET + MPC8xx_FEC1_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_FEC1,
+				.end	= MPC8xx_INT_FEC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_FEC2] =	{
+		.name = "fsl-cpm-fec",
+		.id	= 2,
+		.num_resources = 2,
+		.resource = (struct resource[])	{
+			{
+				.name	= "regs",
+				.start	= MPC8xx_FEC2_OFFSET,
+				.end	= MPC8xx_FEC2_OFFSET + MPC8xx_FEC2_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_FEC2,
+				.end	= MPC8xx_INT_FEC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SCC1] = {
+		.name = "fsl-cpm-scc",
+		.id	= 1,
+		.num_resources = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= MPC8xx_SCC1_OFFSET,
+				.end	= MPC8xx_SCC1_OFFSET + MPC8xx_SCC1_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name 	= "pram",
+				.start 	= MPC8xx_DPARAM_SCC1_OFFSET,
+				.end 	= MPC8xx_DPARAM_SCC1_OFFSET + MPC8xx_DPARAM_SCC1_SIZE,
+				.flags 	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SCC1,
+				.end	= MPC8xx_INT_SCC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SCC2] = {
+		.name = "fsl-cpm-scc",
+		.id	= 2,
+		.num_resources	= 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= MPC8xx_SCC2_OFFSET,
+				.end	= MPC8xx_SCC2_OFFSET + MPC8xx_SCC2_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name 	= "pram",
+				.start 	= MPC8xx_DPARAM_SCC2_OFFSET,
+				.end 	= MPC8xx_DPARAM_SCC2_OFFSET + MPC8xx_DPARAM_SCC2_SIZE,
+				.flags 	= IORESOURCE_MEM,
+			},
+
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SCC2,
+				.end	= MPC8xx_INT_SCC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SCC3] = {
+		.name = "fsl-cpm-scc",
+		.id	= 3,
+		.num_resources	= 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= MPC8xx_SCC3_OFFSET,
+				.end	= MPC8xx_SCC3_OFFSET + MPC8xx_SCC3_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name 	= "pram",
+				.start 	= MPC8xx_DPARAM_SCC3_OFFSET,
+				.end 	= MPC8xx_DPARAM_SCC3_OFFSET + MPC8xx_DPARAM_SCC3_SIZE,
+				.flags 	= IORESOURCE_MEM,
+			},
+
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SCC3,
+				.end	= MPC8xx_INT_SCC3,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SCC4] = {
+		.name = "fsl-cpm-scc",
+		.id	= 4,
+		.num_resources	= 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= MPC8xx_SCC4_OFFSET,
+				.end	= MPC8xx_SCC3_OFFSET + MPC8xx_SCC1_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name 	= "pram",
+				.start 	= MPC8xx_DPARAM_SCC4_OFFSET,
+				.end 	= MPC8xx_DPARAM_SCC4_OFFSET + MPC8xx_DPARAM_SCC4_SIZE,
+				.flags 	= IORESOURCE_MEM,
+			},
+
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SCC4,
+				.end	= MPC8xx_INT_SCC4,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SMC1] = {
+		.name = "fsl-cpm-smc",
+		.id	= 1,
+		.num_resources	= 2,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= MPC8xx_SMC1_OFFSET,
+				.end	= MPC8xx_SCC3_OFFSET + MPC8xx_SMC1_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SMC1,
+				.end	= MPC8xx_INT_SMC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SMC2] = {
+		.name = "fsl-cpm-smc",
+		.id	= 2,
+		.num_resources	= 2,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= MPC8xx_SMC2_OFFSET,
+				.end	= MPC8xx_SMC2_OFFSET + MPC8xx_SMC2_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SMC2,
+				.end	= MPC8xx_INT_SMC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+};
+
+static int __init mach_mpc8xx_fixup(struct platform_device *pdev)
+{
+	ppc_sys_fixup_mem_resource (pdev, IMAP_ADDR);
+	return 0;
+}
+
+static int __init mach_mpc8xx_init(void)
+{
+	ppc_sys_device_fixup = mach_mpc8xx_fixup;
+	return 0;
+}
+
+postcore_initcall(mach_mpc8xx_init);
diff --git a/arch/ppc/syslib/mpc8xx_sys.c b/arch/ppc/syslib/mpc8xx_sys.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/syslib/mpc8xx_sys.c
@@ -0,0 +1,61 @@
+/*
+ * arch/ppc/platforms/mpc8xx_sys.c
+ *
+ * MPC8xx System descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 MontaVista Software, Inc. by Vitaly Bordug <vbordug@ru.mvista.com>
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
+#include <asm/ppc_sys.h>
+
+struct ppc_sys_spec *cur_ppc_sys_spec; 
+struct ppc_sys_spec ppc_sys_specs[] = {
+	{
+		.ppc_sys_name	= "MPC86X",
+		.mask 		= 0xFFFFFFFF,
+		.value 		= 0x00000000,
+		.num_devices	= 2,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC8xx_CPM_FEC1,
+			MPC8xx_CPM_SCC1,
+			MPC8xx_CPM_SCC2,
+			MPC8xx_CPM_SCC3,
+			MPC8xx_CPM_SCC4,
+			MPC8xx_CPM_SMC1,
+			MPC8xx_CPM_SMC2,
+		},
+	},
+	{
+		.ppc_sys_name	= "MPC885",
+		.mask 		= 0xFFFFFFFF,
+		.value 		= 0x00000000,
+		.num_devices	= 3,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC8xx_CPM_FEC1,
+			MPC8xx_CPM_FEC2,
+			MPC8xx_CPM_SCC1,
+			MPC8xx_CPM_SCC2,
+			MPC8xx_CPM_SCC3,
+			MPC8xx_CPM_SCC4,
+			MPC8xx_CPM_SMC1,
+			MPC8xx_CPM_SMC2,
+		},
+	},
+	{	/* default match */
+		.ppc_sys_name	= "",
+		.mask 		= 0x00000000,
+		.value 		= 0x00000000,
+	},
+};
@@ -101,6 +105,22 @@ extern unsigned char __res[];
 
 struct pt_regs;
 
+enum ppc_sys_devices {
+	MPC8xx_CPM_FEC1,
+	MPC8xx_CPM_FEC2,
+	MPC8xx_CPM_I2C,
+	MPC8xx_CPM_SCC1,
+	MPC8xx_CPM_SCC2,
+	MPC8xx_CPM_SCC3,
+	MPC8xx_CPM_SCC4,
+	MPC8xx_CPM_SPI,
+	MPC8xx_CPM_MCC1,
+	MPC8xx_CPM_MCC2,
+	MPC8xx_CPM_SMC1,
+	MPC8xx_CPM_SMC2,
+	MPC8xx_CPM_USB,
+};
+
 #endif /* !__ASSEMBLY__ */
 #endif /* CONFIG_8xx */
 #endif /* __CONFIG_8xx_DEFS */
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -25,6 +25,8 @@
 #include <asm/mpc83xx.h>
 #elif defined(CONFIG_85xx)
 #include <asm/mpc85xx.h>
+#elif defined(CONFIG_8xx)
+#include <asm/mpc8xx.h>
 #elif defined(CONFIG_PPC_MPC52xx)
 #include <asm/mpc52xx.h>
 #elif defined(CONFIG_MPC10X_BRIDGE)

--------------010703080902010606020804--
