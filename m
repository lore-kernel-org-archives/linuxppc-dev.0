Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B7B3DDF96
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 07:27:49 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n4CLRZk4015380
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 16:27:41 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Add MSI nodes for MPC8568/9 MDS systems
Date: Tue, 12 May 2009 16:27:33 -0500
Message-Id: <1242163655-880-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The MPC8568/9 chips support MSIs on PCIe so no reason not to enable them.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8568mds.dts |   16 ++++++++++++++++
 arch/powerpc/boot/dts/mpc8569mds.dts |   16 ++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 038913d..00c2bbd 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -288,6 +288,22 @@
 			device_type = "open-pic";
 		};
 
+		msi@41600 {
+			compatible = "fsl,mpc8568-msi", "fsl,mpic-msi";
+			reg = <0x41600 0x80>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0
+				0xe1 0
+				0xe2 0
+				0xe3 0
+				0xe4 0
+				0xe5 0
+				0xe6 0
+				0xe7 0>;
+			interrupt-parent = <&mpic>;
+		};
+
 		par_io@e0100 {
 			reg = <0xe0100 0x100>;
 			device_type = "par_io";
diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index 23a102e..39c2927 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -252,6 +252,22 @@
 			device_type = "open-pic";
 		};
 
+		msi@41600 {
+			compatible = "fsl,mpc8568-msi", "fsl,mpic-msi";
+			reg = <0x41600 0x80>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0
+				0xe1 0
+				0xe2 0
+				0xe3 0
+				0xe4 0
+				0xe5 0
+				0xe6 0
+				0xe7 0>;
+			interrupt-parent = <&mpic>;
+		};
+
 		global-utilities@e0000 {
 			compatible = "fsl,mpc8569-guts";
 			reg = <0xe0000 0x1000>;
-- 
1.6.0.6
