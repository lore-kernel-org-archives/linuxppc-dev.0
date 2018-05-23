Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rCrp3Rk2zDr4h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 10:22:34 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4N0KH4J016435
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 20:22:32 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j4t0w0v3u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 20:22:32 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 22 May 2018 18:22:31 -0600
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC v7 6/7] migration/memory: Update memory for assoc changes
In-Reply-To: <b9c98429-f3d7-1e6d-603f-6ac01225e400@linux.vnet.ibm.com>
Date: Tue, 22 May 2018 19:22:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <a6da4b25-0120-cb2d-cb23-ad6e23977529@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

migration/memory: This patch adds more recognition for changes to
the associativity of memory blocks described by the device-tree
properties and updates local and general kernel data structures to
reflect those changes.  These differences may include:

* Evaluating 'ibm,dynamic-memory' properties when processing the
  topology of LPARS in Post Migration events.  Previous efforts
  only recognized whether a memory block's assignment had changed
  in the property.  Changes here include checking the aa_index
  values for each drc_index of the old/new LMBs and to 'readd'
  any block for which the setting has changed.

* In an LPAR migration scenario, the "ibm,associativity-lookup-arrays"
  property may change.  In the event that a row of the array differs,
  locate all assigned memory blocks with that 'aa_index' and 're-add'
  them to the system memory block data structures.  In the process of
  the 're-add', the system routines will update the corresponding entry
  for the memory in the LMB structures and any other relevant kernel
  data structures.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in RFC:
  -- Simplify code to update memory nodes during mobility checks.
  -- Reuse code from DRMEM changes to scan for LMBs when updating
     aa_index
  -- Combine common code for properties 'ibm,dynamic-memory' and
     'ibm,dynamic-memory-v2' after integrating DRMEM features.
  -- Rearrange patches to co-locate memory property-related changes.
  -- Use new paired list iterator for the drmem info arrays.
  -- Use direct calls to add/remove memory from the update drconf
     function as those operations are only intended for user DLPAR
     ops, and should not occur during Migration reconfig notifier
     changes.
  -- Correct processing bug in processing of ibm,associativity-lookup-arrays
  -- Rebase to 4.17-rc5 kernel
  -- Apply minor code cleanups
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |  152 ++++++++++++++++++-----
 1 file changed, 120 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index c1578f5..cdceb3e 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -994,13 +994,11 @@ static int pseries_add_mem_node(struct device_node *np)
 	return (ret < 0) ? -EINVAL : 0;
 }
 
-static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
+static int pseries_update_drconf_memory(struct drmem_lmb_info *new_dinfo)
 {
-	struct of_drconf_cell_v1 *new_drmem, *old_drmem;
+	struct drmem_lmb *old_lmb, *new_lmb;
 	unsigned long memblock_size;
-	u32 entries;
-	__be32 *p;
-	int i, rc = -EINVAL;
+	int rc = 0;
 
 	if (rtas_hp_event)
 		return 0;
@@ -1009,42 +1007,124 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
 	if (!memblock_size)
 		return -EINVAL;
 
-	p = (__be32 *) pr->old_prop->value;
-	if (!p)
-		return -EINVAL;
+	/* Arrays should have the same size and DRC indexes */
+	for_each_pair_drmem_lmb(drmem_info, old_lmb, new_dinfo, new_lmb) {
 
-	/* The first int of the property is the number of lmb's described
-	 * by the property. This is followed by an array of of_drconf_cell
-	 * entries. Get the number of entries and skip to the array of
-	 * of_drconf_cell's.
-	 */
-	entries = be32_to_cpu(*p++);
-	old_drmem = (struct of_drconf_cell_v1 *)p;
-
-	p = (__be32 *)pr->prop->value;
-	p++;
-	new_drmem = (struct of_drconf_cell_v1 *)p;
+		if (new_lmb->drc_index != old_lmb->drc_index)
+			continue;
 
-	for (i = 0; i < entries; i++) {
-		if ((be32_to_cpu(old_drmem[i].flags) & DRCONF_MEM_ASSIGNED) &&
-		    (!(be32_to_cpu(new_drmem[i].flags) & DRCONF_MEM_ASSIGNED))) {
+		if ((old_lmb->flags & DRCONF_MEM_ASSIGNED) &&
+		    (!(new_lmb->flags & DRCONF_MEM_ASSIGNED))) {
 			rc = pseries_remove_memblock(
-				be64_to_cpu(old_drmem[i].base_addr),
-						     memblock_size);
+				old_lmb->base_addr, memblock_size);
 			break;
-		} else if ((!(be32_to_cpu(old_drmem[i].flags) &
-			    DRCONF_MEM_ASSIGNED)) &&
-			    (be32_to_cpu(new_drmem[i].flags) &
-			    DRCONF_MEM_ASSIGNED)) {
-			rc = memblock_add(be64_to_cpu(old_drmem[i].base_addr),
-					  memblock_size);
+		} else if ((!(old_lmb->flags & DRCONF_MEM_ASSIGNED)) &&
+			   (new_lmb->flags & DRCONF_MEM_ASSIGNED)) {
+			rc = memblock_add(old_lmb->base_addr,
+					memblock_size);
 			rc = (rc < 0) ? -EINVAL : 0;
 			break;
+		} else if ((old_lmb->aa_index != new_lmb->aa_index) &&
+			   (new_lmb->flags & DRCONF_MEM_ASSIGNED)) {
+			dlpar_queue_action(PSERIES_HP_ELOG_RESOURCE_MEM,
+					   PSERIES_HP_ELOG_ACTION_READD,
+					   new_lmb->drc_index);
 		}
 	}
 	return rc;
 }
 
+static void pseries_update_ala_memory_aai(int aa_index)
+{
+	struct drmem_lmb *lmb;
+
+	/* Readd all LMBs which were previously using the
+	 * specified aa_index value.
+	 */
+	for_each_drmem_lmb(lmb) {
+		if ((lmb->aa_index == aa_index) &&
+			(lmb->flags & DRCONF_MEM_ASSIGNED)) {
+			dlpar_queue_action(PSERIES_HP_ELOG_RESOURCE_MEM,
+					   PSERIES_HP_ELOG_ACTION_READD,
+					   lmb->drc_index);
+		}
+	}
+}
+
+struct assoc_arrays {
+	u32 n_arrays;
+	u32 array_sz;
+	const __be32 *arrays;
+};
+
+static int pseries_update_ala_memory(struct of_reconfig_data *pr)
+{
+	struct assoc_arrays new_ala, old_ala;
+	__be32 *p;
+	int i, lim;
+
+	if (rtas_hp_event)
+		return 0;
+
+	/*
+	 * The layout of the ibm,associativity-lookup-arrays
+	 * property is a number N indicating the number of
+	 * associativity arrays, followed by a number M
+	 * indicating the size of each associativity array,
+	 * followed by a list of N associativity arrays.
+	 */
+
+	p = (__be32 *) pr->old_prop->value;
+	if (!p)
+		return -EINVAL;
+	old_ala.n_arrays = of_read_number(p++, 1);
+	old_ala.array_sz = of_read_number(p++, 1);
+	old_ala.arrays = p;
+
+	p = (__be32 *) pr->prop->value;
+	if (!p)
+		return -EINVAL;
+	new_ala.n_arrays = of_read_number(p++, 1);
+	new_ala.array_sz = of_read_number(p++, 1);
+	new_ala.arrays = p;
+
+	lim = (new_ala.n_arrays > old_ala.n_arrays) ? old_ala.n_arrays :
+			new_ala.n_arrays;
+
+	if (old_ala.array_sz == new_ala.array_sz) {
+
+		/* Reset any entries where the old and new rows
+		 * the array have changed.
+		 */
+		for (i = 0; i < lim; i++) {
+			int index = (i * new_ala.array_sz);
+
+			if (!memcmp(&old_ala.arrays[index],
+				&new_ala.arrays[index],
+				new_ala.array_sz))
+				continue;
+
+			pseries_update_ala_memory_aai(i);
+		}
+
+		/* Reset any entries representing the extra rows.
+		 * There shouldn't be any, but just in case ...
+		 */
+		for (i = lim; i < new_ala.n_arrays; i++)
+			pseries_update_ala_memory_aai(i);
+
+	} else {
+		/* Update all entries representing these rows;
+		 * as all rows have different sizes, none can
+		 * have equivalent values.
+		 */
+		for (i = 0; i < lim; i++)
+			pseries_update_ala_memory_aai(i);
+	}
+
+	return 0;
+}
+
 static int pseries_memory_notifier(struct notifier_block *nb,
 				   unsigned long action, void *data)
 {
@@ -1059,8 +1139,16 @@ static int pseries_memory_notifier(struct notifier_block *nb,
 		err = pseries_remove_mem_node(rd->dn);
 		break;
 	case OF_RECONFIG_UPDATE_PROPERTY:
-		if (!strcmp(rd->prop->name, "ibm,dynamic-memory"))
-			err = pseries_update_drconf_memory(rd);
+		if (!strcmp(rd->prop->name, "ibm,dynamic-memory")) {
+			struct drmem_lmb_info *dinfo =
+				drmem_lmbs_init(rd->prop);
+			if (!dinfo)
+				return -EINVAL;
+			err = pseries_update_drconf_memory(dinfo);
+			drmem_lmbs_free(dinfo);
+		} else if (!strcmp(rd->prop->name,
+				"ibm,associativity-lookup-arrays"))
+			err = pseries_update_ala_memory(rd);
 		break;
 	}
 	return notifier_from_errno(err);
