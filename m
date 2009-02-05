Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1709EDDEEC
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 06:04:49 +1100 (EST)
Date: Thu, 5 Feb 2009 22:04:47 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc: Document FSL eSDHC bindings
Message-ID: <20090205190447.GA3348@oksana.dev.rtsoft.ru>
References: <20090205190403.GA27976@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090205190403.GA27976@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch documents OF bindings for the Freescale Enhanced Secure
Digital Host Controller.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/dts-bindings/fsl/esdhc.txt |   24 ++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/esdhc.txt

diff --git a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
new file mode 100644
index 0000000..6008465
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
@@ -0,0 +1,24 @@
+* Freescale Enhanced Secure Digital Host Controller (eSDHC)
+
+The Enhanced Secure Digital Host Controller provides an interface
+for MMC, SD, and SDIO types of memory cards.
+
+Required properties:
+  - compatible : should be
+    "fsl,<chip>-esdhc", "fsl,mpc8379-esdhc" for MPC83xx processors.
+    "fsl,<chip>-esdhc", "fsl,mpc8536-esdhc" for MPC85xx processors.
+  - reg : should contain eSDHC registers location and length.
+  - interrupts : should contain eSDHC interrupt.
+  - interrupt-parent : interrupt source phandle.
+  - clock-frequency : specifies eSDHC base clock frequency.
+
+Example:
+
+sdhci@2e000 {
+	compatible = "fsl,mpc8378-esdhc", "fsl,mpc8379-esdhc";
+	reg = <0x2e000 0x1000>;
+	interrupts = <42 0x8>;
+	interrupt-parent = <&ipic>;
+	/* Filled in by U-Boot */
+	clock-frequency = <0>;
+};
-- 
1.5.6.5
