Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 0FF05B710C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 28 Aug 2010 07:49:48 +1000 (EST)
Received: from mail164-tx2 (localhost.localdomain [127.0.0.1])	by
	mail164-tx2-R.bigfish.com (Postfix) with ESMTP id 2ED12D08232	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 27 Aug 2010 21:49:36 +0000 (UTC)
Received: from TX2EHSMHS047.bigfish.com (unknown [10.9.14.250])	by
	mail164-tx2.bigfish.com (Postfix) with ESMTP id 0408F120804F	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 27 Aug 2010 21:49:35 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7RLnNEw003152	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Aug 2010 14:49:34 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/fsl_soc: Search all global-utilities nodes for rstccr
Date: Fri, 27 Aug 2010 16:55:47 -0500
Message-ID: <1282946147-28164-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The first global-utilities node might not contain the rstcr
property, so we should search all the nodes

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index b91f7ac..e2c8e47 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -378,17 +378,19 @@ static __be32 __iomem *rstcr;
 static int __init setup_rstcr(void)
 {
 	struct device_node *np;
-	np = of_find_node_by_name(NULL, "global-utilities");
-	if ((np && of_get_property(np, "fsl,has-rstcr", NULL))) {
-		rstcr = of_iomap(np, 0) + 0xb0;
-		if (!rstcr)
-			printk (KERN_EMERG "Error: reset control register "
-					"not mapped!\n");
-	} else if (ppc_md.restart == fsl_rstcr_restart)
+
+	for_each_node_by_name(np, "global-utilities") {
+		if ((of_get_property(np, "fsl,has-rstcr", NULL))) {
+			rstcr = of_iomap(np, 0) + 0xb0;
+			if (!rstcr)
+				printk (KERN_EMERG "Error: reset control "
+						"register not mapped!\n");
+		}
+	}
+
+	if (!rstcr && ppc_md.restart == fsl_rstcr_restart)
 		printk(KERN_ERR "No RSTCR register, warm reboot won't work\n");
 
-	if (np)
-		of_node_put(np);
 	return 0;
 }
 
-- 
1.6.6.1
