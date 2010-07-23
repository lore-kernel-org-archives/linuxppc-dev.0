Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id AACB4100F10
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jul 2010 00:01:22 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 4/5] powerpc: doc/dts-bindings: update doc of FSL DIU
	bindings
Date: Fri, 23 Jul 2010 16:00:38 +0200
Message-Id: <1279893639-24333-5-git-send-email-agust@denx.de>
In-Reply-To: <1279893639-24333-1-git-send-email-agust@denx.de>
References: <1279893639-24333-1-git-send-email-agust@denx.de>
Cc: linux-fbdev@vger.kernel.org, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, devicetree-discuss@lists.ozlabs.org,
	Anatolij Gustschin <agust@denx.de>
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
Acked-by: Timur Tabi <timur@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org
---
v4:
 - added ack tag

v2 and v3:
 - no changes since v1

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
1.7.0.4
