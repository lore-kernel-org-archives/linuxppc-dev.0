Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BD90E67B5F
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 13:42:45 +1000 (EST)
Date: Tue, 26 Sep 2006 13:37:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 4/7] [POWERPC] fix ioremap for a combined kernel
Message-Id: <20060926133756.071a981f.sfr@canb.auug.org.au>
In-Reply-To: <20060926133651.897ad602.sfr@canb.auug.org.au>
References: <20060926133413.8ca8142e.sfr@canb.auug.org.au>
	<20060926133548.43afd711.sfr@canb.auug.org.au>
	<20060926133651.897ad602.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/pgtable_64.c |   29 +++++++----------------------
 1 files changed, 7 insertions(+), 22 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index b1da031..ac64f4a 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -63,32 +63,13 @@ #include <asm/system.h>
 #include <asm/iommu.h>
 #include <asm/abs_addr.h>
 #include <asm/vdso.h>
+#include <asm/firmware.h>
 
 #include "mmu_decl.h"
 
 unsigned long ioremap_bot = IMALLOC_BASE;
 static unsigned long phbs_io_bot = PHBS_IO_BASE;
 
-#ifdef CONFIG_PPC_ISERIES
-
-void __iomem *ioremap(unsigned long addr, unsigned long size)
-{
-	return (void __iomem *)addr;
-}
-
-extern void __iomem *__ioremap(unsigned long addr, unsigned long size,
-		       unsigned long flags)
-{
-	return (void __iomem *)addr;
-}
-
-void iounmap(volatile void __iomem *addr)
-{
-	return;
-}
-
-#else
-
 /*
  * map_io_page currently only called by __ioremap
  * map_io_page adds an entry to the ioremap page table
@@ -161,6 +142,9 @@ void __iomem * __ioremap(unsigned long a
 	unsigned long pa, ea;
 	void __iomem *ret;
 
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return (void __iomem *)addr;
+
 	/*
 	 * Choose an address to map it to.
 	 * Once the imalloc system is running, we use it.
@@ -255,6 +239,9 @@ void iounmap(volatile void __iomem *toke
 {
 	void *addr;
 
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return;
+
 	if (!mem_init_done)
 		return;
 	
@@ -315,8 +302,6 @@ int iounmap_explicit(volatile void __iom
 	return 0;
 }
 
-#endif
-
 EXPORT_SYMBOL(ioremap);
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(iounmap);
-- 
1.4.2.1
