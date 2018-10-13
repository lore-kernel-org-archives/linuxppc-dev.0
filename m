Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43825C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 21:38:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0B220652
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 21:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0B220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XdPW5QytzF3JX
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 08:38:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XdK83fJbzF3FF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 08:35:08 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9DLXsMQ118056
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 17:35:06 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n3ctfafrm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 17:35:06 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sat, 13 Oct 2018 17:35:04 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 13 Oct 2018 17:35:03 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9DLZ2pu31850724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 13 Oct 2018 21:35:02 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E464124054;
 Sat, 13 Oct 2018 18:34:45 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE3AD124053;
 Sat, 13 Oct 2018 18:34:44 -0400 (EDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (unknown [9.40.195.192])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Sat, 13 Oct 2018 18:34:44 -0400 (EDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltcalpine2-lp9.aus.stglabs.ibm.com (Postfix) with ESMTP id B070720FBAB7;
 Sat, 13 Oct 2018 16:35:01 -0500 (CDT)
Subject: [PATCH v05 1/5] powerpc/drmem: Export 'dynamic-memory' loader
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mwb@linux.vnet.ibm.com
Date: Sat, 13 Oct 2018 16:35:01 -0500
In-Reply-To: <20181013213434.4237.33531.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
References: <20181013213434.4237.33531.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101321-0040-0000-0000-00000480280D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009874; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01102233; UDB=6.00570430; IPR=6.00882278; 
 MB=3.00023746; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-13 21:35:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101321-0041-0000-0000-000008883B47
Message-Id: <20181013213450.4237.51557.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-13_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810130202
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

* Add iterator function to work through a pair of drmem_info arrays
  with a callback function to apply specific tests.
* Modify DRMEM code to replace usages of dt_root_addr_cells, and
  dt_mem_next_cell, as these are only available at first boot.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in v05:
  -- Add walk_drmem_lmbs_pairs to replace macro for_each_pair_lmb
---
 arch/powerpc/include/asm/drmem.h |   13 +++++
 arch/powerpc/mm/drmem.c          |   96 ++++++++++++++++++++++++++++++--------
 2 files changed, 89 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index 7c1d8e7..cfe8598 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -35,6 +35,11 @@ struct drmem_lmb_info {
 		&drmem_info->lmbs[0],				\
 		&drmem_info->lmbs[drmem_info->n_lmbs - 1])
 
+#define for_each_dinfo_lmb(dinfo, lmb)				\
+	for_each_drmem_lmb_in_range((lmb),			\
+		&dinfo->lmbs[0],				\
+		&dinfo->lmbs[dinfo->n_lmbs - 1])
+
 /*
  * The of_drconf_cell_v1 struct defines the layout of the LMB data
  * specified in the ibm,dynamic-memory device tree property.
@@ -94,6 +99,14 @@ void __init walk_drmem_lmbs(struct device_node *dn,
 			void (*func)(struct drmem_lmb *, const __be32 **));
 int drmem_update_dt(void);
 
+struct drmem_lmb_info *drmem_lmbs_init(struct property *prop);
+void drmem_lmbs_free(struct drmem_lmb_info *dinfo);
+int walk_drmem_lmbs_pairs(struct drmem_lmb_info *dinfo_oth,
+			  int (*func)(struct drmem_lmb *cnt,
+					struct drmem_lmb *oth,
+					void *data),
+			  void *data);
+
 #ifdef CONFIG_PPC_PSERIES
 void __init walk_drmem_lmbs_early(unsigned long node,
 			void (*func)(struct drmem_lmb *, const __be32 **));
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index 3f18036..ded9dbf 100644
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
@@ -353,24 +359,47 @@ void __init walk_drmem_lmbs(struct device_node *dn,
 	}
 }
 
-static void __init init_drmem_v1_lmbs(const __be32 *prop)
+int walk_drmem_lmbs_pairs(struct drmem_lmb_info *dinfo_oth,
+			int (*func)(struct drmem_lmb *cnt,
+				     struct drmem_lmb *oth,
+				     void *data),
+			void *data)
+{
+	struct drmem_lmb *lmb1, *lmb2;
+	int rc = 0;
+
+	for ((lmb1) = (&drmem_info->lmbs[0]), (lmb2) = (&dinfo_oth->lmbs[0]);
+		((lmb1) <= (&drmem_info->lmbs[drmem_info->n_lmbs - 1])) &&
+		((lmb2) <= (&dinfo_oth->lmbs[dinfo_oth->n_lmbs - 1]));
+		(lmb1)++, (lmb2)++)
+	{
+		rc = func(lmb1, lmb2, data);
+		if (rc <= 0)
+			break;
+	}
+	return rc;
+}
+
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
@@ -386,12 +415,12 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
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
@@ -402,10 +431,10 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
 		read_drconf_v2_cell(&dr_cell, &p);
 
 		for (j = 0; j < dr_cell.seq_lmbs; j++) {
-			lmb = &drmem_info->lmbs[lmb_index++];
+			lmb = &dinfo->lmbs[lmb_index++];
 
 			lmb->base_addr = dr_cell.base_addr;
-			dr_cell.base_addr += drmem_info->lmb_size;
+			dr_cell.base_addr += dinfo->lmb_size;
 
 			lmb->drc_index = dr_cell.drc_index;
 			dr_cell.drc_index++;
@@ -416,11 +445,38 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
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
@@ -434,11 +490,11 @@ static int __init drmem_init(void)
 
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

