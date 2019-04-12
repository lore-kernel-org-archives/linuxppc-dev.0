Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE1BC10F14
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 19:02:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6543C20818
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 19:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6543C20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gnM50BnszDq8g
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 05:02:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=robin.murphy@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44gnFf6V7wzDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2019 04:57:26 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1658C1682;
 Fri, 12 Apr 2019 11:57:25 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D7253F718;
 Fri, 12 Apr 2019 11:57:23 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH 2/3] mm: clean up is_device_*_page() definitions
Date: Fri, 12 Apr 2019 19:56:01 +0100
Message-Id: <2adb3982a790078fe49fd454414a7b9c0fd60bcb.1555093412.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1555093412.git.robin.murphy@arm.com>
References: <cover.1555093412.git.robin.murphy@arm.com>
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
Cc: anshuman.khandual@arm.com, linuxppc-dev@lists.ozlabs.org, ohall@gmail.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, jglisse@redhat.com,
 dan.j.williams@intel.com, ira.weiny@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Refactor is_device_{public,private}_page() with is_pci_p2pdma_page()
to make them all consistent in depending on their respective config
options even when CONFIG_DEV_PAGEMAP_OPS is enabled for other reasons.
This allows a little more compile-time optimisation as well as the
conceptual and cosmetic cleanup.

Suggested-by: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/mm.h | 43 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 76769749b5a5..d76dfb7ac617 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -910,32 +910,6 @@ static inline bool put_devmap_managed_page(struct page *page)
 	}
 	return false;
 }
-
-static inline bool is_device_private_page(const struct page *page)
-{
-	return is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
-}
-
-static inline bool is_device_public_page(const struct page *page)
-{
-	return is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PUBLIC;
-}
-
-#ifdef CONFIG_PCI_P2PDMA
-static inline bool is_pci_p2pdma_page(const struct page *page)
-{
-	return is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
-}
-#else /* CONFIG_PCI_P2PDMA */
-static inline bool is_pci_p2pdma_page(const struct page *page)
-{
-	return false;
-}
-#endif /* CONFIG_PCI_P2PDMA */
-
 #else /* CONFIG_DEV_PAGEMAP_OPS */
 static inline void dev_pagemap_get_ops(void)
 {
@@ -949,22 +923,31 @@ static inline bool put_devmap_managed_page(struct page *page)
 {
 	return false;
 }
+#endif /* CONFIG_DEV_PAGEMAP_OPS */
 
 static inline bool is_device_private_page(const struct page *page)
 {
-	return false;
+	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
+		IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
+		is_zone_device_page(page) &&
+		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
 }
 
 static inline bool is_device_public_page(const struct page *page)
 {
-	return false;
+	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
+		IS_ENABLED(CONFIG_DEVICE_PUBLIC) &&
+		is_zone_device_page(page) &&
+		page->pgmap->type == MEMORY_DEVICE_PUBLIC;
 }
 
 static inline bool is_pci_p2pdma_page(const struct page *page)
 {
-	return false;
+	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
+		IS_ENABLED(CONFIG_PCI_P2PDMA) &&
+		is_zone_device_page(page) &&
+		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
 }
-#endif /* CONFIG_DEV_PAGEMAP_OPS */
 
 static inline void get_page(struct page *page)
 {
-- 
2.21.0.dirty

