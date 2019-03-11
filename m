Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EA1C10F06
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 14:15:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CADD62075C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 14:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="pc1kZ9xX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADD62075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44J0VZ4BsFzDqKy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 01:15:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="pc1kZ9xX"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HzXl0hJkzDqF3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 00:31:50 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 5D71041988;
 Mon, 11 Mar 2019 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1552311103; x=1554125504; bh=MjIvT+kNNwGlIGwMxKj5uZhAYpA426wYUCt
 RLWth4v4=; b=pc1kZ9xXkA/eLuPWaDBEph52JVTsWQ1sp+hDa9pa92G44joqlqj
 Gg/4Rh8kMMk6s8ovNf0AMJ2OlRu1jeA2ipb1yIJpqg1PZI1qnzjCJ5jCPKDUqrR/
 0hGOQKv0orw9XiJ/Xq/2KV1JDwNcl7fUShywHwobYGQqdpzaL9nO4puU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n-xtV4EdcOCb; Mon, 11 Mar 2019 16:31:43 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 3AE57419EB;
 Mon, 11 Mar 2019 16:31:34 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Mar 2019 16:31:33 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH RFC v4 19/21] PCI: Prioritize fixed BAR assigning over the
 movable ones
Date: Mon, 11 Mar 2019 16:31:20 +0300
Message-ID: <20190311133122.11417-20-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
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
Cc: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The allocated bridge windows are big enough to house all the children
bridges and BARs, but the fixed resources must be assigned first, so the
movable ones later divide the rest of the window. That's the assignment
order:

 1. Bridge windows with fixed areas;
 2. Fixed BARs;
 3. The rest of BARs and bridge windows.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 69 ++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f4737339d5ec..932a6c020d10 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -272,31 +272,54 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 	}
 }
 
-/**
- * assign_requested_resources_sorted() - satisfy resource requests
- *
- * @head : head of the list tracking requests for resources
- * @fail_head : head of the list tracking requests that could
- *		not be allocated
- *
- * Satisfy resource requests of each element in the list. Add
- * requests that could not satisfied to the failed_list.
- */
-static void assign_requested_resources_sorted(struct list_head *head,
-				 struct list_head *fail_head)
+enum assign_step {
+	assign_fixed_bridge_windows,
+	assign_fixed_resources,
+	assign_float_resources,
+};
+
+static void _assign_requested_resources_sorted(struct list_head *head,
+					       struct list_head *fail_head,
+					       enum assign_step step)
 {
 	struct resource *res;
 	struct pci_dev_resource *dev_res;
 	int idx;
 
 	list_for_each_entry(dev_res, head, list) {
+		bool is_fixed;
+		bool is_fixed_bridge;
+		bool is_bridge;
+
 		if (pci_dev_is_ignored(dev_res->dev))
 			continue;
 
 		res = dev_res->res;
+		if (!resource_size(res))
+			continue;
+
 		idx = res - &dev_res->dev->resource[0];
-		if (resource_size(res) &&
-		    pci_assign_resource(dev_res->dev, idx)) {
+		is_fixed = res->flags & IORESOURCE_PCI_FIXED;
+		is_bridge = dev_res->dev->subordinate && idx >= PCI_BRIDGE_RESOURCES;
+
+		if (is_bridge) {
+			struct pci_bus *child = dev_res->dev->subordinate;
+			int b_res_idx = pci_get_bridge_resource_idx(res);
+			struct resource *fixed_res = &child->fixed_range_hard[b_res_idx];
+
+			is_fixed_bridge = fixed_res->start < fixed_res->end;
+		} else {
+			is_fixed_bridge = false;
+		}
+
+		if (assign_fixed_bridge_windows == step && !is_fixed_bridge)
+			continue;
+		else if (assign_fixed_resources == step && (!is_fixed || is_bridge))
+			continue;
+		else if (assign_float_resources == step && (is_fixed || is_fixed_bridge))
+			continue;
+
+		if (pci_assign_resource(dev_res->dev, idx)) {
 			if (fail_head) {
 				/*
 				 * if the failed res is for ROM BAR, and it will
@@ -315,6 +338,24 @@ static void assign_requested_resources_sorted(struct list_head *head,
 	}
 }
 
+/**
+ * assign_requested_resources_sorted() - satisfy resource requests
+ *
+ * @head : head of the list tracking requests for resources
+ * @fail_head : head of the list tracking requests that could
+ *		not be allocated
+ *
+ * Satisfy resource requests of each element in the list. Add
+ * requests that could not satisfied to the failed_list.
+ */
+static void assign_requested_resources_sorted(struct list_head *head,
+					      struct list_head *fail_head)
+{
+	_assign_requested_resources_sorted(head, fail_head, assign_fixed_bridge_windows);
+	_assign_requested_resources_sorted(head, fail_head, assign_fixed_resources);
+	_assign_requested_resources_sorted(head, fail_head, assign_float_resources);
+}
+
 static unsigned long pci_fail_res_type_mask(struct list_head *fail_head)
 {
 	struct pci_dev_resource *fail_res;
-- 
2.20.1

