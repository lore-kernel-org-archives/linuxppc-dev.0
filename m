Return-Path: <millerjo@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4Jng3PsjzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 02:44:39 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u73GYBr2037139
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 12:44:37 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkag3863-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 12:44:37 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <millerjo@us.ibm.com>;
 Wed, 3 Aug 2016 10:44:36 -0600
From: Jack Miller <jack@codezen.org>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: jk@ozlabs.org, stewart@linux.vnet.ibm.com, benh@kernel.crashing.org
Subject: [PATCH] powernv: Simplify searching for compatible device nodes
Date: Wed,  3 Aug 2016 11:44:12 -0500
In-Reply-To: <20160803164412.7039-1-jack@codezen.org>
References: <147020859492.19099.3536038186529840354@concordia>
 <20160803164412.7039-1-jack@codezen.org>
Message-Id: <20160803164412.7039-2-jack@codezen.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This condenses the opal node searching into a single function that finds
all compatible nodes, instead of just searching the ibm,opal children,
for ipmi, flash, and prd similar to how opal-i2c nodes are found.

Signed-off-by: Jack Miller <jack@codezen.org>
---
 arch/powerpc/platforms/powernv/opal.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index ae29eaf..86b7352 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -640,21 +640,11 @@ static void __init opal_dump_region_init(void)
 			"rc = %d\n", rc);
 }
 
-static void opal_pdev_init(struct device_node *opal_node,
-		const char *compatible)
+static void opal_pdev_init(const char *compatible)
 {
 	struct device_node *np;
 
-	for_each_child_of_node(opal_node, np)
-		if (of_device_is_compatible(np, compatible))
-			of_platform_device_create(np, NULL, NULL);
-}
-
-static void opal_i2c_create_devs(void)
-{
-	struct device_node *np;
-
-	for_each_compatible_node(np, NULL, "ibm,opal-i2c")
+	for_each_compatible_node(np, NULL, compatible)
 		of_platform_device_create(np, NULL, NULL);
 }
 
@@ -722,7 +712,7 @@ static int __init opal_init(void)
 	opal_hmi_handler_init();
 
 	/* Create i2c platform devices */
-	opal_i2c_create_devs();
+	opal_pdev_init("ibm,opal-i2c");
 
 	/* Setup a heatbeat thread if requested by OPAL */
 	opal_init_heartbeat();
@@ -754,9 +744,9 @@ static int __init opal_init(void)
 	}
 
 	/* Initialize platform devices: IPMI backend, PRD & flash interface */
-	opal_pdev_init(opal_node, "ibm,opal-ipmi");
-	opal_pdev_init(opal_node, "ibm,opal-flash");
-	opal_pdev_init(opal_node, "ibm,opal-prd");
+	opal_pdev_init("ibm,opal-ipmi");
+	opal_pdev_init("ibm,opal-flash");
+	opal_pdev_init("ibm,opal-prd");
 
 	/* Initialise OPAL kmsg dumper for flushing console on panic */
 	opal_kmsg_init();
-- 
2.9.2
