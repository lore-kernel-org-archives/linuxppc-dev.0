Return-Path: <pieterjan.busschaert@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.235])
	by ozlabs.org (Postfix) with ESMTP id CF82F67C1A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 21:41:11 +1100 (EST)
Received: by qb-out-0506.google.com with SMTP id q12so84698qbq
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 02:41:09 -0800 (PST)
Message-ID: <950a36fb0612140241n15ca51e5xb8a9bb98888befb8@mail.gmail.com>
Date: Thu, 14 Dec 2006 11:41:09 +0100
From: "Pieter-Jan Busschaert" <pieterjan.busschaert@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2.6.19] enable watchdog device on mpc834x platforms
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch adds the watchdog device for all mpc834x platforms. It
should be used with the mpc83xx_wdt driver which is already present in
the kernel.

Patch is made against a clean 2.6.19 kernel.

Signed-off-by: Pieter-Jan Busschaert
<pieterjan.busschaert+ppcembedded@gmail.com>

---
 arch/ppc/syslib/mpc83xx_devices.c |   17 ++++++++++++++++
 arch/ppc/syslib/mpc83xx_sys.c     |   40 ++++++++++++++++++++++----------------
 include/asm-ppc/mpc83xx.h         |    1
 include/linux/fsl_devices.h       |    4 +++
 4 files changed, 46 insertions(+), 16 deletions(-)

Index: linux-2.6.19/arch/ppc/syslib/mpc83xx_devices.c
===================================================================
--- linux-2.6.19.orig/arch/ppc/syslib/mpc83xx_devices.c
+++ linux-2.6.19/arch/ppc/syslib/mpc83xx_devices.c
@@ -64,6 +64,10 @@
 	{ },
 };

+static struct fsl_mpc83xx_wdt_platform_data mpc83xx_wdt_pdata = {
+	.freq		= 400000000,
+};
+
 struct platform_device ppc_sys_platform_devices[] = {
 	[MPC83xx_TSEC1] = {
 		.name = "fsl-gianfar",
@@ -232,6 +236,19 @@
 			},
 		},
 	},
+	[MPC83xx_WDT] = {
+		.name = "mpc83xx_wdt",
+		.id = 0,
+		.dev.platform_data = &mpc83xx_wdt_pdata,
+		.num_resources = 1,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x00200,
+				.end	= 0x002ff,
+				.flags	= IORESOURCE_MEM,
+			},
+		},
+	},
 };

 static int __init mach_mpc83xx_fixup(struct platform_device *pdev)
Index: linux-2.6.19/arch/ppc/syslib/mpc83xx_sys.c
===================================================================
--- linux-2.6.19.orig/arch/ppc/syslib/mpc83xx_sys.c
+++ linux-2.6.19/arch/ppc/syslib/mpc83xx_sys.c
@@ -22,96 +22,104 @@
 		.ppc_sys_name	= "8349E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80500000,
-		.num_devices	= 9,
+		.num_devices	= 10,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
-			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO,
+			MPC83xx_WDT
 		},
 	},
 	{
 		.ppc_sys_name	= "8349",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80510000,
-		.num_devices	= 8,
+		.num_devices	= 9,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART,
-			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO,
+			MPC83xx_WDT
 		},
 	},
 	{
 		.ppc_sys_name	= "8347E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80520000,
-		.num_devices	= 9,
+		.num_devices	= 10,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
-			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO,
+			MPC83xx_WDT
 		},
 	},
 	{
 		.ppc_sys_name	= "8347",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80530000,
-		.num_devices	= 8,
+		.num_devices	= 9,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART,
-			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO,
+			MPC83xx_WDT
 		},
 	},
 	{
 		.ppc_sys_name	= "8347E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80540000,
-		.num_devices	= 9,
+		.num_devices	= 10,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
-			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO,
+			MPC83xx_WDT
 		},
 	},
 	{
 		.ppc_sys_name	= "8347",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80550000,
-		.num_devices	= 8,
+		.num_devices	= 9,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART,
-			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO,
+			MPC83xx_WDT
 		},
 	},
 	{
 		.ppc_sys_name	= "8343E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80560000,
-		.num_devices	= 8,
+		.num_devices	= 9,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
-			MPC83xx_USB2_DR, MPC83xx_MDIO
+			MPC83xx_USB2_DR, MPC83xx_MDIO,
+			MPC83xx_WDT
 		},
 	},
 	{
 		.ppc_sys_name	= "8343",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80570000,
-		.num_devices	= 7,
+		.num_devices	= 8,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART,
-			MPC83xx_USB2_DR, MPC83xx_MDIO
+			MPC83xx_USB2_DR, MPC83xx_MDIO,
+			MPC83xx_WDT
 		},
 	},
 	{	/* default match */
Index: linux-2.6.19/include/asm-ppc/mpc83xx.h
===================================================================
--- linux-2.6.19.orig/include/asm-ppc/mpc83xx.h
+++ linux-2.6.19/include/asm-ppc/mpc83xx.h
@@ -107,6 +107,7 @@
 	MPC83xx_USB2_DR,
 	MPC83xx_USB2_MPH,
 	MPC83xx_MDIO,
+	MPC83xx_WDT,
 	NUM_PPC_SYS_DEVS,
 };

Index: linux-2.6.19/include/linux/fsl_devices.h
===================================================================
--- linux-2.6.19.orig/include/linux/fsl_devices.h
+++ linux-2.6.19/include/linux/fsl_devices.h
@@ -119,6 +119,10 @@
 	u32	sysclk;
 };

+struct fsl_mpc83xx_wdt_platform_data {
+	unsigned int	freq;
+};
+
 /* Ethernet interface (phy management and speed)
 */
 enum enet_interface {
