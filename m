Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 02FF6B7EC8
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Feb 2010 18:48:49 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc: doc/dts-bindings: document mpc5121 psc uart
	dts-bindings
Date: Tue,  2 Feb 2010 08:47:43 +0100
Message-Id: <1265096864-3506-3-git-send-email-agust@denx.de>
In-Reply-To: <1265096864-3506-1-git-send-email-agust@denx.de>
References: <1265096864-3506-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Support for MPC5121 PSC UART in the mpc52xx_uart driver
added new DTS properties for FSL MPC5121 PSC FIFO Controller.
Provide documentation of the new properties and some examples.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 .../powerpc/dts-bindings/fsl/mpc5121-psc.txt       |   70 ++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/mpc5121-psc.txt

diff --git a/Documentation/powerpc/dts-bindings/fsl/mpc5121-psc.txt b/Documentation/powerpc/dts-bindings/fsl/mpc5121-psc.txt
new file mode 100644
index 0000000..8832e87
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/mpc5121-psc.txt
@@ -0,0 +1,70 @@
+MPC5121 PSC Device Tree Bindings
+
+PSC in UART mode
+----------------
+
+For PSC in UART mode the needed PSC serial devices
+are specified by fsl,mpc5121-psc-uart nodes in the
+fsl,mpc5121-immr SoC node. Additionally the PSC FIFO
+Controller node fsl,mpc5121-psc-fifo is requered there:
+
+fsl,mpc5121-psc-uart nodes
+--------------------------
+
+Required properties :
+ - compatible : Should contain "fsl,mpc5121-psc-uart" and "fsl,mpc5121-psc"
+ - cell-index : Index of the PSC in hardware
+ - reg : Offset and length of the register set for the PSC device
+ - interrupts : <a b> where a is the interrupt number of the
+   PSC FIFO Controller and b is a field that represents an
+   encoding of the sense and level information for the interrupt.
+ - interrupt-parent : the phandle for the interrupt controller that
+   services interrupts for this device.
+
+Recommended properties :
+ - fsl,rx-fifo-size : the size of the RX fifo slice (a multiple of 4)
+ - fsl,tx-fifo-size : the size of the TX fifo slice (a multiple of 4)
+
+
+fsl,mpc5121-psc-fifo node
+-------------------------
+
+Required properties :
+ - compatible : Should be "fsl,mpc5121-psc-fifo"
+ - reg : Offset and length of the register set for the PSC
+         FIFO Controller
+ - interrupts : <a b> where a is the interrupt number of the
+   PSC FIFO Controller and b is a field that represents an
+   encoding of the sense and level information for the interrupt.
+ - interrupt-parent : the phandle for the interrupt controller that
+   services interrupts for this device.
+
+
+Example for a board using PSC0 and PSC1 devices in serial mode:
+
+serial@11000 {
+	compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+	cell-index = <0>;
+	reg = <0x11000 0x100>;
+	interrupts = <40 0x8>;
+	interrupt-parent = < &ipic >;
+	fsl,rx-fifo-size = <16>;
+	fsl,tx-fifo-size = <16>;
+};
+
+serial@11100 {
+	compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+	cell-index = <1>;
+	reg = <0x11100 0x100>;
+	interrupts = <40 0x8>;
+	interrupt-parent = < &ipic >;
+	fsl,rx-fifo-size = <16>;
+	fsl,tx-fifo-size = <16>;
+};
+
+pscfifo@11f00 {
+	compatible = "fsl,mpc5121-psc-fifo";
+	reg = <0x11f00 0x100>;
+	interrupts = <40 0x8>;
+	interrupt-parent = < &ipic >;
+};
-- 
1.6.3.3
