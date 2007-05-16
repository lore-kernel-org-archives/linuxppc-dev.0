Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 16 May 2007 16:57:24 +1000
Subject: [PATCH] powerpc: Make sure device node type/name is not NULL
Message-Id: <20070516065755.5FE9EDDF97@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Our device-tree unflattening code makes sure the name and type
fields of a device-node are not NULL. However, the code for dynamically
adding devices nodes which is used for pSeries hotplug for example didn't
do it, potentially causing crashes in some code that assume it can
always do things like strcmp on those.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---

 arch/powerpc/kernel/prom.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-cell/arch/powerpc/kernel/prom.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/prom.c	2007-05-14 16:32:34.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/prom.c	2007-05-16 16:52:08.000000000 +1000
@@ -1472,6 +1472,11 @@ static int of_finish_dynamic_node(struct
 	node->name = of_get_property(node, "name", NULL);
 	node->type = of_get_property(node, "device_type", NULL);
 
+	if (!node->name)
+		node->name = "<NULL>";
+	if (!node->type)
+		node->type = "<NULL>";
+
 	if (!parent) {
 		err = -ENODEV;
 		goto out;
