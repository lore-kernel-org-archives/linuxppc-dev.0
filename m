Return-Path: <Shruti@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0242.outbound.protection.outlook.com [207.46.163.242])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC8B01A03F2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 06:33:16 +1000 (EST)
From: Shruti Kanetkar <Shruti@Freescale.com>
To: <scottwood@Freescale.com>
Subject: [PATCH v2 7/7] powerpc/corenet: Enable muxing MDIO buses via FPGA
Date: Wed, 16 Jul 2014 15:17:11 -0500
Message-ID: <1405541831-1277-7-git-send-email-Shruti@Freescale.com>
In-Reply-To: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
References: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shruti Kanetkar <Shruti@Freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Andy Fleming <afleming@gmail.com>, Shaohui Xie <Shaohui.Xie@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andy Fleming <afleming@gmail.com>
Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Shruti Kanetkar <Shruti@Freescale.com>
---
 arch/powerpc/configs/corenet32_smp_defconfig  | 1 +
 arch/powerpc/configs/corenet64_smp_defconfig  | 1 +
 arch/powerpc/platforms/85xx/corenet_generic.c | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 64dcd113..9c62cac 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -105,6 +105,7 @@ CONFIG_AT803X_PHY=y
 CONFIG_FIXED_PHY=y
 CONFIG_MDIO_BUS_MUX=y
 CONFIG_MDIO_BUS_MUX_GPIO=y
+CONFIG_MDIO_BUS_MUX_MMIOREG=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 7f25c4a..d12cab5 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -99,6 +99,7 @@ CONFIG_E1000E=y
 CONFIG_MDIO_BUS_MUX=y
 CONFIG_MDIO_BUS_MUX_GPIO=y
 CONFIG_INPUT_FF_MEMLESS=m
+CONFIG_MDIO_BUS_MUX_MMIOREG=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index e5473bb..a0b50dd 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -80,6 +80,9 @@ static const struct of_device_id of_device_ids[] = {
 		.compatible	= "mdio-mux-gpio"
 	},
 	{
+		.compatible	= "fsl,fpga-ngpixis"
+	},
+	{
 		.compatible	= "fsl,srio",
 	},
 	{
-- 
1.8.3.1
