Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF8CC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 20:46:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8EC3208E7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 20:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EC3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433f9257dwzDqcn
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 07:46:46 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 433dxz0LzJzDqNn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 07:37:10 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAQKYA2C138590
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 15:37:08 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p0p70cse7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 15:37:08 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 26 Nov 2018 20:37:07 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 26 Nov 2018 20:37:06 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAQKb5vQ14680076
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Nov 2018 20:37:05 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F048112066;
 Mon, 26 Nov 2018 20:37:05 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5DDE112061;
 Mon, 26 Nov 2018 20:37:04 +0000 (GMT)
Received: from ltczep4-lp5.aus.stglabs.ibm.com (unknown [9.40.193.67])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 26 Nov 2018 20:37:04 +0000 (GMT)
Received: from ltczep4-lp5.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltczep4-lp5.aus.stglabs.ibm.com (Postfix) with ESMTP id 93D8E40CAA83;
 Mon, 26 Nov 2018 14:37:04 -0600 (CST)
Subject: [Internal Review PATCH] powerpc/pseries: Relocate drmem.c to pseries
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Juliet Kim <minkim@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 26 Nov 2018 14:37:04 -0600
In-Reply-To: <20181126203633.11871.94010.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
References: <20181126203633.11871.94010.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112620-0072-0000-0000-000003CF6656
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010125; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123169; UDB=6.00582089; IPR=6.00903298; 
 MB=3.00024341; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-26 20:37:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112620-0073-0000-0000-00004A3CEB17
Message-Id: <20181126203652.11871.77109.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-26_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260175
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The implementation of the pseries-specific dynamic memory features
is currently implemented in several non-pseries-specific files.
This patch set moves the implementation of the device-tree parsing
code for the properties ibm,dynamic-memory, ibm,dynamic-memory-v2,
and its representation in the kernel into the platform-specific
directory to the Pseries features.

This patch moves drmem.c from kernel directory arch/powerpc/mm to
powerpc/platforms/pseries.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/mm/Makefile                |    2 
 arch/powerpc/mm/drmem.c                 |  447 -------------------------------
 arch/powerpc/platforms/pseries/Makefile |    3 
 arch/powerpc/platforms/pseries/drmem.c  |  447 +++++++++++++++++++++++++++++++
 4 files changed, 450 insertions(+), 449 deletions(-)
 delete mode 100644 arch/powerpc/mm/drmem.c
 create mode 100644 arch/powerpc/platforms/pseries/drmem.c

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index ca96e7b..06281e0f 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -9,7 +9,7 @@ CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
 
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
 				   init_$(BITS).o pgtable_$(BITS).o \
-				   init-common.o mmu_context.o drmem.o
+				   init-common.o mmu_context.o
 obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 				   tlb_nohash_low.o
 obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(BITS)e.o
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
deleted file mode 100644
index 3f18036..0000000
--- a/arch/powerpc/mm/drmem.c
+++ /dev/null
@@ -1,447 +0,0 @@
-/*
- * Dynamic reconfiguration memory support
- *
- * Copyright 2017 IBM Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#define pr_fmt(fmt) "drmem: " fmt
-
-#include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/of_fdt.h>
-#include <linux/memblock.h>
-#include <asm/prom.h>
-#include <asm/drmem.h>
-
-static struct drmem_lmb_info __drmem_info;
-struct drmem_lmb_info *drmem_info = &__drmem_info;
-
-u64 drmem_lmb_memory_max(void)
-{
-	struct drmem_lmb *last_lmb;
-
-	last_lmb = &drmem_info->lmbs[drmem_info->n_lmbs - 1];
-	return last_lmb->base_addr + drmem_lmb_size();
-}
-
-static u32 drmem_lmb_flags(struct drmem_lmb *lmb)
-{
-	/*
-	 * Return the value of the lmb flags field minus the reserved
-	 * bit used internally for hotplug processing.
-	 */
-	return lmb->flags & ~DRMEM_LMB_RESERVED;
-}
-
-static struct property *clone_property(struct property *prop, u32 prop_sz)
-{
-	struct property *new_prop;
-
-	new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
-	if (!new_prop)
-		return NULL;
-
-	new_prop->name = kstrdup(prop->name, GFP_KERNEL);
-	new_prop->value = kzalloc(prop_sz, GFP_KERNEL);
-	if (!new_prop->name || !new_prop->value) {
-		kfree(new_prop->name);
-		kfree(new_prop->value);
-		kfree(new_prop);
-		return NULL;
-	}
-
-	new_prop->length = prop_sz;
-#if defined(CONFIG_OF_DYNAMIC)
-	of_property_set_flag(new_prop, OF_DYNAMIC);
-#endif
-	return new_prop;
-}
-
-static int drmem_update_dt_v1(struct device_node *memory,
-			      struct property *prop)
-{
-	struct property *new_prop;
-	struct of_drconf_cell_v1 *dr_cell;
-	struct drmem_lmb *lmb;
-	u32 *p;
-
-	new_prop = clone_property(prop, prop->length);
-	if (!new_prop)
-		return -1;
-
-	p = new_prop->value;
-	*p++ = cpu_to_be32(drmem_info->n_lmbs);
-
-	dr_cell = (struct of_drconf_cell_v1 *)p;
-
-	for_each_drmem_lmb(lmb) {
-		dr_cell->base_addr = cpu_to_be64(lmb->base_addr);
-		dr_cell->drc_index = cpu_to_be32(lmb->drc_index);
-		dr_cell->aa_index = cpu_to_be32(lmb->aa_index);
-		dr_cell->flags = cpu_to_be32(drmem_lmb_flags(lmb));
-
-		dr_cell++;
-	}
-
-	of_update_property(memory, new_prop);
-	return 0;
-}
-
-static void init_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
-				struct drmem_lmb *lmb)
-{
-	dr_cell->base_addr = cpu_to_be64(lmb->base_addr);
-	dr_cell->drc_index = cpu_to_be32(lmb->drc_index);
-	dr_cell->aa_index = cpu_to_be32(lmb->aa_index);
-	dr_cell->flags = cpu_to_be32(drmem_lmb_flags(lmb));
-}
-
-static int drmem_update_dt_v2(struct device_node *memory,
-			      struct property *prop)
-{
-	struct property *new_prop;
-	struct of_drconf_cell_v2 *dr_cell;
-	struct drmem_lmb *lmb, *prev_lmb;
-	u32 lmb_sets, prop_sz, seq_lmbs;
-	u32 *p;
-
-	/* First pass, determine how many LMB sets are needed. */
-	lmb_sets = 0;
-	prev_lmb = NULL;
-	for_each_drmem_lmb(lmb) {
-		if (!prev_lmb) {
-			prev_lmb = lmb;
-			lmb_sets++;
-			continue;
-		}
-
-		if (prev_lmb->aa_index != lmb->aa_index ||
-		    drmem_lmb_flags(prev_lmb) != drmem_lmb_flags(lmb))
-			lmb_sets++;
-
-		prev_lmb = lmb;
-	}
-
-	prop_sz = lmb_sets * sizeof(*dr_cell) + sizeof(__be32);
-	new_prop = clone_property(prop, prop_sz);
-	if (!new_prop)
-		return -1;
-
-	p = new_prop->value;
-	*p++ = cpu_to_be32(lmb_sets);
-
-	dr_cell = (struct of_drconf_cell_v2 *)p;
-
-	/* Second pass, populate the LMB set data */
-	prev_lmb = NULL;
-	seq_lmbs = 0;
-	for_each_drmem_lmb(lmb) {
-		if (prev_lmb == NULL) {
-			/* Start of first LMB set */
-			prev_lmb = lmb;
-			init_drconf_v2_cell(dr_cell, lmb);
-			seq_lmbs++;
-			continue;
-		}
-
-		if (prev_lmb->aa_index != lmb->aa_index ||
-		    drmem_lmb_flags(prev_lmb) != drmem_lmb_flags(lmb)) {
-			/* end of one set, start of another */
-			dr_cell->seq_lmbs = cpu_to_be32(seq_lmbs);
-			dr_cell++;
-
-			init_drconf_v2_cell(dr_cell, lmb);
-			seq_lmbs = 1;
-		} else {
-			seq_lmbs++;
-		}
-
-		prev_lmb = lmb;
-	}
-
-	/* close out last LMB set */
-	dr_cell->seq_lmbs = cpu_to_be32(seq_lmbs);
-	of_update_property(memory, new_prop);
-	return 0;
-}
-
-int drmem_update_dt(void)
-{
-	struct device_node *memory;
-	struct property *prop;
-	int rc = -1;
-
-	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (!memory)
-		return -1;
-
-	prop = of_find_property(memory, "ibm,dynamic-memory", NULL);
-	if (prop) {
-		rc = drmem_update_dt_v1(memory, prop);
-	} else {
-		prop = of_find_property(memory, "ibm,dynamic-memory-v2", NULL);
-		if (prop)
-			rc = drmem_update_dt_v2(memory, prop);
-	}
-
-	of_node_put(memory);
-	return rc;
-}
-
-static void __init read_drconf_v1_cell(struct drmem_lmb *lmb,
-				       const __be32 **prop)
-{
-	const __be32 *p = *prop;
-
-	lmb->base_addr = dt_mem_next_cell(dt_root_addr_cells, &p);
-	lmb->drc_index = of_read_number(p++, 1);
-
-	p++; /* skip reserved field */
-
-	lmb->aa_index = of_read_number(p++, 1);
-	lmb->flags = of_read_number(p++, 1);
-
-	*prop = p;
-}
-
-static void __init __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *usm,
-			void (*func)(struct drmem_lmb *, const __be32 **))
-{
-	struct drmem_lmb lmb;
-	u32 i, n_lmbs;
-
-	n_lmbs = of_read_number(prop++, 1);
-	if (n_lmbs == 0)
-		return;
-
-	for (i = 0; i < n_lmbs; i++) {
-		read_drconf_v1_cell(&lmb, &prop);
-		func(&lmb, &usm);
-	}
-}
-
-static void __init read_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
-				       const __be32 **prop)
-{
-	const __be32 *p = *prop;
-
-	dr_cell->seq_lmbs = of_read_number(p++, 1);
-	dr_cell->base_addr = dt_mem_next_cell(dt_root_addr_cells, &p);
-	dr_cell->drc_index = of_read_number(p++, 1);
-	dr_cell->aa_index = of_read_number(p++, 1);
-	dr_cell->flags = of_read_number(p++, 1);
-
-	*prop = p;
-}
-
-static void __init __walk_drmem_v2_lmbs(const __be32 *prop, const __be32 *usm,
-			void (*func)(struct drmem_lmb *, const __be32 **))
-{
-	struct of_drconf_cell_v2 dr_cell;
-	struct drmem_lmb lmb;
-	u32 i, j, lmb_sets;
-
-	lmb_sets = of_read_number(prop++, 1);
-	if (lmb_sets == 0)
-		return;
-
-	for (i = 0; i < lmb_sets; i++) {
-		read_drconf_v2_cell(&dr_cell, &prop);
-
-		for (j = 0; j < dr_cell.seq_lmbs; j++) {
-			lmb.base_addr = dr_cell.base_addr;
-			dr_cell.base_addr += drmem_lmb_size();
-
-			lmb.drc_index = dr_cell.drc_index;
-			dr_cell.drc_index++;
-
-			lmb.aa_index = dr_cell.aa_index;
-			lmb.flags = dr_cell.flags;
-
-			func(&lmb, &usm);
-		}
-	}
-}
-
-#ifdef CONFIG_PPC_PSERIES
-void __init walk_drmem_lmbs_early(unsigned long node,
-			void (*func)(struct drmem_lmb *, const __be32 **))
-{
-	const __be32 *prop, *usm;
-	int len;
-
-	prop = of_get_flat_dt_prop(node, "ibm,lmb-size", &len);
-	if (!prop || len < dt_root_size_cells * sizeof(__be32))
-		return;
-
-	drmem_info->lmb_size = dt_mem_next_cell(dt_root_size_cells, &prop);
-
-	usm = of_get_flat_dt_prop(node, "linux,drconf-usable-memory", &len);
-
-	prop = of_get_flat_dt_prop(node, "ibm,dynamic-memory", &len);
-	if (prop) {
-		__walk_drmem_v1_lmbs(prop, usm, func);
-	} else {
-		prop = of_get_flat_dt_prop(node, "ibm,dynamic-memory-v2",
-					   &len);
-		if (prop)
-			__walk_drmem_v2_lmbs(prop, usm, func);
-	}
-
-	memblock_dump_all();
-}
-
-#endif
-
-static int __init init_drmem_lmb_size(struct device_node *dn)
-{
-	const __be32 *prop;
-	int len;
-
-	if (drmem_info->lmb_size)
-		return 0;
-
-	prop = of_get_property(dn, "ibm,lmb-size", &len);
-	if (!prop || len < dt_root_size_cells * sizeof(__be32)) {
-		pr_info("Could not determine LMB size\n");
-		return -1;
-	}
-
-	drmem_info->lmb_size = dt_mem_next_cell(dt_root_size_cells, &prop);
-	return 0;
-}
-
-/*
- * Returns the property linux,drconf-usable-memory if
- * it exists (the property exists only in kexec/kdump kernels,
- * added by kexec-tools)
- */
-static const __be32 *of_get_usable_memory(struct device_node *dn)
-{
-	const __be32 *prop;
-	u32 len;
-
-	prop = of_get_property(dn, "linux,drconf-usable-memory", &len);
-	if (!prop || len < sizeof(unsigned int))
-		return NULL;
-
-	return prop;
-}
-
-void __init walk_drmem_lmbs(struct device_node *dn,
-			    void (*func)(struct drmem_lmb *, const __be32 **))
-{
-	const __be32 *prop, *usm;
-
-	if (init_drmem_lmb_size(dn))
-		return;
-
-	usm = of_get_usable_memory(dn);
-
-	prop = of_get_property(dn, "ibm,dynamic-memory", NULL);
-	if (prop) {
-		__walk_drmem_v1_lmbs(prop, usm, func);
-	} else {
-		prop = of_get_property(dn, "ibm,dynamic-memory-v2", NULL);
-		if (prop)
-			__walk_drmem_v2_lmbs(prop, usm, func);
-	}
-}
-
-static void __init init_drmem_v1_lmbs(const __be32 *prop)
-{
-	struct drmem_lmb *lmb;
-
-	drmem_info->n_lmbs = of_read_number(prop++, 1);
-	if (drmem_info->n_lmbs == 0)
-		return;
-
-	drmem_info->lmbs = kcalloc(drmem_info->n_lmbs, sizeof(*lmb),
-				   GFP_KERNEL);
-	if (!drmem_info->lmbs)
-		return;
-
-	for_each_drmem_lmb(lmb)
-		read_drconf_v1_cell(lmb, &prop);
-}
-
-static void __init init_drmem_v2_lmbs(const __be32 *prop)
-{
-	struct drmem_lmb *lmb;
-	struct of_drconf_cell_v2 dr_cell;
-	const __be32 *p;
-	u32 i, j, lmb_sets;
-	int lmb_index;
-
-	lmb_sets = of_read_number(prop++, 1);
-	if (lmb_sets == 0)
-		return;
-
-	/* first pass, calculate the number of LMBs */
-	p = prop;
-	for (i = 0; i < lmb_sets; i++) {
-		read_drconf_v2_cell(&dr_cell, &p);
-		drmem_info->n_lmbs += dr_cell.seq_lmbs;
-	}
-
-	drmem_info->lmbs = kcalloc(drmem_info->n_lmbs, sizeof(*lmb),
-				   GFP_KERNEL);
-	if (!drmem_info->lmbs)
-		return;
-
-	/* second pass, read in the LMB information */
-	lmb_index = 0;
-	p = prop;
-
-	for (i = 0; i < lmb_sets; i++) {
-		read_drconf_v2_cell(&dr_cell, &p);
-
-		for (j = 0; j < dr_cell.seq_lmbs; j++) {
-			lmb = &drmem_info->lmbs[lmb_index++];
-
-			lmb->base_addr = dr_cell.base_addr;
-			dr_cell.base_addr += drmem_info->lmb_size;
-
-			lmb->drc_index = dr_cell.drc_index;
-			dr_cell.drc_index++;
-
-			lmb->aa_index = dr_cell.aa_index;
-			lmb->flags = dr_cell.flags;
-		}
-	}
-}
-
-static int __init drmem_init(void)
-{
-	struct device_node *dn;
-	const __be32 *prop;
-
-	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (!dn) {
-		pr_info("No dynamic reconfiguration memory found\n");
-		return 0;
-	}
-
-	if (init_drmem_lmb_size(dn)) {
-		of_node_put(dn);
-		return 0;
-	}
-
-	prop = of_get_property(dn, "ibm,dynamic-memory", NULL);
-	if (prop) {
-		init_drmem_v1_lmbs(prop);
-	} else {
-		prop = of_get_property(dn, "ibm,dynamic-memory-v2", NULL);
-		if (prop)
-			init_drmem_v2_lmbs(prop);
-	}
-
-	of_node_put(dn);
-	return 0;
-}
-late_initcall(drmem_init);
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index a43ec84..4278690 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -6,7 +6,8 @@ obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
 			   of_helpers.o \
 			   setup.o iommu.o event_sources.o ras.o \
 			   firmware.o power.o dlpar.o mobility.o rng.o \
-			   pci.o pci_dlpar.o eeh_pseries.o msi.o
+			   pci.o pci_dlpar.o eeh_pseries.o msi.o \
+			   drmem.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
 obj-$(CONFIG_KEXEC_CORE)	+= kexec.o
diff --git a/arch/powerpc/platforms/pseries/drmem.c b/arch/powerpc/platforms/pseries/drmem.c
new file mode 100644
index 0000000..3f18036
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/drmem.c
@@ -0,0 +1,447 @@
+/*
+ * Dynamic reconfiguration memory support
+ *
+ * Copyright 2017 IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt) "drmem: " fmt
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/memblock.h>
+#include <asm/prom.h>
+#include <asm/drmem.h>
+
+static struct drmem_lmb_info __drmem_info;
+struct drmem_lmb_info *drmem_info = &__drmem_info;
+
+u64 drmem_lmb_memory_max(void)
+{
+	struct drmem_lmb *last_lmb;
+
+	last_lmb = &drmem_info->lmbs[drmem_info->n_lmbs - 1];
+	return last_lmb->base_addr + drmem_lmb_size();
+}
+
+static u32 drmem_lmb_flags(struct drmem_lmb *lmb)
+{
+	/*
+	 * Return the value of the lmb flags field minus the reserved
+	 * bit used internally for hotplug processing.
+	 */
+	return lmb->flags & ~DRMEM_LMB_RESERVED;
+}
+
+static struct property *clone_property(struct property *prop, u32 prop_sz)
+{
+	struct property *new_prop;
+
+	new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
+	if (!new_prop)
+		return NULL;
+
+	new_prop->name = kstrdup(prop->name, GFP_KERNEL);
+	new_prop->value = kzalloc(prop_sz, GFP_KERNEL);
+	if (!new_prop->name || !new_prop->value) {
+		kfree(new_prop->name);
+		kfree(new_prop->value);
+		kfree(new_prop);
+		return NULL;
+	}
+
+	new_prop->length = prop_sz;
+#if defined(CONFIG_OF_DYNAMIC)
+	of_property_set_flag(new_prop, OF_DYNAMIC);
+#endif
+	return new_prop;
+}
+
+static int drmem_update_dt_v1(struct device_node *memory,
+			      struct property *prop)
+{
+	struct property *new_prop;
+	struct of_drconf_cell_v1 *dr_cell;
+	struct drmem_lmb *lmb;
+	u32 *p;
+
+	new_prop = clone_property(prop, prop->length);
+	if (!new_prop)
+		return -1;
+
+	p = new_prop->value;
+	*p++ = cpu_to_be32(drmem_info->n_lmbs);
+
+	dr_cell = (struct of_drconf_cell_v1 *)p;
+
+	for_each_drmem_lmb(lmb) {
+		dr_cell->base_addr = cpu_to_be64(lmb->base_addr);
+		dr_cell->drc_index = cpu_to_be32(lmb->drc_index);
+		dr_cell->aa_index = cpu_to_be32(lmb->aa_index);
+		dr_cell->flags = cpu_to_be32(drmem_lmb_flags(lmb));
+
+		dr_cell++;
+	}
+
+	of_update_property(memory, new_prop);
+	return 0;
+}
+
+static void init_drconf_v2_cell(struct of_drconf_cell_v2 *dr_cell,
+				struct drmem_lmb *lmb)
+{
+	dr_cell->base_addr = cpu_to_be64(lmb->base_addr);
+	dr_cell->drc_index = cpu_to_be32(lmb->drc_index);
+	dr_cell->aa_index = cpu_to_be32(lmb->aa_index);
+	dr_cell->flags = cpu_to_be32(drmem_lmb_flags(lmb));
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
+		    drmem_lmb_flags(prev_lmb) != drmem_lmb_flags(lmb))
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
+		    drmem_lmb_flags(prev_lmb) != drmem_lmb_flags(lmb)) {
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
+int drmem_update_dt(void)
+{
+	struct device_node *memory;
+	struct property *prop;
+	int rc = -1;
+
+	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!memory)
+		return -1;
+
+	prop = of_find_property(memory, "ibm,dynamic-memory", NULL);
+	if (prop) {
+		rc = drmem_update_dt_v1(memory, prop);
+	} else {
+		prop = of_find_property(memory, "ibm,dynamic-memory-v2", NULL);
+		if (prop)
+			rc = drmem_update_dt_v2(memory, prop);
+	}
+
+	of_node_put(memory);
+	return rc;
+}
+
+static void __init read_drconf_v1_cell(struct drmem_lmb *lmb,
+				       const __be32 **prop)
+{
+	const __be32 *p = *prop;
+
+	lmb->base_addr = dt_mem_next_cell(dt_root_addr_cells, &p);
+	lmb->drc_index = of_read_number(p++, 1);
+
+	p++; /* skip reserved field */
+
+	lmb->aa_index = of_read_number(p++, 1);
+	lmb->flags = of_read_number(p++, 1);
+
+	*prop = p;
+}
+
+static void __init __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *usm,
+			void (*func)(struct drmem_lmb *, const __be32 **))
+{
+	struct drmem_lmb lmb;
+	u32 i, n_lmbs;
+
+	n_lmbs = of_read_number(prop++, 1);
+	if (n_lmbs == 0)
+		return;
+
+	for (i = 0; i < n_lmbs; i++) {
+		read_drconf_v1_cell(&lmb, &prop);
+		func(&lmb, &usm);
+	}
+}
+
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
+	if (lmb_sets == 0)
+		return;
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
+#ifdef CONFIG_PPC_PSERIES
+void __init walk_drmem_lmbs_early(unsigned long node,
+			void (*func)(struct drmem_lmb *, const __be32 **))
+{
+	const __be32 *prop, *usm;
+	int len;
+
+	prop = of_get_flat_dt_prop(node, "ibm,lmb-size", &len);
+	if (!prop || len < dt_root_size_cells * sizeof(__be32))
+		return;
+
+	drmem_info->lmb_size = dt_mem_next_cell(dt_root_size_cells, &prop);
+
+	usm = of_get_flat_dt_prop(node, "linux,drconf-usable-memory", &len);
+
+	prop = of_get_flat_dt_prop(node, "ibm,dynamic-memory", &len);
+	if (prop) {
+		__walk_drmem_v1_lmbs(prop, usm, func);
+	} else {
+		prop = of_get_flat_dt_prop(node, "ibm,dynamic-memory-v2",
+					   &len);
+		if (prop)
+			__walk_drmem_v2_lmbs(prop, usm, func);
+	}
+
+	memblock_dump_all();
+}
+
+#endif
+
+static int __init init_drmem_lmb_size(struct device_node *dn)
+{
+	const __be32 *prop;
+	int len;
+
+	if (drmem_info->lmb_size)
+		return 0;
+
+	prop = of_get_property(dn, "ibm,lmb-size", &len);
+	if (!prop || len < dt_root_size_cells * sizeof(__be32)) {
+		pr_info("Could not determine LMB size\n");
+		return -1;
+	}
+
+	drmem_info->lmb_size = dt_mem_next_cell(dt_root_size_cells, &prop);
+	return 0;
+}
+
+/*
+ * Returns the property linux,drconf-usable-memory if
+ * it exists (the property exists only in kexec/kdump kernels,
+ * added by kexec-tools)
+ */
+static const __be32 *of_get_usable_memory(struct device_node *dn)
+{
+	const __be32 *prop;
+	u32 len;
+
+	prop = of_get_property(dn, "linux,drconf-usable-memory", &len);
+	if (!prop || len < sizeof(unsigned int))
+		return NULL;
+
+	return prop;
+}
+
+void __init walk_drmem_lmbs(struct device_node *dn,
+			    void (*func)(struct drmem_lmb *, const __be32 **))
+{
+	const __be32 *prop, *usm;
+
+	if (init_drmem_lmb_size(dn))
+		return;
+
+	usm = of_get_usable_memory(dn);
+
+	prop = of_get_property(dn, "ibm,dynamic-memory", NULL);
+	if (prop) {
+		__walk_drmem_v1_lmbs(prop, usm, func);
+	} else {
+		prop = of_get_property(dn, "ibm,dynamic-memory-v2", NULL);
+		if (prop)
+			__walk_drmem_v2_lmbs(prop, usm, func);
+	}
+}
+
+static void __init init_drmem_v1_lmbs(const __be32 *prop)
+{
+	struct drmem_lmb *lmb;
+
+	drmem_info->n_lmbs = of_read_number(prop++, 1);
+	if (drmem_info->n_lmbs == 0)
+		return;
+
+	drmem_info->lmbs = kcalloc(drmem_info->n_lmbs, sizeof(*lmb),
+				   GFP_KERNEL);
+	if (!drmem_info->lmbs)
+		return;
+
+	for_each_drmem_lmb(lmb)
+		read_drconf_v1_cell(lmb, &prop);
+}
+
+static void __init init_drmem_v2_lmbs(const __be32 *prop)
+{
+	struct drmem_lmb *lmb;
+	struct of_drconf_cell_v2 dr_cell;
+	const __be32 *p;
+	u32 i, j, lmb_sets;
+	int lmb_index;
+
+	lmb_sets = of_read_number(prop++, 1);
+	if (lmb_sets == 0)
+		return;
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
+static int __init drmem_init(void)
+{
+	struct device_node *dn;
+	const __be32 *prop;
+
+	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!dn) {
+		pr_info("No dynamic reconfiguration memory found\n");
+		return 0;
+	}
+
+	if (init_drmem_lmb_size(dn)) {
+		of_node_put(dn);
+		return 0;
+	}
+
+	prop = of_get_property(dn, "ibm,dynamic-memory", NULL);
+	if (prop) {
+		init_drmem_v1_lmbs(prop);
+	} else {
+		prop = of_get_property(dn, "ibm,dynamic-memory-v2", NULL);
+		if (prop)
+			init_drmem_v2_lmbs(prop);
+	}
+
+	of_node_put(dn);
+	return 0;
+}
+late_initcall(drmem_init);

