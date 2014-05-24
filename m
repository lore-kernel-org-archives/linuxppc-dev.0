Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-x22f.google.com (mail-lb0-x22f.google.com
 [IPv6:2a00:1450:4010:c04::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1831D1A0591
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 19:33:44 +1000 (EST)
Received: by mail-lb0-f175.google.com with SMTP id l4so3248339lbv.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 02:33:38 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/3] dmaengine: mpc512x: add device tree binding document
Date: Sat, 24 May 2014 13:33:27 +0400
Message-Id: <1400924009-23992-2-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1400924009-23992-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1400924009-23992-1-git-send-email-a13xp0p0v88@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce a device tree binding document for the MPC512x DMA controller

Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
---
 .../devicetree/bindings/dma/mpc512x-dma.txt        | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/mpc512x-dma.txt b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
new file mode 100644
index 0000000..b1cbc3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
@@ -0,0 +1,40 @@
+* Freescale MPC512x and MPC8308 DMA Controller
+
+The DMA controller in Freescale MPC512x and MPC8308 SoCs can move
+blocks of memory contents between memory and peripherals or
+from memory to memory.
+
+Refer to "Generic DMA Controller and DMA request bindings" in
+the dma/dma.txt file for a more detailed description of binding.
+
+Required properties:
+- compatible: Should be "fsl,mpc5121-dma" or "fsl,mpc8308-dma"
+- reg: Address and size of the DMA controller's register set
+- Interrupt for the DMA controller. Syntax of interrupt client node
+	is described in interrupt-controller/interrupts.txt
+
+Optional properties:
+- #dma-cells: The length of the DMA specifier, must be <1>.
+	Each channel of this DMA controller has a peripheral request line,
+	this assignment is fixed in hardware. The cell in dmas property
+	of a client device represents the channel number
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
+DMA clients must use the format described in dma/dma.txt
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
