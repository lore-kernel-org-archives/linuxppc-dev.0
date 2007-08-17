Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E9AE0DDE38
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 14:53:42 +1000 (EST)
Date: Thu, 16 Aug 2007 22:57:39 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] pasemi: Another IOMMU bugfix for 64K PAGE_SIZE
Message-ID: <20070817035739.GA8294@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

More fallout from the switch from PAGE_SIZE based IOMMU to the native page
size for the driver. By pure luck it happened to work most of the time, since
we end up invalidating the wrong entries in the TLB.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: linux-2.6/arch/powerpc/platforms/pasemi/iommu.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pasemi/iommu.c
+++ linux-2.6/arch/powerpc/platforms/pasemi/iommu.c
@@ -93,7 +93,7 @@ static void iobmap_build(struct iommu_ta
 
 	pr_debug("iobmap: build at: %lx, %lx, addr: %lx\n", index, npages, uaddr);
 
-	bus_addr = (tbl->it_offset + index) << PAGE_SHIFT;
+	bus_addr = (tbl->it_offset + index) << IOBMAP_PAGE_SHIFT;
 
 	ip = ((u32 *)tbl->it_base) + index;
 
@@ -118,7 +118,7 @@ static void iobmap_free(struct iommu_tab
 
 	pr_debug("iobmap: free at: %lx, %lx\n", index, npages);
 
-	bus_addr = (tbl->it_offset + index) << PAGE_SHIFT;
+	bus_addr = (tbl->it_offset + index) << IOBMAP_PAGE_SHIFT;
 
 	ip = ((u32 *)tbl->it_base) + index;
 
@@ -137,7 +137,7 @@ static void iommu_table_iobmap_setup(voi
 	iommu_table_iobmap.it_busno = 0;
 	iommu_table_iobmap.it_offset = 0;
 	/* it_size is in number of entries */
-	iommu_table_iobmap.it_size = 0x80000000 >> PAGE_SHIFT;
+	iommu_table_iobmap.it_size = 0x80000000 >> IOBMAP_PAGE_SHIFT;
 
 	/* Initialize the common IOMMU code */
 	iommu_table_iobmap.it_base = (unsigned long)iob_l2_base;
