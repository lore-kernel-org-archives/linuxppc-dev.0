Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 986A61A036E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 13:23:38 +1000 (AEST)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 1/3 v2] powerpc/powernv: Merge common platform device
 initialisation
Message-Id: <1432092213.629456.385035345144.1.gpush@pablo>
To: linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 20 May 2015 11:23:33 +0800
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

opal_ipmi_init and opal_flash_init are equivalent, except for the
compatbile string. Merge these two into a common opal_pdev_init
function.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/powernv/opal.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2241565..b03ac9e 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -693,21 +693,13 @@ static void __init opal_dump_region_init(void)
 			"rc = %d\n", rc);
 }
 
-static void opal_flash_init(struct device_node *opal_node)
+static void opal_pdev_init(struct device_node *opal_node,
+		const char *compatible)
 {
 	struct device_node *np;
 
 	for_each_child_of_node(opal_node, np)
-		if (of_device_is_compatible(np, "ibm,opal-flash"))
-			of_platform_device_create(np, NULL, NULL);
-}
-
-static void opal_ipmi_init(struct device_node *opal_node)
-{
-	struct device_node *np;
-
-	for_each_child_of_node(opal_node, np)
-		if (of_device_is_compatible(np, "ibm,opal-ipmi"))
+		if (of_device_is_compatible(np, compatible))
 			of_platform_device_create(np, NULL, NULL);
 }
 
@@ -835,10 +827,9 @@ static int __init opal_init(void)
 		opal_msglog_init();
 	}
 
-	/* Initialize OPAL IPMI backend */
-	opal_ipmi_init(opal_node);
-
-	opal_flash_init(opal_node);
+	/* Initialize platform devices: IPMI backend & flash interface */
+	opal_pdev_init(opal_node, "ibm,opal-ipmi");
+	opal_pdev_init(opal_node, "ibm,opal-flash");
 
 	return 0;
 }
