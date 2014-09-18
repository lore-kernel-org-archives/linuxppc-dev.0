Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0127.outbound.protection.outlook.com [65.55.169.127])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEF4F1A012D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 09:22:42 +1000 (EST)
Date: Thu, 18 Sep 2014 18:22:26 -0500
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/mm: Use common paging_init() for NUMA
Message-ID: <20140918232226.GA20727@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 1c98025c6c95bc057a25e2c6596de23288c68160 "powerpc: Dynamic DMA
zone limits" updated how zones are created in paging_init(), but missed
the NUMA version of paging_init().  This was noticed via a linker
error, since dma_pfn_limit_to_zone() was, like the non-NUMA
paging_init(), limited by #ifndef CONFIG_NEED_MULTIPLE_NODES.

It turns out that the NUMA paging_init() was not actually doing
anything different from the standard paging_init(), other than a couple
debug prints, a couple 32-bit-only ifdef sections, and a call to
mark_nonram_nosave().  It's not clear whether mark_nonram_nosave() is
inherently wrong to do for NUMA, or just not useful on targets that
have NUMA, but for now I'm preserving the existing behavior.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
I've tested this with CONFIG_NUMA turned on on a NUMA-less system.  While
this patch shouldn't cause any functional difference to what happens
in paging_init(), it would be helpful if someone with access to a NUMA
system could test.

And yes, I did try building ppc64_defconfig with "powerpc: Dynamic DMA
zone limits" before pushing, but the linker doesn't put "error:" in its
errors, so my build script (since updated) missed it.

 arch/powerpc/mm/mem.c  | 7 ++++++-
 arch/powerpc/mm/numa.c | 8 --------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 687e7f7..420dfff 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -259,6 +259,12 @@ static int __init mark_nonram_nosave(void)
 	}
 	return 0;
 }
+#else /* CONFIG_NEED_MULTIPLE_NODES */
+static int __init mark_nonram_nosave(void)
+{
+	return 0;
+}
+#endif
 
 static bool zone_limits_final;
 
@@ -351,7 +357,6 @@ void __init paging_init(void)
 
 	mark_nonram_nosave();
 }
-#endif /* ! CONFIG_NEED_MULTIPLE_NODES */
 
 static void __init register_page_bootmem_info(void)
 {
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 3b181b2..5eb07f3 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1126,14 +1126,6 @@ void __init do_init_bootmem(void)
 			  (void *)(unsigned long)boot_cpuid);
 }
 
-void __init paging_init(void)
-{
-	unsigned long max_zone_pfns[MAX_NR_ZONES];
-	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
-	max_zone_pfns[ZONE_DMA] = memblock_end_of_DRAM() >> PAGE_SHIFT;
-	free_area_init_nodes(max_zone_pfns);
-}
-
 static int __init early_numa(char *p)
 {
 	if (!p)
-- 
1.9.1
