Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA82F1A1ADC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 19:04:38 +1100 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc/msi: Use WARN_ON() in msi bitmap selftests
Date: Fri, 10 Oct 2014 19:04:25 +1100
Message-Id: <1412928265-21991-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1412928265-21991-1-git-send-email-mpe@ellerman.id.au>
References: <1412928265-21991-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As demonstrated in the previous commit, the failure message from the msi
bitmap selftests is a bit subtle, it's easy to miss a failure in a busy
boot log.

So drop our check() macro and use WARN_ON() instead. This necessitates
inverting all the conditions as well.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/sysdev/msi_bitmap.c | 54 ++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
index 8155d93dee1d..73b64c73505b 100644
--- a/arch/powerpc/sysdev/msi_bitmap.c
+++ b/arch/powerpc/sysdev/msi_bitmap.c
@@ -145,69 +145,64 @@ void msi_bitmap_free(struct msi_bitmap *bmp)
 
 #ifdef CONFIG_MSI_BITMAP_SELFTEST
 
-#define check(x)	\
-	if (!(x)) printk("msi_bitmap: test failed at line %d\n", __LINE__);
-
 static void __init test_basics(void)
 {
 	struct msi_bitmap bmp;
 	int rc, i, size = 512;
 
 	/* Can't allocate a bitmap of 0 irqs */
-	check(msi_bitmap_alloc(&bmp, 0, NULL) != 0);
+	WARN_ON(msi_bitmap_alloc(&bmp, 0, NULL) == 0);
 
 	/* of_node may be NULL */
-	check(0 == msi_bitmap_alloc(&bmp, size, NULL));
+	WARN_ON(msi_bitmap_alloc(&bmp, size, NULL));
 
 	/* Should all be free by default */
-	check(0 == bitmap_find_free_region(bmp.bitmap, size,
-					   get_count_order(size)));
+	WARN_ON(bitmap_find_free_region(bmp.bitmap, size, get_count_order(size)));
 	bitmap_release_region(bmp.bitmap, 0, get_count_order(size));
 
 	/* With no node, there's no msi-available-ranges, so expect > 0 */
-	check(msi_bitmap_reserve_dt_hwirqs(&bmp) > 0);
+	WARN_ON(msi_bitmap_reserve_dt_hwirqs(&bmp) <= 0);
 
 	/* Should all still be free */
-	check(0 == bitmap_find_free_region(bmp.bitmap, size,
-					   get_count_order(size)));
+	WARN_ON(bitmap_find_free_region(bmp.bitmap, size, get_count_order(size)));
 	bitmap_release_region(bmp.bitmap, 0, get_count_order(size));
 
 	/* Check we can fill it up and then no more */
 	for (i = 0; i < size; i++)
-		check(msi_bitmap_alloc_hwirqs(&bmp, 1) >= 0);
+		WARN_ON(msi_bitmap_alloc_hwirqs(&bmp, 1) < 0);
 
-	check(msi_bitmap_alloc_hwirqs(&bmp, 1) < 0);
+	WARN_ON(msi_bitmap_alloc_hwirqs(&bmp, 1) >= 0);
 
 	/* Should all be allocated */
-	check(bitmap_find_free_region(bmp.bitmap, size, 0) < 0);
+	WARN_ON(bitmap_find_free_region(bmp.bitmap, size, 0) >= 0);
 
 	/* And if we free one we can then allocate another */
 	msi_bitmap_free_hwirqs(&bmp, size / 2, 1);
-	check(msi_bitmap_alloc_hwirqs(&bmp, 1) == size / 2);
+	WARN_ON(msi_bitmap_alloc_hwirqs(&bmp, 1) != size / 2);
 
 	/* Free most of them for the alignment tests */
 	msi_bitmap_free_hwirqs(&bmp, 3, size - 3);
 
 	/* Check we get a naturally aligned offset */
 	rc = msi_bitmap_alloc_hwirqs(&bmp, 2);
-	check(rc >= 0 && rc % 2 == 0);
+	WARN_ON(rc < 0 && rc % 2 != 0);
 	rc = msi_bitmap_alloc_hwirqs(&bmp, 4);
-	check(rc >= 0 && rc % 4 == 0);
+	WARN_ON(rc < 0 && rc % 4 != 0);
 	rc = msi_bitmap_alloc_hwirqs(&bmp, 8);
-	check(rc >= 0 && rc % 8 == 0);
+	WARN_ON(rc < 0 && rc % 8 != 0);
 	rc = msi_bitmap_alloc_hwirqs(&bmp, 9);
-	check(rc >= 0 && rc % 16 == 0);
+	WARN_ON(rc < 0 && rc % 16 != 0);
 	rc = msi_bitmap_alloc_hwirqs(&bmp, 3);
-	check(rc >= 0 && rc % 4 == 0);
+	WARN_ON(rc < 0 && rc % 4 != 0);
 	rc = msi_bitmap_alloc_hwirqs(&bmp, 7);
-	check(rc >= 0 && rc % 8 == 0);
+	WARN_ON(rc < 0 && rc % 8 != 0);
 	rc = msi_bitmap_alloc_hwirqs(&bmp, 121);
-	check(rc >= 0 && rc % 128 == 0);
+	WARN_ON(rc < 0 && rc % 128 != 0);
 
 	msi_bitmap_free(&bmp);
 
-	/* Clients may check bitmap == NULL for "not-allocated" */
-	check(bmp.bitmap == NULL);
+	/* Clients may WARN_ON bitmap == NULL for "not-allocated" */
+	WARN_ON(bmp.bitmap != NULL);
 
 	kfree(bmp.bitmap);
 }
@@ -229,14 +224,13 @@ static void __init test_of_node(void)
 	of_node_init(&of_node);
 	of_node.full_name = node_name;
 
-	check(0 == msi_bitmap_alloc(&bmp, size, &of_node));
+	WARN_ON(msi_bitmap_alloc(&bmp, size, &of_node));
 
 	/* No msi-available-ranges, so expect > 0 */
-	check(msi_bitmap_reserve_dt_hwirqs(&bmp) > 0);
+	WARN_ON(msi_bitmap_reserve_dt_hwirqs(&bmp) <= 0);
 
 	/* Should all still be free */
-	check(0 == bitmap_find_free_region(bmp.bitmap, size,
-					   get_count_order(size)));
+	WARN_ON(bitmap_find_free_region(bmp.bitmap, size, get_count_order(size)));
 	bitmap_release_region(bmp.bitmap, 0, get_count_order(size));
 
 	/* Now create a fake msi-available-ranges property */
@@ -250,11 +244,11 @@ static void __init test_of_node(void)
 	of_node.properties = &prop;
 
 	/* msi-available-ranges, so expect == 0 */
-	check(msi_bitmap_reserve_dt_hwirqs(&bmp) == 0);
+	WARN_ON(msi_bitmap_reserve_dt_hwirqs(&bmp));
 
 	/* Check we got the expected result */
-	check(0 == bitmap_parselist(expected_str, expected, size));
-	check(bitmap_equal(expected, bmp.bitmap, size));
+	WARN_ON(bitmap_parselist(expected_str, expected, size));
+	WARN_ON(!bitmap_equal(expected, bmp.bitmap, size));
 
 	msi_bitmap_free(&bmp);
 	kfree(bmp.bitmap);
-- 
1.9.1
