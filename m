Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 9E533DDFFA
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 05:46:54 +1000 (EST)
Message-Id: <20070423193913.253050755@arndb.de>
References: <20070423193538.576702568@arndb.de>
Date: Mon, 23 Apr 2007 21:35:46 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 08/10] cell: add support for proper device-tree
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Krafft <krafft@de.ibm.com>

This patch adds support for a proper device-tree.
A porper device-tree on cell contains be nodes
for each CBE containg nodes for SPEs and all the
other special devices on it.
Ofcourse oldschool devicetree is still supported.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/cbe_regs.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_regs.c
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_regs.c
@@ -14,6 +14,8 @@
 #include <asm/pgtable.h>
 #include <asm/prom.h>
 #include <asm/ptrace.h>
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
 
 #include "cbe_regs.h"
 
@@ -27,6 +29,7 @@
 static struct cbe_regs_map
 {
 	struct device_node *cpu_node;
+	struct device_node *be_node;
 	struct cbe_pmd_regs __iomem *pmd_regs;
 	struct cbe_iic_regs __iomem *iic_regs;
 	struct cbe_mic_tm_regs __iomem *mic_tm_regs;
@@ -37,6 +40,7 @@ static int cbe_regs_map_count;
 static struct cbe_thread_map
 {
 	struct device_node *cpu_node;
+	struct device_node *be_node;
 	struct cbe_regs_map *regs;
 	unsigned int thread_id;
 	unsigned int cbe_id;
@@ -50,22 +54,29 @@ static struct cbe_regs_map *cbe_find_map
 	int i;
 	struct device_node *tmp_np;
 
-	if (strcasecmp(np->type, "spe") == 0) {
-		if (np->data == NULL) {
-			/* walk up path until cpu node was found */
-			tmp_np = np->parent;
-			while (tmp_np != NULL && strcasecmp(tmp_np->type, "cpu") != 0)
-				tmp_np = tmp_np->parent;
+	if (strcasecmp(np->type, "spe")) {
+		for (i = 0; i < cbe_regs_map_count; i++)
+			if (cbe_regs_maps[i].cpu_node == np ||
+			    cbe_regs_maps[i].be_node == np)
+				return &cbe_regs_maps[i];
+		return NULL;
+	}
 
-			np->data = cbe_find_map(tmp_np);
-		}
+	if (np->data)
 		return np->data;
-	}
 
-	for (i = 0; i < cbe_regs_map_count; i++)
-		if (cbe_regs_maps[i].cpu_node == np)
-			return &cbe_regs_maps[i];
-	return NULL;
+	/* walk up path until cpu or be node was found */
+	tmp_np = np;
+	do {
+		tmp_np = tmp_np->parent;
+		/* on a correct devicetree we wont get up to root */
+		BUG_ON(!tmp_np);
+	} while (strcasecmp(tmp_np->type, "cpu") &&
+		 strcasecmp(tmp_np->type, "be"));
+
+	np->data = cbe_find_map(tmp_np);
+
+	return np->data;
 }
 
 struct cbe_pmd_regs __iomem *cbe_get_pmd_regs(struct device_node *np)
@@ -153,6 +164,67 @@ u32 cbe_node_to_cpu(int node)
 }
 EXPORT_SYMBOL_GPL(cbe_node_to_cpu);
 
+static struct device_node *cbe_get_be_node(int cpu_id)
+{
+	struct device_node *np;
+
+	for_each_node_by_type (np, "be") {
+		int len,i;
+		const phandle *cpu_handle;
+
+		cpu_handle = of_get_property(np, "cpus", &len);
+
+		for (i=0; i<len; i++)
+			if (of_find_node_by_phandle(cpu_handle[i]) == of_get_cpu_node(cpu_id, NULL))
+				return np;
+	}
+
+	return NULL;
+}
+
+void __init cbe_fill_regs_map(struct cbe_regs_map *map)
+{
+	if(map->be_node) {
+		struct device_node *be, *np;
+
+		be = map->be_node;
+
+		for_each_node_by_type(np, "pervasive")
+			if (of_get_parent(np) == be)
+				map->pmd_regs = of_iomap(np, 0);
+
+		for_each_node_by_type(np, "CBEA-Internal-Interrupt-Controller")
+			if (of_get_parent(np) == be)
+				map->iic_regs = of_iomap(np, 2);
+
+		for_each_node_by_type(np, "mic-tm")
+			if (of_get_parent(np) == be)
+				map->mic_tm_regs = of_iomap(np, 0);
+	} else {
+		struct device_node *cpu;
+		/* That hack must die die die ! */
+		const struct address_prop {
+			unsigned long address;
+			unsigned int len;
+		} __attribute__((packed)) *prop;
+
+		cpu = map->cpu_node;
+
+		prop = of_get_property(cpu, "pervasive", NULL);
+		if (prop != NULL)
+			map->pmd_regs = ioremap(prop->address, prop->len);
+
+		prop = of_get_property(cpu, "iic", NULL);
+		if (prop != NULL)
+			map->iic_regs = ioremap(prop->address, prop->len);
+
+		prop = of_get_property(cpu, "mic-tm", NULL);
+		if (prop != NULL)
+			map->mic_tm_regs = ioremap(prop->address, prop->len);
+	}
+}
+
+
 void __init cbe_regs_init(void)
 {
 	int i;
@@ -162,6 +234,7 @@ void __init cbe_regs_init(void)
 	/* Build local fast map of CPUs */
 	for_each_possible_cpu(i) {
 		cbe_thread_map[i].cpu_node = of_get_cpu_node(i, &thread_id);
+		cbe_thread_map[i].be_node = cbe_get_be_node(i);
 		cbe_thread_map[i].thread_id = thread_id;
 	}
 
@@ -170,12 +243,6 @@ void __init cbe_regs_init(void)
 		struct cbe_regs_map *map;
 		unsigned int cbe_id;
 
-		/* That hack must die die die ! */
-		const struct address_prop {
-			unsigned long address;
-			unsigned int len;
-		} __attribute__((packed)) *prop;
-
 		cbe_id = cbe_regs_map_count++;
 		map = &cbe_regs_maps[cbe_id];
 
@@ -193,23 +260,14 @@ void __init cbe_regs_init(void)
 			if (thread->cpu_node == cpu) {
 				thread->regs = map;
 				thread->cbe_id = cbe_id;
+				map->be_node = thread->be_node;
 				cpu_set(i, cbe_local_mask[cbe_id]);
 				if(thread->thread_id == 0)
 					cpu_set(i, cbe_first_online_cpu);
 			}
 		}
 
-		prop = of_get_property(cpu, "pervasive", NULL);
-		if (prop != NULL)
-			map->pmd_regs = ioremap(prop->address, prop->len);
-
-		prop = of_get_property(cpu, "iic", NULL);
-		if (prop != NULL)
-			map->iic_regs = ioremap(prop->address, prop->len);
-
-		prop = of_get_property(cpu, "mic-tm", NULL);
-		if (prop != NULL)
-			map->mic_tm_regs = ioremap(prop->address, prop->len);
+		cbe_fill_regs_map(map);
 	}
 }
 

--
