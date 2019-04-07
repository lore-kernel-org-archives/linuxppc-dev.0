Return-Path: <SRS0=YAae=SJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6406C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 13:19:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FAF213F2
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 13:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FAF213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44cZ043H1jzDqLC
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 23:19:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
X-Greylist: delayed 942 seconds by postgrey-1.36 at bilbo;
 Sun, 07 Apr 2019 23:04:04 AEST
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44cYfD4X1lzDqKP
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Apr 2019 23:04:03 +1000 (AEST)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D94DA2587E4ADED563FF;
 Sun,  7 Apr 2019 20:48:10 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Sun, 7 Apr 2019 20:48:04 +0800
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
Subject: [PATCH v4 4/6] s390/pci: use common boot option iommu.dma_mode
Date: Sun, 7 Apr 2019 20:41:45 +0800
Message-ID: <20190407124147.13576-5-thunder.leizhen@huawei.com>
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

s390_iommu=strict can be replaced with iommu.dma_mode=strict.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 -------
 arch/s390/pci/pci_dma.c                         | 20 +++++---------------
 drivers/iommu/Kconfig                           |  1 +
 3 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 60409ad23b2ac8b..a2df11945b33fc9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4095,13 +4095,6 @@
 
 	S		[KNL] Run init in single mode
 
-	s390_iommu=	[HW,S390]
-			Set s390 IOTLB flushing mode
-		strict
-			With strict flushing every unmap operation will result in
-			an IOTLB flush. Default is lazy flushing before reuse,
-			which is faster.
-
 	sa1100ir	[NET]
 			See drivers/net/irda/sa1100_ir.c.
 
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 9e52d1527f71495..6f1615c16f33995 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -17,7 +17,6 @@
 
 static struct kmem_cache *dma_region_table_cache;
 static struct kmem_cache *dma_page_table_cache;
-static int s390_iommu_strict;
 
 static int zpci_refresh_global(struct zpci_dev *zdev)
 {
@@ -193,13 +192,13 @@ static int __dma_purge_tlb(struct zpci_dev *zdev, dma_addr_t dma_addr,
 		if (!zdev->tlb_refresh)
 			return 0;
 	} else {
-		if (!s390_iommu_strict)
+		if (IOMMU_DMA_MODE_IS_LAZY())
 			return 0;
 	}
 
 	ret = zpci_refresh_trans((u64) zdev->fh << 32, dma_addr,
 				 PAGE_ALIGN(size));
-	if (ret == -ENOMEM && !s390_iommu_strict) {
+	if (ret == -ENOMEM && IOMMU_DMA_MODE_IS_LAZY()) {
 		/* enable the hypervisor to free some resources */
 		if (zpci_refresh_global(zdev))
 			goto out;
@@ -278,7 +277,7 @@ static dma_addr_t dma_alloc_address(struct device *dev, int size)
 	spin_lock_irqsave(&zdev->iommu_bitmap_lock, flags);
 	offset = __dma_alloc_iommu(dev, zdev->next_bit, size);
 	if (offset == -1) {
-		if (!s390_iommu_strict) {
+		if (IOMMU_DMA_MODE_IS_LAZY()) {
 			/* global flush before DMA addresses are reused */
 			if (zpci_refresh_global(zdev))
 				goto out_error;
@@ -313,7 +312,7 @@ static void dma_free_address(struct device *dev, dma_addr_t dma_addr, int size)
 	if (!zdev->iommu_bitmap)
 		goto out;
 
-	if (s390_iommu_strict)
+	if (!IOMMU_DMA_MODE_IS_LAZY())
 		bitmap_clear(zdev->iommu_bitmap, offset, size);
 	else
 		bitmap_set(zdev->lazy_bitmap, offset, size);
@@ -584,7 +583,7 @@ int zpci_dma_init_device(struct zpci_dev *zdev)
 		rc = -ENOMEM;
 		goto free_dma_table;
 	}
-	if (!s390_iommu_strict) {
+	if (IOMMU_DMA_MODE_IS_LAZY()) {
 		zdev->lazy_bitmap = vzalloc(zdev->iommu_pages / 8);
 		if (!zdev->lazy_bitmap) {
 			rc = -ENOMEM;
@@ -671,12 +670,3 @@ void zpci_dma_exit(void)
 	/* dma_supported is unconditionally true without a callback */
 };
 EXPORT_SYMBOL_GPL(s390_pci_dma_ops);
-
-static int __init s390_iommu_setup(char *str)
-{
-	if (!strncmp(str, "strict", 6))
-		s390_iommu_strict = 1;
-	return 0;
-}
-
-__setup("s390_iommu=", s390_iommu_setup);
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 19118cfdea1c335..d88dc44d60d88ea 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -77,6 +77,7 @@ config IOMMU_DEBUGFS
 choice
 	prompt "IOMMU dma mode"
 	depends on IOMMU_API
+	default IOMMU_DMA_MODE_LAZY if S390_IOMMU
 	default IOMMU_DMA_MODE_STRICT
 	help
 	  IOMMU dma mode, such as: passthrough, lazy, strict.
-- 
1.8.3


