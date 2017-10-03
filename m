Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y67Vy1LpLzDqks
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 05:54:33 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v93InTEj011733
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 14:54:32 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dccvkunr4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Oct 2017 14:54:31 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 3 Oct 2017 14:54:30 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v93IsSFC41353278
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 18:54:28 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8D482803A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 14:54:21 -0400 (EDT)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id 7FED02804C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 14:54:21 -0400 (EDT)
Subject: [PATCH7/8] powerpc/pseries: Add support for ibm,
 dynamic-memory-v2 property
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 03 Oct 2017 13:40:16 -0500
In-Reply-To: <150705593139.7318.5934648279979743833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <150705593139.7318.5934648279979743833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <150705601647.7318.2462819659401153641.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Power Hypervisor has introduced a new device tree format for
the property describing the dynamic reconfiguration LMBs for a system.
This new format condenses the size of the property, especially
on large memory systems, to provide an entry per range of LMBs
that possess the same flags and associativity index instead of
specifying an entry per LMB.

This patch updates the drmem code to be able to parse the new
property format at boot and create the LMB array. This also updates
the device tree updating routine to build a device tree property
in this format.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/drmem.h |   12 ++
 arch/powerpc/mm/drmem.c          |  188 ++++++++++++++++++++++++++++++++++----
 2 files changed, 182 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index 32d859c84202..b7becafc528d 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -49,6 +49,18 @@ struct of_drconf_cell_v1 {
 	u32     flags;
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
+} __attribute__((packed));
+
 #define DRCONF_MEM_ASSIGNED	0x00000008
 #define DRCONF_MEM_AI_INVALID	0x00000040
 #define DRCONF_MEM_RESERVED	0x00000080
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index 9cd9e680874e..b5b8b8f46292 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -21,25 +21,13 @@
 static struct drmem_lmb_info __drmem_info;
 struct drmem_lmb_info *drmem_info = &__drmem_info;
 
-int __init init_drmem_lmbs(unsigned long node)
+static int __init init_drmem_lmbs_v1(const __be32 *prop, u32 len)
 {
 	struct drmem_lmb *lmb;
-	const __be32 *prop;
-	int prop_sz;
-	u32 len;
-
-	prop = of_get_flat_dt_prop(node, "ibm,lmb-size", &len);
-	if (!prop || len < dt_root_size_cells * sizeof(__be32))
-		return -1;
-
-	drmem_info->lmb_size = dt_mem_next_cell(dt_root_size_cells, &prop);
-
-	prop = of_get_flat_dt_prop(node, "ibm,dynamic-memory", &len);
-	if (!prop || len < dt_root_size_cells * sizeof(__be32))
-		return -1;
+	u32 prop_sz;
 
 	drmem_info->n_lmbs = of_read_number(prop++, 1);
-	prop_sz = drmem_info->n_lmbs * sizeof(struct of_drconf_cell)
+	prop_sz = drmem_info->n_lmbs * sizeof(struct of_drconf_cell_v1)
 		  + sizeof(__be32);
 	if (prop_sz < len)
 		return -1;
@@ -61,6 +49,89 @@ int __init init_drmem_lmbs(unsigned long node)
 	return 0;
 }
 
+static void read_one_drconf_v2_cell(const __be32 **cell,
+				    struct of_drconf_cell_v2 *dr_cell)
+{
+	const __be32 *p = *cell;
+
+	dr_cell->seq_lmbs = of_read_number(p++, 1);
+	dr_cell->base_addr = dt_mem_next_cell(dt_root_addr_cells, &p);
+	dr_cell->drc_index = of_read_number(p++, 1);
+	dr_cell->aa_index = of_read_number(p++, 1);
+	dr_cell->flags = of_read_number(p++, 1);
+
+	*cell = p;
+}
+
+static int __init init_drmem_lmbs_v2(const __be32 *prop, u32 len)
+{
+	struct drmem_lmb *lmb;
+	struct of_drconf_cell_v2 dr_cell;
+	const __be32 *p;
+	u32 lmb_sets, prop_sz;
+	int i, j, lmb_index;
+
+	lmb_sets = of_read_number(prop++, 1);
+	prop_sz = lmb_sets * sizeof(struct of_drconf_cell_v2)
+		  + sizeof(__be32);
+	if (prop_sz < len)
+		return -1;
+
+	/* first pass, calculate the number of LMBs */
+	p = prop;
+	for (i = 0; i < lmb_sets; i++) {
+		read_one_drconf_v2_cell(&p, &dr_cell);
+		drmem_info->n_lmbs += dr_cell.seq_lmbs;
+	}
+
+	drmem_info->lmbs = alloc_bootmem(drmem_info->n_lmbs * sizeof(*lmb));
+	if (!drmem_info->lmbs)
+		return -1;
+
+	lmb_index = 0;
+	p = prop;
+	for (i = 0; i < lmb_sets; i++) {
+		read_one_drconf_v2_cell(&p, &dr_cell);
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
+
+	return 0;
+}
+
+int __init init_drmem_lmbs(unsigned long node)
+{
+	const __be32 *prop;
+	u32 len;
+
+	prop = of_get_flat_dt_prop(node, "ibm,lmb-size", &len);
+	if (!prop || len < dt_root_size_cells * sizeof(__be32))
+		return -1;
+
+	drmem_info->lmb_size = dt_mem_next_cell(dt_root_size_cells, &prop);
+
+	prop = of_get_flat_dt_prop(node, "ibm,dynamic-memory", &len);
+	if (prop)
+		return init_drmem_lmbs_v1(prop, len);
+
+	prop = of_get_flat_dt_prop(node, "ibm,dynamic-memory-v2", &len);
+	if (prop)
+		return init_drmem_lmbs_v2(prop, len);
+
+	return -1;
+}
+
 u64 drmem_lmb_memory_max(void)
 {
 	struct drmem_lmb *last_lmb;
@@ -130,6 +201,82 @@ static int drmem_update_dt_v1(struct device_node *memory,
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
+		    prev_lmb->flags != drmem_lmb_flags(lmb))
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
+	prev_lmb = NULL;
+	seq_lmbs = 0;
+	for_each_drmem_lmb(lmb) {
+		if (prev_lmb == NULL) {
+			/* Start of first set */
+			prev_lmb = lmb;
+			init_drconf_v2_cell(dr_cell, lmb);
+			seq_lmbs++;
+			continue;
+		}
+
+		if (prev_lmb->aa_index != lmb->aa_index ||
+		    prev_lmb->flags != drmem_lmb_flags(lmb)) {
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
+	/* close out last dr_cell */
+	dr_cell->seq_lmbs = cpu_to_be32(seq_lmbs);
+	of_update_property(memory, new_prop);
+	return 0;
+}
+
 int drmem_update_dt(void)
 {
 	struct device_node *memory;
@@ -141,10 +288,15 @@ int drmem_update_dt(void)
 		return -1;
 
 	prop = of_find_property(memory, "ibm,dynamic-memory", NULL);
-	if (prop)
+	if (prop) {
 		rc = drmem_update_dt_v1(memory, prop);
-	else
-		rc = -1;
+	} else {
+		prop = of_find_property(memory, "ibm,dynamic-memory-v2", NULL);
+		if (prop)
+			rc = drmem_update_dt_v2(memory, prop);
+		else
+			rc = -1;
+	}
 
 	of_node_put(memory);
 	return rc;
