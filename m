Return-Path: <kda@linux-powerpc.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0409D1A035C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 06:04:57 +1000 (AEST)
Received: by lbbvu2 with SMTP id vu2so37823460lbb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 13:04:53 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH v3] powerpc: msi: mark bitmap with kmemleak_not_leak()
Date: Wed, 16 Sep 2015 22:26:14 +0300
Message-Id: <1442431574-4575-1-git-send-email-kda@linux-powerpc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During the MSI bitmap test on boot kmemleak spews the following trace:

unreferenced object 0xc00000016e86c900 (size 64):
    comm "swapper/0", pid 1, jiffies 4294893173 (age 518.024s)
    hex dump (first 32 bytes):
	00 00 01 ff 7f ff 7f 37 00 00 00 00 00 00 00 00
	.......7........
	ff ff ff ff ff ff ff ff 01 ff ff ff ff
	ff ff ff
	................
	backtrace:
	[<c00000000003eebc>] .zalloc_maybe_bootmem+0x3c/0x380
	[<c000000000042d6c>] .msi_bitmap_alloc+0x3c/0xb0
	[<c000000000a9aff8>] .msi_bitmap_selftest+0x30/0x2b4
	[<c0000000000090f4>] .do_one_initcall+0xd4/0x270
	[<c000000000a8e250>] .kernel_init_freeable+0x1a0/0x280
	[<c000000000009b5c>] .kernel_init+0x1c/0x120
	[<c000000000007fbc>] .ret_from_kernel_thread+0x58/0x9c

Added a flag to msi_bitmap for tracking allocations
from slab and memblock so we can properly free/handle
memory in msi_bitmap_free().

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

Changes vor v2:
 - added a flag to msi_bitmap
 - kmemleak annotaion moved under CONFIG_MSI_BITMAP_SELFTEST

Changes vor v3:
 - correctly initialize bitmap_from_slab
 - put kmemleak_not_leak annotation right after the allocation
---
 arch/powerpc/include/asm/msi_bitmap.h |  1 +
 arch/powerpc/sysdev/msi_bitmap.c      | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/msi_bitmap.h b/arch/powerpc/include/asm/msi_bitmap.h
index 97ac3f4..47a8ebc 100644
--- a/arch/powerpc/include/asm/msi_bitmap.h
+++ b/arch/powerpc/include/asm/msi_bitmap.h
@@ -19,6 +19,7 @@ struct msi_bitmap {
 	unsigned long		*bitmap;
 	spinlock_t		lock;
 	unsigned int		irq_count;
+	bool		 	    bitmap_from_slab;
 };
 
 int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp, int num);
diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
index 73b64c7..6f2f3d6 100644
--- a/arch/powerpc/sysdev/msi_bitmap.c
+++ b/arch/powerpc/sysdev/msi_bitmap.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/bitmap.h>
+#include <linux/bootmem.h>
 #include <asm/msi_bitmap.h>
 #include <asm/setup.h>
 
@@ -122,7 +123,16 @@ int msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned int irq_count,
 	size = BITS_TO_LONGS(irq_count) * sizeof(long);
 	pr_debug("msi_bitmap: allocator bitmap size is 0x%x bytes\n", size);
 
-	bmp->bitmap = zalloc_maybe_bootmem(size, GFP_KERNEL);
+	if (slab_is_available()) {
+		bmp->bitmap = kzalloc(size, GFP_KERNEL);
+		bmp->bitmap_from_slab = true;
+	} else {
+		bmp->bitmap = memblock_virt_alloc(size, 0);
+		bmp->bitmap_from_slab = false;
+		/* the bitmap won't be freed from memblock allocator */
+		kmemleak_not_leak(bmp->bitmap);
+	}
+
 	if (!bmp->bitmap) {
 		pr_debug("msi_bitmap: ENOMEM allocating allocator bitmap!\n");
 		return -ENOMEM;
@@ -138,7 +148,8 @@ int msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned int irq_count,
 
 void msi_bitmap_free(struct msi_bitmap *bmp)
 {
-	/* we can't free the bitmap we don't know if it's bootmem etc. */
+	if (bmp->bitmap_from_slab)
+		kfree(bmp->bitmap);
 	of_node_put(bmp->of_node);
 	bmp->bitmap = NULL;
 }
@@ -203,8 +214,6 @@ static void __init test_basics(void)
 
 	/* Clients may WARN_ON bitmap == NULL for "not-allocated" */
 	WARN_ON(bmp.bitmap != NULL);
-
-	kfree(bmp.bitmap);
 }
 
 static void __init test_of_node(void)
-- 
2.4.0
