Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17553.16736.157418.936815@cargo.ozlabs.ibm.com>
Date: Thu, 15 Jun 2006 21:15:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: [PATCH] powerpc: Fix 64k pages on non-partitioned machines
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd.bergmann@de.ibm.com>

The page size encoding passed to tlbie is incorrect for new-style
large pages.  This fixes it.  This doesn't affect anything on older
machines because mmu_psize_defs[psize].penc (the page size encoding)
is 0 for 4k and 16M pages (the two are distinguished by a separate "is
a large page" bit).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Linus, without this patch, we can't use 64k pages on Cell systems.  If
you could apply this before 2.6.17 is released, that would be good.
If not, I'll send it in post 2.6.17.

Paul.

Index: linus-2.6/arch/powerpc/mm/hash_native_64.c
===================================================================
--- linus-2.6.orig/arch/powerpc/mm/hash_native_64.c
+++ linus-2.6/arch/powerpc/mm/hash_native_64.c
@@ -52,7 +52,7 @@ static inline void __tlbie(unsigned long
 	default:
 		penc = mmu_psize_defs[psize].penc;
 		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
-		va |= (0x7f >> (8 - penc)) << 12;
+		va |= penc << 12;
 		asm volatile("tlbie %0,1" : : "r" (va) : "memory");
 		break;
 	}
@@ -74,7 +74,7 @@ static inline void __tlbiel(unsigned lon
 	default:
 		penc = mmu_psize_defs[psize].penc;
 		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
-		va |= (0x7f >> (8 - penc)) << 12;
+		va |= penc << 12;
 		asm volatile(".long 0x7c000224 | (%0 << 11) | (1 << 21)"
 			     : : "r"(va) : "memory");
 		break;
