Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 95B05DDED8
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 04:19:37 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n3MIJWk8025595
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 13:19:33 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl: use of_iomap() for rstcr mapping
Date: Wed, 22 Apr 2009 13:19:32 -0500
Message-Id: <1240424372-11461-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The rstcr register mapping code was written sometime ago before
of_iomap() existed.  We can use it and clean up the code a bit
and get rid of one user of get_immrbase() in the process.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_soc.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index afe8dbc..bd1b74d 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -425,16 +425,10 @@ static int __init setup_rstcr(void)
 	struct device_node *np;
 	np = of_find_node_by_name(NULL, "global-utilities");
 	if ((np && of_get_property(np, "fsl,has-rstcr", NULL))) {
-		const u32 *prop = of_get_property(np, "reg", NULL);
-		if (prop) {
-			/* map reset control register
-			 * 0xE00B0 is offset of reset control register
-			 */
-			rstcr = ioremap(get_immrbase() + *prop + 0xB0, 0xff);
-			if (!rstcr)
-				printk (KERN_EMERG "Error: reset control "
-						"register not mapped!\n");
-		}
+		rstcr = of_iomap(np, 0) + 0xb0;
+		if (!rstcr)
+			printk (KERN_EMERG "Error: reset control register "
+					"not mapped!\n");
 	} else
 		printk (KERN_INFO "rstcr compatible register does not exist!\n");
 	if (np)
-- 
1.6.0.6
