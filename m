Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 70689DDDFB
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 10:43:03 +1000 (EST)
Date: Sun, 3 Jun 2007 19:49:05 -0500
To: paulus@samba.org
Subject: [PATCH] pasemi: fix iommu + 64K PAGE_SIZE bug
Message-ID: <20070604004905.GA26238@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The powerpc iommu code was refactored by Linas back in the 2.6.20 time
frame to map 4K pages from the generic code, but I had forgotten to go
back and fix my platform driver before submitting it.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index 95fa6a7..f33b21b 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -31,8 +31,6 @@
 #define IOBMAP_PAGE_SIZE	(1 << IOBMAP_PAGE_SHIFT)
 #define IOBMAP_PAGE_MASK	(IOBMAP_PAGE_SIZE - 1)
 
-#define IOBMAP_PAGE_FACTOR	(PAGE_SHIFT - IOBMAP_PAGE_SHIFT)
-
 #define IOB_BASE		0xe0000000
 #define IOB_SIZE		0x3000
 /* Configuration registers */
@@ -97,9 +95,6 @@ static void iobmap_build(struct iommu_table *tbl, long index,
 
 	bus_addr = (tbl->it_offset + index) << PAGE_SHIFT;
 
-	npages <<= IOBMAP_PAGE_FACTOR;
-	index <<= IOBMAP_PAGE_FACTOR;
-
 	ip = ((u32 *)tbl->it_base) + index;
 
 	while (npages--) {
@@ -125,9 +120,6 @@ static void iobmap_free(struct iommu_table *tbl, long index,
 
 	bus_addr = (tbl->it_offset + index) << PAGE_SHIFT;
 
-	npages <<= IOBMAP_PAGE_FACTOR;
-	index <<= IOBMAP_PAGE_FACTOR;
-
 	ip = ((u32 *)tbl->it_base) + index;
 
 	while (npages--) {
