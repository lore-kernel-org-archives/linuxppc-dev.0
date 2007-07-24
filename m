Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 72258DDE11
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 02:24:11 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6OGO24D002569
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 09:24:06 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6OGO1O3002346
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 11:24:01 -0500 (CDT)
Subject: [PATCH] 86xx: Remove unnecessary loops_per_jiffy initialization code.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1185294241.9703.6.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 24 Jul 2007 11:24:01 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 5b01ec7..566c311 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -326,23 +326,13 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
 static void __init
 mpc86xx_hpcn_setup_arch(void)
 {
+#ifdef CONFIG_PCI
 	struct device_node *np;
+#endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc86xx_hpcn_setup_arch()", 0);
 
-	np = of_find_node_by_type(NULL, "cpu");
-	if (np != 0) {
-		const unsigned int *fp;
-
-		fp = of_get_property(np, "clock-frequency", NULL);
-		if (fp != 0)
-			loops_per_jiffy = *fp / HZ;
-		else
-			loops_per_jiffy = 50000000 / HZ;
-		of_node_put(np);
-	}
-
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		mpc86xx_add_bridge(np);
-- 
1.5.0.3
