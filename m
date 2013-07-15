Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D0EB92C0199
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 13:03:38 +1000 (EST)
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r6F33KdM013377
 for <linuxppc-dev@ozlabs.org>; Sun, 14 Jul 2013 22:03:35 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/8] powerpc/powernv: Don't crash if there are no OPAL consoles
Date: Mon, 15 Jul 2013 13:03:14 +1000
Message-Id: <1373857395-2084-7-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1373857395-2084-1-git-send-email-benh@kernel.crashing.org>
References: <1373857395-2084-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some machines might provide the console via a different mechanism
such as direct access to a UART from Linux, in which case OPAL
might not expose any console. In that case, the code would cause
a NULL dereference.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/opal.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 106301f..91cf97d 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -380,18 +380,20 @@ static int __init opal_init(void)
 		pr_warn("opal: Node not found\n");
 		return -ENODEV;
 	}
+
+	/* Register OPAL consoles if any ports */
 	if (firmware_has_feature(FW_FEATURE_OPALv2))
 		consoles = of_find_node_by_path("/ibm,opal/consoles");
 	else
 		consoles = of_node_get(opal_node);
-
-	/* Register serial ports */
-	for_each_child_of_node(consoles, np) {
-		if (strcmp(np->name, "serial"))
-			continue;
-		of_platform_device_create(np, NULL, NULL);
+	if (consoles) {
+		for_each_child_of_node(consoles, np) {
+			if (strcmp(np->name, "serial"))
+				continue;
+			of_platform_device_create(np, NULL, NULL);
+		}
+		of_node_put(consoles);
 	}
-	of_node_put(consoles);
 
 	/* Find all OPAL interrupts and request them */
 	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
-- 
1.8.1.2
