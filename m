Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 551351A03B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 04:12:18 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 12:12:16 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E90946E803F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 11:59:05 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1AHCDS127131972
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:12:13 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1AHCDXT028145
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 12:12:13 -0500
Received: from [9.41.105.104] ([9.41.105.104])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u1AHCDg4028085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 12:12:13 -0500
Subject: [PATCH 2/3] powerpc/pseries: Update LMB associativity index during
 DLPAR add/remove
To: linuxppc-dev@lists.ozlabs.org
References: <56BB6EA5.9090405@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <56BB6F6D.8050806@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 11:12:13 -0600
MIME-Version: 1.0
In-Reply-To: <56BB6EA5.9090405@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The associativity array index specified for a LMB in the device tree,
/ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory, needs to be updated
prior to DLPAR adding a LMB and after DLPAR removing a LMB.

Without doing this step in the DLPAR add process a LMB could be configured
with the incorrect affinity. For a LMB that was not present at boot the
affinity index is set to 0xffffffff, which defaults to adding the LMB to
the first online node since the index is not a valid value. Or, the
affinity index could contain a stale value if the LMB was present at boot
but later DLPAR removed and is being DLPAR added back to the system.

This patch adds a step in the DLPAR add flow to look up the associativity
index for a LMB prior to adding a LMB and setting the associativity to
0xffffffff when a LMB is removed.

This patch also modifies the DLPAR add/remove flow to no longer do a single
update of the device tree property after all of the requested DLPAR
operations are complete and now does a property update during the add
or remove of each LMB.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |  193 +++++++++++++++++++----
 1 file changed, 162 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 294acfd..2ce1385 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -116,6 +116,155 @@ static struct property *dlpar_clone_drconf_property(struct device_node *dn)
 	return new_prop;
 }
 
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
+static int dlpar_update_device_tree_lmb(struct of_drconf_cell *lmb)
+{
+	struct device_node *dn;
+	struct property *prop;
+	struct of_drconf_cell *lmbs;
+	u32 *p, num_lmbs;
+	int i;
+
+	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!dn)
+		return -ENODEV;
+
+	prop = dlpar_clone_drconf_property(dn);
+	if (!prop) {
+		of_node_put(dn);
+		return -ENODEV;
+	}
+
+	p = prop->value;
+	num_lmbs = *p++;
+	lmbs = (struct of_drconf_cell *)p;
+
+	for (i = 0; i < num_lmbs; i++) {
+		if (lmbs[i].drc_index == lmb->drc_index) {
+			lmbs[i].flags = lmb->flags;
+			lmbs[i].aa_index = lmb->aa_index;
+
+			dlpar_update_drconf_property(dn, prop);
+			break;
+		}
+	}
+
+	of_node_put(dn);
+	return 0;
+}
+
+static u32 lookup_lmb_associativity_index(struct of_drconf_cell *lmb)
+{
+	struct device_node *parent, *lmb_node, *dr_node;
+	const u32 *lmb_assoc;
+	const u32 *assoc_arrays;
+	u32 aa_index;
+	int aa_arrays, aa_array_entries, aa_array_sz;
+	int i;
+
+	parent = of_find_node_by_path("/");
+	if (!parent)
+		return -ENODEV;
+
+	lmb_node = dlpar_configure_connector(cpu_to_be32(lmb->drc_index),
+					     parent);
+	of_node_put(parent);
+	if (!lmb_node)
+		return -EINVAL;
+
+	lmb_assoc = of_get_property(lmb_node, "ibm,associativity", NULL);
+	if (!lmb_assoc) {
+		dlpar_free_cc_nodes(lmb_node);
+		return -ENODEV;
+	}
+
+	dr_node = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!dr_node) {
+		dlpar_free_cc_nodes(lmb_node);
+		return -ENODEV;
+	}
+
+	assoc_arrays = of_get_property(dr_node,
+				       "ibm,associativity-lookup-arrays",
+				       NULL);
+	of_node_put(dr_node);
+	if (!assoc_arrays) {
+		dlpar_free_cc_nodes(lmb_node);
+		return -ENODEV;
+	}
+
+	/* The ibm,associativity-lookup-arrays property is defined to be
+	 * a 32-bit value specifying the number of associativity arrays
+	 * followed by a 32-bitvalue specifying the number of entries per
+	 * array, followed by the associativity arrays.
+	 */
+	aa_arrays = be32_to_cpu(assoc_arrays[0]);
+	aa_array_entries = be32_to_cpu(assoc_arrays[1]);
+	aa_array_sz = aa_array_entries * sizeof(u32);
+
+	aa_index = -1;
+	for (i = 0; i < aa_arrays; i++) {
+		int indx = (i * aa_array_entries) + 2;
+
+		if (memcmp(&assoc_arrays[indx], &lmb_assoc[1], aa_array_sz))
+			continue;
+
+		aa_index = i;
+		break;
+	}
+
+	dlpar_free_cc_nodes(lmb_node);
+	return aa_index;
+}
+
+static int dlpar_add_device_tree_lmb(struct of_drconf_cell *lmb)
+{
+	int aa_index;
+
+	lmb->flags |= DRCONF_MEM_ASSIGNED;
+
+	aa_index = lookup_lmb_associativity_index(lmb);
+	if (aa_index < 0) {
+		pr_err("Couldn't find associativity index for drc index %x\n",
+		       lmb->drc_index);
+		return aa_index;
+	}
+
+	lmb->aa_index = aa_index;
+	return dlpar_update_device_tree_lmb(lmb);
+}
+
+static int dlpar_remove_device_tree_lmb(struct of_drconf_cell *lmb)
+{
+	lmb->flags &= ~DRCONF_MEM_ASSIGNED;
+	lmb->aa_index = 0xffffffff;
+	return dlpar_update_device_tree_lmb(lmb);
+}
+
 static struct memory_block *lmb_to_memblock(struct of_drconf_cell *lmb)
 {
 	unsigned long section_nr;
@@ -243,8 +392,8 @@ static int dlpar_remove_lmb(struct of_drconf_cell *lmb)
 	memblock_remove(lmb->base_addr, block_sz);
 
 	dlpar_release_drc(lmb->drc_index);
+	dlpar_remove_device_tree_lmb(lmb);
 
-	lmb->flags &= ~DRCONF_MEM_ASSIGNED;
 	return 0;
 }
 
@@ -435,9 +584,19 @@ static int dlpar_add_lmb(struct of_drconf_cell *lmb)
 	if (rc)
 		return rc;
 
+	rc = dlpar_add_device_tree_lmb(lmb);
+	if (rc) {
+		pr_err("Couldn't update device tree for drc index %x\n",
+		       lmb->drc_index);
+		dlpar_release_drc(lmb->drc_index);
+		return rc;
+	}
+
 	rc = dlpar_add_lmb_memory(lmb);
-	if (rc)
+	if (rc) {
+		dlpar_remove_device_tree_lmb(lmb);
 		dlpar_release_drc(lmb->drc_index);
+	}
 
 	return rc;
 }
@@ -542,31 +701,6 @@ static int dlpar_memory_add_by_index(u32 drc_index, struct property *prop)
 	return rc;
 }
 
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
 int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 {
 	struct device_node *dn;
@@ -614,10 +748,7 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		break;
 	}
 
-	if (rc)
-		dlpar_free_drconf_property(prop);
-	else
-		dlpar_update_drconf_property(dn, prop);
+	dlpar_free_drconf_property(prop);
 
 dlpar_memory_out:
 	of_node_put(dn);
