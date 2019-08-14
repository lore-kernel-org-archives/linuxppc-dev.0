Return-Path: <SRS0=FJcg=WK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B284C0650F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 08:31:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A3020843
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 08:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="hNrUJiUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A3020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 467jTk61SCzDql5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 18:31:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=fossix.org
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=santosh@fossix.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=fossix-org.20150623.gappssmtp.com
 header.i=@fossix-org.20150623.gappssmtp.com header.b="hNrUJiUv"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 467jLt6nQpzDqNj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2019 18:25:10 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id f17so49151913pfn.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2019 01:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fossix-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VnrvH0lLRSjFBd5z7+N/MSRnWflXEihHjlpyfnMoUzY=;
 b=hNrUJiUvaMTAcdels7iiLMFrprxq1oiCJbWQj8ULSZLlA0NLFFBp+SftwjhhSRBQHv
 Ey/ZbP1ugyzdOWgDFkZeEOxh9L7bG46PDLZML2GQbOZB3ryhOq2DcWzjXlbvtO6cHp+J
 U9heZaL3xvfgWKFnY51QzKMifewK0LkmLIO6KjI2a4ZwoU83HHpxunk+a/j8RZF7F/km
 +RdhUc/oAB8xbCbXcMPiY5FmxQbPeB1O3OXjRsFpVgBZFkIKZwMV4SlLvC1ehaAkXId9
 RbNH+02TYugTjSn+4/r50MCLcJmSmbtLsoPm76XA55dWU1okDYjDba378V4vrPBmipQR
 Asdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VnrvH0lLRSjFBd5z7+N/MSRnWflXEihHjlpyfnMoUzY=;
 b=gPf3VOzy3XtWtNmjMoYWYeiCtOVGUfdz3g/1OsMx/6uD/3LrLXqmNGvdDJQFsa0N+k
 XGcDP91lJo8aTtBIbZZscP1OZc2q9rMEOWNYnnVy106T7jFWJqyAqQDDkP3nVef3a/x7
 qOrjwmOXeTK+fu6J1DIyOhEIaN8mjkkzR2KXbWgFLJnd0FYQGSRqzMjAr/Xxho9j1nUe
 kIbXDnlZ6S0WeU1hukPD4c1v8sRePIM7Ly4SxclF2kTIAKg1ijqVhJ3kEj0dsjvxmLGq
 bMavi/+sVlDQgE9wTE8gPseuRWX43dC938/45ghkxsOUNjrjMyRSeMHcXg73FQjeyBO4
 im3A==
X-Gm-Message-State: APjAAAXAi7zgWujresexziplZJaR11+RO/PwLUS3A0gFwrfgXWm1WC/L
 EhBIjIuHx/xysk98lcvufxT2G7/L8wQ=
X-Google-Smtp-Source: APXvYqySuMN3JpDlUbkMpJdei0+46wEIutTmNDRnJ6HJb8mXDJuRS8iMw5Xdv68gXgGlrE7VUpQx8A==
X-Received: by 2002:a65:63c4:: with SMTP id n4mr37423412pgv.44.1565771108004; 
 Wed, 14 Aug 2019 01:25:08 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.76])
 by smtp.gmail.com with ESMTPSA id y194sm124672463pfg.116.2019.08.14.01.25.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 14 Aug 2019 01:25:07 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/3] of_pmem: Add memory ranges which took a mce to bad range
Date: Wed, 14 Aug 2019 13:54:51 +0530
Message-Id: <20190814082452.28013-3-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814082452.28013-1-santosh@fossix.org>
References: <20190814082452.28013-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Chandan Rajendra <chandan@linux.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Subscribe to the MCE notification and add the physical address which
generated a memory error to nvdimm bad range.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 drivers/nvdimm/of_pmem.c | 122 +++++++++++++++++++++++++++++++++------
 1 file changed, 103 insertions(+), 19 deletions(-)

diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index a0c8dcfa0bf9..828dbfe44ca6 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -8,6 +8,9 @@
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/nd.h>
+#include <asm/mce.h>
 
 static const struct attribute_group *region_attr_groups[] = {
 	&nd_region_attribute_group,
@@ -25,11 +28,77 @@ struct of_pmem_private {
 	struct nvdimm_bus *bus;
 };
 
+struct of_pmem_region {
+	struct of_pmem_private *priv;
+	struct nd_region_desc *region_desc;
+	struct nd_region *region;
+	struct list_head list;
+};
+
+LIST_HEAD(pmem_regions);
+DEFINE_MUTEX(pmem_region_lock);
+
+static int handle_mce_ue(struct notifier_block *nb, unsigned long val,
+			 void *data)
+{
+	struct machine_check_event *evt = data;
+	struct of_pmem_region *pmem_region;
+	u64 phys_addr;
+
+	if (evt->error_type != MCE_ERROR_TYPE_UE)
+		return NOTIFY_DONE;
+
+	if (list_empty(&pmem_regions))
+		return NOTIFY_DONE;
+
+	phys_addr = evt->u.ue_error.physical_address +
+		(evt->u.ue_error.effective_address & ~PAGE_MASK);
+
+	if (!evt->u.ue_error.physical_address_provided ||
+	    !is_zone_device_page(pfn_to_page(phys_addr >> PAGE_SHIFT)))
+		return NOTIFY_DONE;
+
+	mutex_lock(&pmem_region_lock);
+	list_for_each_entry(pmem_region, &pmem_regions, list) {
+		struct resource *res = pmem_region->region_desc->res;
+		u64 aligned_addr;
+
+		if (res->start > phys_addr)
+			continue;
+
+		if (res->end < phys_addr)
+			continue;
+
+		aligned_addr = ALIGN_DOWN(phys_addr, L1_CACHE_BYTES);
+		pr_debug("Add memory range (0x%llx -- 0x%llx) as bad range\n",
+			 aligned_addr, aligned_addr + L1_CACHE_BYTES);
+
+		if (nvdimm_bus_add_badrange(pmem_region->priv->bus,
+					     aligned_addr, L1_CACHE_BYTES))
+			pr_warn("Failed to add bad range (0x%llx -- 0x%llx)\n",
+				aligned_addr, aligned_addr + L1_CACHE_BYTES);
+
+		nvdimm_region_notify(pmem_region->region,
+				     NVDIMM_REVALIDATE_POISON);
+
+		break;
+	}
+	mutex_unlock(&pmem_region_lock);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block mce_ue_nb = {
+	.notifier_call = handle_mce_ue
+};
+
 static int of_pmem_region_probe(struct platform_device *pdev)
 {
 	struct of_pmem_private *priv;
 	struct device_node *np;
 	struct nvdimm_bus *bus;
+	struct of_pmem_region *pmem_region;
+	struct nd_region_desc *ndr_desc;
 	bool is_volatile;
 	int i;
 
@@ -58,34 +127,49 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 			is_volatile ? "volatile" : "non-volatile",  np);
 
 	for (i = 0; i < pdev->num_resources; i++) {
-		struct nd_region_desc ndr_desc;
 		struct nd_region *region;
 
-		/*
-		 * NB: libnvdimm copies the data from ndr_desc into it's own
-		 * structures so passing a stack pointer is fine.
-		 */
-		memset(&ndr_desc, 0, sizeof(ndr_desc));
-		ndr_desc.attr_groups = region_attr_groups;
-		ndr_desc.numa_node = dev_to_node(&pdev->dev);
-		ndr_desc.target_node = ndr_desc.numa_node;
-		ndr_desc.res = &pdev->resource[i];
-		ndr_desc.of_node = np;
-		set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
+		ndr_desc = kzalloc(sizeof(struct nd_region_desc), GFP_KERNEL);
+		if (!ndr_desc) {
+			nvdimm_bus_unregister(priv->bus);
+			kfree(priv);
+			return -ENOMEM;
+		}
+
+		ndr_desc->attr_groups = region_attr_groups;
+		ndr_desc->numa_node = dev_to_node(&pdev->dev);
+		ndr_desc->target_node = ndr_desc->numa_node;
+		ndr_desc->res = &pdev->resource[i];
+		ndr_desc->of_node = np;
+		set_bit(ND_REGION_PAGEMAP, &ndr_desc->flags);
 
 		if (is_volatile)
-			region = nvdimm_volatile_region_create(bus, &ndr_desc);
+			region = nvdimm_volatile_region_create(bus, ndr_desc);
 		else
-			region = nvdimm_pmem_region_create(bus, &ndr_desc);
+			region = nvdimm_pmem_region_create(bus, ndr_desc);
 
 		if (!region)
-			dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
-					ndr_desc.res, np);
-		else
-			dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
-					ndr_desc.res, np);
+			continue;
+
+		dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
+			ndr_desc->res, np);
+
+		pmem_region = kzalloc(sizeof(struct of_pmem_region),
+				      GFP_KERNEL);
+		if (!pmem_region)
+			continue;
+
+		pmem_region->region_desc = ndr_desc;
+		pmem_region->region = region;
+		pmem_region->priv = priv;
+
+		/* Save regions registered for use by the notification code */
+		mutex_lock(&pmem_region_lock);
+		list_add_tail(&pmem_region->list, &pmem_regions);
+		mutex_unlock(&pmem_region_lock);
 	}
 
+	mce_register_notifier(&mce_ue_nb);
 	return 0;
 }
 
-- 
2.21.0

