Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1CD91A01F2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 19:08:25 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc/ppc64: Clean up the boot-time settings display
Date: Wed,  6 Aug 2014 19:08:21 +1000
Message-Id: <1407316102-22917-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At boot we display a bunch of low level settings which can be useful to
know, and can help to spot bugs when things are fundamentally
misconfigured.

At the moment they are very widely spaced, so that we can accommodate
the line:

  ppc64_caches.dcache_line_size = 0xYY

But we only print that line when the cache line size is not 128, ie.
almost never, so it just makes the display look odd usually.

The ppc64_caches prefix is redundant so remove it, which means we can
align things a bit closer for the common case. While we're there
replace the last use of camelCase (physicalMemorySize), and use
phys_mem_size.

Before:
  Starting Linux PPC64 #104 SMP Wed Aug 6 18:41:34 EST 2014
  -----------------------------------------------------
  ppc64_pft_size                = 0x1a
  physicalMemorySize            = 0x200000000
  ppc64_caches.dcache_line_size = 0xf0
  ppc64_caches.icache_line_size = 0xf0
  htab_address                  = 0xdeadbeef
  htab_hash_mask                = 0x7ffff
  physical_start                = 0xf000bar
  -----------------------------------------------------

After:
  Starting Linux PPC64 #103 SMP Wed Aug 6 18:38:04 EST 2014
  -----------------------------------------------------
  ppc64_pft_size    = 0x1a
  phys_mem_size     = 0x200000000
  dcache_line_size  = 0xf0
  icache_line_size  = 0xf0
  htab_address      = 0xdeadbeef
  htab_hash_mask    = 0x7ffff
  physical_start    = 0xf000bar
  -----------------------------------------------------

This patch is final, no bike shedding ;)

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index ee082d771178..b364f7bd0a94 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -517,21 +517,23 @@ void __init setup_system(void)
 	printk("Starting Linux PPC64 %s\n", init_utsname()->version);
 
 	printk("-----------------------------------------------------\n");
-	printk("ppc64_pft_size                = 0x%llx\n", ppc64_pft_size);
-	printk("physicalMemorySize            = 0x%llx\n", memblock_phys_mem_size());
+	printk("ppc64_pft_size    = 0x%llx\n", ppc64_pft_size);
+	printk("phys_mem_size     = 0x%llx\n", memblock_phys_mem_size());
+
 	if (ppc64_caches.dline_size != 0x80)
-		printk("ppc64_caches.dcache_line_size = 0x%x\n",
-		       ppc64_caches.dline_size);
+		printk("dcache_line_size  = 0x%x\n", ppc64_caches.dline_size);
 	if (ppc64_caches.iline_size != 0x80)
-		printk("ppc64_caches.icache_line_size = 0x%x\n",
-		       ppc64_caches.iline_size);
+		printk("icache_line_size  = 0x%x\n", ppc64_caches.iline_size);
+
 #ifdef CONFIG_PPC_STD_MMU_64
 	if (htab_address)
-		printk("htab_address                  = 0x%p\n", htab_address);
-	printk("htab_hash_mask                = 0x%lx\n", htab_hash_mask);
-#endif /* CONFIG_PPC_STD_MMU_64 */
+		printk("htab_address      = 0x%p\n", htab_address);
+
+	printk("htab_hash_mask    = 0x%lx\n", htab_hash_mask);
+#endif
+
 	if (PHYSICAL_START > 0)
-		printk("physical_start                = 0x%llx\n",
+		printk("physical_start    = 0x%llx\n",
 		       (unsigned long long)PHYSICAL_START);
 	printk("-----------------------------------------------------\n");
 
-- 
1.9.1
