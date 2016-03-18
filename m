Return-Path: <okaya@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRT1B5hzBzDqVw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2016 02:00:30 +1100 (AEDT)
Subject: Re: [PATCH 2/3] swiotlb: prefix dma_to_phys and phys_to_dma functions
To: Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, timur@codeaurora.org,
 cov@codeaurora.org, nwatters@codeaurora.org
References: <1458252137-24497-1-git-send-email-okaya@codeaurora.org>
 <1458252137-24497-2-git-send-email-okaya@codeaurora.org>
 <56EBF09A.1060503@arm.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Chris Metcalf <cmetcalf@ezchip.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Huacai Chen <chenhc@lemote.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Jisheng Zhang <jszhang@marvell.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Guenter Roeck <linux@roeck-us.net>, Fenghua Yu <fenghua.yu@intel.com>,
 Denys Vlasenko <dvlasenk@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Akinobu Mita <akinobu.mita@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Valentin Rothberg <valentinrothberg@gmail.com>,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Dean Nelson <dnelson@redhat.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>,
 "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
 Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56EC1805.5060207@codeaurora.org>
Date: Fri, 18 Mar 2016 11:00:21 -0400
MIME-Version: 1.0
In-Reply-To: <56EBF09A.1060503@arm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/18/2016 8:12 AM, Robin Murphy wrote:
> Since we know for sure that swiotlb_to_phys is a no-op on arm64, it might be cleaner to simply not reference it at all. I suppose we could have some private local wrappers, e.g.:
> 
> #define swiotlb_to_virt(addr) phys_to_virt((phys_addr_t)(addr))
> 
> to keep the intent of the code clear (and just in case anyone ever builds a system mad enough to warrant switching out that definition, but I'd hope that never happens).
> 
> Otherwise, looks good - thanks for doing this!

OK. I added this. Reviewed-by?

I'm not happy to submit such a big patch for all different ARCHs. I couldn't
find a cleaner solution. I'm willing to split this patch into multiple if there
is a better way.

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index ada00c3..8c0f66b 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -29,6 +29,14 @@

 #include <asm/cacheflush.h>

+/*
+ * If you are building a system without IOMMU, then you are using SWIOTLB
+ * library. The ARM64 adaptation of this library does not support address
+ * translation and it assumes that physical address = dma address for such
+ * a use case. Please don't build a platform that violates this.
+ */
+#define swiotlb_to_virt(addr) phys_to_virt((phys_addr_t)(addr))
+
 static pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
                                 bool coherent)
 {
@@ -188,7 +196,7 @@ static void __dma_free(struct device *dev, size_t size,
                       void *vaddr, dma_addr_t dma_handle,
                       struct dma_attrs *attrs)
 {
-       void *swiotlb_addr = phys_to_virt(swiotlb_dma_to_phys(dev, dma_handle));
+       void *swiotlb_addr = swiotlb_to_virt(dma_handle);

        size = PAGE_ALIGN(size);

@@ -209,8 +217,7 @@ static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,

        dev_addr = swiotlb_map_page(dev, page, offset, size, dir, attrs);
        if (!is_device_dma_coherent(dev))
-               __dma_map_area(phys_to_virt(swiotlb_dma_to_phys(dev, dev_addr)),
-                              size, dir);
+               __dma_map_area(swiotlb_to_virt(dev_addr), size, dir);

        return dev_addr;
 }
@@ -283,8 +290,7 @@ static void __swiotlb_sync_single_for_device(struct device *dev,
 {
        swiotlb_sync_single_for_device(dev, dev_addr, size, dir);
        if (!is_device_dma_coherent(dev))
-               __dma_map_area(phys_to_virt(swiotlb_dma_to_phys(dev, dev_addr)),
-                              size, dir);
+               __dma_map_area(swiotlb_to_virt(dev_addr), size, dir);
 }




-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
