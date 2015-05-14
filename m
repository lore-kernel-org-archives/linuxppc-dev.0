Return-Path: <brking@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5CA81A042E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 07:35:03 +1000 (AEST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Thu, 14 May 2015 15:35:01 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1C07319D803F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 15:26:02 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t4ELYwqI44171490
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 14:34:58 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4ELYwwM015204
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 15:34:58 -0600
Message-ID: <555514FF.3020101@linux.vnet.ibm.com>
Date: Thu, 14 May 2015 16:34:55 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc/iommu: Support "hybrid" iommu/direct DMA
 ops for coherent_mask < dma_mask
References: <555279A8.6060906@linux.vnet.ibm.com> <2214146.EzgWBA6g23@wuerfel>
 <5553505D.50102@linux.vnet.ibm.com> <10045033.4fV0qQU90u@wuerfel>
 <55535BDF.6020502@linux.vnet.ibm.com>
 <CAK=zhgoXx4HJfpTuNAP0tAPnsU8BLmM7X3qGsFCzJfHOx55YCQ@mail.gmail.com>
 <1431550613.20218.88.camel@kernel.crashing.org>
 <5553C428.5090806@linux.vnet.ibm.com>
 <1431589393.4160.47.camel@kernel.crashing.org>
In-Reply-To: <1431589393.4160.47.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Cc: Daniel Kreling <kreling@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-scsi <linux-scsi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Sreekanth Reddy <sreekanth.reddy@avagotech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/14/2015 02:43 AM, Benjamin Herrenschmidt wrote:
> This patch adds the ability to the DMA direct ops to fallback to the IOMMU
> ops for coherent alloc/free if the coherent mask of the device isn't
> suitable for accessing the direct DMA space and the device also happens
> to have an active IOMMU table.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks Ben. This doesn't quite work, though, since pci_set_consistent_dma_mask
ends up calling dma_supported, which returns 0 here for a 32 bit mask if
pci_set_consistent_dma_mask was already called with a 64 bit mask. I worked
around it with the hack below and saw that I was able to get 64 bit DMA
and the card showed up all the drives. We'll need a better a better fix
for upstream obviously, but I wanted to be able to check out the rest of the patch
a bit...

Thanks,

Brian


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center




Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/dma.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff -puN arch/powerpc/kernel/dma.c~powerpc_iommu_hybrid_fixup arch/powerpc/kernel/dma.c
--- linux/arch/powerpc/kernel/dma.c~powerpc_iommu_hybrid_fixup	2015-05-14 10:28:38.361416590 -0500
+++ linux-bjking1/arch/powerpc/kernel/dma.c	2015-05-14 10:54:39.367292683 -0500
@@ -62,6 +62,16 @@ static int dma_direct_dma_supported(stru
 #endif
 }
 
+static int dma_direct_is_dma_supported(struct device *dev, u64 mask)
+{
+	if (!dma_direct_dma_supported(dev, mask)) {
+		if (mask < 0xfffffff)
+			return 0;
+	}
+
+	return 1;
+}
+
 void *__dma_direct_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flag,
 				  struct dma_attrs *attrs)
@@ -273,7 +283,7 @@ struct dma_map_ops dma_direct_ops = {
 	.mmap				= dma_direct_mmap_coherent,
 	.map_sg				= dma_direct_map_sg,
 	.unmap_sg			= dma_direct_unmap_sg,
-	.dma_supported			= dma_direct_dma_supported,
+	.dma_supported			= dma_direct_is_dma_supported,
 	.map_page			= dma_direct_map_page,
 	.unmap_page			= dma_direct_unmap_page,
 	.get_required_mask		= dma_direct_get_required_mask,
_
