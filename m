Return-Path: <yangbo.lu@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411WBC5ZzvzF327
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 13:24:51 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 05/10] arm64: dts: fsl: move ptp timer out of fman
Date: Thu,  7 Jun 2018 11:22:51 +0800
Message-Id: <20180607032256.39802-6-yangbo.lu@nxp.com>
In-Reply-To: <20180607032256.39802-1-yangbo.lu@nxp.com>
References: <20180607032256.39802-1-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is to move ptp timer node out of fman.
Because ptp timer will be probed by ptp_qoriq driver,
it should be an independent device in case of conflict
memory mapping.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Fixed address-cells for ptp-timer.
---
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
index 4dd0676..a56a408 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
@@ -11,13 +11,14 @@ fman0: fman@1a00000 {
 	#size-cells = <1>;
 	cell-index = <0>;
 	compatible = "fsl,fman";
-	ranges = <0x0 0x0 0x1a00000 0x100000>;
-	reg = <0x0 0x1a00000 0x0 0x100000>;
+	ranges = <0x0 0x0 0x1a00000 0xfe000>;
+	reg = <0x0 0x1a00000 0x0 0xfe000>;
 	interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 	clocks = <&clockgen 3 0>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x800 0x10>;
+	ptimer-handle = <&ptp_timer0>;
 
 	muram@0 {
 		compatible = "fsl,fman-muram";
@@ -73,9 +74,10 @@ fman0: fman@1a00000 {
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfd000 0x1000>;
 	};
+};
 
-	ptp_timer0: ptp-timer@fe000 {
-		compatible = "fsl,fman-ptp-timer";
-		reg = <0xfe000 0x1000>;
-	};
+ptp_timer0: ptp-timer@1afe000 {
+	compatible = "fsl,fman-ptp-timer";
+	reg = <0x0 0x1afe000 0x0 0x1000>;
+	interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 };
-- 
1.7.1
