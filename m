Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECC7B1A04EA
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 03:23:21 +1000 (AEST)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 2 Oct 2015 11:23:19 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 9A97C1FF0046
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 11:11:28 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t92HMJmS63307866
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 10:22:19 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t92HNFGC003613
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 11:23:16 -0600
Date: Fri, 2 Oct 2015 10:23:13 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Matthew Wilcox <willy@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] drivers/nvme: default to the IOMMU page size on Power
Message-ID: <20151002172313.GC41011@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002171800.GB41011@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151002171800.GB41011@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We received a bug report recently when DDW (64-bit direct DMA on Power)
is not enabled for NVMe devices. In that case, we fall back to 32-bit
DMA via the IOMMU, which is always done via 4K TCEs (Translation Control
Entries).

The NVMe device driver, though, assumes that the DMA alignment for the
PRP entries will match the device's page size, and that the DMA aligment
matches the kernel's page aligment. On Power, the the IOMMU page size,
as mentioned above, can be 4K, while the device can have a page size of
8K, while the kernel has a page size of 64K. This eventually trips the
BUG_ON in nvme_setup_prps(), as we have a 'dma_len' that is a multiple
of 4K but not 8K (e.g., 0xF000).

In this particular case, and generally, we want to use the IOMMU's page
size for the default device page size, rather than the kernel's page
size.

With this patch, a NVMe device survives our internal hardware
exerciser; the kernel BUGs within a few seconds without the patch.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7920c27..969a95e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -42,6 +42,7 @@
 #include <linux/types.h>
 #include <scsi/sg.h>
 #include <asm-generic/io-64-nonatomic-lo-hi.h>
+#include <asm/iommu.h>
 
 #define NVME_MINORS		(1U << MINORBITS)
 #define NVME_Q_DEPTH		1024
@@ -1680,6 +1681,11 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	unsigned page_shift = PAGE_SHIFT;
 	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
 	unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;
+#ifdef CONFIG_PPC64
+	struct iommu_table *tbl = get_iommu_table_base(dev->dev);
+	if (tbl)
+		page_shift = IOMMU_PAGE_SHIFT(tbl);
+#endif
 
 	if (page_shift < dev_page_min) {
 		dev_err(dev->dev,
