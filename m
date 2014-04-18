Return-Path: <Shruti@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9B6E31400F1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 22:21:51 +1000 (EST)
From: Shruti Kanetkar <Shruti@Freescale.com>
To: <scottwood@Freescale.com>
Subject: [PATCH 2/6] powerpc/corenet: Enable muxing MDIO buses via FPGA
Date: Fri, 18 Apr 2014 07:21:29 -0500
Message-ID: <1397823693-27977-2-git-send-email-Shruti@Freescale.com>
In-Reply-To: <1397823693-27977-1-git-send-email-Shruti@Freescale.com>
References: <1397823693-27977-1-git-send-email-Shruti@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree@vger.kernel.org, Shruti Kanetkar <Shruti@Freescale.com>,
 linuxppc-dev@lists.ozlabs.org
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
index 548b21c..132d9f6 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -104,6 +104,7 @@ CONFIG_AT803X_PHY=y
 CONFIG_FIXED_PHY=y
 CONFIG_MDIO_BUS_MUX=y
 CONFIG_MDIO_BUS_MUX_GPIO=y
+CONFIG_MDIO_BUS_MUX_MMIOREG=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index cbe7afb..b355552 100644
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
index dc9e24e..814faae 100644
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
