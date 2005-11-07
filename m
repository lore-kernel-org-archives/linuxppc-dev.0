Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8912686F8
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Nov 2005 16:58:16 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 16:57:33 +1100
Message-Id: <1131343053.4652.1.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc: Fix PowerBook HD led on ARCH=powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PowerBook HD led code uses obsoletes device-tree accessors which do
not work anymore for getting the root of the tree.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/ide/ppc/pmac.c
===================================================================
--- linux-work.orig/drivers/ide/ppc/pmac.c	2005-11-03 09:40:54.000000000 +1100
+++ linux-work/drivers/ide/ppc/pmac.c	2005-11-07 15:44:05.000000000 +1100
@@ -497,16 +497,19 @@
 	if (pmu_get_model() != PMU_KEYLARGO_BASED)
 		return 0;
 	
-	dt = find_devices("device-tree");
+	dt = of_find_node_by_path("/");
 	if (dt == NULL)
 		return 0;
 	model = (const char *)get_property(dt, "model", NULL);
 	if (model == NULL)
 		return 0;
 	if (strncmp(model, "PowerBook", strlen("PowerBook")) != 0 &&
-	    strncmp(model, "iBook", strlen("iBook")) != 0)
+	    strncmp(model, "iBook", strlen("iBook")) != 0) {
+		of_node_put(dt);
 	    	return 0;
-	
+	}
+	of_node_put(dt);
+
 	pmu_blink_on.complete = 1;
 	pmu_blink_off.complete = 1;
 	spin_lock_init(&pmu_blink_lock);
