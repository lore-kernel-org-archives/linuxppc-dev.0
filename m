Return-Path: <Shruti@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1FA531400E5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 22:21:49 +1000 (EST)
From: Shruti Kanetkar <Shruti@Freescale.com>
To: <scottwood@Freescale.com>
Subject: [PATCH 1/6] powerpc/corenet: Enable muxing MDIO buses via GPIO
Date: Fri, 18 Apr 2014 07:21:28 -0500
Message-ID: <1397823693-27977-1-git-send-email-Shruti@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree@vger.kernel.org, Andy Fleming <afleming@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Shruti Kanetkar <Shruti@Freescale.com>
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
Signed-off-by: Shruti Kanetkar <Shruti@Freescale.com>
---
 arch/powerpc/configs/corenet32_smp_defconfig  | 2 ++
 arch/powerpc/configs/corenet64_smp_defconfig  | 2 ++
 arch/powerpc/platforms/85xx/corenet_generic.c | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index bbd794d..548b21c 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -102,6 +102,8 @@ CONFIG_E1000E=y
 CONFIG_VITESSE_PHY=y
 CONFIG_AT803X_PHY=y
 CONFIG_FIXED_PHY=y
+CONFIG_MDIO_BUS_MUX=y
+CONFIG_MDIO_BUS_MUX_GPIO=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 5c7fa19..cbe7afb 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -96,6 +96,8 @@ CONFIG_SATA_SIL24=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
 CONFIG_E1000E=y
+CONFIG_MDIO_BUS_MUX=y
+CONFIG_MDIO_BUS_MUX_GPIO=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 8e4b1e1..dc9e24e 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -77,6 +77,9 @@ static const struct of_device_id of_device_ids[] = {
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
1.8.3.1
