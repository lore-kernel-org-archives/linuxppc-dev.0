Return-Path: <keescook@chromium.org>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HQl42JFWzF1kY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 04:53:00 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id s21-v6so4611203pfm.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 11:53:00 -0700 (PDT)
Date: Fri, 29 Jun 2018 11:52:54 -0700
From: Kees Cook <keescook@chromium.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Rob Herring <robh@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/msi: Remove VLA usage
Message-ID: <20180629185254.GA37557@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the quest to remove all stack VLA usage from the kernel[1], this
switches from an unchanging variable to a constant expression to eliminate
the VLA generation.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/sysdev/msi_bitmap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
index 6243a7e537d0..e64a411d1a00 100644
--- a/arch/powerpc/sysdev/msi_bitmap.c
+++ b/arch/powerpc/sysdev/msi_bitmap.c
@@ -225,22 +225,23 @@ static void __init test_of_node(void)
 	struct device_node of_node;
 	struct property prop;
 	struct msi_bitmap bmp;
-	int size = 256;
-	DECLARE_BITMAP(expected, size);
+#define SIZE_EXPECTED 256
+	DECLARE_BITMAP(expected, SIZE_EXPECTED);
 
 	/* There should really be a struct device_node allocator */
 	memset(&of_node, 0, sizeof(of_node));
 	of_node_init(&of_node);
 	of_node.full_name = node_name;
 
-	WARN_ON(msi_bitmap_alloc(&bmp, size, &of_node));
+	WARN_ON(msi_bitmap_alloc(&bmp, SIZE_EXPECTED, &of_node));
 
 	/* No msi-available-ranges, so expect > 0 */
 	WARN_ON(msi_bitmap_reserve_dt_hwirqs(&bmp) <= 0);
 
 	/* Should all still be free */
-	WARN_ON(bitmap_find_free_region(bmp.bitmap, size, get_count_order(size)));
-	bitmap_release_region(bmp.bitmap, 0, get_count_order(size));
+	WARN_ON(bitmap_find_free_region(bmp.bitmap, SIZE_EXPECTED,
+					get_count_order(SIZE_EXPECTED)));
+	bitmap_release_region(bmp.bitmap, 0, get_count_order(SIZE_EXPECTED));
 
 	/* Now create a fake msi-available-ranges property */
 
@@ -256,8 +257,8 @@ static void __init test_of_node(void)
 	WARN_ON(msi_bitmap_reserve_dt_hwirqs(&bmp));
 
 	/* Check we got the expected result */
-	WARN_ON(bitmap_parselist(expected_str, expected, size));
-	WARN_ON(!bitmap_equal(expected, bmp.bitmap, size));
+	WARN_ON(bitmap_parselist(expected_str, expected, SIZE_EXPECTED));
+	WARN_ON(!bitmap_equal(expected, bmp.bitmap, SIZE_EXPECTED));
 
 	msi_bitmap_free(&bmp);
 	kfree(bmp.bitmap);
-- 
2.17.1


-- 
Kees Cook
Pixel Security
