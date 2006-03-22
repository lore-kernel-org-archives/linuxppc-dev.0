Return-Path: <SRS0=lOLd=5O=de.ibm.com=abergman@srs.kundenserver.de>
Message-Id: <20060323203521.502162000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Thu, 23 Mar 2006 00:00:04 +0100
From: Arnd Bergmann <abergman@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 04/13] powerpc: fix cell iommu setup
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A small bug crept in the iommu driver when we made it more
generic. This patch is needed for boards that have a dma
window that does not start at bus address zero.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6.15-rc5/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/powerpc/platforms/cell/iommu.c
+++ linux-2.6.15-rc5/arch/powerpc/platforms/cell/iommu.c
@@ -289,7 +289,7 @@ static void cell_do_map_iommu(struct cel
 	ioc_base = iommu->mapped_base;
 	ioc_mmio_base = iommu->mapped_mmio_base;
 
-	for (real_address = 0, io_address = 0;
+	for (real_address = 0, io_address = map_start;
 	     io_address <= map_start + map_size;
 	     real_address += io_page_size, io_address += io_page_size) {
 		ioste = get_iost_entry(fake_iopt, io_address, io_page_size);
@@ -302,7 +302,7 @@ static void cell_do_map_iommu(struct cel
 		set_iopt_cache(ioc_mmio_base,
 			get_ioc_hash_1way(ioste, io_address),
 			get_ioc_tag(ioste, io_address),
-			get_iopt_entry(real_address-map_start, ioid, IOPT_PROT_RW));
+			get_iopt_entry(real_address, ioid, IOPT_PROT_RW));
 	}
 }
 

--
