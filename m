Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40h1cL1SH0zF2RK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 02:13:21 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w49G9NL1057922
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 May 2018 12:13:18 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hv3df38x2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 12:13:18 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 9 May 2018 12:13:17 -0400
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [RFC v3 1/3] powerpc migration/drmem: Modify DRMEM code to export
 more features
In-Reply-To: <5763b190-6b8a-eccb-663a-7d35363c81c8@linux.vnet.ibm.com>
Date: Wed, 9 May 2018 11:13:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <773a0479-6598-beb5-487b-5326835b554f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc migration/drmem: Export many of the functions of DRMEM to
parse "ibm,dynamic-memory" and "ibm,dynamic-memory-v2" during
hotplug operations and for Post Migration events.

Also modify the DRMEM initialization code to allow it to,

* Be called after system initialization
* Provide a separate user copy of the LMB array that is produces
* Free the user copy upon request

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in RFC:
  -- Separate DRMEM changes into a standalone patch
  -- Do not export excess functions.  Make exported names more explicit.
  -- Add new iterator to work through a pair of drmem_info arrays.
  -- Modify DRMEM code to replace usages of dt_root_addr_cells, and
     dt_mem_next_cell, as these are only available at first boot.
---
 arch/powerpc/include/asm/drmem.h |   10 +++++
 arch/powerpc/mm/drmem.c          |   78 +++++++++++++++++++++++++++-----------
 2 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index ce242b9..c964b89 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -35,6 +35,13 @@ struct drmem_lmb_info {
 		&drmem_info->lmbs[0],				\
 		&drmem_info->lmbs[drmem_info->n_lmbs - 1])
 
+#define for_each_pair_drmem_lmb(dinfo1, lmb1, dinfo2, lmb2)	\
+	for ((lmb1) = (&dinfo1->lmbs[0]),			\
+	     (lmb2) = (&dinfo2->lmbs[0]);			\
+             ((lmb1) <= (&dinfo1->lmbs[dinfo1->n_lmbs - 1])) &&	\
+             ((lmb2) <= (&dinfo2->lmbs[dinfo2->n_lmbs - 1]));	\
+	     (lmb1)++, (lmb2)++)
+
 /*
  * The of_drconf_cell_v1 struct defines the layout of the LMB data
  * specified in the ibm,dynamic-memory device tree property.
@@ -94,6 +101,9 @@ void __init walk_drmem_lmbs(struct device_node *dn,
 			void (*func)(struct drmem_lmb *, const __be32 **));
 int drmem_update_dt(void);
 
+struct drmem_lmb_info* drmem_init_lmbs(struct property *prop);
+void drmem_lmbs_free(struct drmem_lmb_info *dinfo);
+
 #ifdef CONFIG_PPC_PSERIES
 void __init walk_drmem_lmbs_early(unsigned long node,
 			void (*func)(struct drmem_lmb *, const __be32 **));
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index 3f18036..d9b281c 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -20,6 +20,7 @@
 
 static struct drmem_lmb_info __drmem_info;
 struct drmem_lmb_info *drmem_info = &__drmem_info;
+static int n_root_addr_cells;
 
 u64 drmem_lmb_memory_max(void)
 {
@@ -193,12 +194,13 @@ int drmem_update_dt(void)
 	return rc;
 }
 
-static void __init read_drconf_v1_cell(struct drmem_lmb *lmb,
+static void read_drconf_v1_cell(struct drmem_lmb *lmb,
 				       const __be32 **prop)
 {
 	const __be32 *p = *prop;
 
-	lmb->base_addr = dt_mem_next_cell(dt_root_addr_cells, &p);
+	lmb->base_addr = of_read_number(p, n_root_addr_cells);
+	p += n_root_addr_cells;
 	lmb->drc_index = of_read_number(p++, 1);
 
 	p++; /* skip reserved field */
@@ -209,7 +211,7 @@ static void __init read_drconf_v1_cell(struct drmem_lmb *lmb,
 	*prop = p;
 }
 
-static void __init __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *usm,
+static void __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *data,
 			void (*func)(struct drmem_lmb *, const __be32 **))
 {
 	struct drmem_lmb lmb;
@@ -221,17 +223,18 @@ static void __init __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *usm,
 
 	for (i = 0; i < n_lmbs; i++) {
 		read_drconf_v1_cell(&lmb, &prop);
-		func(&lmb, &usm);
+		func(&lmb, &data);
 	}
 }
 
-static void __init read_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
+static void read_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
 				       const __be32 **prop)
 {
 	const __be32 *p = *prop;
 
 	dr_cell->seq_lmbs = of_read_number(p++, 1);
-	dr_cell->base_addr = dt_mem_next_cell(dt_root_addr_cells, &p);
+	dr_cell->base_addr = of_read_number(p, n_root_addr_cells);
+	p += n_root_addr_cells;
 	dr_cell->drc_index = of_read_number(p++, 1);
 	dr_cell->aa_index = of_read_number(p++, 1);
 	dr_cell->flags = of_read_number(p++, 1);
@@ -239,7 +242,7 @@ static void __init read_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
 	*prop = p;
 }
 
-static void __init __walk_drmem_v2_lmbs(const __be32 *prop, const __be32 *usm,
+static void __walk_drmem_v2_lmbs(const __be32 *prop, const __be32 *data,
 			void (*func)(struct drmem_lmb *, const __be32 **))
 {
 	struct of_drconf_cell_v2 dr_cell;
@@ -263,7 +266,7 @@ static void __init __walk_drmem_v2_lmbs(const __be32 *prop, const __be32 *usm,
 			lmb.aa_index = dr_cell.aa_index;
 			lmb.flags = dr_cell.flags;
 
-			func(&lmb, &usm);
+			func(&lmb, &data);
 		}
 	}
 }
@@ -275,6 +278,9 @@ void __init walk_drmem_lmbs_early(unsigned long node,
 	const __be32 *prop, *usm;
 	int len;
 
+	if (n_root_addr_cells == 0)
+		n_root_addr_cells = dt_root_addr_cells;
+
 	prop = of_get_flat_dt_prop(node, "ibm,lmb-size", &len);
 	if (!prop || len < dt_root_size_cells * sizeof(__be32))
 		return;
@@ -353,24 +359,26 @@ void __init walk_drmem_lmbs(struct device_node *dn,
 	}
 }
 
-static void __init init_drmem_v1_lmbs(const __be32 *prop)
+static void init_drmem_v1_lmbs(const __be32 *prop,
+			struct drmem_lmb_info *dinfo)
 {
 	struct drmem_lmb *lmb;
 
-	drmem_info->n_lmbs = of_read_number(prop++, 1);
-	if (drmem_info->n_lmbs == 0)
+	dinfo->n_lmbs = of_read_number(prop++, 1);
+	if (dinfo->n_lmbs == 0)
 		return;
 
-	drmem_info->lmbs = kcalloc(drmem_info->n_lmbs, sizeof(*lmb),
+	dinfo->lmbs = kcalloc(dinfo->n_lmbs, sizeof(*lmb),
 				   GFP_KERNEL);
-	if (!drmem_info->lmbs)
+	if (!dinfo->lmbs)
 		return;
 
 	for_each_drmem_lmb(lmb)
 		read_drconf_v1_cell(lmb, &prop);
 }
 
-static void __init init_drmem_v2_lmbs(const __be32 *prop)
+static void init_drmem_v2_lmbs(const __be32 *prop,
+			struct drmem_lmb_info *dinfo)
 {
 	struct drmem_lmb *lmb;
 	struct of_drconf_cell_v2 dr_cell;
@@ -386,12 +394,12 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
 	p = prop;
 	for (i = 0; i < lmb_sets; i++) {
 		read_drconf_v2_cell(&dr_cell, &p);
-		drmem_info->n_lmbs += dr_cell.seq_lmbs;
+		dinfo->n_lmbs += dr_cell.seq_lmbs;
 	}
 
-	drmem_info->lmbs = kcalloc(drmem_info->n_lmbs, sizeof(*lmb),
+	dinfo->lmbs = kcalloc(dinfo->n_lmbs, sizeof(*lmb),
 				   GFP_KERNEL);
-	if (!drmem_info->lmbs)
+	if (!dinfo->lmbs)
 		return;
 
 	/* second pass, read in the LMB information */
@@ -402,25 +410,51 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
 		read_drconf_v2_cell(&dr_cell, &p);
 
 		for (j = 0; j < dr_cell.seq_lmbs; j++) {
-			lmb = &drmem_info->lmbs[lmb_index++];
+			lmb = &dinfo->lmbs[lmb_index++];
 
 			lmb->base_addr = dr_cell.base_addr;
-			dr_cell.base_addr += drmem_info->lmb_size;
+			dr_cell.base_addr += dinfo->lmb_size;
 
 			lmb->drc_index = dr_cell.drc_index;
 			dr_cell.drc_index++;
 
 			lmb->aa_index = dr_cell.aa_index;
-			lmb->flags = dr_cell.flags;
 		}
 	}
 }
 
+void drmem_lmbs_free(struct drmem_lmb_info *dinfo)
+{
+	if (dinfo) {
+		kfree(dinfo->lmbs);
+		kfree(dinfo);
+	}
+}
+
+struct drmem_lmb_info* drmem_init_lmbs(struct property *prop)
+{
+	struct drmem_lmb_info *dinfo;
+
+	dinfo = kzalloc(sizeof(*dinfo), GFP_KERNEL);
+	if (!dinfo)
+		return NULL;
+
+	if (!strcmp("ibm,dynamic-memory", prop->name))
+		init_drmem_v1_lmbs(prop->value, dinfo);
+	else if (!strcmp("ibm,dynamic-memory-v2", prop->name))
+		init_drmem_v2_lmbs(prop->value, dinfo);
+
+	return dinfo;
+}
+
 static int __init drmem_init(void)
 {
 	struct device_node *dn;
 	const __be32 *prop;
 
+	if (n_root_addr_cells == 0)
+		n_root_addr_cells = dt_root_addr_cells;
+
 	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
 	if (!dn) {
 		pr_info("No dynamic reconfiguration memory found\n");
@@ -434,11 +468,11 @@ static int __init drmem_init(void)
 
 	prop = of_get_property(dn, "ibm,dynamic-memory", NULL);
 	if (prop) {
-		init_drmem_v1_lmbs(prop);
+		init_drmem_v1_lmbs(prop, drmem_info);
 	} else {
 		prop = of_get_property(dn, "ibm,dynamic-memory-v2", NULL);
 		if (prop)
-			init_drmem_v2_lmbs(prop);
+			init_drmem_v2_lmbs(prop, drmem_info);
 	}
 
 	of_node_put(dn);
