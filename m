Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 01/18] powerpc: Remove remaining iSeries chunks
Date: Thu, 26 Jul 2012 17:19:47 +1000
Message-Id: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit f5339277 "powerpc: Remove FW_FEATURE ISERIES from arch code", we
removed the bulk of the iSeries code, but missed a few bits.

Remove the mschunks bits, these were only ever used on iSeries as far as I
know, and are definitely not used anymore.

Make it even clearer that phys_to_abs() is a nop, by making it a macro. We
still have a few users of this, but should clean those up.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/abs_addr.h |   32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/abs_addr.h b/arch/powerpc/include/asm/abs_addr.h
index 9d92ba0..419aab7 100644
--- a/arch/powerpc/include/asm/abs_addr.h
+++ b/arch/powerpc/include/asm/abs_addr.h
@@ -18,38 +18,10 @@
 #include <asm/page.h>
 #include <asm/prom.h>
 
-struct mschunks_map {
-        unsigned long num_chunks;
-        unsigned long chunk_size;
-        unsigned long chunk_shift;
-        unsigned long chunk_mask;
-        u32 *mapping;
-};
-
-extern struct mschunks_map mschunks_map;
-
-/* Chunks are 256 KB */
-#define MSCHUNKS_CHUNK_SHIFT	(18)
-#define MSCHUNKS_CHUNK_SIZE	(1UL << MSCHUNKS_CHUNK_SHIFT)
-#define MSCHUNKS_OFFSET_MASK	(MSCHUNKS_CHUNK_SIZE - 1)
-
-static inline unsigned long chunk_to_addr(unsigned long chunk)
-{
-	return chunk << MSCHUNKS_CHUNK_SHIFT;
-}
-
-static inline unsigned long addr_to_chunk(unsigned long addr)
-{
-	return addr >> MSCHUNKS_CHUNK_SHIFT;
-}
-
-static inline unsigned long phys_to_abs(unsigned long pa)
-{
-	return pa;
-}
+#define phys_to_abs(pa) (pa)
 
 /* Convenience macros */
-#define virt_to_abs(va) phys_to_abs(__pa(va))
+#define virt_to_abs(va) __pa(va)
 #define abs_to_virt(aa) __va(aa)
 
 #endif /* __KERNEL__ */
-- 
1.7.9.5
