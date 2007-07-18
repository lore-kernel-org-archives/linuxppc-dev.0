Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CC28EDE4CF
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:36:09 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1a4j8027727
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:36:04 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1a3n7001575
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:03 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BM0s007978
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:23 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id E004DAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:02 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1a20I015454
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:36:02 -0500
Date: Tue, 17 Jul 2007 20:36:02 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 48/61] 8xx: Use better OF names for PIC.
Message-ID: <20070718013602.GT15238@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/sysdev/mpc8xx_pic.c    |    5 ++---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
index 1807086..9b5bf77 100644
--- a/arch/powerpc/boot/dts/mpc866ads.dts
+++ b/arch/powerpc/boot/dts/mpc866ads.dts
@@ -79,8 +79,7 @@
 			#interrupt-cells = <2>;
 			reg = <0 24>;
 			built-in;
-			device_type = "mpc8xx-pic";
-			compatible = "CPM";
+			compatible = "fsl,mpc866-pic", "fsl,pq1-pic";
 		};
 
 		cpm@ff000000 {
diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index 48717ed..de81407 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -99,8 +99,7 @@
 			#interrupt-cells = <2>;
 			reg = <0 24>;
 			built-in;
-			device_type = "mpc8xx-pic";
-			compatible = "CPM";
+			compatible = "fsl,mpc885-pic", "fsl,pq1-pic";
 		};
 
 		pcmcia@0080 {
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
index 2fc2bcd..1a9c1b3 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -169,10 +169,9 @@ int mpc8xx_pic_init(void)
 	struct device_node *np = NULL;
 	int ret;
 
-	np = of_find_node_by_type(np, "mpc8xx-pic");
-
+	np = of_find_compatible_node(np, NULL, "fsl,pq1-pic");
 	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
+		printk(KERN_ERR "Could not find fsl,pq1-pic node\n");
 		return -ENOMEM;
 	}
 
-- 
1.5.0.3
