Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0139.outbound.protection.outlook.com [207.46.100.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2482D1A006F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2015 03:03:25 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: [v5 1/2] powerpc/corenet: Enable muxing MDIO buses via GPIO
Date: Fri, 27 Feb 2015 09:57:55 -0600
Message-ID: <1425052676-17490-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shruti Kanetkar <Kanetkar.Shruti@gmail.com>,
 Andy Fleming <afleming@gmail.com>, Shaohui Xie <Shaohui.Xie@Freescale.com>,
 Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andy Fleming <afleming@gmail.com>

Signed-off-by: Andy Fleming <afleming@gmail.com>
Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Shruti Kanetkar <Kanetkar.Shruti@gmail.com>
Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---

v5:	Remove 'Change-Id'

v4:	Add 'Signed-off-by'

v3:	Spearated from the FMan MDIO dt/binding patchset http://patchwork.ozlabs.org/patch/370871
	Also supersedes http://patchwork.ozlabs.org/patch/423350
	Update via 'savedefconfig'

 arch/powerpc/configs/corenet32_smp_defconfig  | 1 +
 arch/powerpc/configs/corenet64_smp_defconfig  | 1 +
 arch/powerpc/platforms/85xx/corenet_generic.c | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index ca7957b..44e53a4 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -99,6 +99,7 @@ CONFIG_E1000E=y
 CONFIG_AT803X_PHY=y
 CONFIG_VITESSE_PHY=y
 CONFIG_FIXED_PHY=y
+CONFIG_MDIO_BUS_MUX_GPIO=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 04737aa..724e579 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -85,6 +85,7 @@ CONFIG_FSL_XGMAC_MDIO=y
 CONFIG_E1000E=y
 CONFIG_VITESSE_PHY=y
 CONFIG_FIXED_PHY=y
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
2.3.0
