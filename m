Return-Path: <yangbo.lu@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0076.outbound.protection.outlook.com [157.56.110.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqdpZ64mmzDqWs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 20:46:13 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <linux-mmc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <scott.wood@nxp.com>, Rob Herring
 <robh+dt@kernel.org>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 1/2] powerpc/85xx: adapt QorIQ eSDHC to the new clocking model
Date: Wed, 20 Apr 2016 18:20:43 +0800
Message-ID: <1461147644-18041-1-git-send-email-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Provide clocks property instead of clock-frequency for QorIQ eSDHC
dts node to adapt to the new clocking model, so that the driver
could get clock value by the common clk API and the u-boot could
remove the clock fixup.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
index 20835ae..ddbe562 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
@@ -36,5 +36,5 @@ sdhc: sdhc@114000 {
 	compatible = "fsl,esdhc";
 	reg = <0x114000 0x1000>;
 	interrupts = <48 2 0 0>;
-	clock-frequency = <0>;
+	clocks = <&clockgen 4 1>;
 };
-- 
2.1.0.27.g96db324
