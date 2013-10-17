Return-Path: <B47053@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C308B2C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 20:11:29 +1100 (EST)
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <r65073@freescale.com>, <timur@tabi.org>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>
Subject: [PATCHv1 2/8] ARM: dts: Add Freescale SAI ALSA SoC Digital Audio
 Interface node for VF610.
Date: Thu, 17 Oct 2013 17:01:11 +0800
Message-ID: <1382000477-17304-3-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org,
 linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com, perex@perex.cz,
 LW@KARO-electronics.de, linux@arm.linux.org.uk, b42378@freescale.com,
 oskar@scara.com, grant.likely@linaro.org, devicetree@vger.kernel.org,
 ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org,
 rob.herring@calxeda.com, Jingchang Lu <b35083@freescale.com>,
 linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com,
 linux-kernel@vger.kernel.org, rob@landley.net, r64188@freescale.com,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch add the SAI's edma mux Tx and Rx support.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 18e3a4c..391f180 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -151,9 +151,11 @@
 			sai2: sai@40031000 {
 				compatible = "fsl,vf610-sai";
 				reg = <0x40031000 0x1000>;
-				interrupts = <0 86 0x04>;
 				clocks = <&clks VF610_CLK_SAI2>;
 				clock-names = "sai";
+				dma-names = "tx", "rx";
+				dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
+					<&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
 				status = "disabled";
 			};
 
-- 
1.8.0
