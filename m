Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97CD71A048B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 06:48:32 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 10 Feb 2015 12:48:30 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 3BE166E803F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 14:40:19 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1AJmR9Q27590904
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 19:48:27 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1AJmREP003744
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 14:48:27 -0500
Received: from [9.41.149.215] (dhcp-9-41-149-215.austin.ibm.com [9.41.149.215])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t1AJmQ1w003654
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 14:48:26 -0500
Message-ID: <54DA6089.3030003@linux.vnet.ibm.com>
Date: Tue, 10 Feb 2015 13:48:25 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 4/5] pseries: Implement memory hotplug add in the kernel
References: <54DA5EC1.2060403@linux.vnet.ibm.com>
In-Reply-To: <54DA5EC1.2060403@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the ability to do memory hotplug add in the kernel.

Currently the operation to hotplug add memory is handled by the drmgr
command which performs the operation by performing some work in user-space
and making requests to the kernel to handle other pieces. By moving all
of the work to the kernel we can do the add faster, and provide a common
code path to do memory hotplug for both the PowerVM and PowerKVM environments.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
Changes from previous version:
- converted uint32_t to u32
- removed un-needed phys_addr/page_block checking
- Updated the messaging to properly report the success/failure of memory adds
 
 arch/powerpc/platforms/pseries/hotplug-memory.c |  266 +++++++++++++++++++++++
 1 file changed, 265 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 211d0bf..f5eec0f 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -16,6 +16,7 @@
 #include <linux/memblock.h>
 #include <linux/memory.h>
 #include <linux/memory_hotplug.h>
+#include <linux/slab.h>
 
 #include <asm/firmware.h>
 #include <asm/machdep.h>
@@ -23,6 +24,8 @@
 #include <asm/sparsemem.h>
 #include "pseries.h"
 
+static bool rtas_hp_event;
+
 unsigned long pseries_memory_block_size(void)
 {
 	struct device_node *np;
@@ -66,6 +69,67 @@ unsigned long pseries_memory_block_size(void)
 	return memblock_size;
 }
 
+static void dlpar_free_drconf_property(struct property *prop)
+{
+	kfree(prop->name);
+	kfree(prop->value);
+	kfree(prop);
+}
+
+static struct property *dlpar_clone_drconf_property(struct device_node *dn)
+{
+	struct property *prop, *new_prop;
+	struct of_drconf_cell *lmbs;
+	u32 num_lmbs, *p;
+	int i;
+
+	prop = of_find_property(dn, "ibm,dynamic-memory", NULL);
+	if (!prop)
+		return NULL;
+
+	new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
+	if (!new_prop)
+		return NULL;
+
+	new_prop->name = kstrdup(prop->name, GFP_KERNEL);
+	new_prop->value = kmalloc(prop->length, GFP_KERNEL);
+	if (!new_prop->name || !new_prop->value) {
+		dlpar_free_drconf_property(new_prop);
+		return NULL;
+	}
+
+	memcpy(new_prop->value, prop->value, prop->length);
+	new_prop->length = prop->length;
+
+	/* Convert the property to cpu endian-ness */
+	p = new_prop->value;
+	*p = be32_to_cpu(*p);
+
+	num_lmbs = *p++;
+	lmbs = (struct of_drconf_cell *)p;
+
+	for (i = 0; i < num_lmbs; i++) {
+		lmbs[i].base_addr = be64_to_cpu(lmbs[i].base_addr);
+		lmbs[i].drc_index = be32_to_cpu(lmbs[i].drc_index);
+		lmbs[i].flags = be32_to_cpu(lmbs[i].flags);
+	}
+
+	return new_prop;
+}
+
+static struct memory_block *lmb_to_memblock(struct of_drconf_cell *lmb)
+{
+	unsigned long section_nr;
+	struct mem_section *mem_sect;
+	struct memory_block *mem_block;
+
+	section_nr = pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
+	mem_sect = __nr_to_section(section_nr);
+
+	mem_block = find_memory_block(mem_sect);
+	return mem_block;
+}
+
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static int pseries_remove_memblock(unsigned long base, unsigned int memblock_size)
 {
@@ -136,19 +200,216 @@ static inline int pseries_remove_mem_node(struct device_node *np)
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+static int dlpar_add_lmb(struct of_drconf_cell *lmb)
+{
+	struct memory_block *mem_block;
+	unsigned long block_sz;
+	int nid, rc;
+
+	if (lmb->flags & DRCONF_MEM_ASSIGNED)
+		return -EINVAL;
+
+	block_sz = memory_block_size_bytes();
+
+	rc = dlpar_acquire_drc(lmb->drc_index);
+	if (rc)
+		return rc;
+
+	/* Find the node id for this address */
+	nid = memory_add_physaddr_to_nid(lmb->base_addr);
+
+	/* Add the memory */
+	rc = add_memory(nid, lmb->base_addr, block_sz);
+	if (rc) {
+		dlpar_release_drc(lmb->drc_index);
+		return rc;
+	}
+
+	/* Register this block of memory */
+	rc = memblock_add(lmb->base_addr, block_sz);
+	if (rc) {
+		remove_memory(nid, lmb->base_addr, block_sz);
+		dlpar_release_drc(lmb->drc_index);
+		return rc;
+	}
+
+	mem_block = lmb_to_memblock(lmb);
+	if (!mem_block) {
+		remove_memory(nid, lmb->base_addr, block_sz);
+		dlpar_release_drc(lmb->drc_index);
+		return -EINVAL;
+	}
+
+	rc = device_online(&mem_block->dev);
+	put_device(&mem_block->dev);
+	if (rc) {
+		remove_memory(nid, lmb->base_addr, block_sz);
+		dlpar_release_drc(lmb->drc_index);
+		return rc;
+	}
+
+	lmb->flags |= DRCONF_MEM_ASSIGNED;
+	return 0;
+}
+
+static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property *prop)
+{
+	struct of_drconf_cell *lmbs;
+	u32 num_lmbs, *p;
+	int lmbs_available = 0;
+	int lmbs_added = 0;
+	int i, rc;
+
+	pr_info("Attempting to hot-add %d LMB(s)\n", lmbs_to_add);
+
+	if (lmbs_to_add == 0)
+		return -EINVAL;
+
+	p = prop->value;
+	num_lmbs = *p++;
+	lmbs = (struct of_drconf_cell *)p;
+
+	/* Validate that there are enough LMBs to satisfy the request */
+	for (i = 0; i < num_lmbs; i++) {
+		if (!(lmbs[i].flags & DRCONF_MEM_ASSIGNED))
+			lmbs_available++;
+	}
+
+	if (lmbs_available < lmbs_to_add)
+		return -EINVAL;
+
+	for (i = 0; i < num_lmbs && lmbs_to_add != lmbs_added; i++) {
+		rc = dlpar_add_lmb(&lmbs[i]);
+		if (rc)
+			continue;
+
+		lmbs_added++;
+
+		/* Mark this lmb so we can remove it later if all of the
+		 * requested LMBs cannot be added.
+		 */
+		lmbs[i].reserved = 1;
+	}
+
+	if (lmbs_added != lmbs_to_add) {
+		/* TODO: remove added lmbs */
+		rc = -EINVAL;
+	} else {
+		for (i = 0; i < num_lmbs; i++) {
+			if (!lmbs[i].reserved)
+				continue;
+
+			pr_info("Memory at %llx (drc index %x) was hot-added\n",
+				lmbs[i].base_addr, lmbs[i].drc_index);
+			lmbs[i].reserved = 0;
+		}
+	}
+
+	return rc;
+}
+
+static int dlpar_memory_add_by_index(u32 drc_index, struct property *prop)
+{
+	struct of_drconf_cell *lmbs;
+	u32 num_lmbs, *p;
+	int i, lmb_found;
+	int rc;
+
+	pr_info("Attempting to hot-add LMB, drc index %x\n", drc_index);
+
+	p = prop->value;
+	num_lmbs = *p++;
+	lmbs = (struct of_drconf_cell *)p;
+
+	lmb_found = 0;
+	for (i = 0; i < num_lmbs; i++) {
+		if (lmbs[i].drc_index == drc_index) {
+			lmb_found = 1;
+			rc = dlpar_add_lmb(&lmbs[i]);
+			break;
+		}
+	}
+
+	if (!lmb_found)
+		rc = -EINVAL;
+
+	if (rc)
+		pr_info("Failed to hot-add memory, drc index %x\n", drc_index);
+	else
+		pr_info("Memory at %llx (drc index %x) was hot-added\n",
+			lmbs[i].base_addr, drc_index);
+
+	return rc;
+}
+
+static void dlpar_update_drconf_property(struct device_node *dn,
+					 struct property *prop)
+{
+	struct of_drconf_cell *lmbs;
+	u32 num_lmbs, *p;
+	int i;
+
+	/* Convert the property back to BE */
+	p = prop->value;
+	num_lmbs = *p;
+	*p = cpu_to_be32(*p);
+	p++;
+
+	lmbs = (struct of_drconf_cell *)p;
+	for (i = 0; i < num_lmbs; i++) {
+		lmbs[i].base_addr = cpu_to_be64(lmbs[i].base_addr);
+		lmbs[i].drc_index = cpu_to_be32(lmbs[i].drc_index);
+		lmbs[i].flags = cpu_to_be32(lmbs[i].flags);
+	}
+
+	rtas_hp_event = true;
+	of_update_property(dn, prop);
+	rtas_hp_event = false;
+}
+
 int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 {
-	int rc = 0;
+	struct device_node *dn;
+	struct property *prop;
+	u32 count, drc_index;
+	int rc;
+
+	count = hp_elog->_drc_u.drc_count;
+	drc_index = hp_elog->_drc_u.drc_index;
 
 	lock_device_hotplug();
 
+	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!dn)
+		return -EINVAL;
+
+	prop = dlpar_clone_drconf_property(dn);
+	if (!prop) {
+		of_node_put(dn);
+		return -EINVAL;
+	}
+
 	switch (hp_elog->action) {
+	case PSERIES_HP_ELOG_ACTION_ADD:
+		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
+			rc = dlpar_memory_add_by_count(count, prop);
+		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
+			rc = dlpar_memory_add_by_index(drc_index, prop);
+		else
+			rc = -EINVAL;
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;
 		break;
 	}
 
+	if (rc)
+		dlpar_free_drconf_property(prop);
+	else
+		dlpar_update_drconf_property(dn, prop);
+
+	of_node_put(dn);
 	unlock_device_hotplug();
 	return rc;
 }
@@ -193,6 +454,9 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
 	__be32 *p;
 	int i, rc = -EINVAL;
 
+	if (rtas_hp_event)
+		return 0;
+
 	memblock_size = pseries_memory_block_size();
 	if (!memblock_size)
 		return -EINVAL;
