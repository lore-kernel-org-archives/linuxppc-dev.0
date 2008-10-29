Return-Path: <gerickson@nuovations.com>
Received: from relay00.pair.com (relay00.pair.com [209.68.5.9])
	by ozlabs.org (Postfix) with SMTP id C4B25DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 08:41:18 +1100 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PPC40x: Limit Allocable RAM During Early Mapping
Date: Wed, 29 Oct 2008 14:41:14 -0700
Message-Id: <1225316474-29035-1-git-send-email-gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If the size of RAM is not an exact power of two, we may not have
covered RAM in its entirety with large 16 and 4 MiB
pages. Consequently, restrict the top end of RAM currently allocable
by updating '__initial_memory_limit_addr' so that calls to the LMB to
allocate PTEs for "tail" coverage with normal-sized pages (or other
reasons) do not attempt to allocate outside the allowed range.

Signed-off-by: Grant Erickson <gerickson@nuovations.com>
---

This bug was discovered in the course of working on CONFIG_LOGBUFFER support
(see http://ozlabs.org/pipermail/linuxppc-dev/2008-October/064685.html).
However, the bug is triggered quite easily independent of that feature
by placing a memory limit via the 'mem=' kernel command line that results in
a memory size that is not equal to an exact power of two.

For example, on the AMCC PowerPC 405EXr "Haleakala" board with 256 MiB
of RAM, mmu_mapin_ram() normally covers RAM with precisely 16 16 MiB
large pages. However, if a memory limit of 256 MiB - 20 KiB (as might
be the case for CONFIG_LOGBUFFER) is put in place with
"mem=268414976", then large pages only cover (16 MiB * 15) + (4 MiB *
3) = 252 MiB with a 4 MiB - 20 KiB "tail" to cover with normal, 4 KiB
pages via map_page().

Unfortunately, if __initial_memory_limit_addr is not updated from its
initial value of 0x1000 0000 (256 MiB) to reflect what was actually
mapped via mmu_mapin_ram(), the following happens during the "tail"
mapping when the first PTE is allocated at 0xFFF A000 (rather than the
desired 0xFBF F000):

    mapin_ram
        mmu_mapin_ram
        map_page
            pte_alloc_kernel
                pte_alloc_one_kernel
                    early_get_page
                        lmb_alloc_base
                    clear_page
                        clear_pages
                            dcbz    0,page  <-- BOOM!

a non-recoverable page fault.

 arch/powerpc/mm/40x_mmu.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/40x_mmu.c b/arch/powerpc/mm/40x_mmu.c
index cecbbc7..29954dc 100644
--- a/arch/powerpc/mm/40x_mmu.c
+++ b/arch/powerpc/mm/40x_mmu.c
@@ -93,7 +93,7 @@ void __init MMU_init_hw(void)
 
 unsigned long __init mmu_mapin_ram(void)
 {
-	unsigned long v, s;
+	unsigned long v, s, mapped;
 	phys_addr_t p;
 
 	v = KERNELBASE;
@@ -130,5 +130,17 @@ unsigned long __init mmu_mapin_ram(void)
 		s -= LARGE_PAGE_SIZE_4M;
 	}
 
-	return total_lowmem - s;
+	mapped = total_lowmem - s;
+
+	/* If the size of RAM is not an exact power of two, we may not
+	 * have covered RAM in its entirety with 16 and 4 MiB
+	 * pages. Consequently, restrict the top end of RAM currently
+	 * allocable so that calls to the LMB to allocate PTEs for "tail"
+	 * coverage with normal-sized pages (or other reasons) do not
+	 * attempt to allocate outside the allowed range.
+	 */
+
+	__initial_memory_limit_addr = memstart_addr + mapped;
+
+	return mapped;
 }
-- 
1.6.0.1
