Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0114.outbound.protection.outlook.com [157.56.110.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D72411A097F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 22:02:32 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@Freescale.com>
Subject: [PATCH v3 1/2] powerpc/corenet: Enable muxing MDIO buses via GPIO
Date: Thu, 22 Jan 2015 04:48:37 -0600
Message-ID: <1421923718-21352-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kanetkar.shruti@gmail.com, Andy Fleming <afleming@gmail.com>,
 Shruti Kanetkar <Shruti@Freescale.com>, Shaohui
 Xie <Shaohui.Xie@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andy Fleming <afleming@gmail.com>

Change-Id: I4489db79957ad533f4ba3f04fe7d5bcb3288e981
Signed-off-by: Andy Fleming <afleming@gmail.com>
Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Shruti Kanetkar <Shruti@Freescale.com>
---

v3:	Spearated from the FMan MDIO dt/binding patchset http://patchwork.ozlabs.org/patch/370871
	Also supersedes http://patchwork.ozlabs.org/patch/423350
	Update via 'savedefconfig'

 arch/powerpc/configs/corenet32_smp_defconfig  | 1 +
 arch/powerpc/configs/corenet64_smp_defconfig  | 2 ++
 arch/powerpc/platforms/85xx/corenet_generic.c | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 611efe9..5ccedc1 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -103,6 +103,7 @@ CONFIG_E1000E=y
 CONFIG_VITESSE_PHY=y
 CONFIG_AT803X_PHY=y
 CONFIG_FIXED_PHY=y
+CONFIG_MDIO_BUS_MUX_GPIO=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index be24a18..ce16278 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -80,6 +80,8 @@ CONFIG_SATA_SIL24=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
 CONFIG_E1000E=y
+CONFIG_PHYLIB=y
+CONFIG_MDIO_BUS_MUX_GPIO=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 1f309cc..0804b10 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -88,6 +88,9 @@ static const struct of_device_id of_device_ids[] = {
 		.compatible	= "simple-bus"
 	},
 	{
+		.compatible	= "mdio-mux-gpio"
+	},
+	{
 		.compatible	= "fsl,srio",
 	},
 	{
-- 
2.2.2
