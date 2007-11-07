Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D8B6DDE05
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 10:12:50 +1100 (EST)
Date: Thu, 8 Nov 2007 02:12:52 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <608329302.20071108021252@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [PPC 44x] L2-cache synchronization for ppc44x
MIME-Version: 1.0
Content-Type: text/plain; charset=Windows-1251
Cc: Olof Johansson <olof@lixom.net>
Reply-To: Yuri Tikhonov <yur@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0A This is the updated patch for support synchronization of L2-Cache wi=
th the external memory on the ppc44x-based platforms.

 Differencies against the previous patch-set:
- remove L2_CACHE config option;
- introduce the ppc machdep to invalidate L2 cache lines;
- some code clean-up.

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
Signed-off-by: Pavel Kolesnikov <concord@emcraft.com>

--
diff --git a/arch/powerpc/lib/dma-noncoherent.c b/arch/powerpc/lib/dma-nonc=
oherent.c
index 1947380..b06f05c 100644
--- a/arch/powerpc/lib/dma-noncoherent.c
+++ b/arch/powerpc/lib/dma-noncoherent.c
@@ -31,6 +31,7 @@
 #include <linux/dma-mapping.h>
=20
 #include <asm/tlbflush.h>
+#include <asm/machdep.h>
=20
 /*
  * This address range defaults to a value that is safe for all
@@ -186,6 +187,8 @@ __dma_alloc_coherent(size_t size, dma_addr_t *handle, g=
fp_t gfp)
 =09=09unsigned long kaddr =3D (unsigned long)page_address(page);
 =09=09memset(page_address(page), 0, size);
 =09=09flush_dcache_range(kaddr, kaddr + size);
+=09=09if (ppc_md.l2cache_inv_range)
+=09=09=09ppc_md.l2cache_inv_range(__pa(kaddr), __pa(kaddr + size));
 =09}
=20
 =09/*
@@ -351,12 +354,16 @@ void __dma_sync(void *vaddr, size_t size, int directi=
on)
 =09=09BUG();
 =09case DMA_FROM_DEVICE:=09/* invalidate only */
 =09=09invalidate_dcache_range(start, end);
+=09=09if (ppc_md.l2cache_inv_range)
+=09=09=09ppc_md.l2cache_inv_range(__pa(start), __pa(end));
 =09=09break;
 =09case DMA_TO_DEVICE:=09=09/* writeback only */
 =09=09clean_dcache_range(start, end);
 =09=09break;
 =09case DMA_BIDIRECTIONAL:=09/* writeback and invalidate */
 =09=09flush_dcache_range(start, end);
+=09=09if (ppc_md.l2cache_inv_range)
+=09=09=09ppc_md.l2cache_inv_range(__pa(start), __pa(end));
 =09=09break;
 =09}
 }
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
index 46cf8fa..31c9149 100644
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -25,6 +25,10 @@
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
=20
+#ifdef CONFIG_44x
+#include <asm/ibm44x.h>
+#endif
+
 #ifdef CONFIG_8xx
 #define ISYNC_8xx isync
 #else
@@ -386,6 +390,35 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 =09sync=09=09=09=09/* additional sync needed on g4 */
 =09isync
 =09blr
+
+#if defined(CONFIG_44x)
+/*
+ * Invalidate the Level-2 cache lines corresponded to the address
+ * range.
+ *
+ * invalidate_l2cache_range(unsigned long start, unsigned long stop)
+ */
+_GLOBAL(invalidate_l2cache_range)
+=09li=09r5,PPC44X_L2_CACHE_BYTES-1=09/* align on L2-cache line */
+=09andc=09r3,r3,r5
+=09subf=09r4,r3,r4
+=09add=09r4,r4,r5
+=09srwi.=09r4,r4,PPC44X_L2_CACHE_SHIFT
+=09mtctr=09r4
+
+=09lis=09r4, L2C_CMD_INV>>16
+1:=09mtdcr=09DCRN_L2C0_ADDR,r3=09/* write address to invalidate */
+=09mtdcr=09DCRN_L2C0_CMD,r4=09/* issue the Invalidate cmd */
+
+2:=09mfdcr=09r5,DCRN_L2C0_SR=09=09/* wait for complete */
+=09andis.=09r5,r5,L2C_CMD_CLR>>16
+=09beq=092b
+
+=09addi=09r3,r3,PPC44X_L2_CACHE_BYTES=09/* next address to invalidate */
+=09bdnz=091b
+=09blr
+#endif
+
 /*
  * Write any modified data cache blocks out to memory.
  * Does not invalidate the corresponding cache lines (especially for
diff --git a/arch/ppc/syslib/ibm440gx_common.c b/arch/ppc/syslib/ibm440gx_c=
ommon.c
index 6b1a801..64c663f 100644
--- a/arch/ppc/syslib/ibm440gx_common.c
+++ b/arch/ppc/syslib/ibm440gx_common.c
@@ -12,6 +12,8 @@
  */
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
+#include <asm/machdep.h>
+#include <asm/cacheflush.h>
 #include <asm/ibm44x.h>
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -201,6 +203,7 @@ void __init ibm440gx_l2c_enable(void){
=20
 =09asm volatile ("sync; isync" ::: "memory");
 =09local_irq_restore(flags);
+=09ppc_md.l2cache_inv_range =3D invalidate_l2cache_range;
 }
=20
 /* Disable L2 cache */
diff --git a/include/asm-powerpc/cacheflush.h b/include/asm-powerpc/cachefl=
ush.h
index ba667a3..bdebfaa 100644
--- a/include/asm-powerpc/cacheflush.h
+++ b/include/asm-powerpc/cacheflush.h
@@ -49,6 +49,7 @@ extern void flush_dcache_range(unsigned long start, unsig=
ned long stop);
 #ifdef CONFIG_PPC32
 extern void clean_dcache_range(unsigned long start, unsigned long stop);
 extern void invalidate_dcache_range(unsigned long start, unsigned long sto=
p);
+extern void invalidate_l2cache_range(unsigned long start, unsigned long st=
op);
 #endif /* CONFIG_PPC32 */
 #ifdef CONFIG_PPC64
 extern void flush_inval_dcache_range(unsigned long start, unsigned long st=
op);
diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
index 71c6e7e..754f416 100644
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -201,6 +201,8 @@ struct machdep_calls {
 =09void=09=09(*early_serial_map)(void);
 =09void=09=09(*kgdb_map_scc)(void);
=20
+=09void=09=09(*l2cache_inv_range)(unsigned long s, unsigned long e);
+
 =09/*
 =09 * optional PCI "hooks"
 =09 */
diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
index 8078a58..8ac0a13 100644
--- a/include/asm-ppc/ibm44x.h
+++ b/include/asm-ppc/ibm44x.h
@@ -138,7 +138,6 @@
  * The "residual" board information structure the boot loader passes
  * into the kernel.
  */
-#ifndef __ASSEMBLY__
=20
 /*
  * DCRN definitions
@@ -596,6 +595,9 @@
 #define  SRAM_DPC_ENABLE=090x80000000
=20
 /* L2 Cache Controller 440GX/440SP/440SPe */
+#define PPC44X_L2_CACHE_SHIFT=095
+#define PPC44X_L2_CACHE_BYTES=09(1 << PPC44X_L2_CACHE_SHIFT)
+
 #define DCRN_L2C0_CFG=09=090x030
 #define  L2C_CFG_L2M=09=090x80000000
 #define  L2C_CFG_ICU=09=090x40000000
@@ -814,6 +816,5 @@
=20
 #include <asm/ibm4xx.h>
=20
-#endif /* __ASSEMBLY__ */
 #endif /* __ASM_IBM44x_H__ */
 #endif /* __KERNEL__ */
diff --git a/include/asm-ppc/machdep.h b/include/asm-ppc/machdep.h
index 293a444..4e7a270 100644
--- a/include/asm-ppc/machdep.h
+++ b/include/asm-ppc/machdep.h
@@ -80,6 +80,8 @@ struct machdep_calls {
 =09void=09=09(*nvram_write_val)(int addr, unsigned char val);
 =09void=09=09(*nvram_sync)(void);
=20
+=09void=09=09(*l2cache_inv_range)(unsigned long s, unsigned long e);
+
 =09/*
 =09 * optional PCI "hooks"
 =09 */=20
