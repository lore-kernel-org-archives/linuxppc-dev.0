Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRQRt0YfRzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 17:06:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/iommu: Avoid undefined right shift in
 iommu_range_alloc()
Date: Tue,  8 Aug 2017 17:06:32 +1000
Message-Id: <1502175992-13626-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In iommu_range_alloc() we generate a mask by right shifting ~0,
however if the specified alignment is 0 then we right shift by 64,
which is undefined. UBSAN tells us so:

  UBSAN: Undefined behaviour in ../arch/powerpc/kernel/iommu.c:193:35
  shift exponent 64 is too large for 64-bit type 'long unsigned int'

We can avoid it by instead generating the mask with:

  align_mask = (1ull << align_order) - 1;

That will also generate an undefined shift if align_order is 64 or
greater, but that shouldn't be a problem for a while.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 0e49a4560cff..e0af6cd7ba4f 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -190,7 +190,7 @@ static unsigned long iommu_range_alloc(struct device *dev,
 	unsigned int pool_nr;
 	struct iommu_pool *pool;
 
-	align_mask = 0xffffffffffffffffl >> (64 - align_order);
+	align_mask = (1ull << align_order) - 1;
 
 	/* This allocator was derived from x86_64's bit string search */
 
-- 
2.7.4
