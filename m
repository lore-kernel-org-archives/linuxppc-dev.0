Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3276EDDF6C
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 05:25:30 +1100 (EST)
From: Trent Piepho <tpiepho@freescale.com>
To: linux-mtd@lists.infradead.org
Subject: [PATCH] POWERPC: MTD: Add cached map support to physmap_of MTD driver
Date: Mon, 15 Dec 2008 10:25:18 -0800
Message-Id: <1229365518-20538-1-git-send-email-tpiepho@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Trent Piepho <xyzzy@speakeasy.org>,
	Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The MTD system supports operation where a direct mapped flash chip is
mapped twice.  The normal mapping is a standard ioremap(), which is
non-cached and guarded on powerpc.  The second mapping is used only for
reads and can be cached and non-guarded.  Currently, only the pxa2xx
mapping driver makes use of this feature.  This patch adds support to the
physmap_of driver on PPC32 platforms for this cached mapping mode.

Because the flash chip doesn't participate in the cache coherency protocol,
it's necessary to invalidate the cache for parts of flash that are modified
with a program or erase operation.  This is platform specific, for instance
the pxa2xx driver uses an ARM specific function.  This patch adds
invalidate_dcache_icache_range() for PPC32 and uses it.  Because of XIP,
it's entirely possible that the flash might be in the icache(*), so the
existing invalidate_dcache_range() function isn't enough.

Of course, a cached mapping can increase performance if the data is read
from cache instead of flash.  But less obvious is that it can provide a
significant performance increase for cold-cache reads that still come from
flash.  It allows efficient back-to-back reads and if the flash chip &
controller support page burst mode, it allows that to be used as well.

The figures are for *cold-cache* read performance, measured on a Freescale
MPC8572 controlling a Spansion S29GL064N NOR flash chip.  With and without
the flash being mapped cached and with and without the localbus controller
being programmed to use page burst mode:

Non-cached, w/o bursts: 13.61 MB/s
Non-cached, w/ bursts:  13.61 MB/s
Cached, w/o bursts:     16.75 MB/s 23% increase
Cached, w/ bursts:      44.79 MB/s 229% increase!

Even without any cache hits, the cached mapping provides a significant
increase in performance via improved bus utilization.  Enabling burst
transfers is even more significant.

(*) The MTD device's ->point() method, which is the mechanism for
supporting mmap and XIP, only allows for mmapping the uncached region.  So
you can't actually XIP anything in the cache.  But this could be fixed.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
 arch/powerpc/include/asm/cacheflush.h |    2 ++
 arch/powerpc/kernel/misc_32.S         |   21 +++++++++++++++++++++
 drivers/mtd/maps/physmap_of.c         |   20 ++++++++++++++++++++
 3 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index ba667a3..385c26c 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -49,6 +49,8 @@ extern void flush_dcache_range(unsigned long start, unsigned long stop);
 #ifdef CONFIG_PPC32
 extern void clean_dcache_range(unsigned long start, unsigned long stop);
 extern void invalidate_dcache_range(unsigned long start, unsigned long stop);
+extern void invalidate_dcache_icache_range(unsigned long start,
+					   unsigned long stop);
 #endif /* CONFIG_PPC32 */
 #ifdef CONFIG_PPC64
 extern void flush_inval_dcache_range(unsigned long start, unsigned long stop);
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index d108715..5e6a154 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -639,6 +639,27 @@ _GLOBAL(invalidate_dcache_range)
 	blr
 
 /*
+ * Like above, but invalidate both the D-cache and I-cache.  Used when a cached
+ * region has been modified from a source that does not participate in the cache
+ * coherency protocol.
+ *
+ * invalidate_dcache_icache_range(unsigned long start, unsigned long stop)
+ */
+_GLOBAL(invalidate_dcache_icache_range)
+	clrrwi	r3, r3, L1_CACHE_SHIFT	/* start &= ~((1<<SHIFT)-1) */
+	subf	r4,r3,r4
+	addi	r4,r4,L1_CACHE_BYTES-1
+	srwi.	r4,r4,L1_CACHE_SHIFT	/* count = (start-stop+BYTES-1)/BYTES */
+	beqlr				/* if (!count) return */
+	mtctr	r4
+1:	dcbi	0,r3
+	icbi	0,r3
+	addi	r3,r3,L1_CACHE_BYTES
+	bdnz	1b
+	sync				/* wait for [id]cbi's to get to ram */
+	blr
+
+/*
  * Flush a particular page from the data cache to RAM.
  * Note: this is necessary because the instruction cache does *not*
  * snoop from the data cache.
diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index 5fcfec0..e834298 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -32,6 +32,16 @@ struct of_flash {
 #endif
 };
 
+#ifdef CONFIG_PPC32
+#include <asm/cacheflush.h>
+static void ppc32_inval_cache(struct map_info *map, unsigned long from,
+			      ssize_t len)
+{
+	invalidate_dcache_icache_range((unsigned long)map->cached + from,
+	                               (unsigned long)map->cached + from + len);
+}
+#endif
+
 #ifdef CONFIG_MTD_PARTITIONS
 #define OF_FLASH_PARTS(info)	((info)->parts)
 
@@ -106,6 +116,8 @@ static int of_flash_remove(struct of_device *dev)
 
 	if (info->map.virt)
 		iounmap(info->map.virt);
+	if (info->map.cached)
+		iounmap(info->map.cached);
 
 	if (info->res) {
 		release_resource(info->res);
@@ -205,6 +217,14 @@ static int __devinit of_flash_probe(struct of_device *dev,
 		dev_err(&dev->dev, "Failed to ioremap() flash region\n");
 		goto err_out;
 	}
+#ifdef CONFIG_PPC32
+	/* Don't use no-cache or guarded flags */
+	info->map.cached = ioremap_flags(info->map.phys, info->map.size, 0);
+	if (!info->map.cached)
+		dev_warn(&dev->dev, "Failed to ioremap() cached flash region\n");
+	else
+		info->map.inval_cache = ppc32_inval_cache;
+#endif
 
 	simple_map_init(&info->map);
 
-- 
1.5.4.1
