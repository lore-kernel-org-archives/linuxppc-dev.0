Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E09E41A012E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 06:34:04 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 15 Sep 2014 16:34:02 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 5106B6E803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:33:47 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8FKXx7s1442144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 20:33:59 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8FKXx2E032145
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:33:59 -0400
Received: from localhost.localdomain (dhcp-9-41-149-95.austin.ibm.com
 [9.41.149.95])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s8FKXwHd032117
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 16:33:59 -0400
Message-ID: <54174D36.4000002@linux.vnet.ibm.com>
Date: Mon, 15 Sep 2014 15:33:58 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] pseries: Implement memory hotplug remove in the kernel
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

This patch adds the ability to do memory hotplug remove in the kernel.

Currently the hotplug add/remove of memory is handled by the drmgr
command. The drmgr command performs the add/remove by performing
some work in user-space and making requests to the kernel to handle
other pieces. By moving all of the work to the kernel we can do the
add and remove faster, and provide a common place to do memory hotplug
for both the PowerVM and PowerKVM environments.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |  140 +++++++++++++++++++++++
 1 file changed, 139 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index b254773..160c424 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -193,7 +193,137 @@ static int pseries_remove_mem_node(struct device_node *np)
 	pseries_remove_memblock(base, lmb_size);
 	return 0;
 }
+
+static int lmb_is_removable(struct of_drconf_cell *lmb)
+{
+	int i, scns_per_block;
+	int rc = 1;
+	unsigned long pfn, block_sz;
+	u64 phys_addr;
+
+	phys_addr = be64_to_cpu(lmb->base_addr);
+	block_sz = memory_block_size_bytes();
+	scns_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
+
+	for (i = 0; i < scns_per_block; i++) {
+		pfn = PFN_DOWN(phys_addr);
+		if (!pfn_present(pfn))
+			continue;
+
+		rc &= is_mem_section_removable(pfn, PAGES_PER_SECTION);
+		phys_addr += MIN_MEMORY_BLOCK_SIZE;
+	}
+
+	return rc;
+}
+
+static int dlpar_add_one_lmb(struct of_drconf_cell *);
+
+static int dlpar_remove_one_lmb(struct of_drconf_cell *lmb)
+{
+	struct memory_block *mem_block;
+	unsigned long block_sz;
+	u64 phys_addr;
+	int nid, rc;
+
+	block_sz = memory_block_size_bytes();
+	phys_addr = be64_to_cpu(lmb->base_addr);
+	nid = memory_add_physaddr_to_nid(phys_addr);
+
+	if (!pfn_valid(phys_addr >> PAGE_SHIFT)) {
+		memblock_remove(phys_addr, block_sz);
+		return 0;
+	}
+
+	mem_block = lmb_to_memblock(lmb);
+	if (!mem_block)
+		return -EINVAL;
+
+	rc = device_offline(&mem_block->dev);
+	put_device(&mem_block->dev);
+	if (rc)
+		return rc;
+
+	remove_memory(nid, phys_addr, block_sz);
+	memblock_remove(phys_addr, block_sz);
+
+	return 0;
+}
+
+static int dlpar_memory_remove(struct pseries_hp_errorlog *hp_elog)
+{
+	struct of_drconf_cell *lmb;
+	struct device_node *dn;
+	struct property *prop;
+	int lmbs_to_remove, lmbs_removed = 0;
+	int i, entries;
+	int rc = -EINVAL;
+	uint32_t *p;
+
+	if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT) {
+		lmbs_to_remove = be32_to_cpu(hp_elog->_drc_u.drc_count);
+		pr_info("Attempting to hot-remove %d LMB(s)\n", lmbs_to_remove);
+	} else {
+		lmbs_to_remove = 1;
+		pr_info("Attempting to hot-remove LMB, drc index %x\n",
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
+		if (lmbs_to_remove == lmbs_removed)
+			break;
+
+		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX
+		    && lmb->drc_index != hp_elog->_drc_u.drc_index)
+			continue;
+
+		if (!(be32_to_cpu(lmb->flags) & DRCONF_MEM_ASSIGNED)
+		    || !lmb_is_removable(lmb))
+			continue;
+
+		rc = dlpar_remove_one_lmb(lmb);
+		if (rc)
+			continue;
+
+		rc = dlpar_release_drc(drc_index);
+		if (rc) {
+			dlpar_add_one_lmb(lmb);
+			continue;
+		}
+
+		lmb->flags &= cpu_to_be32(~DRCONF_MEM_ASSIGNED);
+		lmbs_removed++;
+		pr_info("Memory at %llx (drc index %x) has been hot-removed\n",
+			be64_to_cpu(lmb->base_addr), drc_index);
+	}
+
+	if (lmbs_removed)
+		rc = of_update_property(dn, prop);
+	else
+		dlpar_free_drconf_property(prop);
+
+	of_node_put(dn);
+	return rc ? rc : lmbs_removed;
+}
+
 #else
+
 static inline int pseries_remove_memblock(unsigned long base,
 					  unsigned int memblock_size)
 {
@@ -203,6 +333,11 @@ static inline int pseries_remove_mem_node(struct device_node *np)
 {
 	return 0;
 }
+static inline int dlpar_memory_remove(struct pseries_hp_errorlog *hp_elog)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 static int dlpar_add_one_lmb(struct of_drconf_cell *lmb)
@@ -320,7 +455,7 @@ static int dlpar_memory_add(struct pseries_hp_errorlog *hp_elog)
 
 int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 {
-	int rc = 0;
+	int rc;
 
 	if (hp_elog->id_type != PSERIES_HP_ELOG_ID_DRC_COUNT
 	    && hp_elog->id_type != PSERIES_HP_ELOG_ID_DRC_INDEX)
@@ -332,6 +467,9 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 	case PSERIES_HP_ELOG_ACTION_ADD:
 		rc = dlpar_memory_add(hp_elog);
 		break;
+	case PSERIES_HP_ELOG_ACTION_REMOVE:
+		rc = dlpar_memory_remove(hp_elog);
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;
