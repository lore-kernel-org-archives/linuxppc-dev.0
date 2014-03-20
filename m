Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-x232.google.com (mail-lb0-x232.google.com
 [IPv6:2a00:1450:4010:c04::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B571E2C0131
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 01:48:27 +1100 (EST)
Received: by mail-lb0-f178.google.com with SMTP id s7so679733lbd.37
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 07:48:22 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: [PATCH RFC v10 5/6] dma: mpc512x: add device tree binding document
Date: Thu, 20 Mar 2014 18:47:57 +0400
Message-Id: <1395326878-25243-6-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1395326878-25243-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1395326878-25243-1-git-send-email-a13xp0p0v88@gmail.com>
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
