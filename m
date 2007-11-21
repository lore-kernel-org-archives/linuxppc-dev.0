Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 21 Nov 2007 17:16:27 +1100
Subject: [RFC/PATCH 8/14] powerpc: Fix kmalloc alignmenent on non-coherent DMA
In-Reply-To: <1195625777.579001.269266058699.qpush@grosgo>
Message-Id: <20071121061717.57A1CDE1B1@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On platforms doing non-coherent DMA (4xx, 8xx, ...), it's important that
kmalloc minimum alignment is set to the cache line size, to avoid sharing
cache lines between different objects.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 include/asm-powerpc/page_32.h |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-work/include/asm-powerpc/page_32.h
===================================================================
--- linux-work.orig/include/asm-powerpc/page_32.h	2007-11-19 15:01:08.000000000 +1100
+++ linux-work/include/asm-powerpc/page_32.h	2007-11-19 15:01:17.000000000 +1100
@@ -6,6 +6,10 @@
 
 #define PPC_MEMSTART	0
 
+#ifdef CONFIG_NOT_COHERENT_CACHE
+#define ARCH_KMALLOC_MINALIGN	L1_CACHE_BYTES
+#endif
+
 #ifndef __ASSEMBLY__
 /*
  * The basic type of a PTE - 64 bits for those CPUs with > 32 bit
