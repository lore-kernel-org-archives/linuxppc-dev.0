Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F11B5DF05B
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:36:01 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1ZuRo027686
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:57 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1Zuw8001553
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:56 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BFSX007959
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:15 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 374EEAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:55 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1ZtFO015429
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:55 -0500
Date: Tue, 17 Jul 2007 20:35:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 42/61] 8xx: commproc.c: Use better OF names.
Message-ID: <20070718013555.GN15238@ld0162-tx32.am.freescale.net>
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

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/mpc866ads.dts |    3 +--
 arch/powerpc/boot/dts/mpc885ads.dts |    3 +--
 arch/powerpc/sysdev/commproc.c      |    6 +++---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
index b3dbfe8..1807086 100644
--- a/arch/powerpc/boot/dts/mpc866ads.dts
+++ b/arch/powerpc/boot/dts/mpc866ads.dts
@@ -103,8 +103,7 @@
 				interrupt-parent = <&Mpc8xx_pic>;
 				reg = <930 20>;
 				built-in;
-				device_type = "cpm-pic";
-				compatible = "CPM";
+				compatible = "fsl,mpc866-cpm-pic", "fsl,cpm1-pic";
 			};
 
 			smc@a80 {
diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index 8372469..48717ed 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -134,8 +134,7 @@
 				interrupt-parent = <&Mpc8xx_pic>;
 				reg = <930 20>;
 				built-in;
-				device_type = "cpm-pic";
-				compatible = "CPM";
+				compatible = "fsl,mpc885-cpm-pic", "fsl,cpm1-pic";
 			};
 
 			smc@a80 {
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index f73e96d..b0a58fd 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -141,9 +141,9 @@ unsigned int cpm_pic_init(void)
 
 	pr_debug("cpm_pic_init\n");
 
-	np = of_find_compatible_node(NULL, "cpm-pic", "CPM");
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm1-pic");
 	if (np == NULL) {
-		printk(KERN_ERR "CPM PIC init: can not find cpm-pic node\n");
+		printk(KERN_ERR "CPM PIC init: can not find fsl,cpm1-pic node\n");
 		return sirq;
 	}
 	ret = of_address_to_resource(np, 0, &res);
@@ -177,7 +177,7 @@ unsigned int cpm_pic_init(void)
 	of_node_put(np);
 
 	/* Install our own error handler. */
-	np = of_find_node_by_type(NULL, "cpm");
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm1");
 	if (np == NULL) {
 		printk(KERN_ERR "CPM PIC init: can not find cpm node\n");
 		goto end;
-- 
1.5.0.3
