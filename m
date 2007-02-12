Return-Path: <tnt@246tNt.com>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1867DDECF
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 09:14:23 +1100 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1CMEERX013420
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 23:14:15 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 05/10] powerpc: Fix unbalanced of_node_{get,
	put} in efika-setup.c
Date: Mon, 12 Feb 2007 23:13:23 +0100
Message-Id: <11713184141191-git-send-email-tnt@246tNt.com>
In-Reply-To: <11713184132161-git-send-email-tnt@246tNt.com>
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
	<11713184101239-git-send-email-tnt@246tNt.com>
	<11713184112187-git-send-email-tnt@246tNt.com>
	<11713184132161-git-send-email-tnt@246tNt.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/52xx/efika-setup.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/efika-setup.c b/arch/powerpc/platforms/52xx/efika-setup.c
index d61ce84..b6945cb 100644
--- a/arch/powerpc/platforms/52xx/efika-setup.c
+++ b/arch/powerpc/platforms/52xx/efika-setup.c
@@ -42,14 +42,13 @@ static void efika_show_cpuinfo(struct se
 	const char *codegenvendor = NULL;
 
 	root = of_find_node_by_path("/");
-	if (root) {
-		revision = get_property(root, "revision", NULL);
-		codegendescription =
-		    get_property(root, "CODEGEN,description", NULL);
-		codegenvendor = get_property(root, "CODEGEN,vendor", NULL);
+	if (!root)
+		return;
 
-		of_node_put(root);
-	}
+	revision = get_property(root, "revision", NULL);
+	codegendescription =
+		    get_property(root, "CODEGEN,description", NULL);
+	codegenvendor = get_property(root, "CODEGEN,vendor", NULL);
 
 	if (codegendescription)
 		seq_printf(m, "machine\t\t: %s\n", codegendescription);
-- 
1.4.2
