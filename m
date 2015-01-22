Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0142.outbound.protection.outlook.com [207.46.100.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AEA41A08AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 22:02:31 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@Freescale.com>
Subject: [PATCH v3 2/2] powerpc/corenet: Enable muxing MDIO buses via FPGA
Date: Thu, 22 Jan 2015 04:48:38 -0600
Message-ID: <1421923718-21352-2-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1421923718-21352-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1421923718-21352-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kanetkar.shruti@gmail.com, Shruti Kanetkar <Shruti@Freescale.com>, Andy
 Fleming <afleming@gmail.com>, Shaohui Xie <Shaohui.Xie@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Shruti Kanetkar <Shruti@Freescale.com>

Change-Id: I00c521664573808af4f9a9c06a97665db470b49a
Signed-off-by: Andy Fleming <afleming@gmail.com>
Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Shruti Kanetkar <Shruti@Freescale.com>
---

v3:	Spearated from the FMan MDIO dt/binding patchset http://patchwork.ozlabs.org/patch/370873
	Also supersedes http://patchwork.ozlabs.org/patch/423348
	Update via 'savedefconfig'
	Auto-probe devices on 'fsl,fpga-qixis'

arch/powerpc/configs/corenet32_smp_defconfig  | 1 +
 arch/powerpc/configs/corenet64_smp_defconfig  | 1 +
 arch/powerpc/platforms/85xx/corenet_generic.c | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 5ccedc1..869270c 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -104,6 +104,7 @@ CONFIG_VITESSE_PHY=y
 CONFIG_AT803X_PHY=y
 CONFIG_FIXED_PHY=y
 CONFIG_MDIO_BUS_MUX_GPIO=y
+CONFIG_MDIO_BUS_MUX_MMIOREG=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index ce16278..00c49b0 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -82,6 +82,7 @@ CONFIG_DUMMY=y
 CONFIG_E1000E=y
 CONFIG_PHYLIB=y
 CONFIG_MDIO_BUS_MUX_GPIO=y
+CONFIG_MDIO_BUS_MUX_MMIOREG=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 0804b10..63bef30 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -91,6 +91,12 @@ static const struct of_device_id of_device_ids[] = {
 		.compatible	= "mdio-mux-gpio"
 	},
 	{
+		.compatible	= "fsl,fpga-ngpixis"
+	},
+	{
+		.compatible	= "fsl,fpga-qixis"
+	},
+	{
 		.compatible	= "fsl,srio",
 	},
 	{
-- 
2.2.2
