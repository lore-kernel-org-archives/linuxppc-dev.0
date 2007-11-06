Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58A0BDDE05
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 09:40:28 +1100 (EST)
Date: Wed, 7 Nov 2007 01:40:28 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1078030427.20071107014028@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] [PPC 4xx] invalidate_l2cache_range() implementation for
	ppc44x
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sr@denx.de, dzu@denx.de
Reply-To: Yuri Tikhonov <yur@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 Support for L2-cache coherency synchronization routines in ppc44x
processors.


Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
Signed-off-by: Pavel Kolesnikov <concord@emcraft.com>

--
diff --git a/arch/powerpc/lib/dma-noncoherent.c b/arch/powerpc/lib/dma-noncoherent.c
index 1947380..593a425 100644
--- a/arch/powerpc/lib/dma-noncoherent.c
+++ b/arch/powerpc/lib/dma-noncoherent.c
@@ -351,12 +351,18 @@ void __dma_sync(void *vaddr, size_t size, int direction)
                BUG();
        case DMA_FROM_DEVICE:   /* invalidate only */
                invalidate_dcache_range(start, end);
+#ifdef CONFIG_L2_CACHE
+               invalidate_l2cache_range(__pa(start), __pa(end));
+#endif
                break;
        case DMA_TO_DEVICE:             /* writeback only */
                clean_dcache_range(start, end);
                break;
        case DMA_BIDIRECTIONAL: /* writeback and invalidate */
                flush_dcache_range(start, end);
+#ifdef CONFIG_L2_CACHE
+               invalidate_l2cache_range(__pa(start), __pa(end));
+#endif
                break;
        }
 }
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
index 46cf8fa..de62f85 100644
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -386,6 +386,36 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
        sync                            /* additional sync needed on g4 */
        isync
        blr
+
+#ifdef CONFIG_L2_CACHE
+/*
+ * Invalidate the Level-2 cache lines corresponded to the address
+ * range.
+ *
+ * invalidate_l2cache_range(unsigned long start, unsigned long stop)
+ */
+#include <asm/ibm4xx.h>
+_GLOBAL(invalidate_l2cache_range)
+       li      r5,L2_CACHE_BYTES-1     /* do l2-cache line alignment */
+       andc    r3,r3,r5
+       subf    r4,r3,r4
+       add     r4,r4,r5
+       srwi.   r4,r4,L2_CACHE_SHIFT
+       mtctr   r4
+
+       lis     r4, L2C_CMD_INV>>16
+1:     mtdcr   DCRN_L2C0_ADDR,r3       /* write address to invalidate */
+       mtdcr   DCRN_L2C0_CMD,r4        /* issue the Invalidate cmd */
+
+2:     mfdcr   r5,DCRN_L2C0_SR         /* wait for complete */
+       andis.  r5,r5,L2C_CMD_CLR>>16
+        beq    2b
+
+       addi    r3,r3,L2_CACHE_BYTES    /* next address to invalidate */
+       bdnz    1b
+       blr
+#endif
+
 /*
  * Write any modified data cache blocks out to memory.
  * Does not invalidate the corresponding cache lines (especially for
diff --git a/include/asm-powerpc/cache.h b/include/asm-powerpc/cache.h
index 5350704..8a2f9e6 100644
--- a/include/asm-powerpc/cache.h
+++ b/include/asm-powerpc/cache.h
@@ -10,12 +10,14 @@
 #define MAX_COPY_PREFETCH      1
 #elif defined(CONFIG_PPC32)
 #define L1_CACHE_SHIFT         5
+#define L2_CACHE_SHIFT         5
 #define MAX_COPY_PREFETCH      4
 #else /* CONFIG_PPC64 */
 #define L1_CACHE_SHIFT         7
 #endif
 
 #define        L1_CACHE_BYTES          (1 << L1_CACHE_SHIFT)
+#define        L2_CACHE_BYTES          (1 << L2_CACHE_SHIFT)
 
 #define        SMP_CACHE_BYTES         L1_CACHE_BYTES
 
diff --git a/include/asm-powerpc/cacheflush.h b/include/asm-powerpc/cacheflush.h
index ba667a3..bdebfaa 100644
--- a/include/asm-powerpc/cacheflush.h
+++ b/include/asm-powerpc/cacheflush.h
@@ -49,6 +49,7 @@ extern void flush_dcache_range(unsigned long start, unsigned long stop);
 #ifdef CONFIG_PPC32
 extern void clean_dcache_range(unsigned long start, unsigned long stop);
 extern void invalidate_dcache_range(unsigned long start, unsigned long stop);
+extern void invalidate_l2cache_range(unsigned long start, unsigned long stop);
 #endif /* CONFIG_PPC32 */
 #ifdef CONFIG_PPC64
 extern void flush_inval_dcache_range(unsigned long start, unsigned long stop);
diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
index 8078a58..782909a 100644
--- a/include/asm-ppc/ibm44x.h
+++ b/include/asm-ppc/ibm44x.h
@@ -138,7 +138,6 @@
  * The "residual" board information structure the boot loader passes
  * into the kernel.
  */
-#ifndef __ASSEMBLY__
 
 /*
  * DCRN definitions
@@ -814,6 +813,5 @@
 
 #include <asm/ibm4xx.h>
 
-#endif /* __ASSEMBLY__ */
 #endif /* __ASM_IBM44x_H__ */
 #endif /* __KERNEL__ */ 
