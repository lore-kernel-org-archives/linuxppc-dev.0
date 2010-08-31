Return-Path: <msm@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141]) by ozlabs.org (Postfix) with ESMTP id 0B0CFB7116
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 08:38:16 +1000 (EST)
Received: from mail69-db3 (localhost.localdomain [127.0.0.1])	by
	mail69-db3-R.bigfish.com (Postfix) with ESMTP id 9805714980F4	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2010 22:38:08 +0000 (UTC)
Received: from DB3EHSMHS006.bigfish.com (unknown [10.3.81.249])	by
	mail69-db3.bigfish.com (Postfix) with ESMTP id 09A4FD8004F	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2010 22:38:07 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7VMbr6m001345	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 Aug 2010 15:38:04 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/fsl_soc: Search all global-utilities nodes for
	rstccr
Date: Tue, 31 Aug 2010 17:44:51 -0500
Message-ID: <1283294691-18765-1-git-send-email-msm@freescale.com>
In-Reply-To: <AANLkTikdm6f6dRDoOXuBx0-viwNqHuez4P+xTum+M+9O@mail.gmail.com>
References: <AANLkTikdm6f6dRDoOXuBx0-viwNqHuez4P+xTum+M+9O@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>, kumar.gala@freescale.com,
	timur@freescale.com
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
-Changed KERN_EMERG to KERN_ERR
-Break if we do not find rstcr mapped
-Restore of_put_node that was dropped

 arch/powerpc/sysdev/fsl_soc.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index b91f7ac..6c67d9e 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -378,17 +378,23 @@ static __be32 __iomem *rstcr;
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
+				printk (KERN_ERR "Error: reset control "
+						"register not mapped!\n");
+			break;
+		}
+	}
+
+	if (!rstcr && ppc_md.restart == fsl_rstcr_restart)
 		printk(KERN_ERR "No RSTCR register, warm reboot won't work\n");
 
 	if (np)
 		of_node_put(np);
+
 	return 0;
 }
 
-- 
1.6.6.1
