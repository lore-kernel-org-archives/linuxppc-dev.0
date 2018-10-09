Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F21EC64EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 16:00:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0138220841
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 16:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0138220841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V2520xttzF3NS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 03:00:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=yuehaibing@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TzSh4lJqzF1RG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 01:02:28 +1100 (AEDT)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3350075B0C332;
 Tue,  9 Oct 2018 22:02:23 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Tue, 9 Oct 2018
 22:02:14 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <nfont@linux.vnet.ibm.com>
Subject: [PATCH v3 -next] powerpc/pseries/memory-hotplug: Fix return value
 type of find_aa_index
Date: Tue, 9 Oct 2018 21:59:13 +0800
Message-ID: <20181009135913.14616-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
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
Cc: YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

'aa_index' is defined as an unsigned value, but find_aa_index
may return -1 when dlpar_clone_property fails. So change 
find_aa_index return value type to bool, which indicate 'aa_index'
whether found or not.

Fixes: c05a5a40969e ("powerpc/pseries: Dynamic add entires to associativity lookup array")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v3: change find_aa_index return type to bool
v2: use 'rc' track the validation of aa_index
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 61 ++++++++++++-------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index d26a771..4db510f 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -101,11 +101,12 @@ static struct property *dlpar_clone_property(struct property *prop,
 	return new_prop;
 }
 
-static u32 find_aa_index(struct device_node *dr_node,
-			 struct property *ala_prop, const u32 *lmb_assoc)
+static bool find_aa_index(struct device_node *dr_node,
+			 struct property *ala_prop,
+			 const u32 *lmb_assoc, u32 *aa_index)
 {
-	u32 *assoc_arrays;
-	u32 aa_index;
+	u32 *assoc_arrays, new_prop_size;
+	struct property *new_prop;
 	int aa_arrays, aa_array_entries, aa_array_sz;
 	int i, index;
 
@@ -121,46 +122,39 @@ static u32 find_aa_index(struct device_node *dr_node,
 	aa_array_entries = be32_to_cpu(assoc_arrays[1]);
 	aa_array_sz = aa_array_entries * sizeof(u32);
 
-	aa_index = -1;
 	for (i = 0; i < aa_arrays; i++) {
 		index = (i * aa_array_entries) + 2;
 
 		if (memcmp(&assoc_arrays[index], &lmb_assoc[1], aa_array_sz))
 			continue;
 
-		aa_index = i;
-		break;
+		*aa_index = i;
+		return true;
 	}
 
-	if (aa_index == -1) {
-		struct property *new_prop;
-		u32 new_prop_size;
-
-		new_prop_size = ala_prop->length + aa_array_sz;
-		new_prop = dlpar_clone_property(ala_prop, new_prop_size);
-		if (!new_prop)
-			return -1;
-
-		assoc_arrays = new_prop->value;
+	new_prop_size = ala_prop->length + aa_array_sz;
+	new_prop = dlpar_clone_property(ala_prop, new_prop_size);
+	if (!new_prop)
+		return false;
 
-		/* increment the number of entries in the lookup array */
-		assoc_arrays[0] = cpu_to_be32(aa_arrays + 1);
+	assoc_arrays = new_prop->value;
 
-		/* copy the new associativity into the lookup array */
-		index = aa_arrays * aa_array_entries + 2;
-		memcpy(&assoc_arrays[index], &lmb_assoc[1], aa_array_sz);
+	/* increment the number of entries in the lookup array */
+	assoc_arrays[0] = cpu_to_be32(aa_arrays + 1);
 
-		of_update_property(dr_node, new_prop);
+	/* copy the new associativity into the lookup array */
+	index = aa_arrays * aa_array_entries + 2;
+	memcpy(&assoc_arrays[index], &lmb_assoc[1], aa_array_sz);
 
-		/*
-		 * The associativity lookup array index for this lmb is
-		 * number of entries - 1 since we added its associativity
-		 * to the end of the lookup array.
-		 */
-		aa_index = be32_to_cpu(assoc_arrays[0]) - 1;
-	}
+	of_update_property(dr_node, new_prop);
 
-	return aa_index;
+	/*
+	 * The associativity lookup array index for this lmb is
+	 * number of entries - 1 since we added its associativity
+	 * to the end of the lookup array.
+	 */
+	*aa_index = be32_to_cpu(assoc_arrays[0]) - 1;
+	return true;
 }
 
 static int update_lmb_associativity_index(struct drmem_lmb *lmb)
@@ -169,6 +163,7 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
 	struct property *ala_prop;
 	const u32 *lmb_assoc;
 	u32 aa_index;
+	bool is_found;
 
 	parent = of_find_node_by_path("/");
 	if (!parent)
@@ -200,11 +195,11 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
 		return -ENODEV;
 	}
 
-	aa_index = find_aa_index(dr_node, ala_prop, lmb_assoc);
+	is_found = find_aa_index(dr_node, ala_prop, lmb_assoc, &aa_index);
 
 	dlpar_free_cc_nodes(lmb_node);
 
-	if (aa_index < 0) {
+	if (!is_found) {
 		pr_err("Could not find LMB associativity\n");
 		return -1;
 	}
-- 
2.7.0


