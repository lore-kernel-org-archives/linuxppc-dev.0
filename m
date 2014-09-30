Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E13A1A099C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 20:35:38 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: greg@kroah.com, arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH v2 04/17] powerpc/msi: Improve IRQ bitmap allocator
Date: Tue, 30 Sep 2014 20:34:53 +1000
Message-Id: <1412073306-13812-5-git-send-email-mikey@neuling.org>
In-Reply-To: <1412073306-13812-1-git-send-email-mikey@neuling.org>
References: <1412073306-13812-1-git-send-email-mikey@neuling.org>
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, imunsie@au.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

Currently msi_bitmap_alloc_hwirqs() will round up any IRQ allocation requests
to the nearest power of 2.  eg. ask for 5 IRQs and you'll get 8.  This wastes a
lot of IRQs which can be a scarce resource.

For cxl we can require multiple IRQs for every contexts that is attached to the
accelerator.  For AFU directed accelerators, there may be 1000s of contexts
attached, hence we can easily run out of IRQs, especially if we are needlessly
wasting them.

This changes the msi_bitmap_alloc_hwirqs() to allocate only the required number
of IRQs, hence avoiding this wastage.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/sysdev/msi_bitmap.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
index 2ff6302..961a358 100644
--- a/arch/powerpc/sysdev/msi_bitmap.c
+++ b/arch/powerpc/sysdev/msi_bitmap.c
@@ -20,32 +20,37 @@ int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp, int num)
 	int offset, order = get_count_order(num);
 
 	spin_lock_irqsave(&bmp->lock, flags);
-	/*
-	 * This is fast, but stricter than we need. We might want to add
-	 * a fallback routine which does a linear search with no alignment.
-	 */
-	offset = bitmap_find_free_region(bmp->bitmap, bmp->irq_count, order);
+
+	offset = bitmap_find_next_zero_area(bmp->bitmap, bmp->irq_count, 0,
+					    num, (1 << order) - 1);
+	if (offset > bmp->irq_count)
+		goto err;
+	bitmap_set(bmp->bitmap, offset, num);
 	spin_unlock_irqrestore(&bmp->lock, flags);
 
 	pr_debug("msi_bitmap: allocated 0x%x (2^%d) at offset 0x%x\n",
 		 num, order, offset);
 
 	return offset;
+err:
+	spin_unlock_irqrestore(&bmp->lock, flags);
+	return -ENOMEM;
 }
+EXPORT_SYMBOL(msi_bitmap_alloc_hwirqs);
 
 void msi_bitmap_free_hwirqs(struct msi_bitmap *bmp, unsigned int offset,
 			    unsigned int num)
 {
 	unsigned long flags;
-	int order = get_count_order(num);
 
-	pr_debug("msi_bitmap: freeing 0x%x (2^%d) at offset 0x%x\n",
-		 num, order, offset);
+	pr_debug("msi_bitmap: freeing 0x%x at offset 0x%x\n",
+		 num, offset);
 
 	spin_lock_irqsave(&bmp->lock, flags);
-	bitmap_release_region(bmp->bitmap, offset, order);
+	bitmap_clear(bmp->bitmap, offset, num);
 	spin_unlock_irqrestore(&bmp->lock, flags);
 }
+EXPORT_SYMBOL(msi_bitmap_free_hwirqs);
 
 void msi_bitmap_reserve_hwirq(struct msi_bitmap *bmp, unsigned int hwirq)
 {
-- 
1.9.1
