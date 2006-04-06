Return-Path: <arnd@arndb.de>
Message-Id: <20060407150743.341768000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060407150124.422051000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Fri, 07 Apr 2006 00:00:02 +0200
From: arnd@arndb.de
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/5] powerpc: fix 64k pages on non-hypervisor
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The page size encoding passed to tlbie is incorrect for
new-style large pages. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
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

--
