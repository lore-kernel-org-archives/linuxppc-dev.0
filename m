Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935ECC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 13:12:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76C92084C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 13:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76C92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dnkq5q00zDqJh
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 23:12:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com;
 envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dnQ34fq2zDqHf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 22:57:43 +1000 (AEST)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 69556E42FB4B562EA00F;
 Tue,  9 Apr 2019 20:54:15 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Tue, 9 Apr 2019 20:54:06 +0800
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
Subject: [PATCH v5 4/6] s390/pci: add support for generic boot option
 iommu.dma_mode
Date: Tue, 9 Apr 2019 20:53:06 +0800
Message-ID: <20190409125308.18304-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20190409125308.18304-1-thunder.leizhen@huawei.com>
References: <20190409125308.18304-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
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
Cc: Hanjun Guo <guohanjun@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

s390_iommu=strict is equivalent to iommu.dma_mode=strict.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 +++---
 arch/s390/pci/pci_dma.c                         | 14 +++++++-------
 drivers/iommu/Kconfig                           |  1 +
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 92d1b3151d003c2..ab8e3c4798c0a2a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1815,9 +1815,9 @@
 			options(such as CONFIG_IOMMU_DEFAULT_PASSTHROUGH) to
 			choose which mode to be used.
 			Note: For historical reasons, ARM64/S390/PPC/X86 have
-			their specific options. Currently, only ARM64 support
-			this boot option, and hope other ARCHs to use this as
-			generic boot option.
+			their specific options. Currently, only ARM64/S390
+			support this boot option, and hope other ARCHs to use
+			this as generic boot option.
 		passthrough
 			Configure DMA to bypass the IOMMU by default.
 		lazy
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 9e52d1527f71495..f658ca41547eed5 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/iommu.h>
 #include <linux/iommu-helper.h>
 #include <linux/dma-mapping.h>
 #include <linux/vmalloc.h>
@@ -17,7 +18,6 @@
 
 static struct kmem_cache *dma_region_table_cache;
 static struct kmem_cache *dma_page_table_cache;
-static int s390_iommu_strict;
 
 static int zpci_refresh_global(struct zpci_dev *zdev)
 {
@@ -193,13 +193,13 @@ static int __dma_purge_tlb(struct zpci_dev *zdev, dma_addr_t dma_addr,
 		if (!zdev->tlb_refresh)
 			return 0;
 	} else {
-		if (!s390_iommu_strict)
+		if (!IOMMU_DMA_MODE_IS_STRICT())
 			return 0;
 	}
 
 	ret = zpci_refresh_trans((u64) zdev->fh << 32, dma_addr,
 				 PAGE_ALIGN(size));
-	if (ret == -ENOMEM && !s390_iommu_strict) {
+	if (ret == -ENOMEM && !IOMMU_DMA_MODE_IS_STRICT()) {
 		/* enable the hypervisor to free some resources */
 		if (zpci_refresh_global(zdev))
 			goto out;
@@ -278,7 +278,7 @@ static dma_addr_t dma_alloc_address(struct device *dev, int size)
 	spin_lock_irqsave(&zdev->iommu_bitmap_lock, flags);
 	offset = __dma_alloc_iommu(dev, zdev->next_bit, size);
 	if (offset == -1) {
-		if (!s390_iommu_strict) {
+		if (!IOMMU_DMA_MODE_IS_STRICT()) {
 			/* global flush before DMA addresses are reused */
 			if (zpci_refresh_global(zdev))
 				goto out_error;
@@ -313,7 +313,7 @@ static void dma_free_address(struct device *dev, dma_addr_t dma_addr, int size)
 	if (!zdev->iommu_bitmap)
 		goto out;
 
-	if (s390_iommu_strict)
+	if (IOMMU_DMA_MODE_IS_STRICT())
 		bitmap_clear(zdev->iommu_bitmap, offset, size);
 	else
 		bitmap_set(zdev->lazy_bitmap, offset, size);
@@ -584,7 +584,7 @@ int zpci_dma_init_device(struct zpci_dev *zdev)
 		rc = -ENOMEM;
 		goto free_dma_table;
 	}
-	if (!s390_iommu_strict) {
+	if (!IOMMU_DMA_MODE_IS_STRICT()) {
 		zdev->lazy_bitmap = vzalloc(zdev->iommu_pages / 8);
 		if (!zdev->lazy_bitmap) {
 			rc = -ENOMEM;
@@ -675,7 +675,7 @@ void zpci_dma_exit(void)
 static int __init s390_iommu_setup(char *str)
 {
 	if (!strncmp(str, "strict", 6))
-		s390_iommu_strict = 1;
+		iommu_default_dma_mode_set(IOMMU_DMA_MODE_STRICT);
 	return 0;
 }
 
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 1986f9767da488b..b7173b106cd816a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -77,6 +77,7 @@ config IOMMU_DEBUGFS
 choice
 	prompt "IOMMU dma mode"
 	depends on IOMMU_API
+	default IOMMU_DEFAULT_LAZY if S390_IOMMU
 	default IOMMU_DEFAULT_STRICT
 	help
 	  This option allows IOMMU dma mode to be chose at build time, to
-- 
1.8.3


