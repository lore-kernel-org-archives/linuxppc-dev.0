Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 65C28B7D1D
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 09:49:39 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5] powerpc: doc/dts-bindings: update doc of FSL DIU bindings
Date: Fri, 30 Apr 2010 01:49:37 +0200
Message-Id: <1272584978-19063-5-git-send-email-agust@denx.de>
In-Reply-To: <1272584978-19063-1-git-send-email-agust@denx.de>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	devicetree-discuss@lists.ozlabs.org, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update compatible and interrupt properties description.
Furthermore an example for the MPC5121 has been added.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 Documentation/powerpc/dts-bindings/fsl/diu.txt |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/diu.txt b/Documentation/powerpc/dts-bindings/fsl/diu.txt
index deb35de..326cddf 100644
--- a/Documentation/powerpc/dts-bindings/fsl/diu.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/diu.txt
@@ -4,10 +4,12 @@ The Freescale DIU is a LCD controller, with proper hardware, it can also
 drive DVI monitors.
 
 Required properties:
-- compatible : should be "fsl-diu".
+- compatible : should be "fsl,diu" or "fsl,mpc5121-diu".
 - reg : should contain at least address and length of the DIU register
   set.
-- Interrupts : one DIU interrupt should be describe here.
+- interrupts : one DIU interrupt should be described here.
+- interrupt-parent : the phandle for the interrupt controller that
+  services interrupts for this device.
 
 Example (MPC8610HPCD):
 	display@2c000 {
@@ -16,3 +18,11 @@ Example (MPC8610HPCD):
 		interrupts = <72 2>;
 		interrupt-parent = <&mpic>;
 	};
+
+Example for MPC5121:
+	display@2100 {
+		compatible = "fsl,mpc5121-diu";
+		reg = <0x2100 0x100>;
+		interrupts = <64 0x8>;
+		interrupt-parent = <&ipic>;
+	};
-- 
1.6.3.3
