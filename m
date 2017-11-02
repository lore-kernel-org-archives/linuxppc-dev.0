Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySckJ3bF7zDrDD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 07:53:28 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA2KiE75141148
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Nov 2017 16:53:26 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e05atst83-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Nov 2017 16:53:25 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 2 Nov 2017 16:53:25 -0400
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <eef99211-b3a2-41cc-f4a1-8a88878c9e12@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH 3/3] postmigration/memory: Associativity &
 ibm,dynamic-memory-v2
Date: Thu, 2 Nov 2017 15:53:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <feaa4a9c-4e0c-e98e-7c1b-a9fa66307f85@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/hotplug/memory: Apply changes to the associativity of memory
blocks described by the 'ibm,dynamic-memory-v2' property regarding
the topology of LPARS in Post Migration events.  Previous efforts
only recognized whether a block's assignment had changed in the
property.  Topology migration requires us to compare the 'aa_index'
values of the old/new properties and 'readd' any block for which the
setting has changed.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/prom.h                 |   12 ++
 arch/powerpc/platforms/pseries/hotplug-memory.c |  175 +++++++++++++++++++++--
 2 files changed, 175 insertions(+), 12 deletions(-)

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
index 7aba515..aa44011 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -1153,9 +1153,9 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
 					memblock_size);
 			break;
 		} else if ((!(be32_to_cpu(old_drmem[i].flags) &
-			    DRCONF_MEM_ASSIGNED)) &&
-			    (be32_to_cpu(new_drmem[i].flags) &
-			    DRCONF_MEM_ASSIGNED)) {
+					DRCONF_MEM_ASSIGNED)) &&
+			     (be32_to_cpu(new_drmem[i].flags) &
+					DRCONF_MEM_ASSIGNED)) {
 			rc = memblock_add(be64_to_cpu(old_drmem[i].base_addr),
 					memblock_size);
 			rc = (rc < 0) ? -EINVAL : 0;
@@ -1171,14 +1171,111 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
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
@@ -1208,11 +1305,47 @@ static int pseries_update_ala_memory_aai(int aa_index,
 	return 0;
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
 
@@ -1225,8 +1358,13 @@ static int pseries_update_ala_memory(struct of_reconfig_data *pr)
 
 	dmprop = of_find_property(dn, "ibm,dynamic-memory", NULL);
 	if (!dmprop) {
-		of_node_put(dn);
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
@@ -1268,19 +1406,30 @@ static int pseries_update_ala_memory(struct of_reconfig_data *pr)
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
@@ -1303,6 +1452,8 @@ static int pseries_memory_notifier(struct notifier_block *nb,
 	case OF_RECONFIG_UPDATE_PROPERTY:
 		if (!strcmp(rd->prop->name, "ibm,dynamic-memory"))
 			err = pseries_update_drconf_memory(rd);
+		if (!strcmp(rd->prop->name, "ibm,dynamic-memory-v2"))
+			err = pseries_update_drconf_memory_v2(rd);
 		if (!strcmp(rd->prop->name,
 				"ibm,associativity-lookup-arrays"))
 			err = pseries_update_ala_memory(rd);
