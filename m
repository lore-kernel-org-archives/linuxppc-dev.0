Return-Path: <guangyu.chen@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D61EE2C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2013 22:07:26 +1100 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <timur@tabi.org>, <shawn.guo@linaro.org>, <broonie@kernel.org>
Subject: [PATCH 1/2] ARM: dts: imx: specify the value of audmux pinctrl
 instead of 0x80000000
Date: Thu, 14 Nov 2013 19:07:09 +0800
Message-ID: <1384427230-979-2-git-send-email-b42378@freescale.com>
In-Reply-To: <1384427230-979-1-git-send-email-b42378@freescale.com>
References: <1384427230-979-1-git-send-email-b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux@arm.linux.org.uk, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org,
 linux-kernel@vger.kernel.org, rob.herring@calxeda.com, lgirdwood@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We must specify the value of audmux pinctrl if we want to use pinctrl_pm().
Thus change bypass value 0x80000000 to what we exactly need.

This patch also seperately unset PUE bit for TXD so that IOMUX won't pull
up/down the pin after turning into tristate. When we use SSI normal mode to
playback monaural audio via I2S signal, there'd be a pulled curve occur to
its signal at the second slot if setting PUE bit for TXD. And it will make
the second channel to play a constant noise. So by keeping the signal level
in the second slot, we can get a constant high level signal (-1) or a low
level one (0).

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 6e096ca..6b76e55 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -601,27 +601,27 @@
 				audmux {
 					pinctrl_audmux_1: audmux-1 {
 						fsl,pins = <
-							MX6QDL_PAD_SD2_DAT0__AUD4_RXD  0x80000000
-							MX6QDL_PAD_SD2_DAT3__AUD4_TXC  0x80000000
-							MX6QDL_PAD_SD2_DAT2__AUD4_TXD  0x80000000
-							MX6QDL_PAD_SD2_DAT1__AUD4_TXFS 0x80000000
+							MX6QDL_PAD_SD2_DAT0__AUD4_RXD  0x130b0
+							MX6QDL_PAD_SD2_DAT3__AUD4_TXC  0x130b0
+							MX6QDL_PAD_SD2_DAT2__AUD4_TXD  0x110b0
+							MX6QDL_PAD_SD2_DAT1__AUD4_TXFS 0x130b0
 						>;
 					};
 
 					pinctrl_audmux_2: audmux-2 {
 						fsl,pins = <
-							MX6QDL_PAD_CSI0_DAT7__AUD3_RXD  0x80000000
-							MX6QDL_PAD_CSI0_DAT4__AUD3_TXC  0x80000000
-							MX6QDL_PAD_CSI0_DAT5__AUD3_TXD  0x80000000
-							MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS 0x80000000
+							MX6QDL_PAD_CSI0_DAT7__AUD3_RXD  0x130b0
+							MX6QDL_PAD_CSI0_DAT4__AUD3_TXC  0x130b0
+							MX6QDL_PAD_CSI0_DAT5__AUD3_TXD  0x110b0
+							MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS 0x130b0
 						>;
 					};
 
 					pinctrl_audmux_3: audmux-3 {
 						fsl,pins = <
-							MX6QDL_PAD_DISP0_DAT16__AUD5_TXC  0x80000000
-							MX6QDL_PAD_DISP0_DAT18__AUD5_TXFS 0x80000000
-							MX6QDL_PAD_DISP0_DAT19__AUD5_RXD  0x80000000
+							MX6QDL_PAD_DISP0_DAT16__AUD5_TXC  0x130b0
+							MX6QDL_PAD_DISP0_DAT18__AUD5_TXFS 0x130b0
+							MX6QDL_PAD_DISP0_DAT19__AUD5_RXD  0x130b0
 						>;
 					};
 				};
-- 
1.8.4
