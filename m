Return-Path: <k.kozlowski@samsung.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLBKF0Nq4zDqgj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 01:41:20 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O8500NYBI8T0I00@mailout1.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 02 Jun 2016 16:41:18 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Steven Miao <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>,
 Aurelien Jacquiot <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>,
 Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>,
 Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 Geoff Levand <geoff@infradead.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 David Vrabel <david.vrabel@citrix.com>, Juergen Gross <jgross@suse.com>,
 Muli Ben-Yehuda <muli@il.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 David Airlie <airlied@linux.ie>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, adi-buildroot-devel@lists.sourceforge.net,
 linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
 uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-am33-list@redhat.com, nios2-dev@lists.rocketboards.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, discuss@x86-64.org, linux-pci@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-media@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Cc: hch@infradead.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC v3 17/45] infiniband: dma-mapping: Use unsigned long for
 dma_attrs
Date: Thu, 02 Jun 2016 17:39:19 +0200
Message-id: <1464881987-13203-18-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/infiniband/core/umem.c | 7 +++----
 include/rdma/ib_verbs.h        | 8 ++++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index fe4d2e1a8b58..75d8a8b178a5 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -37,7 +37,6 @@
 #include <linux/sched.h>
 #include <linux/export.h>
 #include <linux/hugetlb.h>
-#include <linux/dma-attrs.h>
 #include <linux/slab.h>
 #include <rdma/ib_umem_odp.h>
 
@@ -92,12 +91,12 @@ struct ib_umem *ib_umem_get(struct ib_ucontext *context, unsigned long addr,
 	unsigned long npages;
 	int ret;
 	int i;
-	DEFINE_DMA_ATTRS(attrs);
+	unsigned long attrs = 0;
 	struct scatterlist *sg, *sg_list_start;
 	int need_release = 0;
 
 	if (dmasync)
-		dma_set_attr(DMA_ATTR_WRITE_BARRIER, &attrs);
+		attrs |= DMA_ATTR_WRITE_BARRIER;
 
 	if (!size)
 		return ERR_PTR(-EINVAL);
@@ -215,7 +214,7 @@ struct ib_umem *ib_umem_get(struct ib_ucontext *context, unsigned long addr,
 				  umem->sg_head.sgl,
 				  umem->npages,
 				  DMA_BIDIRECTIONAL,
-				  &attrs);
+				  attrs);
 
 	if (umem->nmap <= 0) {
 		ret = -ENOMEM;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 432bed510369..4d73928962c7 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2819,7 +2819,7 @@ static inline void ib_dma_unmap_single(struct ib_device *dev,
 static inline u64 ib_dma_map_single_attrs(struct ib_device *dev,
 					  void *cpu_addr, size_t size,
 					  enum dma_data_direction direction,
-					  struct dma_attrs *attrs)
+					  unsigned long attrs)
 {
 	return dma_map_single_attrs(dev->dma_device, cpu_addr, size,
 				    direction, attrs);
@@ -2828,7 +2828,7 @@ static inline u64 ib_dma_map_single_attrs(struct ib_device *dev,
 static inline void ib_dma_unmap_single_attrs(struct ib_device *dev,
 					     u64 addr, size_t size,
 					     enum dma_data_direction direction,
-					     struct dma_attrs *attrs)
+					     unsigned long attrs)
 {
 	return dma_unmap_single_attrs(dev->dma_device, addr, size,
 				      direction, attrs);
@@ -2906,7 +2906,7 @@ static inline void ib_dma_unmap_sg(struct ib_device *dev,
 static inline int ib_dma_map_sg_attrs(struct ib_device *dev,
 				      struct scatterlist *sg, int nents,
 				      enum dma_data_direction direction,
-				      struct dma_attrs *attrs)
+				      unsigned long attrs)
 {
 	return dma_map_sg_attrs(dev->dma_device, sg, nents, direction, attrs);
 }
@@ -2914,7 +2914,7 @@ static inline int ib_dma_map_sg_attrs(struct ib_device *dev,
 static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
 					 struct scatterlist *sg, int nents,
 					 enum dma_data_direction direction,
-					 struct dma_attrs *attrs)
+					 unsigned long attrs)
 {
 	dma_unmap_sg_attrs(dev->dma_device, sg, nents, direction, attrs);
 }
-- 
1.9.1
