Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sLYcK3pS7zDrfZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Aug 2016 07:10:57 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7QL3pWt137783
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:10:54 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25238g2xua-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:10:54 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 26 Aug 2016 17:10:53 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 575AA6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:10:29 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7QLAniK8585634
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 21:10:50 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 710DFAC03C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:10:50 -0400 (EDT)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP id 43289AC057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:10:50 -0400 (EDT)
Subject: [PATCH 1/3] powerpc/pseries: maintain single copy of ibm,
 dynamic-memory property
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Fri, 26 Aug 2016 17:03:56 -0400
In-Reply-To: <20160826210312.44862.37838.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <20160826210312.44862.37838.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20160826210356.44862.7162.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory property
of the device-tree can be fairly big on systems with a large amount
of memory. A system with 1 TB of memory (256 MB LMBs) the property
size is 94k, this equates to roughly a 30MB property size for a 32 TB
system. This file size is not neccessarily huge, but the need to update
this property every time we DLPAR add or remove an LMB could be
problematic.

Every time the property is updated a new copy of the property is made
with the previous copy being added to the old_properties list. Due to
the lack of reference counting on properties old versions of a property
are never free'ed. One a large 32TB system we could easilty do
several thousands of memory add/remove operations and thus create
several thousand of copies of this property. This seems a bit wasteful
with respect to system resources.

This patch changes the pseries hotplug memory code to maintain a static
reference to this property instead of creating a new copy for every LMB
that we add or remove. In doing this we have to ensure that the property
remains in BE format so a set of accessor methods are provided to
get/set values from the property in the proper cpu format.

This should provide an improvement in kernel resources as
we will no longer have un-referenced copies of this property.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |  520 ++++++++++-------------
 1 file changed, 225 insertions(+), 295 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index b708c5c..5173e49 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -26,6 +26,83 @@
 
 static bool rtas_hp_event;
 
+static struct drconf_mem {
+	u32 num_lmbs;
+	struct of_drconf_cell *lmbs;
+} drmem;
+
+#define for_each_lmb_range(lmb, start, end)			\
+	for ((lmb) = (start); (lmb) < (end); (lmb)++)
+#define for_each_lmb(lmb)	for_each_lmb_range((lmb), 0, drmem.num_lmbs)
+
+static u64 lmb_base_address(u32 lmb) {
+	return be64_to_cpu(drmem.lmbs[lmb].base_addr);
+}
+
+static u32 lmb_drc_index(u32 lmb) {
+	return be32_to_cpu(drmem.lmbs[lmb].drc_index);
+}
+
+static void lmb_set_aa_index(u32 lmb, u32 aa_index) {
+	drmem.lmbs[lmb].aa_index = cpu_to_be32(aa_index);
+}
+
+static bool lmb_updated(u32 lmb) {
+	return drmem.lmbs[lmb].reserved;
+}
+
+static void mark_lmb_updated(u32 lmb) {
+	drmem.lmbs[lmb].reserved = 1;
+}
+
+static void rm_lmb_update(u32 lmb) {
+	drmem.lmbs[lmb].reserved = 0;
+}
+
+static bool lmb_reserved(u32 lmb) {
+	return be32_to_cpu(drmem.lmbs[lmb].flags) & DRCONF_MEM_RESERVED;
+}
+
+static bool lmb_assigned(u32 lmb) {
+	return be32_to_cpu(drmem.lmbs[lmb].flags) & DRCONF_MEM_ASSIGNED;
+}
+
+static void mark_lmb_assigned(u32 lmb) {
+	drmem.lmbs[lmb].flags |= cpu_to_be32(DRCONF_MEM_ASSIGNED);
+}
+
+static void mark_lmb_unassigned(u32 lmb) {
+	drmem.lmbs[lmb].flags &= cpu_to_be32(~DRCONF_MEM_ASSIGNED);
+}
+
+static int dlpar_acquire_lmb(u32 lmb) {
+	return dlpar_acquire_drc(be32_to_cpu(drmem.lmbs[lmb].drc_index));
+}
+
+static int dlpar_release_lmb(u32 lmb) {
+	return dlpar_release_drc(be32_to_cpu(drmem.lmbs[lmb].drc_index));
+}
+
+static void __init update_drconf_memory(void)
+{
+	struct device_node *dn;
+	struct property *prop;
+	__be32 *p;
+
+	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!dn)
+		return;
+
+	prop = of_find_property(dn, "ibm,dynamic-memory", NULL);
+	of_node_put(dn);
+	if (!prop)
+		return;
+
+	p = prop->value;
+	drmem.num_lmbs = be32_to_cpu(*p++);
+	drmem.lmbs = (struct of_drconf_cell *)p;
+}
+
 unsigned long pseries_memory_block_size(void)
 {
 	struct device_node *np;
@@ -99,98 +176,6 @@ static struct property *dlpar_clone_property(struct property *prop,
 	return new_prop;
 }
 
-static struct property *dlpar_clone_drconf_property(struct device_node *dn)
-{
-	struct property *prop, *new_prop;
-	struct of_drconf_cell *lmbs;
-	u32 num_lmbs, *p;
-	int i;
-
-	prop = of_find_property(dn, "ibm,dynamic-memory", NULL);
-	if (!prop)
-		return NULL;
-
-	new_prop = dlpar_clone_property(prop, prop->length);
-	if (!new_prop)
-		return NULL;
-
-	/* Convert the property to cpu endian-ness */
-	p = new_prop->value;
-	*p = be32_to_cpu(*p);
-
-	num_lmbs = *p++;
-	lmbs = (struct of_drconf_cell *)p;
-
-	for (i = 0; i < num_lmbs; i++) {
-		lmbs[i].base_addr = be64_to_cpu(lmbs[i].base_addr);
-		lmbs[i].drc_index = be32_to_cpu(lmbs[i].drc_index);
-		lmbs[i].flags = be32_to_cpu(lmbs[i].flags);
-	}
-
-	return new_prop;
-}
-
-static void dlpar_update_drconf_property(struct device_node *dn,
-					 struct property *prop)
-{
-	struct of_drconf_cell *lmbs;
-	u32 num_lmbs, *p;
-	int i;
-
-	/* Convert the property back to BE */
-	p = prop->value;
-	num_lmbs = *p;
-	*p = cpu_to_be32(*p);
-	p++;
-
-	lmbs = (struct of_drconf_cell *)p;
-	for (i = 0; i < num_lmbs; i++) {
-		lmbs[i].base_addr = cpu_to_be64(lmbs[i].base_addr);
-		lmbs[i].drc_index = cpu_to_be32(lmbs[i].drc_index);
-		lmbs[i].flags = cpu_to_be32(lmbs[i].flags);
-	}
-
-	rtas_hp_event = true;
-	of_update_property(dn, prop);
-	rtas_hp_event = false;
-}
-
-static int dlpar_update_device_tree_lmb(struct of_drconf_cell *lmb)
-{
-	struct device_node *dn;
-	struct property *prop;
-	struct of_drconf_cell *lmbs;
-	u32 *p, num_lmbs;
-	int i;
-
-	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (!dn)
-		return -ENODEV;
-
-	prop = dlpar_clone_drconf_property(dn);
-	if (!prop) {
-		of_node_put(dn);
-		return -ENODEV;
-	}
-
-	p = prop->value;
-	num_lmbs = *p++;
-	lmbs = (struct of_drconf_cell *)p;
-
-	for (i = 0; i < num_lmbs; i++) {
-		if (lmbs[i].drc_index == lmb->drc_index) {
-			lmbs[i].flags = lmb->flags;
-			lmbs[i].aa_index = lmb->aa_index;
-
-			dlpar_update_drconf_property(dn, prop);
-			break;
-		}
-	}
-
-	of_node_put(dn);
-	return 0;
-}
-
 static u32 find_aa_index(struct device_node *dr_node,
 			 struct property *ala_prop, const u32 *lmb_assoc)
 {
@@ -253,18 +238,20 @@ static u32 find_aa_index(struct device_node *dr_node,
 	return aa_index;
 }
 
-static u32 lookup_lmb_associativity_index(struct of_drconf_cell *lmb)
+static u32 lookup_lmb_associativity_index(u32 lmb)
 {
 	struct device_node *parent, *lmb_node, *dr_node;
 	struct property *ala_prop;
 	const u32 *lmb_assoc;
+	u32 my_drc_index;
 	u32 aa_index;
 
 	parent = of_find_node_by_path("/");
 	if (!parent)
 		return -ENODEV;
 
-	lmb_node = dlpar_configure_connector(cpu_to_be32(lmb->drc_index),
+	my_drc_index = lmb_drc_index(lmb);
+	lmb_node = dlpar_configure_connector(cpu_to_be32(my_drc_index),
 					     parent);
 	of_node_put(parent);
 	if (!lmb_node)
@@ -296,37 +283,35 @@ static u32 lookup_lmb_associativity_index(struct of_drconf_cell *lmb)
 	return aa_index;
 }
 
-static int dlpar_add_device_tree_lmb(struct of_drconf_cell *lmb)
+static int dlpar_add_device_tree_lmb(u32 lmb)
 {
 	int aa_index;
 
-	lmb->flags |= DRCONF_MEM_ASSIGNED;
-
 	aa_index = lookup_lmb_associativity_index(lmb);
 	if (aa_index < 0) {
 		pr_err("Couldn't find associativity index for drc index %x\n",
-		       lmb->drc_index);
+		       lmb_drc_index(lmb));
 		return aa_index;
 	}
 
-	lmb->aa_index = aa_index;
-	return dlpar_update_device_tree_lmb(lmb);
+	mark_lmb_assigned(lmb);
+	lmb_set_aa_index(lmb, aa_index);
+	return 0;
 }
 
-static int dlpar_remove_device_tree_lmb(struct of_drconf_cell *lmb)
+static void dlpar_remove_device_tree_lmb(u32 lmb)
 {
-	lmb->flags &= ~DRCONF_MEM_ASSIGNED;
-	lmb->aa_index = 0xffffffff;
-	return dlpar_update_device_tree_lmb(lmb);
+	mark_lmb_unassigned(lmb);
+	lmb_set_aa_index(lmb, 0xffffffff);
 }
 
-static struct memory_block *lmb_to_memblock(struct of_drconf_cell *lmb)
+static struct memory_block *lmb_to_memblock(u32 lmb)
 {
 	unsigned long section_nr;
 	struct mem_section *mem_sect;
 	struct memory_block *mem_block;
 
-	section_nr = pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
+	section_nr = pfn_to_section_nr(PFN_DOWN(lmb_base_address(lmb)));
 	mem_sect = __nr_to_section(section_nr);
 
 	mem_block = find_memory_block(mem_sect);
@@ -392,19 +377,19 @@ static int pseries_remove_mem_node(struct device_node *np)
 	return 0;
 }
 
-static bool lmb_is_removable(struct of_drconf_cell *lmb)
+static bool lmb_is_removable(u32 lmb)
 {
 	int i, scns_per_block;
 	int rc = 1;
 	unsigned long pfn, block_sz;
 	u64 phys_addr;
 
-	if (!(lmb->flags & DRCONF_MEM_ASSIGNED))
+	if (!lmb_assigned(lmb))
 		return false;
 
 	block_sz = memory_block_size_bytes();
 	scns_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
-	phys_addr = lmb->base_addr;
+	phys_addr = lmb_base_address(lmb);
 
 	for (i = 0; i < scns_per_block; i++) {
 		pfn = PFN_DOWN(phys_addr);
@@ -418,12 +403,13 @@ static bool lmb_is_removable(struct of_drconf_cell *lmb)
 	return rc ? true : false;
 }
 
-static int dlpar_add_lmb(struct of_drconf_cell *);
+static int dlpar_add_lmb(u32 lmb);
 
-static int dlpar_remove_lmb(struct of_drconf_cell *lmb)
+static int dlpar_remove_lmb(u32 lmb)
 {
 	struct memory_block *mem_block;
 	unsigned long block_sz;
+	u64 base_addr;
 	int nid, rc;
 
 	if (!lmb_is_removable(lmb))
@@ -439,84 +425,81 @@ static int dlpar_remove_lmb(struct of_drconf_cell *lmb)
 		return rc;
 
 	block_sz = pseries_memory_block_size();
-	nid = memory_add_physaddr_to_nid(lmb->base_addr);
+	base_addr = lmb_base_address(lmb);
+	nid = memory_add_physaddr_to_nid(base_addr);
 
-	remove_memory(nid, lmb->base_addr, block_sz);
+	remove_memory(nid, base_addr, block_sz);
 
 	/* Update memory regions for memory remove */
-	memblock_remove(lmb->base_addr, block_sz);
+	memblock_remove(base_addr, block_sz);
 
-	dlpar_release_drc(lmb->drc_index);
+	dlpar_release_lmb(lmb);
 	dlpar_remove_device_tree_lmb(lmb);
 
 	return 0;
 }
 
-static int dlpar_memory_remove_by_count(u32 lmbs_to_remove,
-					struct property *prop)
+static int dlpar_memory_remove_by_count(u32 lmbs_to_remove)
 {
-	struct of_drconf_cell *lmbs;
+	u32 lmb;
 	int lmbs_removed = 0;
 	int lmbs_available = 0;
-	u32 num_lmbs, *p;
-	int i, rc;
+	int rc;
 
 	pr_info("Attempting to hot-remove %d LMB(s)\n", lmbs_to_remove);
 
 	if (lmbs_to_remove == 0)
 		return -EINVAL;
 
-	p = prop->value;
-	num_lmbs = *p++;
-	lmbs = (struct of_drconf_cell *)p;
-
 	/* Validate that there are enough LMBs to satisfy the request */
-	for (i = 0; i < num_lmbs; i++) {
-		if (lmbs[i].flags & DRCONF_MEM_ASSIGNED)
+	for_each_lmb(lmb) {
+		if (lmb_assigned(lmb))
 			lmbs_available++;
 	}
 
 	if (lmbs_available < lmbs_to_remove)
 		return -EINVAL;
 
-	for (i = 0; i < num_lmbs && lmbs_removed < lmbs_to_remove; i++) {
-		rc = dlpar_remove_lmb(&lmbs[i]);
+	for_each_lmb(lmb) {
+		rc = dlpar_remove_lmb(lmb);
 		if (rc)
 			continue;
 
-		lmbs_removed++;
-
 		/* Mark this lmb so we can add it later if all of the
 		 * requested LMBs cannot be removed.
 		 */
-		lmbs[i].reserved = 1;
+		mark_lmb_updated(lmb);
+		
+		lmbs_removed++;
+		if (lmbs_removed == lmbs_to_remove)
+			break;
 	}
 
 	if (lmbs_removed != lmbs_to_remove) {
 		pr_err("Memory hot-remove failed, adding LMB's back\n");
 
-		for (i = 0; i < num_lmbs; i++) {
-			if (!lmbs[i].reserved)
+		for_each_lmb(lmb) {
+			if (!lmb_updated(lmb))
 				continue;
 
-			rc = dlpar_add_lmb(&lmbs[i]);
+			rc = dlpar_add_lmb(lmb);
 			if (rc)
 				pr_err("Failed to add LMB back, drc index %x\n",
-				       lmbs[i].drc_index);
+				       lmb_drc_index(lmb));
 
-			lmbs[i].reserved = 0;
+			rm_lmb_update(lmb);
 		}
 
 		rc = -EINVAL;
 	} else {
-		for (i = 0; i < num_lmbs; i++) {
-			if (!lmbs[i].reserved)
+		for_each_lmb(lmb) {
+			if (!lmb_updated(lmb))
 				continue;
 
 			pr_info("Memory at %llx was hot-removed\n",
-				lmbs[i].base_addr);
+				lmb_base_address(lmb));
 
-			lmbs[i].reserved = 0;
+			rm_lmb_update(lmb);
 		}
 		rc = 0;
 	}
@@ -524,24 +507,19 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove,
 	return rc;
 }
 
-static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
+static int dlpar_memory_remove_by_index(u32 drc_index)
 {
-	struct of_drconf_cell *lmbs;
-	u32 num_lmbs, *p;
+	u32 lmb;
 	int lmb_found;
-	int i, rc;
+	int rc;
 
 	pr_info("Attempting to hot-remove LMB, drc index %x\n", drc_index);
 
-	p = prop->value;
-	num_lmbs = *p++;
-	lmbs = (struct of_drconf_cell *)p;
-
 	lmb_found = 0;
-	for (i = 0; i < num_lmbs; i++) {
-		if (lmbs[i].drc_index == drc_index) {
+	for_each_lmb(lmb) {
+		if (lmb_drc_index(lmb) == drc_index) {
 			lmb_found = 1;
-			rc = dlpar_remove_lmb(&lmbs[i]);
+			rc = dlpar_remove_lmb(lmb);
 			break;
 		}
 	}
@@ -551,20 +529,19 @@ static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
 
 	if (rc)
 		pr_info("Failed to hot-remove memory at %llx\n",
-			lmbs[i].base_addr);
+			lmb_base_address(lmb));
 	else
-		pr_info("Memory at %llx was hot-removed\n", lmbs[i].base_addr);
+		pr_info("Memory at %llx was hot-removed\n",
+			lmb_base_address(lmb));
 
 	return rc;
 }
 
-static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index,
-				     struct property *prop)
+static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 {
-	struct of_drconf_cell *lmbs;
-	u32 num_lmbs, *p;
-	int i, rc, start_lmb_found;
-	int lmbs_available = 0, start_index = 0, end_index;
+	u32 lmb, start_lmb, end_lmb;
+	int lmbs_available = 0;
+	int rc;
 
 	pr_info("Attempting to hot-remove %u LMB(s) at %x\n",
 		lmbs_to_remove, drc_index);
@@ -572,29 +549,17 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index,
 	if (lmbs_to_remove == 0)
 		return -EINVAL;
 
-	p = prop->value;
-	num_lmbs = *p++;
-	lmbs = (struct of_drconf_cell *)p;
-	start_lmb_found = 0;
-
 	/* Navigate to drc_index */
-	while (start_index < num_lmbs) {
-		if (lmbs[start_index].drc_index == drc_index) {
-			start_lmb_found = 1;
+	for_each_lmb(start_lmb) {
+		if (lmb_drc_index(start_lmb) == drc_index)
 			break;
-		}
-
-		start_index++;
 	}
 
-	if (!start_lmb_found)
-		return -EINVAL;
-
-	end_index = start_index + lmbs_to_remove;
+	end_lmb = start_lmb + lmbs_to_remove;
 
 	/* Validate that there are enough LMBs to satisfy the request */
-	for (i = start_index; i < end_index; i++) {
-		if (lmbs[i].flags & DRCONF_MEM_RESERVED)
+	for_each_lmb_range(lmb, start_lmb, end_lmb) {
+		if (lmb_reserved(lmb))
 			break;
 
 		lmbs_available++;
@@ -603,41 +568,41 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index,
 	if (lmbs_available < lmbs_to_remove)
 		return -EINVAL;
 
-	for (i = 0; i < end_index; i++) {
-		if (!(lmbs[i].flags & DRCONF_MEM_ASSIGNED))
+	for_each_lmb_range(lmb, start_lmb, end_lmb) {
+		if (!lmb_assigned(lmb))
 			continue;
 
-		rc = dlpar_remove_lmb(&lmbs[i]);
+		rc = dlpar_remove_lmb(lmb);
 		if (rc)
 			break;
 
-		lmbs[i].reserved = 1;
+		mark_lmb_updated(lmb);
 	}
 
 	if (rc) {
 		pr_err("Memory indexed-count-remove failed, adding any removed LMBs\n");
 
-		for (i = start_index; i < end_index; i++) {
-			if (!lmbs[i].reserved)
+		for_each_lmb_range(lmb, start_lmb, end_lmb) {
+			if (!lmb_updated(lmb))
 				continue;
 
-			rc = dlpar_add_lmb(&lmbs[i]);
+			rc = dlpar_add_lmb(lmb);
 			if (rc)
 				pr_err("Failed to add LMB, drc index %x\n",
-				       be32_to_cpu(lmbs[i].drc_index));
+				       lmb_drc_index(lmb));
 
-			lmbs[i].reserved = 0;
+			rm_lmb_update(lmb);
 		}
 		rc = -EINVAL;
 	} else {
-		for (i = start_index; i < end_index; i++) {
-			if (!lmbs[i].reserved)
+		for_each_lmb_range(lmb, start_lmb, end_lmb) {
+			if (!lmb_updated(lmb))
 				continue;
 
 			pr_info("Memory at %llx (drc index %x) was hot-removed\n",
-				lmbs[i].base_addr, lmbs[i].drc_index);
+				lmb_base_address(lmb), lmb_drc_index(lmb));
 
-			lmbs[i].reserved = 0;
+			rm_lmb_update(lmb);
 		}
 	}
 
@@ -658,143 +623,137 @@ static inline int dlpar_memory_remove(struct pseries_hp_errorlog *hp_elog)
 {
 	return -EOPNOTSUPP;
 }
-static int dlpar_remove_lmb(struct of_drconf_cell *lmb)
+static int dlpar_remove_lmb(u32 lmb)
 {
 	return -EOPNOTSUPP;
 }
-static int dlpar_memory_remove_by_count(u32 lmbs_to_remove,
-					struct property *prop)
+static int dlpar_memory_remove_by_count(u32 lmbs_to_remove)
 {
 	return -EOPNOTSUPP;
 }
-static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
+static int dlpar_memory_remove_by_index(u32 drc_index)
 {
 	return -EOPNOTSUPP;
 }
 
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-static int dlpar_add_lmb(struct of_drconf_cell *lmb)
+static int dlpar_add_lmb(u32 lmb)
 {
 	unsigned long block_sz;
+	u64 base_addr;
 	int nid, rc;
 
-	if (lmb->flags & DRCONF_MEM_ASSIGNED)
+	if (lmb_assigned(lmb))
 		return -EINVAL;
 
-	rc = dlpar_acquire_drc(lmb->drc_index);
+	rc = dlpar_acquire_lmb(lmb);
 	if (rc)
 		return rc;
 
 	rc = dlpar_add_device_tree_lmb(lmb);
 	if (rc) {
 		pr_err("Couldn't update device tree for drc index %x\n",
-		       lmb->drc_index);
-		dlpar_release_drc(lmb->drc_index);
+		       lmb_drc_index(lmb));
+		dlpar_release_lmb(lmb);
 		return rc;
 	}
 
 	block_sz = memory_block_size_bytes();
+	base_addr = lmb_base_address(lmb);
 
 	/* Find the node id for this address */
-	nid = memory_add_physaddr_to_nid(lmb->base_addr);
+	nid = memory_add_physaddr_to_nid(base_addr);
 
 	/* Add the memory */
-	rc = add_memory(nid, lmb->base_addr, block_sz);
+	rc = add_memory(nid, base_addr, block_sz);
 	if (rc) {
 		dlpar_remove_device_tree_lmb(lmb);
-		dlpar_release_drc(lmb->drc_index);
+		dlpar_release_lmb(lmb);
 	} else {
-		lmb->flags |= DRCONF_MEM_ASSIGNED;
+		mark_lmb_assigned(lmb);
 	}
 
 	return rc;
 }
 
-static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property *prop)
+static int dlpar_memory_add_by_count(u32 lmbs_to_add)
 {
-	struct of_drconf_cell *lmbs;
-	u32 num_lmbs, *p;
 	int lmbs_available = 0;
 	int lmbs_added = 0;
-	int i, rc;
+	u32 lmb;
+	int rc;
 
 	pr_info("Attempting to hot-add %d LMB(s)\n", lmbs_to_add);
 
 	if (lmbs_to_add == 0)
 		return -EINVAL;
 
-	p = prop->value;
-	num_lmbs = *p++;
-	lmbs = (struct of_drconf_cell *)p;
-
 	/* Validate that there are enough LMBs to satisfy the request */
-	for (i = 0; i < num_lmbs; i++) {
-		if (!(lmbs[i].flags & DRCONF_MEM_ASSIGNED))
+	for_each_lmb(lmb) {
+		if (!lmb_assigned(lmb))
 			lmbs_available++;
 	}
 
 	if (lmbs_available < lmbs_to_add)
 		return -EINVAL;
 
-	for (i = 0; i < num_lmbs && lmbs_to_add != lmbs_added; i++) {
-		rc = dlpar_add_lmb(&lmbs[i]);
+	for_each_lmb(lmb) {
+		rc = dlpar_add_lmb(lmb);
 		if (rc)
 			continue;
 
-		lmbs_added++;
 
 		/* Mark this lmb so we can remove it later if all of the
 		 * requested LMBs cannot be added.
 		 */
-		lmbs[i].reserved = 1;
+		mark_lmb_updated(lmb);
+
+		lmbs_added++;
+		if (lmbs_added == lmbs_to_add)
+			break;
 	}
 
 	if (lmbs_added != lmbs_to_add) {
 		pr_err("Memory hot-add failed, removing any added LMBs\n");
 
-		for (i = 0; i < num_lmbs; i++) {
-			if (!lmbs[i].reserved)
+		for_each_lmb(lmb) {
+			if (!lmb_updated(lmb))
 				continue;
 
-			rc = dlpar_remove_lmb(&lmbs[i]);
+			rc = dlpar_remove_lmb(lmb);
 			if (rc)
 				pr_err("Failed to remove LMB, drc index %x\n",
-				       be32_to_cpu(lmbs[i].drc_index));
+				       lmb_drc_index(lmb));
 		}
 		rc = -EINVAL;
 	} else {
-		for (i = 0; i < num_lmbs; i++) {
-			if (!lmbs[i].reserved)
+		for_each_lmb(lmb) {
+			if (!lmb_updated(lmb))
 				continue;
 
 			pr_info("Memory at %llx (drc index %x) was hot-added\n",
-				lmbs[i].base_addr, lmbs[i].drc_index);
-			lmbs[i].reserved = 0;
+				lmb_base_address(lmb), lmb_drc_index(lmb));
+			rm_lmb_update(lmb);
 		}
 	}
 
 	return rc;
 }
 
-static int dlpar_memory_add_by_index(u32 drc_index, struct property *prop)
+static int dlpar_memory_add_by_index(u32 drc_index)
 {
-	struct of_drconf_cell *lmbs;
-	u32 num_lmbs, *p;
-	int i, lmb_found;
+	u32 lmb;
+	int lmb_found;
 	int rc;
 
 	pr_info("Attempting to hot-add LMB, drc index %x\n", drc_index);
 
-	p = prop->value;
-	num_lmbs = *p++;
-	lmbs = (struct of_drconf_cell *)p;
-
 	lmb_found = 0;
-	for (i = 0; i < num_lmbs; i++) {
-		if (lmbs[i].drc_index == drc_index) {
+	for_each_lmb(lmb) {
+		if (lmb_drc_index(lmb) == drc_index) {
 			lmb_found = 1;
-			rc = dlpar_add_lmb(&lmbs[i]);
+			rc = dlpar_add_lmb(lmb);
 			break;
 		}
 	}
@@ -806,18 +765,16 @@ static int dlpar_memory_add_by_index(u32 drc_index, struct property *prop)
 		pr_info("Failed to hot-add memory, drc index %x\n", drc_index);
 	else
 		pr_info("Memory at %llx (drc index %x) was hot-added\n",
-			lmbs[i].base_addr, drc_index);
+			lmb_base_address(lmb), drc_index);
 
 	return rc;
 }
 
-static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index,
-				  struct property *prop)
+static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index)
 {
-	struct of_drconf_cell *lmbs;
-	u32 num_lmbs, *p;
-	int i, rc, start_lmb_found;
-	int lmbs_available = 0, start_index = 0, end_index;
+	u32 lmb, start_lmb, end_lmb;
+	int lmbs_available = 0;
+	int rc;
 
 	pr_info("Attempting to hot-add %u LMB(s) at index %x\n",
 		lmbs_to_add, drc_index);
@@ -825,29 +782,17 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index,
 	if (lmbs_to_add == 0)
 		return -EINVAL;
 
-	p = prop->value;
-	num_lmbs = *p++;
-	lmbs = (struct of_drconf_cell *)p;
-	start_lmb_found = 0;
-
 	/* Navigate to drc_index */
-	while (start_index < num_lmbs) {
-		if (lmbs[start_index].drc_index == drc_index) {
-			start_lmb_found = 1;
+	for_each_lmb(start_lmb) {
+		if (lmb_drc_index(start_lmb) == drc_index)
 			break;
-		}
-
-		start_index++;
 	}
 
-	if (!start_lmb_found)
-		return -EINVAL;
-
-	end_index = start_index + lmbs_to_add;
+	end_lmb = start_lmb + lmbs_to_add;
 
 	/* Validate that there are enough LMBs to satisfy the request */
-	for (i = start_index; i < end_index; i++) {
-		if (lmbs[i].flags & DRCONF_MEM_RESERVED)
+	for_each_lmb_range(lmb, start_lmb, end_lmb) {
+		if (lmb_reserved(lmb))
 			break;
 
 		lmbs_available++;
@@ -856,38 +801,38 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index,
 	if (lmbs_available < lmbs_to_add)
 		return -EINVAL;
 
-	for (i = start_index; i < end_index; i++) {
-		if (lmbs[i].flags & DRCONF_MEM_ASSIGNED)
+	for_each_lmb_range(lmb, start_lmb, end_lmb) {
+		if (lmb_assigned(lmb))
 			continue;
 
-		rc = dlpar_add_lmb(&lmbs[i]);
+		rc = dlpar_add_lmb(lmb);
 		if (rc)
 			break;
 
-		lmbs[i].reserved = 1;
+		mark_lmb_updated(lmb);
 	}
 
 	if (rc) {
 		pr_err("Memory indexed-count-add failed, removing any added LMBs\n");
 
-		for (i = start_index; i < end_index; i++) {
-			if (!lmbs[i].reserved)
+		for_each_lmb_range(lmb, start_lmb, end_lmb) {
+			if (!lmb_updated(lmb))
 				continue;
 
-			rc = dlpar_remove_lmb(&lmbs[i]);
+			rc = dlpar_remove_lmb(lmb);
 			if (rc)
 				pr_err("Failed to remove LMB, drc index %x\n",
-				       be32_to_cpu(lmbs[i].drc_index));
+				       lmb_drc_index(lmb));
 		}
 		rc = -EINVAL;
 	} else {
-		for (i = start_index; i < end_index; i++) {
-			if (!lmbs[i].reserved)
+		for_each_lmb_range(lmb, start_lmb, end_lmb) {
+			if (!lmb_updated(lmb))
 				continue;
 
 			pr_info("Memory at %llx (drc index %x) was hot-added\n",
-				lmbs[i].base_addr, lmbs[i].drc_index);
-			lmbs[i].reserved = 0;
+				lmb_base_address(lmb), lmb_drc_index(lmb));
+			rm_lmb_update(lmb);
 		}
 	}
 
@@ -896,37 +841,23 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index,
 
 int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 {
-	struct device_node *dn;
-	struct property *prop;
 	u32 count, drc_index;
 	int rc;
 
 	lock_device_hotplug();
 
-	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (!dn) {
-		rc = -EINVAL;
-		goto dlpar_memory_out;
-	}
-
-	prop = dlpar_clone_drconf_property(dn);
-	if (!prop) {
-		rc = -EINVAL;
-		goto dlpar_memory_out;
-	}
-
 	switch (hp_elog->action) {
 	case PSERIES_HP_ELOG_ACTION_ADD:
 		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT) {
 			count = hp_elog->_drc_u.drc_count;
-			rc = dlpar_memory_add_by_count(count, prop);
+			rc = dlpar_memory_add_by_count(count);
 		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX) {
 			drc_index = hp_elog->_drc_u.drc_index;
-			rc = dlpar_memory_add_by_index(drc_index, prop);
+			rc = dlpar_memory_add_by_index(drc_index);
 		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_IC) {
 			count = hp_elog->_drc_u.indexed_count[0];
 			drc_index = hp_elog->_drc_u.indexed_count[1];
-			rc = dlpar_memory_add_by_ic(count, drc_index, prop);
+			rc = dlpar_memory_add_by_ic(count, drc_index);
 		} else {
 			rc = -EINVAL;
 		}
@@ -935,14 +866,14 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 	case PSERIES_HP_ELOG_ACTION_REMOVE:
 		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT) {
 			count = hp_elog->_drc_u.drc_count;
-			rc = dlpar_memory_remove_by_count(count, prop);
+			rc = dlpar_memory_remove_by_count(count);
 		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX) {
 			drc_index = hp_elog->_drc_u.drc_index;
-			rc = dlpar_memory_remove_by_index(drc_index, prop);
+			rc = dlpar_memory_remove_by_index(drc_index);
 		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_IC) {
 			count = hp_elog->_drc_u.indexed_count[0];
 			drc_index = hp_elog->_drc_u.indexed_count[1];
-			rc = dlpar_memory_remove_by_ic(count, drc_index, prop);
+			rc = dlpar_memory_remove_by_ic(count, drc_index);
 		} else {
 			rc = -EINVAL;
 		}
@@ -954,10 +885,6 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		break;
 	}
 
-	dlpar_free_property(prop);
-
-dlpar_memory_out:
-	of_node_put(dn);
 	unlock_device_hotplug();
 	return rc;
 }
@@ -1005,6 +932,8 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
 	if (rtas_hp_event)
 		return 0;
 
+	update_drconf_memory();
+
 	memblock_size = pseries_memory_block_size();
 	if (!memblock_size)
 		return -EINVAL;
@@ -1075,6 +1004,7 @@ static int __init pseries_memory_hotplug_init(void)
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		of_reconfig_notifier_register(&pseries_mem_nb);
 
+	update_drconf_memory();
 	return 0;
 }
 machine_device_initcall(pseries, pseries_memory_hotplug_init);
