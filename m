Date: Tue, 4 Mar 2003 15:36:37 -0700
From: Matt Porter <porter@cox.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Fix *dma_sync_single() and flush_dcache_all
Message-ID: <20030304153637.E2120@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I've had people trying to convince me of all sorts of things
lately on this and finally went to the source (DaveM).  The
short is that DMA-mapping.txt means what it says in the
section entitled "What memory is DMA'able?".  That is, the
only memory that can be used with the DMA API is memory
acquired via *get_free_page, kmalloc, or kmem_cache_alloc.
Period.

That means the ARM and MIPS implementations that use a
bus_to_virt() on the dma_handle in *dma_sync_single are
correct and our (performance killing) call to flush_dcache_all
is unnecessary.  flush_dcache_all is still used by 405lp pm
code so it stays and I updated the comments and made it
safe (per another thread) for 440gp's cache size.  This
is in case it is needed by some external callers on non-405lp.

If there are no objections, then I will commit to following
patch to 2_4_devel and 2.5.  The 2.5 pci_map_single/sync_single
are horked up anyway for 4xx so that will get fixed too.

===== arch/ppc/kernel/misc.S 1.79 vs edited =====
--- 1.79/arch/ppc/kernel/misc.S	Thu Feb 27 12:40:15 2003
+++ edited/arch/ppc/kernel/misc.S	Tue Mar  4 14:51:48 2003
@@ -607,25 +607,18 @@
 	blr

 #ifdef CONFIG_NOT_COHERENT_CACHE
-/* This is a bad one....It is used by 'consistent_sync' functions when
- * there isn't any handle on the virtual address needed by the usual
- * cache flush instructions.  On the MPC8xx, we can use the cache line
- * flush command, on others all we can do is read enough data to completely
- * reload the cache, flushing old data out.
- */
-
 /*
  * 40x cores have 8K or 16K dcache and 32 byte line size.
  * 440 has a 32K dcache and 32 byte line size.
  * 8xx has 1, 2, 4, 8K variants.
  * For now, cover the worst case of the 440.
- * When we get a cputable cache size entry we can do the right thing.
+ * Must be called with external interrupts disabled.
  */
 #define CACHE_NWAYS	64
 #define CACHE_NLINES	16

 _GLOBAL(flush_dcache_all)
-	li	r4, (CACHE_NWAYS * CACHE_NLINES)
+	li	r4, (2 * CACHE_NWAYS * CACHE_NLINES)
 	mtctr	r4
 	lis     r5, KERNELBASE@h
 1:	lwz	r3, 0(r5)		/* Load one word from every line */
===== include/asm-ppc/pci.h 1.30 vs edited =====
--- 1.30/include/asm-ppc/pci.h	Thu Feb 27 12:40:19 2003
+++ edited/include/asm-ppc/pci.h	Tue Mar  4 14:32:28 2003
@@ -214,20 +214,8 @@
 {
 	if (direction == PCI_DMA_NONE)
 		BUG();
-#ifdef CONFIG_NOT_COHERENT_CACHE
-	/* The bus_to_virt() can't be used here, in case dma_handle
-	 * points to something that doesn't have the same cache attributes
-	 * as the 1:1 mapped kernel memory.  If we used it, we could
-	 * get a cache line alias with the wrong attributes.
-	 * Since there isn't any Linux way to get the real VA from a PA,
-	 * it is just easier to flush the whole cache.  The code to
-	 * determine VA from PA would probably do the same :-).
-	 * I don't know why these functions don't pass VA, since the
-	 * cache operations use VA and the caller has this information.
-	 *	-- Dan
-	 */
-	flush_dcache_all();
-#endif
+
+	consistent_sync(bus_to_virt(dma_handle), size, direction);
 }

 /* Make physical memory consistent for a set of streaming

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
