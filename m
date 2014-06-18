Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-x229.google.com (mail-la0-x229.google.com
 [IPv6:2a00:1450:4010:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FA391A02E3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 20:48:35 +1000 (EST)
Received: by mail-la0-f41.google.com with SMTP id hz20so400826lab.28
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 03:48:30 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] dmaengine: mpc512x: add device tree binding document
Date: Wed, 18 Jun 2014 14:48:10 +0400
Message-Id: <1403088492-15241-2-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1403088492-15241-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1403088492-15241-1-git-send-email-a13xp0p0v88@gmail.com>
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
 .../devicetree/bindings/dma/mpc512x-dma.txt        | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/mpc512x-dma.txt b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
new file mode 100644
index 0000000..95e2ca0
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
@@ -0,0 +1,31 @@
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
+- compatible: should be "fsl,mpc5121-dma" or "fsl,mpc8308-dma";
+- reg: should contain the DMA controller registers location and length;
+- interrupt for the DMA controller: syntax of interrupt client node
+	is described in interrupt-controller/interrupts.txt file.
+
+Optional properties:
+- #dma-cells: the length of the DMA specifier, must be <1>.
+	Each channel of this DMA controller has a peripheral request line,
+	the assignment is fixed in hardware. This one cell
+	in dmas property of a client device represents the channel number.
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
+DMA clients must use the format described in dma/dma.txt file.
-- 
1.8.4.2
