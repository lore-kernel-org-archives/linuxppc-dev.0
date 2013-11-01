Return-Path: <B47053@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E14B2C0447
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 18:49:29 +1100 (EST)
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <r65073@freescale.com>, <timur@tabi.org>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>
Subject: [PATCHv2 4/8] Documentation: Add device tree bindings for Freescale
 SAI.
Date: Fri, 1 Nov 2013 15:04:51 +0800
Message-ID: <1383289495-24523-5-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org,
 linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com, perex@perex.cz,
 LW@KARO-electronics.de, linux@arm.linux.org.uk, b42378@freescale.com,
 oskar@scara.com, grant.likely@linaro.org, devicetree@vger.kernel.org,
 ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org,
 rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org,
 fabio.estevam@freescale.com, linux-kernel@vger.kernel.org, rob@landley.net,
 r64188@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds the Document for Freescale SAI driver under
Documentation/devicetree/bindings/sound/.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 .../devicetree/bindings/sound/fsl-sai.txt          | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl-sai.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
new file mode 100644
index 0000000..267afbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -0,0 +1,32 @@
+Freescale Synchronous Audio Interface (SAI).
+
+The SAI is based on I2S module that used communicating with audio codecs,
+which provides a synchronous audio interface that supports fullduplex
+serial interfaces with frame synchronization such as I2S, AC97, TDM, and
+codec/DSP interfaces.
+
+
+Required properties:
+- compatible: Compatible list, contains "fsl,vf610-sai".
+- reg: Offset and length of the register set for the device.
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names : Must include the "sai" entry.
+- dmas : Generic dma devicetree binding as described in
+  Documentation/devicetree/bindings/dma/dma.txt.
+- dma-names : Two dmas have to be defined, "tx" and "rx".
+- pinctrl-names: Must contain a "default" entry.
+- pinctrl-NNN: One property must exist for each entry in pinctrl-names.
+  See ../pinctrl/pinctrl-bindings.txt for details of the property values.
+
+Example:
+sai2: sai@40031000 {
+	      compatible = "fsl,vf610-sai";
+	      reg = <0x40031000 0x1000>;
+	      pinctrl-names = "default";
+	      pinctrl-0 = <&pinctrl_sai2_1>;
+	      clocks = <&clks VF610_CLK_SAI2>;
+	      clock-names = "sai";
+	      dma-names = "tx", "rx";
+	      dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
+		   <&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
+};
-- 
1.8.4
