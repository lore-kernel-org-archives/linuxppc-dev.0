Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-x22e.google.com (mail-la0-x22e.google.com
 [IPv6:2a00:1450:4010:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1648A2C0228
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 22:09:55 +1100 (EST)
Received: by mail-la0-f46.google.com with SMTP id b8so5410825lan.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 03:09:51 -0800 (PST)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: [PATCH RFC v8 4/5] dma: mpc512x: add device tree binding document
Date: Mon, 24 Feb 2014 15:09:31 +0400
Message-Id: <1393240172-18769-5-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1393240172-18769-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1393240172-18769-1-git-send-email-a13xp0p0v88@gmail.com>
Cc: devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gerhard Sittig <gsi@denx.de>

introduce a device tree binding document for the MPC512x DMA controller

Signed-off-by: Gerhard Sittig <gsi@denx.de>
[ a13xp0p0v88@gmail.com: turn this into a separate patch ]
---
 .../devicetree/bindings/dma/mpc512x-dma.txt        | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/mpc512x-dma.txt b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
new file mode 100644
index 0000000..a4867d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
@@ -0,0 +1,55 @@
+* Freescale MPC512x DMA Controller
+
+The DMA controller in the Freescale MPC512x SoC can move blocks of
+memory contents between memory and peripherals or memory to memory.
+
+Refer to the "Generic DMA Controller and DMA request bindings" description
+in the dma.txt file for a more detailled discussion of the binding.  The
+MPC512x DMA engine binding follows the common scheme, but doesn't provide
+support for the optional channels and requests counters (those values are
+derived from the detected hardware features) and has a fixed client
+specifier length of 1 integer cell (the value is the DMA channel, since
+the DMA controller uses a fixed assignment of request lines per channel).
+
+
+DMA controller node properties:
+
+Required properties:
+- compatible:		should be "fsl,mpc5121-dma"
+- reg:			address and size of the DMA controller's register set
+- interrupts:		interrupt spec for the DMA controller
+
+Optional properties:
+- #dma-cells:		must be <1>, describes the number of integer cells
+			needed to specify the 'dmas' property in client nodes,
+			strongly recommended since common client helper code
+			uses this property
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
+
+Client node properties:
+
+Required properties:
+- dmas:			list of DMA specifiers, consisting each of a handle
+			for the DMA controller and integer cells to specify
+			the channel used within the DMA controller
+- dma-names:		list of identifier strings for the DMA specifiers,
+			client device driver code uses these strings to
+			have DMA channels looked up at the controller
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
