Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFj6Q6q2mzF0bL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 04:33:18 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
 w08HTQph115727
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Jan 2018 12:33:16 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fc9pftht9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jan 2018 12:33:16 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 8 Jan 2018 10:33:15 -0700
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V3 3/3] postmigration/memory: Associativity &
 ibm,dynamic-memory-v2
In-Reply-To: <0658ebca-aa3c-9251-9d74-b645633a750a@linux.vnet.ibm.com>
Date: Mon, 8 Jan 2018 11:32:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <de798beb-80aa-403a-98e4-d175f512701e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

postmigration/memory: Now apply changes to the associativity of memory
blocks described by the 'ibm,dynamic-memory-v2' property regarding
the topology of LPARS in Post Migration events.

* Extend the previous work done for the 'ibm,associativity-lookup-array'
  to apply to either property 'ibm,dynamic-memory' or
  'ibm,dynamic-memory-v2', whichever is present.
* Add new code to parse the 'ibm,dynamic-memory-v2' property looking
  for differences in block 'assignment', associativity indexes per
  block, and any other difference currently known.

When block differences are recognized, the memory block may be removed,
added, or updated depending upon the state of the new device tree
property and differences from the migrated value of the property.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V3:
  -- Remove unnecessary spacing changes from patch.
  -- Improve patch description.
---
 arch/powerpc/include/asm/prom.h                 |   12 ++
 arch/powerpc/platforms/pseries/hotplug-memory.c |  169 ++++++++++++++++++++++-
 2 files changed, 172 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 825bd59..e16ef0f 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -92,6 +92,18 @@ struct of_drconf_cell {
 	u32	flags;
 };
 
+/* The of_drconf_cell_v2 struct defines the layout of the LMB array
+ * specified in the device tree property
+ * ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory-v2
+ */
+struct of_drconf_cell_v2 {
+	u32 num_seq_lmbs;
+	u64 base_address;
+	u32 drc_index;
+	u32 aa_index;
+	u32 flags;
+} __attribute__((packed));
+
 #define DRCONF_MEM_ASSIGNED	0x00000008
 #define DRCONF_MEM_AI_INVALID	0x00000040
 #define DRCONF_MEM_RESERVED	0x00000080
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 04208b0..d406b41 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -1172,14 +1172,111 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
 	return rc;
 }
 
+static inline int pseries_memory_v2_find_drc(u32 drc_index,
+			u64 *base_addr, unsigned long memblock_size,
+			struct of_drconf_cell_v2 **drmem,
+			struct of_drconf_cell_v2 *last_drmem)
+{
+	struct of_drconf_cell_v2 *dm = (*drmem);
+
+	while (dm < last_drmem) {
+		if ((be32_to_cpu(dm->drc_index) <= drc_index) &&
+			(drc_index <= (be32_to_cpu(dm->drc_index)+
+					be32_to_cpu(dm->num_seq_lmbs)-1))) {
+			int offset = drc_index - be32_to_cpu(dm->drc_index);
+			(*base_addr) = be64_to_cpu(dm->base_address) +
+					(offset * memblock_size);
+			break;
+		} else if (drc_index > (be32_to_cpu(dm->drc_index)+
+					be32_to_cpu(dm->num_seq_lmbs)-1)) {
+			dm++;
+			(*drmem) = dm;
+		} else if (be32_to_cpu(dm->drc_index) > drc_index) {
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int pseries_update_drconf_memory_v2(struct of_reconfig_data *pr)
+{
+	struct of_drconf_cell_v2 *new_drmem, *old_drmem, *last_old_drmem;
+	unsigned long memblock_size;
+	u32 new_entries, old_entries;
+	u64 old_base_addr;
+	__be32 *p;
+	int i, rc = 0;
+
+	if (rtas_hp_event)
+		return 0;
+
+	memblock_size = pseries_memory_block_size();
+	if (!memblock_size)
+		return -EINVAL;
+
+	/* The first int of the property is the number of lmb's
+	 * described by the property. This is followed by an array
+	 * of of_drconf_cell_v2 entries. Get the number of entries
+	 * and skip to the array of of_drconf_cell_v2's.
+	 */
+	p = (__be32 *) pr->old_prop->value;
+	if (!p)
+		return -EINVAL;
+	old_entries = be32_to_cpu(*p++);
+	old_drmem = (struct of_drconf_cell_v2 *)p;
+	last_old_drmem = old_drmem +
+			(sizeof(struct of_drconf_cell_v2) * old_entries);
+
+	p = (__be32 *)pr->prop->value;
+	new_entries = be32_to_cpu(*p++);
+	new_drmem = (struct of_drconf_cell_v2 *)p;
+
+	for (i = 0; i < new_entries; i++) {
+		int j;
+		u32 new_drc_index = be32_to_cpu(new_drmem->drc_index);
+
+		for (j = 0; j < new_drmem->num_seq_lmbs; j++) {
+			if (!pseries_memory_v2_find_drc(new_drc_index+j,
+							&old_base_addr,
+							memblock_size,
+							&old_drmem,
+							last_old_drmem)) {
+				if ((be32_to_cpu(old_drmem->flags) &
+						DRCONF_MEM_ASSIGNED) &&
+				    (!(be32_to_cpu(new_drmem->flags) &
+						DRCONF_MEM_ASSIGNED))) {
+					rc = pseries_remove_memblock(
+						old_base_addr,
+						memblock_size);
+				} else if ((!(be32_to_cpu(old_drmem->flags) &
+						DRCONF_MEM_ASSIGNED)) &&
+					   (be32_to_cpu(new_drmem->flags) &
+						DRCONF_MEM_ASSIGNED)) {
+					rc = memblock_add(
+						old_base_addr, memblock_size);
+				} else if ((be32_to_cpu(old_drmem->aa_index) !=
+					    be32_to_cpu(new_drmem->aa_index)) &&
+					   (be32_to_cpu(new_drmem->flags) &
+						DRCONF_MEM_ASSIGNED)) {
+					pseries_memory_readd_by_index(
+						new_drc_index+j);
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
 struct assoc_arrays {
 	u32 n_arrays;
 	u32 array_sz;
 	const __be32 *arrays;
 };
 
-static int pseries_update_ala_memory_aai(int aa_index,
-					struct property *dmprop)
+static int pseries_update_ala_memory_aai_v1(int aa_index,
+				struct property *dmprop)
 {
 	struct of_drconf_cell *drmem;
 	u32 entries;
@@ -1211,11 +1308,47 @@ static int pseries_update_ala_memory_aai(int aa_index,
 	return rc;
 }
 
+static int pseries_update_ala_memory_aai_v2(int aa_index,
+				struct property *dmprop)
+{
+	struct of_drconf_cell_v2 *drmem;
+	u32 entries;
+	__be32 *p;
+	int i;
+
+	p = (__be32 *) dmprop->value;
+	if (!p)
+		return -EINVAL;
+
+	/* The first int of the property is the number of lmb's
+	 * described by the property. This is followed by an array
+	 * of of_drconf_cell_v2 entries. Get the number of entries
+	 * and skip to the array of of_drconf_cell_v2's.
+	 */
+	entries = be32_to_cpu(*p++);
+	drmem = (struct of_drconf_cell_v2 *)p;
+
+	for (i = 0; i < entries; i++) {
+		if ((be32_to_cpu(drmem[i].aa_index) != aa_index) &&
+			(be32_to_cpu(drmem[i].flags) & DRCONF_MEM_ASSIGNED)) {
+			int j;
+			int lim = be32_to_cpu(drmem->num_seq_lmbs);
+			u32 drc_index = be32_to_cpu(drmem->drc_index);
+
+			for (j = 0; j < lim; j++)
+				pseries_memory_readd_by_index(drc_index+j);
+		}
+	}
+
+	return 0;
+}
+
 static int pseries_update_ala_memory(struct of_reconfig_data *pr)
 {
 	struct assoc_arrays new_ala, old_ala;
 	struct device_node *dn;
 	struct property *dmprop;
+	bool v1 = true;
 	__be32 *p;
 	int i, lim;
 
@@ -1228,8 +1361,13 @@ static int pseries_update_ala_memory(struct of_reconfig_data *pr)
 
 	dmprop = of_find_property(dn, "ibm,dynamic-memory", NULL);
 	if (!dmprop) {
-		of_node_put(dn);
-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
-		return -ENODEV;
+		v1 = false;
+		dmprop = of_find_property(dn, "ibm,dynamic-memory-v2",
+					NULL);
+		if (!dmprop) {
+			of_node_put(dn);
+			return -ENODEV;
+		}
 	}
 
 	/*
@@ -1271,19 +1409,30 @@ static int pseries_update_ala_memory(struct of_reconfig_data *pr)
 						new_ala.array_sz))
 				continue;
 
-			pseries_update_ala_memory_aai(i, dmprop);
+			if (v1)
+				pseries_update_ala_memory_aai_v1(i, dmprop);
+			else
+				pseries_update_ala_memory_aai_v2(i, dmprop);
 		}
 
-		for (i = lim; i < new_ala.n_arrays; i++)
-			pseries_update_ala_memory_aai(i, dmprop);
+		for (i = lim; i < new_ala.n_arrays; i++) {
+			if (v1)
+				pseries_update_ala_memory_aai_v1(i, dmprop);
+			else
+				pseries_update_ala_memory_aai_v2(i, dmprop);
+		}
 
 	} else {
 		/* Update all entries representing these rows;
 		 * as all rows have different sizes, none can
 		 * have equivalent values.
 		 */
-		for (i = 0; i < lim; i++)
-			pseries_update_ala_memory_aai(i, dmprop);
+		for (i = 0; i < lim; i++) {
+			if (v1)
+				pseries_update_ala_memory_aai_v1(i, dmprop);
+			else
+				pseries_update_ala_memory_aai_v2(i, dmprop);
+		}
 	}
 
 	of_node_put(dn);
@@ -1306,6 +1455,8 @@ static int pseries_memory_notifier(struct notifier_block *nb,
 	case OF_RECONFIG_UPDATE_PROPERTY:
 		if (!strcmp(rd->prop->name, "ibm,dynamic-memory"))
 			err = pseries_update_drconf_memory(rd);
+		if (!strcmp(rd->prop->name, "ibm,dynamic-memory-v2"))
+			err = pseries_update_drconf_memory_v2(rd);
 		if (!strcmp(rd->prop->name,
 				"ibm,associativity-lookup-arrays"))
 			err = pseries_update_ala_memory(rd);
