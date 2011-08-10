Return-Path: <anton@samba.org>
Message-Id: <20110810064937.495727480@samba.org>
Date: Wed, 10 Aug 2011 16:49:35 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/3] powerpc: Use for_each_node_by_type instead of open coding
	it
References: <20110810064937.424887717@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use for_each_node_by_type instead of open coding it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/kernel/machine_kexec_64.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/kernel/machine_kexec_64.c	2011-08-10 16:17:52.508167607 +1000
+++ linux-powerpc/arch/powerpc/kernel/machine_kexec_64.c	2011-08-10 16:18:03.000000000 +1000
@@ -74,8 +74,7 @@ int default_machine_kexec_prepare(struct
 	}
 
 	/* We also should not overwrite the tce tables */
-	for (node = of_find_node_by_type(NULL, "pci"); node != NULL;
-			node = of_find_node_by_type(node, "pci")) {
+	for_each_node_by_type(node, "pci") {
 		basep = of_get_property(node, "linux,tce-base", NULL);
 		sizep = of_get_property(node, "linux,tce-size", NULL);
 		if (basep == NULL || sizep == NULL)
Index: linux-powerpc/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/kernel/setup_64.c	2011-08-10 16:17:52.518167781 +1000
+++ linux-powerpc/arch/powerpc/kernel/setup_64.c	2011-08-10 16:19:00.629356097 +1000
@@ -278,7 +278,7 @@ static void __init initialize_cache_info
 
 	DBG(" -> initialize_cache_info()\n");
 
-	for (np = NULL; (np = of_find_node_by_type(np, "cpu"));) {
+	for_each_node_by_type(np, "cpu") {
 		num_cpus += 1;
 
 		/* We're assuming *all* of the CPUs have the same
Index: linux-powerpc/arch/powerpc/mm/numa.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/mm/numa.c	2011-08-10 16:17:52.508167607 +1000
+++ linux-powerpc/arch/powerpc/mm/numa.c	2011-08-10 16:19:57.080356036 +1000
@@ -710,7 +710,7 @@ static void __init parse_drconf_memory(s
 static int __init parse_numa_properties(void)
 {
 	struct device_node *cpu = NULL;
-	struct device_node *memory = NULL;
+	struct device_node *memory;
 	int default_nid = 0;
 	unsigned long i;
 
@@ -750,8 +750,8 @@ static int __init parse_numa_properties(
 	}
 
 	get_n_mem_cells(&n_mem_addr_cells, &n_mem_size_cells);
-	memory = NULL;
-	while ((memory = of_find_node_by_type(memory, "memory")) != NULL) {
+
+	for_each_node_by_type(memory, "memory") {
 		unsigned long start;
 		unsigned long size;
 		int nid;
@@ -1187,10 +1187,10 @@ static int hot_add_drconf_scn_to_nid(str
  */
 int hot_add_node_scn_to_nid(unsigned long scn_addr)
 {
-	struct device_node *memory = NULL;
+	struct device_node *memory;
 	int nid = -1;
 
-	while ((memory = of_find_node_by_type(memory, "memory")) != NULL) {
+	for_each_node_by_type(memory, "memory") {
 		unsigned long start, size;
 		int ranges;
 		const unsigned int *memcell_buf;
