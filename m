Return-Path: <arnd@arndb.de>
Message-Id: <20060429233920.825603000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
Date: Sun, 30 Apr 2006 01:28:18 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 06/13] powerpc: fix 64k pages on non-hypervisor
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

The page size encoding passed to tlbie is incorrect for
new-style large pages. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/arch/powerpc/mm/hash_native_64.c
===================================================================
--- linus-2.6.orig/arch/powerpc/mm/hash_native_64.c	2006-04-29 22:47:55.000000000 +0200
+++ linus-2.6/arch/powerpc/mm/hash_native_64.c	2006-04-29 22:53:42.000000000 +0200
@@ -52,7 +52,7 @@
 	default:
 		penc = mmu_psize_defs[psize].penc;
 		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
-		va |= (0x7f >> (8 - penc)) << 12;
+		va |= penc << 12;
 		asm volatile("tlbie %0,1" : : "r" (va) : "memory");
 		break;
 	}
@@ -74,7 +74,7 @@
 	default:
 		penc = mmu_psize_defs[psize].penc;
 		va &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
-		va |= (0x7f >> (8 - penc)) << 12;
+		va |= penc << 12;
 		asm volatile(".long 0x7c000224 | (%0 << 11) | (1 << 21)"
 			     : : "r"(va) : "memory");
 		break;

--
