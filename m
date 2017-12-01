Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypLFP351ZzDsPY
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 04:03:21 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB1Gs0Jc078218
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 12:03:19 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ek86jj88v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Dec 2017 12:03:18 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 1 Dec 2017 12:03:17 -0500
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vB1H3FNF46203068
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 17:03:15 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25AC4AC03F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 12:04:13 -0500 (EST)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP id F23E5AC043
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 12:04:12 -0500 (EST)
Subject: [PATCH V3 8/9] powerpc/drmem: Add support for ibm,
 dynamic-memory-v2 property
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 01 Dec 2017 10:47:53 -0600
In-Reply-To: <151214667699.64022.17601877129884655591.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <151214667699.64022.17601877129884655591.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151214686823.64022.14062853099614941612.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Power Hypervisor has introduced a new device tree format for
the property describing the dynamic reconfiguration LMBs for a system,
ibm,dynamic-memory-v2. This new format condenses the size of the
property, especially on large memory systems, by reporting sets
of LMBs that have the same properties (flags and associativity array
index).

This patch updates the powerpc/mm/drmem.c code to provide routines
that can parse the new device tree format during the walk_drmem_lmb*
routines used during boot, the creation of the LMB array, and updating
the device tree to create a new property in the proper format for
ibm,dynamic-memory-v2.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

---

Updates for V3: Provide parsing routines for ibm,dynamic-memory-v2
to be called from the walk_drmem_lmb* routines.

 arch/powerpc/include/asm/drmem.h |   12 ++
 arch/powerpc/mm/drmem.c          |  192 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 200 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index afa7dce89a67..47a701263b03 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -49,6 +49,18 @@ struct of_drconf_cell_v1 {
 	__be32	flags;
 };
 
+/* Version 2 of the ibm,dynamic-memory property is defined as a
+ * 32-bit value specifying the number of LMB sets followed by an
+ * array of of_drconf_cell_v2 entries, one per LMB set.
+ */
+struct of_drconf_cell_v2 {
+	u32	seq_lmbs;
+	u64	base_addr;
+	u32	drc_index;
+	u32	aa_index;
+	u32	flags;
+} __packed;
+
 #define DRCONF_MEM_ASSIGNED	0x00000008
 #define DRCONF_MEM_AI_INVALID	0x00000040
 #define DRCONF_MEM_RESERVED	0x00000080
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index 5fe3944ebf28..31dbe14f1d96 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -91,6 +91,84 @@ static int drmem_update_dt_v1(struct device_node *memory,
 	return 0;
 }
 
+static void init_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
+				struct drmem_lmb *lmb)
+{
+	dr_cell->base_addr = cpu_to_be64(lmb->base_addr);
+	dr_cell->drc_index = cpu_to_be32(lmb->drc_index);
+	dr_cell->aa_index = cpu_to_be32(lmb->aa_index);
+	dr_cell->flags = cpu_to_be32(lmb->flags);
+}
+
+static int drmem_update_dt_v2(struct device_node *memory,
+			      struct property *prop)
+{
+	struct property *new_prop;
+	struct of_drconf_cell_v2 *dr_cell;
+	struct drmem_lmb *lmb, *prev_lmb;
+	u32 lmb_sets, prop_sz, seq_lmbs;
+	u32 *p;
+
+	/* First pass, determine how many LMB sets are needed. */
+	lmb_sets = 0;
+	prev_lmb = NULL;
+	for_each_drmem_lmb(lmb) {
+		if (!prev_lmb) {
+			prev_lmb = lmb;
+			lmb_sets++;
+			continue;
+		}
+
+		if (prev_lmb->aa_index != lmb->aa_index ||
+		    prev_lmb->flags != lmb->flags)
+			lmb_sets++;
+
+		prev_lmb = lmb;
+	}
+
+	prop_sz = lmb_sets * sizeof(*dr_cell) + sizeof(__be32);
+	new_prop = clone_property(prop, prop_sz);
+	if (!new_prop)
+		return -1;
+
+	p = new_prop->value;
+	*p++ = cpu_to_be32(lmb_sets);
+
+	dr_cell = (struct of_drconf_cell_v2 *)p;
+
+	/* Second pass, populate the LMB set data */
+	prev_lmb = NULL;
+	seq_lmbs = 0;
+	for_each_drmem_lmb(lmb) {
+		if (prev_lmb == NULL) {
+			/* Start of first LMB set */
+			prev_lmb = lmb;
+			init_drconf_v2_cell(dr_cell, lmb);
+			seq_lmbs++;
+			continue;
+		}
+
+		if (prev_lmb->aa_index != lmb->aa_index ||
+		    prev_lmb->flags != lmb->flags) {
+			/* end of one set, start of another */
+			dr_cell->seq_lmbs = cpu_to_be32(seq_lmbs);
+			dr_cell++;
+
+			init_drconf_v2_cell(dr_cell, lmb);
+			seq_lmbs = 1;
+		} else {
+			seq_lmbs++;
+		}
+
+		prev_lmb = lmb;
+	}
+
+	/* close out last LMB set */
+	dr_cell->seq_lmbs = cpu_to_be32(seq_lmbs);
+	of_update_property(memory, new_prop);
+	return 0;
+}
+
 int drmem_update_dt(void)
 {
 	struct device_node *memory;
@@ -102,8 +180,13 @@ int drmem_update_dt(void)
 		return -1;
 
 	prop = of_find_property(memory, "ibm,dynamic-memory", NULL);
-	if (prop)
+	if (prop) {
 		rc = drmem_update_dt_v1(memory, prop);
+	} else {
+		prop = of_find_property(memory, "ibm,dynamic-memory-v2", NULL);
+		if (prop)
+			rc = drmem_update_dt_v2(memory, prop);
+	}
 
 	of_node_put(memory);
 	return rc;
@@ -139,6 +222,47 @@ static void __init __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *usm,
 	}
 }
 
+static void __init read_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
+				       const __be32 **prop)
+{
+	const __be32 *p = *prop;
+
+	dr_cell->seq_lmbs = of_read_number(p++, 1);
+	dr_cell->base_addr = dt_mem_next_cell(dt_root_addr_cells, &p);
+	dr_cell->drc_index = of_read_number(p++, 1);
+	dr_cell->aa_index = of_read_number(p++, 1);
+	dr_cell->flags = of_read_number(p++, 1);
+
+	*prop = p;
+}
+
+static void __init __walk_drmem_v2_lmbs(const __be32 *prop, const __be32 *usm,
+			void (*func)(struct drmem_lmb *, const __be32 **))
+{
+	struct of_drconf_cell_v2 dr_cell;
+	struct drmem_lmb lmb;
+	u32 i, j, lmb_sets;
+
+	lmb_sets = of_read_number(prop++, 1);
+
+	for (i = 0; i < lmb_sets; i++) {
+		read_drconf_v2_cell(&dr_cell, &prop);
+
+		for (j = 0; j < dr_cell.seq_lmbs; j++) {
+			lmb.base_addr = dr_cell.base_addr;
+			dr_cell.base_addr += drmem_lmb_size();
+
+			lmb.drc_index = dr_cell.drc_index;
+			dr_cell.drc_index++;
+
+			lmb.aa_index = dr_cell.aa_index;
+			lmb.flags = dr_cell.flags;
+
+			func(&lmb, &usm);
+		}
+	}
+}
+
 #ifdef CONFIG_PPC_PSERIES
 void __init walk_drmem_lmbs_early(unsigned long node,
 			void (*func)(struct drmem_lmb *, const __be32 **))
@@ -155,8 +279,14 @@ void __init walk_drmem_lmbs_early(unsigned long node,
 	usm = of_get_flat_dt_prop(node, "linux,drconf-usable-memory", &len);
 
 	prop = of_get_flat_dt_prop(node, "ibm,dynamic-memory", &len);
-	if (prop)
+	if (prop) {
 		__walk_drmem_v1_lmbs(prop, usm, func);
+	} else {
+		prop = of_get_flat_dt_prop(node, "ibm,dynamic-memory-v2",
+					   &len);
+		if (prop)
+			__walk_drmem_v2_lmbs(prop, usm, func);
+	}
 
 	memblock_dump_all();
 }
@@ -209,8 +339,13 @@ void __init walk_drmem_lmbs(struct device_node *dn,
 	usm = of_get_usable_memory(dn);
 
 	prop = of_get_property(dn, "ibm,dynamic-memory", NULL);
-	if (prop)
+	if (prop) {
 		__walk_drmem_v1_lmbs(prop, usm, func);
+	} else {
+		prop = of_get_property(dn, "ibm,dynamic-memory-v2", NULL);
+		if (prop)
+			__walk_drmem_v2_lmbs(prop, usm, func);
+	}
 }
 
 static void __init init_drmem_v1_lmbs(const __be32 *prop)
@@ -228,6 +363,50 @@ static void __init init_drmem_v1_lmbs(const __be32 *prop)
 		read_drconf_v1_cell(lmb, &prop);
 }
 
+static void __init init_drmem_v2_lmbs(const __be32 *prop)
+{
+	struct drmem_lmb *lmb;
+	struct of_drconf_cell_v2 dr_cell;
+	const __be32 *p;
+	u32 i, j, lmb_sets;
+	int lmb_index;
+
+	lmb_sets = of_read_number(prop++, 1);
+
+	/* first pass, calculate the number of LMBs */
+	p = prop;
+	for (i = 0; i < lmb_sets; i++) {
+		read_drconf_v2_cell(&dr_cell, &p);
+		drmem_info->n_lmbs += dr_cell.seq_lmbs;
+	}
+
+	drmem_info->lmbs = kcalloc(drmem_info->n_lmbs, sizeof(*lmb),
+				   GFP_KERNEL);
+	if (!drmem_info->lmbs)
+		return;
+
+	/* second pass, read in the LMB information */
+	lmb_index = 0;
+	p = prop;
+
+	for (i = 0; i < lmb_sets; i++) {
+		read_drconf_v2_cell(&dr_cell, &p);
+
+		for (j = 0; j < dr_cell.seq_lmbs; j++) {
+			lmb = &drmem_info->lmbs[lmb_index++];
+
+			lmb->base_addr = dr_cell.base_addr;
+			dr_cell.base_addr += drmem_info->lmb_size;
+
+			lmb->drc_index = dr_cell.drc_index;
+			dr_cell.drc_index++;
+
+			lmb->aa_index = dr_cell.aa_index;
+			lmb->flags = dr_cell.flags;
+		}
+	}
+}
+
 static int __init drmem_init(void)
 {
 	struct device_node *dn;
@@ -245,8 +424,13 @@ static int __init drmem_init(void)
 	}
 
 	prop = of_get_property(dn, "ibm,dynamic-memory", NULL);
-	if (prop)
+	if (prop) {
 		init_drmem_v1_lmbs(prop);
+	} else {
+		prop = of_get_property(dn, "ibm,dynamic-memory-v2", NULL);
+		if (prop)
+			init_drmem_v2_lmbs(prop);
+	}
 
 	of_node_put(dn);
 	return 0;
