Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 39E77DE02F
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2007 04:24:57 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6RIOrcd013323
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 11:24:53 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6RIOqf1017046
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 13:24:52 -0500 (CDT)
Subject: [PATCH 3/5] 52xx: Remove unnecessary loops_per_jiffy
	initialization code.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1185560692.8055.176.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 27 Jul 2007 13:24:52 -0500
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
 arch/powerpc/platforms/52xx/lite5200.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 5c46e89..84bd3da 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -109,22 +109,13 @@ static void lite5200_resume_finish(void __iomem *mbar)
 
 static void __init lite5200_setup_arch(void)
 {
+#ifdef CONFIG_PCI
 	struct device_node *np;
+#endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("lite5200_setup_arch()", 0);
 
-	np = of_find_node_by_type(NULL, "cpu");
-	if (np) {
-		const unsigned int *fp =
-			of_get_property(np, "clock-frequency", NULL);
-		if (fp != 0)
-			loops_per_jiffy = *fp / HZ;
-		else
-			loops_per_jiffy = 50000000 / HZ;
-		of_node_put(np);
-	}
-
 	/* CPU & Port mux setup */
 	mpc52xx_setup_cpu();	/* Generic */
 	lite5200_setup_cpu();	/* Platorm specific */
-- 
1.5.0.3
