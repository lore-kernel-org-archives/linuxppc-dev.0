Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 240A2DEE8D
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:45 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1ZfQg027624
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:41 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZedH001490
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:40 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1AxDl007926
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:10:59 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 80D61AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:39 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1ZdwO015383
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:39 -0500
Date: Tue, 17 Jul 2007 20:35:39 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 31/61] mpc8272ads: Check the board in the probe function.
Message-ID: <20070718013539.GC15238@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/boot/dts/mpc8272ads.dts     |    2 +-
 arch/powerpc/platforms/82xx/mpc8272ads.c |    7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 16a77f4..8c69cd0 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -11,7 +11,7 @@
 
 / {
 	model = "MPC8272ADS";
-	compatible = "MPC8260ADS";
+	compatible = "fsl,mpc8272ads";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
diff --git a/arch/powerpc/platforms/82xx/mpc8272ads.c b/arch/powerpc/platforms/82xx/mpc8272ads.c
index 29c2932..fbf9c67 100644
--- a/arch/powerpc/platforms/82xx/mpc8272ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272ads.c
@@ -599,11 +599,8 @@ static void __init mpc8272ads_setup_arch(void)
  */
 static int __init mpc8272ads_probe(void)
 {
-	/* We always match for now, eventually we should look at
-	 * the flat dev tree to ensure this is the board we are
-	 * supposed to run on
-	 */
-	return 1;
+	unsigned long root = of_get_flat_dt_root();
+	return of_flat_dt_is_compatible(root, "fsl,mpc8272ads");
 }
 
 #define RMR_CSRE 0x00000001
-- 
1.5.0.3
