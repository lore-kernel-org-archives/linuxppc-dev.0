Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F0773B6EEA
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id o6N0fxBn028345
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6N0fx2j1130724
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6N0fx2U023709
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] powerpc: Fix erroneous lmb->memblock conversions
Date: Fri, 23 Jul 2010 10:41:44 +1000
Message-Id: <1279845704-14848-5-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1279845704-14848-4-git-send-email-benh@kernel.crashing.org>
References: <1279845704-14848-1-git-send-email-benh@kernel.crashing.org>
	<1279845704-14848-2-git-send-email-benh@kernel.crashing.org>
	<1279845704-14848-3-git-send-email-benh@kernel.crashing.org>
	<1279845704-14848-4-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oooops... we missed these. We incorrectly converted strings
used when parsing the device-tree on pseries, thus breaking
access to drconf memory and hotplug memory.

While at it, also revert some variable names that represent
something the FW calls "lmb" and thus don't need to be converted
to "memblock".

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
---
 arch/powerpc/kernel/prom.c                      |    2 +-
 arch/powerpc/mm/numa.c                          |   24 +++++++++++-----------
 arch/powerpc/platforms/pseries/hotplug-memory.c |   22 ++++++++++----------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9d39539..fed9bf6 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -414,7 +414,7 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 	u64 base, size, memblock_size;
 	unsigned int is_kexec_kdump = 0, rngs;
 
-	ls = of_get_flat_dt_prop(node, "ibm,memblock-size", &l);
+	ls = of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
 	if (ls == NULL || l < dt_root_size_cells * sizeof(__be32))
 		return 0;
 	memblock_size = dt_mem_next_cell(dt_root_size_cells, &ls);
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index f473645..aa731af 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -398,15 +398,15 @@ static int of_get_drconf_memory(struct device_node *memory, const u32 **dm)
 }
 
 /*
- * Retreive and validate the ibm,memblock-size property for drconf memory
+ * Retreive and validate the ibm,lmb-size property for drconf memory
  * from the device tree.
  */
-static u64 of_get_memblock_size(struct device_node *memory)
+static u64 of_get_lmb_size(struct device_node *memory)
 {
 	const u32 *prop;
 	u32 len;
 
-	prop = of_get_property(memory, "ibm,memblock-size", &len);
+	prop = of_get_property(memory, "ibm,lmb-size", &len);
 	if (!prop || len < sizeof(unsigned int))
 		return 0;
 
@@ -562,7 +562,7 @@ static unsigned long __init numa_enforce_memory_limit(unsigned long start,
 static inline int __init read_usm_ranges(const u32 **usm)
 {
 	/*
-	 * For each memblock in ibm,dynamic-memory a corresponding
+	 * For each lmb in ibm,dynamic-memory a corresponding
 	 * entry in linux,drconf-usable-memory property contains
 	 * a counter followed by that many (base, size) duple.
 	 * read the counter from linux,drconf-usable-memory
@@ -578,7 +578,7 @@ static void __init parse_drconf_memory(struct device_node *memory)
 {
 	const u32 *dm, *usm;
 	unsigned int n, rc, ranges, is_kexec_kdump = 0;
-	unsigned long memblock_size, base, size, sz;
+	unsigned long lmb_size, base, size, sz;
 	int nid;
 	struct assoc_arrays aa;
 
@@ -586,8 +586,8 @@ static void __init parse_drconf_memory(struct device_node *memory)
 	if (!n)
 		return;
 
-	memblock_size = of_get_memblock_size(memory);
-	if (!memblock_size)
+	lmb_size = of_get_lmb_size(memory);
+	if (!lmb_size)
 		return;
 
 	rc = of_get_assoc_arrays(memory, &aa);
@@ -611,7 +611,7 @@ static void __init parse_drconf_memory(struct device_node *memory)
 			continue;
 
 		base = drmem.base_addr;
-		size = memblock_size;
+		size = lmb_size;
 		ranges = 1;
 
 		if (is_kexec_kdump) {
@@ -1072,7 +1072,7 @@ static int hot_add_drconf_scn_to_nid(struct device_node *memory,
 {
 	const u32 *dm;
 	unsigned int drconf_cell_cnt, rc;
-	unsigned long memblock_size;
+	unsigned long lmb_size;
 	struct assoc_arrays aa;
 	int nid = -1;
 
@@ -1080,8 +1080,8 @@ static int hot_add_drconf_scn_to_nid(struct device_node *memory,
 	if (!drconf_cell_cnt)
 		return -1;
 
-	memblock_size = of_get_memblock_size(memory);
-	if (!memblock_size)
+	lmb_size = of_get_lmb_size(memory);
+	if (!lmb_size)
 		return -1;
 
 	rc = of_get_assoc_arrays(memory, &aa);
@@ -1100,7 +1100,7 @@ static int hot_add_drconf_scn_to_nid(struct device_node *memory,
 			continue;
 
 		if ((scn_addr < drmem.base_addr)
-		    || (scn_addr >= (drmem.base_addr + memblock_size)))
+		    || (scn_addr >= (drmem.base_addr + lmb_size)))
 			continue;
 
 		nid = of_drconf_to_nid_single(&drmem, &aa);
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index deab5f9..bc88036 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -69,7 +69,7 @@ static int pseries_remove_memory(struct device_node *np)
 	const char *type;
 	const unsigned int *regs;
 	unsigned long base;
-	unsigned int memblock_size;
+	unsigned int lmb_size;
 	int ret = -EINVAL;
 
 	/*
@@ -87,9 +87,9 @@ static int pseries_remove_memory(struct device_node *np)
 		return ret;
 
 	base = *(unsigned long *)regs;
-	memblock_size = regs[3];
+	lmb_size = regs[3];
 
-	ret = pseries_remove_memblock(base, memblock_size);
+	ret = pseries_remove_memblock(base, lmb_size);
 	return ret;
 }
 
@@ -98,7 +98,7 @@ static int pseries_add_memory(struct device_node *np)
 	const char *type;
 	const unsigned int *regs;
 	unsigned long base;
-	unsigned int memblock_size;
+	unsigned int lmb_size;
 	int ret = -EINVAL;
 
 	/*
@@ -116,36 +116,36 @@ static int pseries_add_memory(struct device_node *np)
 		return ret;
 
 	base = *(unsigned long *)regs;
-	memblock_size = regs[3];
+	lmb_size = regs[3];
 
 	/*
 	 * Update memory region to represent the memory add
 	 */
-	ret = memblock_add(base, memblock_size);
+	ret = memblock_add(base, lmb_size);
 	return (ret < 0) ? -EINVAL : 0;
 }
 
 static int pseries_drconf_memory(unsigned long *base, unsigned int action)
 {
 	struct device_node *np;
-	const unsigned long *memblock_size;
+	const unsigned long *lmb_size;
 	int rc;
 
 	np = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
 	if (!np)
 		return -EINVAL;
 
-	memblock_size = of_get_property(np, "ibm,memblock-size", NULL);
-	if (!memblock_size) {
+	lmb_size = of_get_property(np, "ibm,lmb-size", NULL);
+	if (!lmb_size) {
 		of_node_put(np);
 		return -EINVAL;
 	}
 
 	if (action == PSERIES_DRCONF_MEM_ADD) {
-		rc = memblock_add(*base, *memblock_size);
+		rc = memblock_add(*base, *lmb_size);
 		rc = (rc < 0) ? -EINVAL : 0;
 	} else if (action == PSERIES_DRCONF_MEM_REMOVE) {
-		rc = pseries_remove_memblock(*base, *memblock_size);
+		rc = pseries_remove_memblock(*base, *lmb_size);
 	} else {
 		rc = -EINVAL;
 	}
-- 
1.6.3.3
