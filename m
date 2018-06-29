Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HWBC3Vd1zF1wF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 08:13:23 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5TM8fa6048452
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:13:21 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jwry89c2e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:13:21 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 29 Jun 2018 18:13:20 -0400
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v02 4/5] migration/memory: Evaluate LMB assoc changes
In-Reply-To: <adc67a97-b800-b533-7993-516fc254b6a2@linux.vnet.ibm.com>
Date: Fri, 29 Jun 2018 17:13:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <e11fa759-bcc1-57da-2910-8b727edc850e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

migration/memory: This patch adds code that recognizes changes to
the associativity of memory blocks described by the device-tree
properties in order to drive equivalent 'hotplug' operations to
update local and general kernel data structures to reflect those
changes.  These differences may include:

* Evaluate 'ibm,dynamic-memory' properties when processing the
  updated device-tree properties of the system during Post Migration
  events (migration_store).  The new functionality looks for changes
  to the aa_index values for each drc_index/LMB to identify any memory
  blocks that should be readded.

* In an LPAR migration scenario, the "ibm,associativity-lookup-arrays"
  property may change.  In the event that a row of the array differs,
  locate all assigned memory blocks with that 'aa_index' and 're-add'
  them to the system memory block data structures.  In the process of
  the 're-add', the system routines will update the corresponding entry
  for the memory in the LMB structures and any other relevant kernel
  data structures.

A number of previous extensions made to the DRMEM code for scanning
device-tree properties and creating LMB arrays are used here to
ensure that the resulting code is simpler and more usable:

* Use new paired list iterator for the DRMEM LMB info arrays to find
  differences in old and new versions of properties.
* Use new iterator for copies of the DRMEM info arrays to evaluate
  completely new structures.
* Combine common code for parsing and evaluating memory description
  properties based on the DRMEM LMB array model to greatly simplify
  extension from the older property 'ibm,dynamic-memory' to the new
  property model of 'ibm,dynamic-memory-v2'.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in v02:
  -- Modify the code that parses the memory affinity attributes to
     mark relevant DRMEM LMB array entries using the internal_flags
     mechanism instead of generate unique hotplug actions for each
     memory block to be readded.  The change is intended to both
     simplify the code, and to require fewer resources on systems
     with huge amounts of memory.
  -- Save up notice about any all LMB entries until the end of the
     'migration_store' operation at which point a single action is
     queued to scan the entire DRMEM array.
  -- Add READD_MULTIPLE function for memory that scans the DRMEM
     array to identify multiple entries that were marked previously.
     The corresponding memory blocks are to be readded to the system
     to update relevant data structures outside of the powerpc-
     specific code.
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |  216 +++++++++++++++++++----
 arch/powerpc/platforms/pseries/mobility.c       |    1 
 arch/powerpc/platforms/pseries/pseries.h        |    4 
 3 files changed, 187 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index c1578f5..7dcc3e9 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -561,8 +561,11 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
 		}
 	}
 
-	if (!lmb_found)
-		rc = -EINVAL;
+	if (!lmb_found) {
+		pr_info("Failed to update memory for drc index %lx\n",
+			(unsigned long) drc_index);
+		return -EINVAL;
+	}
 
 	if (rc)
 		pr_info("Failed to update memory at %llx\n",
@@ -573,6 +576,30 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
 	return rc;
 }
 
+static int dlpar_memory_readd_multiple(void)
+{
+	struct drmem_lmb *lmb;
+	int rc;
+
+	pr_info("Attempting to update multiple LMBs\n");
+
+	for_each_drmem_lmb(lmb) {
+		if (drmem_lmb_update(lmb)) {
+			rc = dlpar_remove_lmb(lmb);
+
+			if (!rc) {
+				rc = dlpar_add_lmb(lmb);
+				if (rc)
+					dlpar_release_drc(lmb->drc_index);
+			}
+
+			drmem_remove_lmb_update(lmb);
+		}
+	}
+
+	return rc;
+}
+
 static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 {
 	struct drmem_lmb *lmb, *start_lmb, *end_lmb;
@@ -673,6 +700,10 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
 {
 	return -EOPNOTSUPP;
 }
+static int dlpar_memory_readd_multiple(void)
+{
+	return -EOPNOTSUPP;
+}
 
 static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 {
@@ -952,6 +983,9 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		drc_index = hp_elog->_drc_u.drc_index;
 		rc = dlpar_memory_readd_by_index(drc_index);
 		break;
+	case PSERIES_HP_ELOG_ACTION_READD_MULTIPLE:
+		rc = dlpar_memory_readd_multiple();
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;
@@ -994,13 +1028,39 @@ static int pseries_add_mem_node(struct device_node *np)
 	return (ret < 0) ? -EINVAL : 0;
 }
 
-static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
+static int pmt_changes = 0;
+
+void dlpar_memory_pmt_changes_set(void)
+{
+	pmt_changes = 1;
+}
+
+void dlpar_memory_pmt_changes_clear(void)
+{
+	pmt_changes = 0;
+}
+
+int dlpar_memory_pmt_changes(void)
 {
-	struct of_drconf_cell_v1 *new_drmem, *old_drmem;
+	return pmt_changes;
+}
+
+void dlpar_memory_pmt_changes_action(void)
+{
+	if (dlpar_memory_pmt_changes()) {
+		dlpar_queue_action(
+			PSERIES_HP_ELOG_RESOURCE_MEM,
+			PSERIES_HP_ELOG_ACTION_READD_MULTIPLE,
+			0);
+		dlpar_memory_pmt_changes_clear();
+	}
+}
+
+static int pseries_update_drconf_memory(struct drmem_lmb_info *new_dinfo)
+{
+	struct drmem_lmb *old_lmb, *new_lmb;
 	unsigned long memblock_size;
-	u32 entries;
-	__be32 *p;
-	int i, rc = -EINVAL;
+	int rc = 0;
 
 	if (rtas_hp_event)
 		return 0;
@@ -1009,42 +1069,122 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
 	if (!memblock_size)
 		return -EINVAL;
 
-	p = (__be32 *) pr->old_prop->value;
-	if (!p)
-		return -EINVAL;
+	/* Arrays should have the same size and DRC indexes */
+	for_each_pair_dinfo_lmb(drmem_info, old_lmb, new_dinfo, new_lmb) {
 
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
+			drmem_mark_lmb_update(old_lmb);
+			dlpar_memory_pmt_changes_set();
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
+			drmem_mark_lmb_update(lmb);
+			dlpar_memory_pmt_changes_set();
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
@@ -1059,8 +1199,16 @@ static int pseries_memory_notifier(struct notifier_block *nb,
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
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index d0d1cae..e245a88 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -380,6 +380,7 @@ static ssize_t migration_store(struct class *class,
 	post_mobility_fixup();
 
 	/* Apply any necessary changes identified during fixup */
+	dlpar_memory_pmt_changes_action();
 	dlpar_queued_actions_run();
 
 	return count;
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 72ca996..a4e3e08 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -71,6 +71,10 @@ static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 	return -EOPNOTSUPP;
 }
 #endif
+void dlpar_memory_pmt_changes_set(void);
+void dlpar_memory_pmt_changes_clear(void);
+int dlpar_memory_pmt_changes(void);
+void dlpar_memory_pmt_changes_action(void);
 
 #ifdef CONFIG_HOTPLUG_CPU
 int dlpar_cpu(struct pseries_hp_errorlog *hp_elog);
