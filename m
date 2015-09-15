Return-Path: <kda@linux-powerpc.org>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
 [209.85.215.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 731B51A2C32
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 04:02:20 +1000 (AEST)
Received: by lahg1 with SMTP id g1so83786488lah.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 11:02:16 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH v2] powerpc: msi: mark bitmap with kmemleak_not_leak()
Date: Tue, 15 Sep 2015 20:14:08 +0300
Message-Id: <1442337248-4295-1-git-send-email-kda@linux-powerpc.org>
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
---
 arch/powerpc/include/asm/msi_bitmap.h |  1 +
 arch/powerpc/sysdev/msi_bitmap.c      | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/msi_bitmap.h b/arch/powerpc/include/asm/msi_bitmap.h
index 97ac3f4..9a1d2fb 100644
--- a/arch/powerpc/include/asm/msi_bitmap.h
+++ b/arch/powerpc/include/asm/msi_bitmap.h
@@ -19,6 +19,7 @@ struct msi_bitmap {
 	unsigned long		*bitmap;
 	spinlock_t		lock;
 	unsigned int		irq_count;
+	bool		bitmap_from_slab;
 };
 
 int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp, int num);
diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
index 73b64c7..305ebe3 100644
--- a/arch/powerpc/sysdev/msi_bitmap.c
+++ b/arch/powerpc/sysdev/msi_bitmap.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/bitmap.h>
+#include <linux/bootmem.h>
 #include <asm/msi_bitmap.h>
 #include <asm/setup.h>
 
@@ -122,7 +123,12 @@ int msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned int irq_count,
 	size = BITS_TO_LONGS(irq_count) * sizeof(long);
 	pr_debug("msi_bitmap: allocator bitmap size is 0x%x bytes\n", size);
 
-	bmp->bitmap = zalloc_maybe_bootmem(size, GFP_KERNEL);
+	if (slab_is_available()) {
+		bmp->bitmap = kzalloc(size, GFP_KERNEL);
+		bmp->bitmap_from_slab = true;
+	} else
+		bmp->bitmap = memblock_virt_alloc(size, 0);
+
 	if (!bmp->bitmap) {
 		pr_debug("msi_bitmap: ENOMEM allocating allocator bitmap!\n");
 		return -ENOMEM;
@@ -138,7 +144,8 @@ int msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned int irq_count,
 
 void msi_bitmap_free(struct msi_bitmap *bmp)
 {
-	/* we can't free the bitmap we don't know if it's bootmem etc. */
+	if (bmp->bitmap_from_slab)
+		kfree(bmp->bitmap);
 	of_node_put(bmp->of_node);
 	bmp->bitmap = NULL;
 }
@@ -200,11 +207,11 @@ static void __init test_basics(void)
 	WARN_ON(rc < 0 && rc % 128 != 0);
 
 	msi_bitmap_free(&bmp);
+	if (!bmp.bitmap_from_slab)
+		kmemleak_not_leak(bmp.bitmap);
 
 	/* Clients may WARN_ON bitmap == NULL for "not-allocated" */
 	WARN_ON(bmp.bitmap != NULL);
-
-	kfree(bmp.bitmap);
 }
 
 static void __init test_of_node(void)
-- 
2.4.0
