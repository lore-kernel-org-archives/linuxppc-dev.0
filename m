Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 108FDDDED9
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 21:29:17 +1000 (EST)
Message-ID: <486F5B18.1030508@scram.de>
Date: Sat, 05 Jul 2008 13:29:28 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: Add documentation for CPM GPIO banks
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 Documentation/powerpc/device-tree/fsl/cpm/gpio.txt |   38 ++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/device-tree/fsl/cpm/gpio.txt

diff --git a/Documentation/powerpc/device-tree/fsl/cpm/gpio.txt b/Documentation/powerpc/device-tree/fsl/cpm/gpio.txt
new file mode 100644
index 0000000..54644ae
--- /dev/null
+++ b/Documentation/powerpc/device-tree/fsl/cpm/gpio.txt
@@ -0,0 +1,38 @@
+Every GPIO controller node must have #gpio-cells property defined,
+this information will be used to translate gpio-specifiers.
+
+On CPM1 devices, all ports are using slightly different register layouts.
+Ports A, C and D are 16bit ports and Ports B and E are 32bit ports.
+
+On CPM2 devices, all ports are 32bit ports and use a common register layout.
+
+Required properties:
+- compatible : "fsl,cpm1-pario-bank-a", "fsl,cpm1-pario-bank-b", 
+  "fsl,cpm1-pario-bank-c", "fsl,cpm1-pario-bank-d",
+  "fsl,cpm1-pario-bank-e", "fsl,cpm2-pario-bank"
+- #gpio-cells : Should be two. The first cell is the pin number and the
+  second cell is used to specify optional paramters (currently unused).
+- gpio-controller : Marks the port as GPIO controller.
+
+Example of three SOC GPIO banks defined as gpio-controller nodes:
+
+	CPM1_PIO_A: gpio-controller@950 {
+		#gpio-cells = <2>;
+		compatible = "fsl,cpm1-pario-bank-a";
+		reg = <0x950 0x10>;
+		gpio-controller;
+	};
+
+	CPM1_PIO_B: gpio-controller@ab8 {
+		#gpio-cells = <2>;
+		compatible = "fsl,cpm1-pario-bank-b";
+		reg = <0xab8 0x10>;
+		gpio-controller;
+	};
+
+	CPM1_PIO_E: gpio-controller@ac8 {
+		#gpio-cells = <2>;
+		compatible = "fsl,cpm1-pario-bank-e";
+		reg = <0xac8 0x18>;
+		gpio-controller;
+	};
-- 
1.5.6
