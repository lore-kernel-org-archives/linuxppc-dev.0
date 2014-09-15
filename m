Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6125F1A014D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 06:32:56 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 15 Sep 2014 16:32:53 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 301F96E8029
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:32:40 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8FKWqOf4260294
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 20:32:52 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8FKWpCG027398
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:32:52 -0400
Received: from localhost.localdomain (dhcp-9-41-149-95.austin.ibm.com
 [9.41.149.95])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s8FKWpt5027367
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:32:51 -0400
Message-ID: <54174CF3.1010802@linux.vnet.ibm.com>
Date: Mon, 15 Sep 2014 15:32:51 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] pseries: Implement memory hotplug add in the kernel
References: <54174B81.50504@linux.vnet.ibm.com>
In-Reply-To: <54174B81.50504@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the ability to do memory hotplug adding in the kernel.

Currently the hotplug add/remove of memory is handled by the drmgr
command. The drmgr command performs the add/remove by performing
some work in user-space and making requests to the kernel to handle 
other pieces. By moving all of the work to the kernel we can do the
add and remove faster, and provide a common place to do memory hotplug
for both the PowerVM and PowerKVM environments.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |  170 +++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 0e60e15..b254773 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -17,6 +17,7 @@
 #include <linux/vmalloc.h>
 #include <linux/memory.h>
 #include <linux/memory_hotplug.h>
+#include <linux/slab.h>
 
 #include <asm/firmware.h>
 #include <asm/machdep.h>
@@ -24,6 +25,8 @@
 #include <asm/sparsemem.h>
 #include <asm/rtas.h>
 
+#include "pseries.h"
+
 DEFINE_MUTEX(dlpar_mem_mutex);
 
 unsigned long pseries_memory_block_size(void)
@@ -69,6 +72,53 @@ unsigned long pseries_memory_block_size(void)
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
+	new_prop->value = kmalloc(prop->length + 1, GFP_KERNEL);
+	if (!new_prop->name || !new_prop->value) {
+		dlpar_free_drconf_property(new_prop);
+		return NULL;
+	}
+
+	memcpy(new_prop->value, prop->value, prop->length);
+	new_prop->length = prop->length;
+	*(((char *)new_prop->value) + new_prop->length) = 0;
+
+	return new_prop;
+}
+
+static struct memory_block *lmb_to_memblock(struct of_drconf_cell *lmb)
+{
+	unsigned long section_nr;
+	struct mem_section *mem_sect;
+	struct memory_block *mem_block;
+	u64 phys_addr = be64_to_cpu(lmb->base_addr);
+
+	section_nr = pfn_to_section_nr(PFN_DOWN(phys_addr));
+	mem_sect = __nr_to_section(section_nr);
+
+	mem_block = find_memory_block(mem_sect);
+	return mem_block;
+}
+
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static int pseries_remove_memory(u64 start, u64 size)
 {
@@ -155,13 +205,133 @@ static inline int pseries_remove_mem_node(struct device_node *np)
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+static int dlpar_add_one_lmb(struct of_drconf_cell *lmb)
+{
+	struct memory_block *mem_block;
+	u64 phys_addr;
+	unsigned long pages_per_block;
+	unsigned long block_sz;
+	int nid, sections_per_block;
+	int rc;
+
+	phys_addr = be64_to_cpu(lmb->base_addr);
+	block_sz = memory_block_size_bytes();
+	sections_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
+	pages_per_block = PAGES_PER_SECTION * sections_per_block;
+
+	if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
+		return -EINVAL;
+
+	nid = memory_add_physaddr_to_nid(phys_addr);
+	rc = add_memory(nid, phys_addr, block_sz);
+	if (rc)
+		return rc;
+
+	rc = memblock_add(phys_addr, block_sz);
+	if (rc) {
+		remove_memory(nid, phys_addr, block_sz);
+		return rc;
+	}
+
+	mem_block = lmb_to_memblock(lmb);
+	if (!mem_block) {
+		remove_memory(nid, phys_addr, block_sz);
+		return -EINVAL;
+	}
+
+	rc = device_online(&mem_block->dev);
+	put_device(&mem_block->dev);
+	if (rc)
+		remove_memory(nid, phys_addr, block_sz);
+
+	return rc;
+}
+
+static int dlpar_memory_add(struct pseries_hp_errorlog *hp_elog)
+{
+	struct of_drconf_cell *lmb;
+	struct device_node *dn;
+	struct property *prop;
+	uint32_t entries, *p;
+	int i, lmbs_to_add;
+	int lmbs_added = 0;
+	int rc = -EINVAL;
+
+	if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT) {
+		lmbs_to_add = be32_to_cpu(hp_elog->_drc_u.drc_count);
+		pr_info("Attempting to hot-add %d LMB(s)\n", lmbs_to_add);
+	} else {
+		lmbs_to_add = 1;
+		pr_info("Attempting to hot-add LMB, drc index %x\n",
+			be32_to_cpu(hp_elog->_drc_u.drc_index));
+	}
+
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
+	p = prop->value;
+	entries = be32_to_cpu(*p++);
+	lmb = (struct of_drconf_cell *)p;
+
+	for (i = 0; i < entries; i++, lmb++) {
+		u32 drc_index = be32_to_cpu(lmb->drc_index);
+
+		if (lmbs_to_add == lmbs_added)
+			break;
+
+		if (be32_to_cpu(lmb->flags) & DRCONF_MEM_ASSIGNED)
+			continue;
+
+		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX
+		    && lmb->drc_index != hp_elog->_drc_u.drc_index)
+			continue;
+
+		rc = dlpar_acquire_drc(drc_index);
+		if (rc)
+			continue;
+
+		rc = dlpar_add_one_lmb(lmb);
+		if (rc) {
+			dlpar_release_drc(drc_index);
+			continue;
+		}
+
+		lmb->flags |= cpu_to_be32(DRCONF_MEM_ASSIGNED);
+		lmbs_added++;
+		pr_info("Memory at %llx (drc index %x) has been hot-added\n",
+			be64_to_cpu(lmb->base_addr), drc_index);
+	}
+
+	if (lmbs_added)
+		rc = of_update_property(dn, prop);
+	else
+		dlpar_free_drconf_property(prop);
+
+	of_node_put(dn);
+	return rc ? rc : lmbs_added;
+}
+
 int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 {
 	int rc = 0;
 
+	if (hp_elog->id_type != PSERIES_HP_ELOG_ID_DRC_COUNT
+	    && hp_elog->id_type != PSERIES_HP_ELOG_ID_DRC_INDEX)
+		return -EINVAL;
+
 	mutex_lock(&dlpar_mem_mutex);
 
 	switch (hp_elog->action) {
+	case PSERIES_HP_ELOG_ACTION_ADD:
+		rc = dlpar_memory_add(hp_elog);
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;
