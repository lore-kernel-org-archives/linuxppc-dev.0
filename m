Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C05D1A0304
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 19:04:34 +1100 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc/msi: Fix the msi bitmap alignment tests
Date: Fri, 10 Oct 2014 19:04:24 +1100
Message-Id: <1412928265-21991-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we added the alignment tests recently we failed to check they were
actually passing - oops.

They weren't passing, because the bitmap was full. We should also be a
bit more careful when checking the return code, a negative error return
could by divisible by our alignment value.

Fixes: b0345bbc6d09 ("powerpc/msi: Improve IRQ bitmap allocator")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/sysdev/msi_bitmap.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
index 0c75214b6f92..8155d93dee1d 100644
--- a/arch/powerpc/sysdev/msi_bitmap.c
+++ b/arch/powerpc/sysdev/msi_bitmap.c
@@ -151,7 +151,7 @@ void msi_bitmap_free(struct msi_bitmap *bmp)
 static void __init test_basics(void)
 {
 	struct msi_bitmap bmp;
-	int i, size = 512;
+	int rc, i, size = 512;
 
 	/* Can't allocate a bitmap of 0 irqs */
 	check(msi_bitmap_alloc(&bmp, 0, NULL) != 0);
@@ -185,14 +185,24 @@ static void __init test_basics(void)
 	msi_bitmap_free_hwirqs(&bmp, size / 2, 1);
 	check(msi_bitmap_alloc_hwirqs(&bmp, 1) == size / 2);
 
+	/* Free most of them for the alignment tests */
+	msi_bitmap_free_hwirqs(&bmp, 3, size - 3);
+
 	/* Check we get a naturally aligned offset */
-	check(msi_bitmap_alloc_hwirqs(&bmp, 2) % 2 == 0);
-	check(msi_bitmap_alloc_hwirqs(&bmp, 4) % 4 == 0);
-	check(msi_bitmap_alloc_hwirqs(&bmp, 8) % 8 == 0);
-	check(msi_bitmap_alloc_hwirqs(&bmp, 9) % 16 == 0);
-	check(msi_bitmap_alloc_hwirqs(&bmp, 3) % 4 == 0);
-	check(msi_bitmap_alloc_hwirqs(&bmp, 7) % 8 == 0);
-	check(msi_bitmap_alloc_hwirqs(&bmp, 121) % 128 == 0);
+	rc = msi_bitmap_alloc_hwirqs(&bmp, 2);
+	check(rc >= 0 && rc % 2 == 0);
+	rc = msi_bitmap_alloc_hwirqs(&bmp, 4);
+	check(rc >= 0 && rc % 4 == 0);
+	rc = msi_bitmap_alloc_hwirqs(&bmp, 8);
+	check(rc >= 0 && rc % 8 == 0);
+	rc = msi_bitmap_alloc_hwirqs(&bmp, 9);
+	check(rc >= 0 && rc % 16 == 0);
+	rc = msi_bitmap_alloc_hwirqs(&bmp, 3);
+	check(rc >= 0 && rc % 4 == 0);
+	rc = msi_bitmap_alloc_hwirqs(&bmp, 7);
+	check(rc >= 0 && rc % 8 == 0);
+	rc = msi_bitmap_alloc_hwirqs(&bmp, 121);
+	check(rc >= 0 && rc % 128 == 0);
 
 	msi_bitmap_free(&bmp);
 
-- 
1.9.1
