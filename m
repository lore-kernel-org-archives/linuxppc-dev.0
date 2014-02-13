Return-Path: <hrai@nmglablinux22.freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 118A72C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 18:29:30 +1100 (EST)
From: Harninder Rai <harninder.rai@freescale.com>
To: <scottwood@freescale.com>, <devicetree@vger.kernel.org>
Subject: [PATCH][v2] powerpc/fsl: Add/update miscellaneous missing bindings
Date: Thu, 13 Feb 2014 12:59:14 +0530
Message-ID: <1392276554-10368-1-git-send-email-harninder.rai@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Harninder Rai <harninder.rai@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Missing bindings were found on running checkpatch.pl on bsc9132
device tree. This patch add/update the following

- Add bindings for L2 cache controller
- Add bindings for memory controller
- Update bindings for USB controller

Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
---
Changes since base version:
Incorporated Scott's comments
- Rename l2cc.txt to l2cache.txt
- Add information about ePAPR compliance
- Add missing "cache" in compatible
- Miscellaneous minors

 .../devicetree/bindings/powerpc/fsl/l2cache.txt    |   26 ++++++++++++++++++++
 .../devicetree/bindings/powerpc/fsl/mem-ctrlr.txt  |   16 ++++++++++++
 Documentation/devicetree/bindings/usb/fsl-usb.txt  |    2 +
 3 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mem-ctrlr.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt b/Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt
new file mode 100644
index 0000000..79ef4a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt
@@ -0,0 +1,26 @@
+Freescale L2 Cache Controller
+
+L2 cache is present in Freescale's QorIQ and QorIQ Qonverge platforms.
+The cache bindings explained below are ePAPR compliant
+
+Required Properties:
+
+- compatible	: Should include "fsl,chip-l2-cache-controller" and "cache"
+		  where chip is the processor (bsc9132, npc8572 etc.)
+- reg		: Address and size of L2 cache controller registers
+- cache-size	: Size of the entire L2 cache
+- interrupts	: Error interrupt of L2 controller
+
+Optional Properties:
+
+- cache-line-size : Size of L2 cache lines
+
+Example:
+
+	L2: l2-cache-controller@20000 {
+		compatible = "fsl,bsc9132-l2-cache-controller", "cache";
+		reg = <0x20000 0x1000>;
+		cache-line-size = <32>; // 32 bytes
+		cache-size = <0x40000>; // L2,256K
+		interrupts = <16 2 1 0>;
+	};
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mem-ctrlr.txt b/Documentation/devicetree/bindings/powerpc/fsl/mem-ctrlr.txt
new file mode 100644
index 0000000..70b42bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/mem-ctrlr.txt
@@ -0,0 +1,16 @@
+Freescale DDR memory controller
+
+Properties:
+
+- compatible	: Should include "fsl,chip-memory-controller" where
+		  chip is the processor (bsc9132, mpc8572 etc.)
+- reg		: Address and size of DDR controller registers
+- interrupts	: Error interrupt of DDR controller
+
+Example:
+
+	memory-controller@2000 {
+		compatible = "fsl,bsc9132-memory-controller";
+		reg = <0x2000 0x1000>;
+		interrupts = <16 2 1 8>;
+	};
diff --git a/Documentation/devicetree/bindings/usb/fsl-usb.txt b/Documentation/devicetree/bindings/usb/fsl-usb.txt
index bd5723f..afa5809 100644
--- a/Documentation/devicetree/bindings/usb/fsl-usb.txt
+++ b/Documentation/devicetree/bindings/usb/fsl-usb.txt
@@ -9,6 +9,8 @@ Required properties :
  - compatible : Should be "fsl-usb2-mph" for multi port host USB
    controllers, or "fsl-usb2-dr" for dual role USB controllers
    or "fsl,mpc5121-usb2-dr" for dual role USB controllers of MPC5121
+   Wherever applicable, the IP version of the USB controller should
+   also be mentioned (for eg. fsl-usb2-dr-v2.2 for bsc9132).
  - phy_type : For multi port host USB controllers, should be one of
    "ulpi", or "serial". For dual role USB controllers, should be
    one of "ulpi", "utmi", "utmi_wide", or "serial".
-- 
1.7.6.GIT
