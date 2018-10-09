Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A401C65BD1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 20:39:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF093213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 20:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF093213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V8Gd3rRCzF324
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 07:39:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42V8C648L5zF31L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 07:36:18 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w99KSllY125182
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Oct 2018 16:36:16 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n11drd6j8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 16:36:15 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 9 Oct 2018 14:36:15 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 9 Oct 2018 14:36:12 -0600
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w99KaCkh50790638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Oct 2018 13:36:12 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F36D6BE058;
 Tue,  9 Oct 2018 14:36:11 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2C3CBE056;
 Tue,  9 Oct 2018 14:36:11 -0600 (MDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (unknown [9.40.195.192])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue,  9 Oct 2018 14:36:11 -0600 (MDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltcalpine2-lp9.aus.stglabs.ibm.com (Postfix) with ESMTP id 871D6283621F;
 Tue,  9 Oct 2018 15:36:11 -0500 (CDT)
Subject: [PATCH v04 1/5] powerpc/drmem: Export 'dynamic-memory' loader
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mwb@linux.vnet.ibm.com
Date: Tue, 09 Oct 2018 15:36:11 -0500
In-Reply-To: <20181009203520.26091.86781.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
References: <20181009203520.26091.86781.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100920-0012-0000-0000-000016C52936
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009849; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100293; UDB=6.00569266; IPR=6.00880342; 
 MB=3.00023685; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-09 20:36:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100920-0013-0000-0000-000054B2230A
Message-Id: <20181009203541.26091.11334.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-09_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810090194
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Juliet Kim <minkim@us.ibm.com>, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

powerpc/drmem: Export many of the functions of DRMEM to parse
"ibm,dynamic-memory" and "ibm,dynamic-memory-v2" during hotplug
operations and for Post Migration events.

Also modify the DRMEM initialization code to allow it to,

* Be called after system initialization
* Provide a separate user copy of the LMB array that is produces
* Free the user copy upon request

In addition, a couple of changes were made to make the creation
of additional copies of the LMB array more useful including,

* Add new iterator to work through a pair of drmem_info arrays.
* Modify DRMEM code to replace usages of dt_root_addr_cells, and
  dt_mem_next_cell, as these are only available at first boot.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/drmem.h |   15 ++++++++
 arch/powerpc/mm/drmem.c          |   75 ++++++++++++++++++++++++++++----------
 2 files changed, 70 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index 7c1d8e7..1fbb684 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -35,6 +35,18 @@ struct drmem_lmb_info {
 		&drmem_info->lmbs[0],				\
 		&drmem_info->lmbs[drmem_info->n_lmbs - 1])
 
+#define for_each_dinfo_lmb(dinfo, lmb)				\
+	for_each_drmem_lmb_in_range((lmb),			\
+		&dinfo->lmbs[0],				\
+		&dinfo->lmbs[dinfo->n_lmbs - 1])
+
+#define for_each_pair_dinfo_lmb(dinfo1, lmb1, dinfo2, lmb2)	\
+	for ((lmb1) = (&dinfo1->lmbs[0]),			\
+	     (lmb2) = (&dinfo2->lmbs[0]);			\
+	     ((lmb1) <= (&dinfo1->lmbs[dinfo1->n_lmbs - 1])) &&	\
+	     ((lmb2) <= (&dinfo2->lmbs[dinfo2->n_lmbs - 1]));	\
+	     (lmb1)++, (lmb2)++)
+
 /*
  * The of_drconf_cell_v1 struct defines the layout of the LMB data
  * specified in the ibm,dynamic-memory device tree property.
@@ -94,6 +106,9 @@ void __init walk_drmem_lmbs(struct device_node *dn,
 			void (*func)(struct drmem_lmb *, const __be32 **));
 int drmem_update_dt(void);
 
+struct drmem_lmb_info *drmem_lmbs_init(struct property *prop);
+void drmem_lmbs_free(struct drmem_lmb_info *dinfo);
+
 #ifdef CONFIG_PPC_PSERIES
 void __init walk_drmem_lmbs_early(unsigned long node,
 			void (*func)(struct drmem_lmb *, const __be32 **));
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index 3f18036..13d2abb 100644
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
+static void __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *usm,
 			void (*func)(struct drmem_lmb *, const __be32 **))
 {
 	struct drmem_lmb lmb;
@@ -225,13 +227,14 @@ static void __init __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *usm,
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
+static void __walk_drmem_v2_lmbs(const __be32 *prop, const __be32 *usm,
 			void (*func)(struct drmem_lmb *, const __be32 **))
 {
 	struct of_drconf_cell_v2 dr_cell;
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
+				struct drmem_lmb_info *dinfo)
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
 
-	for_each_drmem_lmb(lmb)
+	for_each_dinfo_lmb(dinfo, lmb)
 		read_drconf_v1_cell(lmb, &prop);
 }
 
-static void __init init_drmem_v2_lmbs(const __be32 *prop)
+static void init_drmem_v2_lmbs(const __be32 *prop,
+				struct drmem_lmb_info *dinfo)
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
@@ -402,10 +410,10 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
 		read_drconf_v2_cell(&dr_cell, &p);
 
 		for (j = 0; j < dr_cell.seq_lmbs; j++) {
-			lmb = &drmem_info->lmbs[lmb_index++];
+			lmb = &dinfo->lmbs[lmb_index++];
 
 			lmb->base_addr = dr_cell.base_addr;
-			dr_cell.base_addr += drmem_info->lmb_size;
+			dr_cell.base_addr += dinfo->lmb_size;
 
 			lmb->drc_index = dr_cell.drc_index;
 			dr_cell.drc_index++;
@@ -416,11 +424,38 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
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
+struct drmem_lmb_info *drmem_lmbs_init(struct property *prop)
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
@@ -434,11 +469,11 @@ static int __init drmem_init(void)
 
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

