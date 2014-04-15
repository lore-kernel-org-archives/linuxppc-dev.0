Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B1C04140116
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 20:54:41 +1000 (EST)
Received: by mail-lb0-f171.google.com with SMTP id w7so6671131lbi.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 03:54:37 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: [PATCH RFC v11 5/6] dma: mpc512x: add device tree binding document
Date: Tue, 15 Apr 2014 14:54:09 +0400
Message-Id: <1397559250-17680-6-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1397559250-17680-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1397559250-17680-1-git-send-email-a13xp0p0v88@gmail.com>
Cc: devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce a device tree binding document for the MPC512x DMA controller

Signed-off-by: Gerhard Sittig <gsi@denx.de>
Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
---
 .../devicetree/bindings/dma/mpc512x-dma.txt        | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/mpc512x-dma.txt b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
new file mode 100644
index 0000000..92eb0d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
@@ -0,0 +1,51 @@
+* Freescale MPC512x and MPC8308 DMA Controller
+
+The DMA controller in the Freescale MPC512x and MPC8308 SoCs can move
+blocks of memory contents between memory and peripherals or
+from memory to memory.
+
+Refer to the "Generic DMA Controller and DMA request bindings" in
+the dma/dma.txt file for a more detailed description of binding.
+
+* DMA controller
+
+Required properties:
+- compatible: Should be one of
+	"fsl,mpc5121-dma"
+	"fsl,mpc8308-dma", "fsl,mpc5121-dma"
+- reg: Address and size of the DMA controller's register set
+- interrupts: Interrupt for the DMA controller. Generic interrupt client node
+	is described in interrupt-controller/interrupts.txt
+
+Optional properties:
+- #dma-cells: The length of the DMA specifier, must be <1> since
+	the DMA controller uses a fixed assignment of request lines
+	per channel. Refer to dma/dma.txt for the detailed description
+	of this property
+
+Example:
+
+	dma0: dma@14000 {
+		compatible = "fsl,mpc5121-dma";
+		reg = <0x14000 0x1800>;
+		interrupts = <65 0x8>;
+		#dma-cells = <1>;
+	};
+
+* DMA client
+
+Required properties:
+- dmas: List of one or more DMA request specifiers. One DMA request specifier
+	consists of a phandle to the DMA controller node followed by
+	the integer specifying the request line
+- dma-names: Contains an identifier string for each DMA request specifier.
+	Refer to dma/dma.txt for the description of this property
+
+Example:
+
+	sdhc@1500 {
+		compatible = "fsl,mpc5121-sdhc";
+		/* ... */
+		dmas = <&dma0 30>;
+		dma-names = "rx-tx";
+	};
-- 
1.8.4.2
