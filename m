Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24A0C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 09:46:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722312098A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 09:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722312098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qp1m3W63zF3Jn
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 19:46:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=yuehaibing@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Qnw13j5xzF3Jm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 19:41:36 +1000 (AEST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 894534268DD10;
 Thu,  4 Oct 2018 17:41:31 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Thu, 4 Oct 2018
 17:41:22 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <nfont@linux.vnet.ibm.com>
Subject: [PATCH v2 -next] powerpc/pseries/memory-hotplug: Fix return value
 type of find_aa_index
Date: Thu, 4 Oct 2018 17:41:13 +0800
Message-ID: <20181004094113.5492-1-yuehaibing@huawei.com>
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
may return -1 when dlpar_clone_property fails. So we use an rc
value to track the validation of finding the aa_index instead
of the 'aa_index' value itself

Fixes: c05a5a40969e ("powerpc/pseries: Dynamic add entires to associativity lookup array")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: use 'rc' track the validation of aa_index
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 9a15d39..796e68b 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -101,13 +101,12 @@ static struct property *dlpar_clone_property(struct property *prop,
 	return new_prop;
 }
 
-static u32 find_aa_index(struct device_node *dr_node,
-			 struct property *ala_prop, const u32 *lmb_assoc)
+static int find_aa_index(struct device_node *dr_node, struct property *ala_prop,
+			 const u32 *lmb_assoc, u32 *aa_index)
 {
 	u32 *assoc_arrays;
-	u32 aa_index;
 	int aa_arrays, aa_array_entries, aa_array_sz;
-	int i, index;
+	int i, index, rc = -1;
 
 	/*
 	 * The ibm,associativity-lookup-arrays property is defined to be
@@ -121,18 +120,18 @@ static u32 find_aa_index(struct device_node *dr_node,
 	aa_array_entries = be32_to_cpu(assoc_arrays[1]);
 	aa_array_sz = aa_array_entries * sizeof(u32);
 
-	aa_index = -1;
 	for (i = 0; i < aa_arrays; i++) {
 		index = (i * aa_array_entries) + 2;
 
 		if (memcmp(&assoc_arrays[index], &lmb_assoc[1], aa_array_sz))
 			continue;
 
-		aa_index = i;
+		*aa_index = i;
+		rc = 0;
 		break;
 	}
 
-	if (aa_index == -1) {
+	if (rc == -1) {
 		struct property *new_prop;
 		u32 new_prop_size;
 
@@ -157,10 +156,11 @@ static u32 find_aa_index(struct device_node *dr_node,
 		 * number of entries - 1 since we added its associativity
 		 * to the end of the lookup array.
 		 */
-		aa_index = be32_to_cpu(assoc_arrays[0]) - 1;
+		*aa_index = be32_to_cpu(assoc_arrays[0]) - 1;
+		rc = 0;
 	}
 
-	return aa_index;
+	return rc;
 }
 
 static int update_lmb_associativity_index(struct drmem_lmb *lmb)
@@ -169,6 +169,7 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
 	struct property *ala_prop;
 	const u32 *lmb_assoc;
 	u32 aa_index;
+	int rc;
 
 	parent = of_find_node_by_path("/");
 	if (!parent)
@@ -200,11 +201,11 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
 		return -ENODEV;
 	}
 
-	aa_index = find_aa_index(dr_node, ala_prop, lmb_assoc);
+	rc = find_aa_index(dr_node, ala_prop, lmb_assoc, &aa_index);
 
 	dlpar_free_cc_nodes(lmb_node);
 
-	if (aa_index < 0) {
+	if (rc < 0) {
 		pr_err("Could not find LMB associativity\n");
 		return -1;
 	}
-- 
2.7.0


