Return-Path: <guangyu.chen@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3D087140162
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 21:07:05 +1100 (EST)
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>, <shawn.guo@linaro.org>
Subject: [PATCH v3 2/2] ARM: dts: Append clock bindings for sai2 on VF610
 platform
Date: Fri, 4 Apr 2014 18:08:13 +0800
Message-ID: <08ba57a2fdce1a404a6bcb61e21e25509fcd6b30.1396605772.git.Guangyu.Chen@freescale.com>
In-Reply-To: <cover.1396605772.git.Guangyu.Chen@freescale.com>
References: <cover.1396605772.git.Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, rob@landley.net,
 galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since we added fours clock to the DT binding, we should update the current
SAI dts/dtsi so as not to break their functions.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
Tested-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index d31ce1b..9fd0007 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -139,8 +139,10 @@
 				compatible = "fsl,vf610-sai";
 				reg = <0x40031000 0x1000>;
 				interrupts = <0 86 0x04>;
-				clocks = <&clks VF610_CLK_SAI2>;
-				clock-names = "sai";
+				clocks = <&clks VF610_CLK_SAI2>,
+				       <&clks VF610_CLK_SAI2>,
+				       <&clks 0>, <&clks 0>;
+				clock-names = "bus", "mclk1", "mclk2", "mclk3";
 				status = "disabled";
 			};
 
-- 
1.8.4
