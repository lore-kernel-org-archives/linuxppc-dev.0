Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 73FA267D72
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 12:28:49 +1000 (EST)
Date: Wed, 12 Apr 2006 21:28:09 -0500
To: paulus@samba.org
Subject: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB
Message-ID: <20060413022809.GD24769@pb15.lixom.net>
References: <20060413020559.GC24769@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060413020559.GC24769@pb15.lixom.net>
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

Hi,

This goes with the previous dma_mask patch -- enable DART at 1GB due to
Airport Extreme cards needing it. Please consider for 2.6.17.


Thanks,

Olof


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
@@ -329,10 +329,14 @@ void iommu_init_early_dart(void)
 
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
+	if (lmb_end_of_DRAM() <= 0x40000000ull && !iommu_force_on)
 		return;
 
 	/* 512 pages (2MB) is max DART tablesize. */
