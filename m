Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6629D67C67
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 12:52:48 +1000 (EST)
Date: Wed, 12 Apr 2006 21:52:33 -0500
To: paulus@samba.org
Subject: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB, V2
Message-ID: <20060413025233.GE24769@pb15.lixom.net>
References: <20060413020559.GC24769@pb15.lixom.net>
	<20060413022809.GD24769@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060413022809.GD24769@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 12, 2006 at 09:28:09PM -0500, Olof Johansson wrote:
> Hi,
> 
> This goes with the previous dma_mask patch -- enable DART at 1GB due to
> Airport Extreme cards needing it. Please consider for 2.6.17.

Crap, I missed a quilt refresh. Here's the version that handles iommu=off
between 1GB and 2GB right.


---


Turn on the DART already at 1GB. This is needed because of crippled
devices in some systems, i.e. Airport Extreme cards, only supporting
30-bit DMA addresses.

Otherwise, users with between 1 and 2GB of memory will need to manually
enable it with iommu=force, and that's no good.

Some simple performance tests show that there's a slight impact of
enabling DART, but it's in the 1-3% range (kernel build with disk I/O
as well as over NFS).

iommu=off can still be used for those who don't want to deal with the
overhead (and don't need it for any devices).


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6/arch/powerpc/sysdev/dart_iommu.c
===================================================================
--- 2.6.orig/arch/powerpc/sysdev/dart_iommu.c
+++ 2.6/arch/powerpc/sysdev/dart_iommu.c
@@ -49,6 +49,7 @@
 
 #include "dart.h"
 
+extern int iommu_is_off;
 extern int iommu_force_on;
 
 /* Physical base address and size of the DART table */
@@ -329,10 +330,17 @@ void iommu_init_early_dart(void)
 
 void __init alloc_dart_table(void)
 {
-	/* Only reserve DART space if machine has more than 2GB of RAM
+	/* Only reserve DART space if machine has more than 1GB of RAM
 	 * or if requested with iommu=on on cmdline.
+	 *
+	 * 1GB of RAM is picked as limit because some default devices
+	 * (i.e. Airport Extreme) have 30 bit address range limits.
 	 */
-	if (lmb_end_of_DRAM() <= 0x80000000ull && !iommu_force_on)
+
+	if (iommu_is_off)
+		return;
+
+	if (!iommu_force_on && lmb_end_of_DRAM() <= 0x40000000ull)
 		return;
 
 	/* 512 pages (2MB) is max DART tablesize. */
Index: 2.6/arch/powerpc/kernel/prom.c
===================================================================
--- 2.6.orig/arch/powerpc/kernel/prom.c
+++ 2.6/arch/powerpc/kernel/prom.c
@@ -62,7 +62,7 @@ static int __initdata dt_root_addr_cells
 static int __initdata dt_root_size_cells;
 
 #ifdef CONFIG_PPC64
-static int __initdata iommu_is_off;
+int __initdata iommu_is_off;
 int __initdata iommu_force_on;
 unsigned long tce_alloc_start, tce_alloc_end;
 #endif
