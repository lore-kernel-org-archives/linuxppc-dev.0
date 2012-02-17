Return-Path: <B38951@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE2781007D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 13:53:14 +1100 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc: document the FSL MPIC message register binding
Date: Fri, 17 Feb 2012 10:49:02 +0800
Message-ID: <1329446943-9732-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: meador_inge@mentor.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This binding documents how the message register blocks found in some FSL
MPIC implementations shall be represented in a device tree.

Signed-off-by: Meador Inge <meador_inge@mentor.com>
Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/mpic-msgr.txt  |   62 ++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt b/Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
new file mode 100644
index 0000000..b4ae70e
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
@@ -0,0 +1,62 @@
+* FSL MPIC Message Registers
+
+This binding specifies what properties must be available in the device tree
+representation of the message register blocks found in some FSL MPIC
+implementations.
+
+Required properties:
+
+    - compatible: Specifies the compatibility list for the message register
+      block.  The type shall be <string> and the value shall be of the form
+      "fsl,mpic-v<version>-msgr", where <version> is the version number of
+      the MPIC containing the message registers.
+
+    - reg: Specifies the base physical address(s) and size(s) of the
+      message register block's addressable register space.  The type shall be
+      <prop-encoded-array>.
+
+    - interrupts: Specifies a list of interrupt source and level-sense pairs.
+      The type shall be <prop-encoded-array>.  The length shall be equal to
+      the number of registers that are available for receiving interrupts.
+
+Optional properties:
+
+    - mpic-msgr-receive-mask: Specifies what registers in the containing block
+      are allowed to receive interrupts.  The value is a bit mask where a set
+      bit at bit 'n' indicates that message register 'n' can receive interrupts.
+      The type shall be <prop-encoded-array>.  If not present, then all of
+      the message registers in the block are available.
+
+Aliases:
+
+    An alias should be created for every message register block.  They are not
+    required, though.  However, a particular implementation of this binding
+    may require aliases to be present.  Aliases are of the form
+    'mpic-msgr-block<n>', where <n> is an integer specifying the block's number.
+    Numbers shall start at 0.
+
+Example:
+
+	aliases {
+		mpic-msgr-block0 = &mpic_msgr_block0;
+		mpic-msgr-block1 = &mpic_msgr_block1;
+	};
+
+	mpic_msgr_block0: mpic-msgr-block@41400 {
+		compatible = "fsl,mpic-v3.1-msgr";
+		reg = <0x41400 0x200>;
+		// Message registers 0 and 2 in this block can receive interrupts on
+		// sources 0xb0 and 0xb2, respectively.
+		interrupts = <0xb0 2 0xb2 2>;
+		mpic-msgr-receive-mask = <0x5>;
+	};
+
+	mpic_msgr_block1: mpic-msgr-block@42400 {
+		compatible = "fsl,mpic-v3.1-msgr";
+		reg = <0x42400 0x200>;
+		// Message registers 0 and 2 in this block can receive interrupts on
+		// sources 0xb4 and 0xb6, respectively.
+		interrupts = <0xb4 2 0xb6 2>;
+		mpic-msgr-receive-mask = <0x5>;
+	};
+
-- 
1.7.5.1
