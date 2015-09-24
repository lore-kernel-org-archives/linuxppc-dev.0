Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0D851A02D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 03:27:58 +1000 (AEST)
Received: by lahh2 with SMTP id h2so70618868lah.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 10:27:55 -0700 (PDT)
From: Alexander Popov <alex.popov@linux.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anatolij Gustschin <agust@denx.de>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <robh@kernel.org>, Timur Tabi <timur@tabi.org>,
 Grant Likely <grant.likely@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, Alexander Popov <alex.popov@linux.com>,
 linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] powerpc/512x: add a device tree binding for LocalPlus
 Bus FIFO
Date: Thu, 24 Sep 2015 20:28:56 +0300
Message-Id: <1443115737-3948-3-git-send-email-alex.popov@linux.com>
In-Reply-To: <1443115737-3948-1-git-send-email-alex.popov@linux.com>
References: <1443115737-3948-1-git-send-email-alex.popov@linux.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a device tree binding for Freescale MPC512x LocalPlus Bus FIFO and
introduce the document describing that binding.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 .../bindings/powerpc/fsl/mpc512x_lpbfifo.txt        | 21 +++++++++++++++++++++
 arch/powerpc/boot/dts/mpc5121.dtsi                  | 11 +++++++++--
 arch/powerpc/boot/dts/mpc5125twr.dts                | 11 ++++++++++-
 3 files changed, 40 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpc512x_lpbfifo.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpc512x_lpbfifo.txt b/Documentation/devicetree/bindings/powerpc/fsl/mpc512x_lpbfifo.txt
new file mode 100644
index 0000000..b3b392f
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/mpc512x_lpbfifo.txt
@@ -0,0 +1,21 @@
+Freescale MPC512x LocalPlus Bus FIFO (called SCLPC in the Reference Manual)
+
+Required properties:
+- compatible: should be "fsl,mpc512x-lpbfifo";
+- reg: should contain the offset and length of SCLPC register set;
+- interrupts: should contain the interrupt specifier for SCLPC; syntax of an
+    interrupt client node is described in interrupt-controller/interrupts.txt;
+- dmas: should contain the DMA specifier for SCLPC as described at
+    dma/dma.txt and dma/mpc512x-dma.txt;
+- dma-names: should be "rx-tx";
+
+Example:
+
+	sclpc@10100 {
+		compatible = "fsl,mpc512x-lpbfifo";
+		reg = <0x10100 0x50>;
+		interrupts = <7 0x8>;
+		dmas = <&dma0 26>;
+		dma-names = "rx-tx";
+	};
+
diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
index 7f9d14f..a015e45 100644
--- a/arch/powerpc/boot/dts/mpc5121.dtsi
+++ b/arch/powerpc/boot/dts/mpc5121.dtsi
@@ -77,7 +77,6 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		reg = <0x80000020 0x40>;
-		interrupts = <7 0x8>;
 		ranges = <0x0 0x0 0xfc000000 0x04000000>;
 	};
 
@@ -329,7 +328,15 @@
 		/* LocalPlus controller */
 		lpc@10000 {
 			compatible = "fsl,mpc5121-lpc";
-			reg = <0x10000 0x200>;
+			reg = <0x10000 0x100>;
+		};
+
+		sclpc@10100 {
+			compatible = "fsl,mpc512x-lpbfifo";
+			reg = <0x10100 0x50>;
+			interrupts = <7 0x8>;
+			dmas = <&dma0 26>;
+			dma-names = "rx-tx";
 		};
 
 		pata@10200 {
diff --git a/arch/powerpc/boot/dts/mpc5125twr.dts b/arch/powerpc/boot/dts/mpc5125twr.dts
index e4f2974..898eb58 100644
--- a/arch/powerpc/boot/dts/mpc5125twr.dts
+++ b/arch/powerpc/boot/dts/mpc5125twr.dts
@@ -246,6 +246,14 @@
 			status = "disabled";
 		};
 
+		sclpc@10100 {
+			compatible = "fsl,mpc512x-lpbfifo";
+			reg = <0x10100 0x50>;
+			interrupts = <7 0x8>;
+			dmas = <&dma0 26>;
+			dma-names = "rx-tx";
+		};
+
 		// 5125 PSCs are not 52xx or 5121 PSC compatible
 		// PSC1 uart0 aka ttyPSC0
 		serial@11100 {
@@ -279,10 +287,11 @@
 			clock-names = "ipg";
 		};
 
-		dma@14000 {
+		dma0: dma@14000 {
 			compatible = "fsl,mpc5121-dma"; // BSP name: "mpc512x-dma2"
 			reg = <0x14000 0x1800>;
 			interrupts = <65 0x8>;
+			#dma-cells = <1>;
 		};
 	};
 };
-- 
1.9.1
