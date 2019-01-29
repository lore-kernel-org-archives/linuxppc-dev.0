Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700B8C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 17:01:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63942087F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 17:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63942087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pt775mz5zDqPK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 04:01:07 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pt5H2mhmzDqFv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 03:59:31 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0TGwpGU001673
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 11:59:29 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qat3utf5v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 11:59:28 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 29 Jan 2019 16:59:28 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 29 Jan 2019 16:59:25 -0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0TGxOLL18940050
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Jan 2019 16:59:24 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72758BE056;
 Tue, 29 Jan 2019 16:59:24 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E00FFBE04F;
 Tue, 29 Jan 2019 16:59:23 +0000 (GMT)
Received: from oc8380061452.ibm.com (unknown [9.53.179.224])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 29 Jan 2019 16:59:23 +0000 (GMT)
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20190129165514.14612.16201.stgit@ltcalpine2-lp20.aus.stglabs.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [REPOST PATCH v07 1/5] powerpc/drmem: Export 'dynamic-memory' loader
Openpgp: preference=signencrypt
Autocrypt: addr=mwb@linux.vnet.ibm.com; prefer-encrypt=mutual; keydata=
 mQENBFcY7GcBCADzw3en+yzo9ASFGCfldVkIg95SAMPK0myXp2XJYET3zT45uBsX/uj9/2nA
 lBmXXeOSXnPfJ9V3vtiwcfATnWIsVt3tL6n1kqikzH9nXNxZT7MU/7gqzWZngMAWh/GJ9qyg
 DTOZdjsvdUNUWxtiLvBo7y+reA4HjlQhwhYxxvCpXBeRoF0qDWfQ8DkneemqINzDZPwSQ7zY
 t4F5iyN1I9GC5RNK8Y6jiKmm6bDkrrbtXPOtzXKs0J0FqWEIab/u3BDrRP3STDVPdXqViHua
 AjEzthQbGZm0VCxI4a7XjMi99g614/qDcXZCs00GLZ/VYIE8hB9C5Q+l66S60PLjRrxnABEB
 AAG0LU1pY2hhZWwgVy4gQnJpbmdtYW5uIDxtd2JAbGludXgudm5ldC5pYm0uY29tPokBOAQT
 AQIAIgUCVxjsZwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQSEdag3dpuTI0NAf8
 CKYTDKQLgOSjVrU2L5rM4lXaJRmQV6oidD3vIhKSnWRvPq9C29ifRG6ri20prTHAlc0vycgm
 41HHg0y2vsGgNXGTWC2ObemoZBI7mySXe/7Tq5mD/semGzOp0YWZ7teqrkiSR8Bw0p+LdE7K
 QmT7tpjjvuhrtQ3RRojUYcuy1nWUsc4D+2cxsnZslsx84FUKxPbLagDgZmgBhUw/sUi40s6S
 AkdViVCVS0WANddLIpG0cfdsV0kCae/XdjK3mRK6drFKv1z+QFjvOhc8QIkkxFD0da9w3tJj
 oqnqHFV5gLcHO6/wizPx/NV90y6RngeBORkQiRFWxTXS4Oj9GVI/UrkBDQRXGOxnAQgAmJ5Y
 ikTWrMWPfiveUacETyEhWVl7u8UhZcx3yy2te8O0ay7t9fYcZgIEfQPPVVus89acIXlG3wYL
 DDPvb21OprLxi+ZJ2a0S5we+LcSWN1jByxJlbWBq+/LcMtGAOhNLpysY1gD0Y4UW/eKS+TFZ
 562qKC3k1dBvnV9JXCgeS1taYFxRdVAn+2DwK3nuyG/DDq/XgJ5BtmyC3MMx8CiW3POj+O+l
 6SedIeAfZlZ7/xhijx82g93h07VavUQRwMZgZFsqmuxBxVGiav2HB+dNvs3PFB087Pvc9OHe
 qhajPWOP/gNLMmvBvknn1NToM9a8/E8rzcIZXoYs4RggRRYh6wARAQABiQEfBBgBAgAJBQJX
 GOxnAhsMAAoJEEhHWoN3abky+RUH/jE08/r5QzaNKYeVhu0uVbgXu5fsxqr2cAxhf+KuwT3T
 efhEP2alarxzUZdEh4MsG6c+X2NYLbD3cryiXxVx/7kSAJEFQJfA5P06g8NLR25Qpq9BLsN7
 ++dxQ+CLKzSEb1X24hYAJZpOhS8ev3ii+M/XIo+olDBKuTaTgB6elrg3CaxUsVgLBJ+jbRkW
 yQe2S5f/Ja1ThDpSSLLWLiLK/z7+gaqwhnwjQ8Z8Y9D2itJQcj4itHilwImsqwLG7SxzC0NX
 IQ5KaAFYdRcOgwR8VhhkOIVd70ObSZU+E4pTET1WDz4o65xZ89yfose1No0+r5ht/xWOOrh8
 53/hcWvxHVs=
Organization: IBM Linux Technology Center
Date: Tue, 29 Jan 2019 10:59:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012916-0004-0000-0000-000014D9B680
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010499; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153536; UDB=6.00601407; IPR=6.00933902; 
 MB=3.00025341; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-29 16:59:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012916-0005-0000-0000-00008A66E534
Message-Id: <3960cfbc-e501-a8b2-4867-cbc88e34cecb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-29_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290127
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
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, Juliet Kim <minkim@us.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Lynch <nathanl@linux.vnet.ibm.com>
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

