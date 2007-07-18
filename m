Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B0347DEE7E
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:45 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1Zdeo027619
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:40 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZdqU001485
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:39 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1AwLB007923
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:10:58 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 4009DAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:38 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1Zcow015379
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:38 -0500
Date: Tue, 17 Jul 2007 20:35:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 30/61] fsl_soc: Update the way get_brgfreq() finds things in
	the device tree.
Message-ID: <20070718013538.GB15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It now uses names that are less namespace polluting.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/mpc8272ads.dts |    5 ++---
 arch/powerpc/boot/dts/mpc8560ads.dts |    5 ++---
 arch/powerpc/boot/dts/mpc866ads.dts  |    5 ++---
 arch/powerpc/boot/dts/mpc885ads.dts  |    5 ++---
 arch/powerpc/sysdev/fsl_soc.c        |   10 +++++-----
 5 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 4d09dca..16a77f4 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -119,12 +119,11 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			#interrupt-cells = <2>;
-			device_type = "cpm";
-			model = "CPM2";
+			compatible = "fsl,mpc8272-cpm", "fsl,cpm2", "fsl,cpm";
 			ranges = <00000000 00000000 20000>;
 			reg = <0 20000>;
 			command-proc = <119c0>;
-			brg-frequency = <17D7840>;
+			fsl,brg-frequency = <d#25000000>;
 			cpm_clk = <BEBC200>;
 
 			scc@11a00 {
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 21ccaaa..1626587 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -235,12 +235,11 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			#interrupt-cells = <2>;
-			device_type = "cpm";
-			model = "CPM2";
+			compatible = "fsl,mpc8560-cpm", "fsl,cpm2", "fsl,cpm";
 			ranges = <0 0 c0000>;
 			reg = <80000 40000>;
 			command-proc = <919c0>;
-			brg-frequency = <9d5b340>;
+			fsl,brg-frequency = <d#165000000>;
 
 			cpmpic: pic@90c00 {
 				interrupt-controller;
diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
index e5e7726..b3dbfe8 100644
--- a/arch/powerpc/boot/dts/mpc866ads.dts
+++ b/arch/powerpc/boot/dts/mpc866ads.dts
@@ -87,12 +87,11 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			#interrupt-cells = <2>;
-			device_type = "cpm";
-			model = "CPM";
+			compatible = "fsl,mpc866-cpm", "fsl,cpm1", "fsl,cpm";
 			ranges = <0 0 4000>;
 			reg = <860 f0>;
 			command-proc = <9c0>;
-			brg-frequency = <0>;
+			fsl,brg-frequency = <0>;
 			interrupts = <0 2>;	// cpm error interrupt
 			interrupt-parent = <&Cpm_pic>;
 
diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index dc7ab9c..8372469 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -118,12 +118,11 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			#interrupt-cells = <2>;
-			device_type = "cpm";
-			model = "CPM";
+			compatible = "fsl,mpc885-cpm", "fsl,cpm1", "fsl,cpm";
 			ranges = <0 0 4000>;
 			reg = <860 f0>;
 			command-proc = <9c0>;
-			brg-frequency = <0>;
+			fsl,brg-frequency = <0>;
 			interrupts = <0 2>;	// cpm error interrupt
 			interrupt-parent = <&Cpm_pic>;
 
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index a837742..ff70d62 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -84,16 +84,16 @@ u32 get_brgfreq(void)
 	if (brgfreq != -1)
 		return brgfreq;
 
-	node = of_find_node_by_type(NULL, "cpm");
+	node = of_find_compatible_node(NULL, NULL, "fsl,cpm");
 	if (node) {
 		unsigned int size;
-		const unsigned int *prop = of_get_property(node,
-					"brg-frequency", &size);
+		const unsigned int *prop =
+			of_get_property(node, "fsl,brg-frequency", &size);
 
-		if (prop)
+		if (prop && size == 4)
 			brgfreq = *prop;
 		of_node_put(node);
-	};
+	}
 
 	return brgfreq;
 }
-- 
1.5.0.3
