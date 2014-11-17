Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 86B5E1A0001
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 08:56:19 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 17 Nov 2014 14:56:17 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id C2B121FF003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 14:44:59 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAHLuFsq59048038
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 22:56:15 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAHLuEL0004536
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 14:56:14 -0700
Message-ID: <546A6EFD.2020001@linux.vnet.ibm.com>
Date: Mon, 17 Nov 2014 15:56:13 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 6/6] pseries: Implement memory hotplug remove in the kernel
References: <546A6C23.1080800@linux.vnet.ibm.com>
In-Reply-To: <546A6C23.1080800@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move handling of memory hotplug remove on pseries completely into the kernel.

The current memory hotplug remove path involves the drmgr command doing part
of this work in userspace and requesting the kernel to do additional pieces.
This patch allows us to handle the act completely in the kernel via rtas
hotplug events. This allows us to perform the operation faster and provide
a common memory hotplug remove path for PowerVM and PowerKVM systems.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |  206 ++++++++++++++++++++++-
 1 file changed, 201 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index b57d42b..c8189e8 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -173,6 +173,179 @@ static int pseries_remove_mem_node(struct device_node *np)
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
+	if (!(be32_to_cpu(lmb->flags) & DRCONF_MEM_ASSIGNED))
+		return -1;
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
+static int dlpar_add_lmb(struct of_drconf_cell *);
+
+static int dlpar_remove_lmb(struct of_drconf_cell *lmb)
+{
+	struct memory_block *mem_block;
+	unsigned long block_sz;
+	u64 phys_addr;
+	uint32_t drc_index;
+	int nid, rc;
+
+	if (!lmb_is_removable(lmb))
+		return -EINVAL;
+
+	phys_addr = be64_to_cpu(lmb->base_addr);
+	drc_index = be32_to_cpu(lmb->drc_index);
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
+	nid = memory_add_physaddr_to_nid(phys_addr);
+
+	remove_memory(nid, phys_addr, block_sz);
+
+	/* Update memory regions for memory remove */
+	memblock_remove(phys_addr, block_sz);
+
+	dlpar_release_drc(drc_index);
+
+	lmb->flags &= cpu_to_be32(~DRCONF_MEM_ASSIGNED);
+	pr_info("Memory at %llx (drc index %x) has been hot-removed\n",
+		be64_to_cpu(lmb->base_addr), drc_index);
+
+	return 0;
+}
+
+static int dlpar_memory_remove_by_count(struct pseries_hp_errorlog *hp_elog,
+					struct property *prop)
+{
+	struct of_drconf_cell *lmbs;
+	int lmbs_to_remove, lmbs_removed = 0;
+	int lmbs_available = 0;
+	uint32_t num_lmbs;
+	__be32 *p;
+	int i, rc;
+
+	lmbs_to_remove = be32_to_cpu(hp_elog->_drc_u.drc_count);
+	pr_info("Attempting to hot-remove %d LMB(s)\n", lmbs_to_remove);
+
+	if (lmbs_to_remove == 0)
+		return -EINVAL;
+
+	p = prop->value;
+	num_lmbs = be32_to_cpu(*p++);
+	lmbs = (struct of_drconf_cell *)p;
+
+	/* Validate that there are enough LMBs to satisfy the request */
+	for (i = 0; i < num_lmbs; i++) {
+		if (be32_to_cpu(lmbs[i].flags) & DRCONF_MEM_ASSIGNED)
+			lmbs_available++;
+	}
+
+	if (lmbs_available < lmbs_to_remove)
+		return -EINVAL;
+
+	for (i = 0; i < num_lmbs; i++) {
+		if (lmbs_to_remove == lmbs_removed)
+			break;
+
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
+				       be32_to_cpu(lmbs[i].drc_index));
+
+			lmbs[i].reserved = 0;
+		}
+		rc = -EINVAL;
+	} else {
+		/* remove any reserved markings */
+		for (i = 0; i < num_lmbs; i++)
+			lmbs[i].reserved = 0;
+	}
+
+	return rc;
+}
+
+static int dlpar_memory_remove_by_index(struct pseries_hp_errorlog *hp_elog,
+					struct property *prop)
+{
+	struct of_drconf_cell *lmbs;
+	uint32_t num_lmbs, drc_index;
+	int lmb_found;
+	__be32 *p;
+	int i, rc;
+
+	drc_index = be32_to_cpu(hp_elog->_drc_u.drc_index);
+	pr_info("Attempting to hot-remove LMB, drc index %x\n", drc_index);
+
+	p = prop->value;
+	num_lmbs = be32_to_cpu(*p++);
+	lmbs = (struct of_drconf_cell *)p;
+
+	lmb_found = 0;
+	for (i = 0; i < num_lmbs; i++) {
+		if (lmbs[i].drc_index == hp_elog->_drc_u.drc_index) {
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
+		pr_info("Failed to hot-remove memory, drc index %x\n",
+			drc_index);
+
+	return rc;
+}
+
 #else
 static inline int pseries_remove_memblock(unsigned long base,
 					  unsigned int memblock_size)
@@ -183,6 +356,11 @@ static inline int pseries_remove_mem_node(struct device_node *np)
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
@@ -298,14 +476,24 @@ static int dlpar_memory_add_by_count(struct pseries_hp_errorlog *hp_elog,
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
+	} else {
+		/* Clear the reserved fields */
+		for (i = 0; i < num_lmbs; i++)
+			lmbs[i].reserved = 0;
 	}
 
-	/* Clear the reserved fields */
-	for (i = 0; i < num_lmbs; i++)
-		lmbs[i].reserved = 0;
-
 	return rc;
 }
 
@@ -373,6 +561,14 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		else
 			rc = -EINVAL;
 		break;
+	case PSERIES_HP_ELOG_ACTION_REMOVE:
+		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
+			rc = dlpar_memory_remove_by_count(hp_elog, prop);
+		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
+			rc = dlpar_memory_remove_by_index(hp_elog, prop);
+		else
+			rc = -EINVAL;
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;
