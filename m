Return-Path: <SRS0=YAae=SJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C76C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 13:24:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BB320693
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 13:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BB320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44cZ5F6jK3zDqD4
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 23:24:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44cYj10rF5zDqKP
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Apr 2019 23:06:29 +1000 (AEST)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id F10F0DBC74379D487DB9;
 Sun,  7 Apr 2019 20:48:10 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Sun, 7 Apr 2019 20:48:03 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, John Garry
 <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon
 <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc <linux-doc@vger.kernel.org>, Sebastian Ott
 <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 "Martin Schwidefsky" <schwidefsky@de.ibm.com>, Heiko Carstens
 <heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu
 <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin"
 <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, x86 <x86@kernel.org>,
 linux-ia64 <linux-ia64@vger.kernel.org>
Subject: [PATCH v4 3/6] iommu: add iommu_default_dma_mode_get() helper
Date: Sun, 7 Apr 2019 20:41:44 +0800
Message-ID: <20190407124147.13576-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20190407124147.13576-1-thunder.leizhen@huawei.com>
References: <20190407124147.13576-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Sun, 07 Apr 2019 23:15:08 +1000
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
Cc: Hanjun Guo <guohanjun@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add IOMMU_DMA_MODE_IS_LAZY() and IOMMU_DMA_MODE_IS_PASSTHROUGH() to make
the code looks cleaner.

There is no functional change, just prepare for the following patches.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/iommu.c | 12 ++++++++----
 include/linux/iommu.h | 11 +++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b75e23a2ea08da8..876c0966db2481a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -168,6 +168,11 @@ static int __init iommu_dma_mode_setup(char *str)
 }
 early_param("iommu.dma_mode", iommu_dma_mode_setup);
 
+int iommu_default_dma_mode_get(void)
+{
+	return iommu_default_dma_mode;
+}
+
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
 {
@@ -1109,9 +1114,8 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	 */
 	if (!group->default_domain) {
 		struct iommu_domain *dom;
-		int def_domain_type =
-			(iommu_default_dma_mode == IOMMU_DMA_MODE_PASSTHROUGH)
-			? IOMMU_DOMAIN_IDENTITY : IOMMU_DOMAIN_DMA;
+		int def_domain_type = IOMMU_DMA_MODE_IS_PASSTHROUGH() \
+				? IOMMU_DOMAIN_IDENTITY : IOMMU_DOMAIN_DMA;
 
 		dom = __iommu_domain_alloc(dev->bus, def_domain_type);
 		if (!dom && def_domain_type != IOMMU_DOMAIN_DMA) {
@@ -1127,7 +1131,7 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 		if (!group->domain)
 			group->domain = dom;
 
-		if (dom && (iommu_default_dma_mode == IOMMU_DMA_MODE_LAZY)) {
+		if (dom && IOMMU_DMA_MODE_IS_LAZY()) {
 			int attr = 1;
 			iommu_domain_set_attr(dom,
 					      DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c3f4e3416176496..1b35ae3f6382e4a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -46,6 +46,10 @@
 #define IOMMU_DMA_MODE_STRICT		0x0
 #define IOMMU_DMA_MODE_LAZY		0x1
 #define IOMMU_DMA_MODE_PASSTHROUGH	0x2
+#define IOMMU_DMA_MODE_IS_LAZY() \
+		(iommu_default_dma_mode_get() == IOMMU_DMA_MODE_LAZY)
+#define IOMMU_DMA_MODE_IS_PASSTHROUGH() \
+		(iommu_default_dma_mode_get() == IOMMU_DMA_MODE_PASSTHROUGH)
 
 struct iommu_ops;
 struct iommu_group;
@@ -421,6 +425,8 @@ static inline void dev_iommu_fwspec_set(struct device *dev,
 int iommu_probe_device(struct device *dev);
 void iommu_release_device(struct device *dev);
 
+extern int iommu_default_dma_mode_get(void);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -705,6 +711,11 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static inline int iommu_default_dma_mode_get(void)
+{
+	return IOMMU_DMA_MODE_PASSTHROUGH;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
-- 
1.8.3


