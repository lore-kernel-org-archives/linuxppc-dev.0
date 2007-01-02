Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id 16AC1DDE20
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 22:30:31 +1100 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: paulus@samba.org
Subject: [PATCH] ppc: prom of_node_(get|put) cleanup
Date: Tue, 2 Jan 2007 12:31:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200701021231.48419.m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

	This patch removes redundant argument checks for of_node_get() and of_node_put().

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/powerpc/kernel/prom.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/kernel/prom.c linux-2.6.20-rc2-mm1-b/arch/powerpc/kernel/prom.c
--- linux-2.6.20-rc2-mm1-a/arch/powerpc/kernel/prom.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/arch/powerpc/kernel/prom.c	2007-01-02 02:05:47.000000000 +0100
@@ -1221,8 +1221,7 @@ struct device_node *of_find_node_by_name
 		if (np->name != NULL && strcasecmp(np->name, name) == 0
 		    && of_node_get(np))
 			break;
-	if (from)
-		of_node_put(from);
+	of_node_put(from);
 	read_unlock(&devtree_lock);
 	return np;
 }
@@ -1250,8 +1249,7 @@ struct device_node *of_find_node_by_type
 		if (np->type != 0 && strcasecmp(np->type, type) == 0
 		    && of_node_get(np))
 			break;
-	if (from)
-		of_node_put(from);
+	of_node_put(from);
 	read_unlock(&devtree_lock);
 	return np;
 }
@@ -1285,8 +1283,7 @@ struct device_node *of_find_compatible_n
 		if (device_is_compatible(np, compatible) && of_node_get(np))
 			break;
 	}
-	if (from)
-		of_node_put(from);
+	of_node_put(from);
 	read_unlock(&devtree_lock);
 	return np;
 }
@@ -1329,8 +1326,7 @@ struct device_node *of_find_node_by_phan
 	for (np = allnodes; np != 0; np = np->allnext)
 		if (np->linux_phandle == handle)
 			break;
-	if (np)
-		of_node_get(np);
+	of_node_get(np);
 	read_unlock(&devtree_lock);
 	return np;
 }
@@ -1353,8 +1349,7 @@ struct device_node *of_find_all_nodes(st
 	for (; np != 0; np = np->allnext)
 		if (of_node_get(np))
 			break;
-	if (prev)
-		of_node_put(prev);
+	of_node_put(prev);
 	read_unlock(&devtree_lock);
 	return np;
 }
@@ -1399,8 +1394,7 @@ struct device_node *of_get_next_child(co
 	for (; next != 0; next = next->sibling)
 		if (of_node_get(next))
 			break;
-	if (prev)
-		of_node_put(prev);
+	of_node_put(prev);
 	read_unlock(&devtree_lock);
 	return next;
 }


-- 
Regards,

	Mariusz Kozlowski
