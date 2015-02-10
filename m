Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9CAD1A1378
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 06:49:27 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 10 Feb 2015 14:49:25 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 5CF99C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 14:40:34 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1AJnM1U24051962
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 19:49:23 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1AJnMdb002077
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 14:49:22 -0500
Received: from [9.41.149.215] (dhcp-9-41-149-215.austin.ibm.com [9.41.149.215])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t1AJnMfF001987
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 14:49:22 -0500
Message-ID: <54DA60C2.2010308@linux.vnet.ibm.com>
Date: Tue, 10 Feb 2015 13:49:22 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 5/5] pseries: Implement memory hotplug remove in the kernel
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

This patch adds the ability to do memory hotplug remove in the kernel.

Currently the operation to hotplug remove memory is handled by the drmgr
command which performs the operation by performing some work in user-space
and making requests to the kernel to handle other pieces. By moving all
of the work to the kernel we can do the remove faster, and provide a common
code path to do memory hotplug for both the PowerVM and PowerKVM environments.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
Changes from previous cversion:
Changes from previous version:
- converted uint32_t to u32
- Updated the messaging to properly report the success/failure of memory adds

 arch/powerpc/platforms/pseries/hotplug-memory.c |  192 +++++++++++++++++++++++
 1 file changed, 191 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index f5eec0f..742ef88 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -188,6 +188,173 @@ static int pseries_remove_mem_node(struct device_node *np)
 	pseries_remove_memblock(base, lmb_size);
 	return 0;
 }
+
+static bool lmb_is_removable(struct of_drconf_cell *lmb)
+{
+	int i, scns_per_block;
+	int rc = 1;
+	unsigned long pfn, block_sz;
+	u64 phys_addr;
+
+	if (!(lmb->flags & DRCONF_MEM_ASSIGNED))
+		return false;
+
+	block_sz = memory_block_size_bytes();
+	scns_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
+	phys_addr = lmb->base_addr;
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
+	return rc ? true : false;
+}
+
+static int dlpar_add_lmb(struct of_drconf_cell *);
+
+static int dlpar_remove_lmb(struct of_drconf_cell *lmb)
+{
+	struct memory_block *mem_block;
+	unsigned long block_sz;
+	int nid, rc;
+
+	if (!lmb_is_removable(lmb))
+		return -EINVAL;
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
+	block_sz = pseries_memory_block_size();
+	nid = memory_add_physaddr_to_nid(lmb->base_addr);
+
+	remove_memory(nid, lmb->base_addr, block_sz);
+
+	/* Update memory regions for memory remove */
+	memblock_remove(lmb->base_addr, block_sz);
+
+	dlpar_release_drc(lmb->drc_index);
+
+	lmb->flags &= ~DRCONF_MEM_ASSIGNED;
+	return 0;
+}
+
+static int dlpar_memory_remove_by_count(u32 lmbs_to_remove,
+					struct property *prop)
+{
+	struct of_drconf_cell *lmbs;
+	int lmbs_removed = 0;
+	int lmbs_available = 0;
+	u32 num_lmbs, *p;
+	int i, rc;
+
+	pr_info("Attempting to hot-remove %d LMB(s)\n", lmbs_to_remove);
+
+	if (lmbs_to_remove == 0)
+		return -EINVAL;
+
+	p = prop->value;
+	num_lmbs = *p++;
+	lmbs = (struct of_drconf_cell *)p;
+
+	/* Validate that there are enough LMBs to satisfy the request */
+	for (i = 0; i < num_lmbs; i++) {
+		if (lmbs[i].flags & DRCONF_MEM_ASSIGNED)
+			lmbs_available++;
+	}
+
+	if (lmbs_available < lmbs_to_remove)
+		return -EINVAL;
+
+	for (i = 0; i < num_lmbs && lmbs_removed < lmbs_to_remove; i++) {
+		rc = dlpar_remove_lmb(&lmbs[i]);
+		if (rc)
+			continue;
+
+		lmbs_removed++;
+
+		/* Mark this lmb so we can add it later if all of the
+		 * requested LMBs cannot be removed.
+		 */
+		lmbs[i].reserved = 1;
+	}
+
+	if (lmbs_removed != lmbs_to_remove) {
+		pr_err("Memory hot-remove failed, adding LMB's back\n");
+
+		for (i = 0; i < num_lmbs; i++) {
+			if (!lmbs[i].reserved)
+				continue;
+
+			rc = dlpar_add_lmb(&lmbs[i]);
+			if (rc)
+				pr_err("Failed to add LMB back, drc index %x\n",
+				       lmbs[i].drc_index);
+
+			lmbs[i].reserved = 0;
+		}
+
+		rc = -EINVAL;
+	} else {
+		for (i = 0; i < num_lmbs; i++) {
+			if (!lmbs[i].reserved)
+				continue;
+
+			pr_info("Memory at %llx was hot-removed\n",
+				lmbs[i].base_addr);
+
+			lmbs[i].reserved = 0;
+		}
+		rc = 0;
+	}
+
+	return rc;
+}
+
+static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
+{
+	struct of_drconf_cell *lmbs;
+	u32 num_lmbs, *p;
+	int lmb_found;
+	int i, rc;
+
+	pr_info("Attempting to hot-remove LMB, drc index %x\n", drc_index);
+
+	p = prop->value;
+	num_lmbs = *p++;
+	lmbs = (struct of_drconf_cell *)p;
+
+	lmb_found = 0;
+	for (i = 0; i < num_lmbs; i++) {
+		if (lmbs[i].drc_index == drc_index) {
+			lmb_found = 1;
+			rc = dlpar_remove_lmb(&lmbs[i]);
+			break;
+		}
+	}
+
+	if (!lmb_found)
+		rc = -EINVAL;
+
+	if (rc)
+		pr_info("Failed to hot-remove memory at %llx\n",
+			lmbs[i].base_addr);
+	else
+		pr_info("Memory at %llx was hot-removed\n", lmbs[i].base_addr);
+
+	return rc;
+}
+
 #else
 static inline int pseries_remove_memblock(unsigned long base,
 					  unsigned int memblock_size)
@@ -198,6 +365,11 @@ static inline int pseries_remove_mem_node(struct device_node *np)
 {
 	return 0;
 }
+static inline int dlpar_memory_remove(struct pseries_hp_errorlog *hp_elog)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 static int dlpar_add_lmb(struct of_drconf_cell *lmb)
@@ -292,7 +464,17 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property *prop)
 	}
 
 	if (lmbs_added != lmbs_to_add) {
-		/* TODO: remove added lmbs */
+		pr_err("Memory hot-add failed, removing any added LMBs\n");
+
+		for (i = 0; i < num_lmbs; i++) {
+			if (!lmbs[i].reserved)
+				continue;
+
+			rc = dlpar_remove_lmb(&lmbs[i]);
+			if (rc)
+				pr_err("Failed to remove LMB, drc index %x\n",
+				       be32_to_cpu(lmbs[i].drc_index));
+		}
 		rc = -EINVAL;
 	} else {
 		for (i = 0; i < num_lmbs; i++) {
@@ -398,6 +580,14 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		else
 			rc = -EINVAL;
 		break;
+	case PSERIES_HP_ELOG_ACTION_REMOVE:
+		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
+			rc = dlpar_memory_remove_by_count(count, prop);
+		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
+			rc = dlpar_memory_remove_by_index(drc_index, prop);
+		else
+			rc = -EINVAL;
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;
