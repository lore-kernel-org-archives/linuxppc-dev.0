Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5E432DDE20
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 11:30:04 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m691TwmU022376
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 18:29:58 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m691Tt6f028671
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 20:29:56 -0500 (CDT)
From: Jason Jin <Jason.jin@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] Minor fixes for 85xxds and 8536ds board.
Date: Wed,  9 Jul 2008 09:27:35 +0800
Message-Id: <1215566855-6198-1-git-send-email-Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jason Jin <Jason.jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove the "uninitialized use" compile warning and
avoid potential runtime issue.

Signed-off-by: Jason Jin <Jason.jin@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc8536_ds.c |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 9943816..69e2129 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -40,7 +40,7 @@ void __init mpc8536_ds_pic_init(void)
 	struct resource r;
 	struct device_node *np;
 
-	np = of_find_node_by_type(np, "open-pic");
+	np = of_find_node_by_type(NULL, "open-pic");
 	if (np == NULL) {
 		printk(KERN_ERR "Could not find open-pic node\n");
 		return;
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 8b2d63d..25f41cd 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -64,7 +64,7 @@ void __init mpc85xx_ds_pic_init(void)
 	int cascade_irq;
 #endif
 
-	np = of_find_node_by_type(np, "open-pic");
+	np = of_find_node_by_type(NULL, "open-pic");
 	if (np == NULL) {
 		printk(KERN_ERR "Could not find open-pic node\n");
 		return;
-- 
1.5.4
