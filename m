Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7E334DDE02
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 12:22:56 +1100 (EST)
Date: Mon, 19 Nov 2007 19:24:45 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3] [POWERPC] vdso: Fixes for cache block sizes
Message-ID: <20071120012445.GA18896@lixom.net>
References: <20071114192405.GA1637@lixom.net>
	<1195072102.28865.41.camel@pasglop>
	<20071114212823.GA3044@lixom.net>
	<18241.3066.346441.180033@cargo.ozlabs.ibm.com>
	<20071119042519.GA28872@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071119042519.GA28872@lixom.net>
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[POWERPC] vdso: Fixes for cache line sizes

Current VDSO implementation is hardcoded to 128 byte cache blocks,
which are only used on IBM's 64-bit processors.

Convert it to get the  blocks sizes out of vdso_data instead, similar
to how the ppc64 in-kernel cache flush does it.


Signed-off-by: Olof Johansson <olof@lixom.net>

---

Added back the crclr instructions that got removed by mistake when moving over
the in-kernel functions.

-Olof


diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 2c8e756..d67bcd8 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -284,6 +284,10 @@ int main(void)
 	DEFINE(CFG_SYSCALL_MAP32, offsetof(struct vdso_data, syscall_map_32));
 	DEFINE(WTOM_CLOCK_SEC, offsetof(struct vdso_data, wtom_clock_sec));
 	DEFINE(WTOM_CLOCK_NSEC, offsetof(struct vdso_data, wtom_clock_nsec));
+	DEFINE(CFG_ICACHE_BLOCKSZ, offsetof(struct vdso_data, icache_block_size));
+	DEFINE(CFG_DCACHE_BLOCKSZ, offsetof(struct vdso_data, dcache_block_size));
+	DEFINE(CFG_ICACHE_LOGBLOCKSZ, offsetof(struct vdso_data, icache_log_block_size));
+	DEFINE(CFG_DCACHE_LOGBLOCKSZ, offsetof(struct vdso_data, dcache_log_block_size));
 #ifdef CONFIG_PPC64
 	DEFINE(CFG_SYSCALL_MAP64, offsetof(struct vdso_data, syscall_map_64));
 	DEFINE(TVAL64_TV_SEC, offsetof(struct timeval, tv_sec));
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 2322ba5..3702df7 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -699,11 +699,22 @@ static int __init vdso_init(void)
 	vdso_data->icache_size = ppc64_caches.isize;
 	vdso_data->icache_line_size = ppc64_caches.iline_size;
 
+	/* XXXOJN: Blocks should be added to ppc64_caches and used instead */
+	vdso_data->dcache_block_size = ppc64_caches.dline_size;
+	vdso_data->icache_block_size = ppc64_caches.iline_size;
+	vdso_data->dcache_log_block_size = ppc64_caches.log_dline_size;
+	vdso_data->icache_log_block_size = ppc64_caches.log_iline_size;
+
 	/*
 	 * Calculate the size of the 64 bits vDSO
 	 */
 	vdso64_pages = (&vdso64_end - &vdso64_start) >> PAGE_SHIFT;
 	DBG("vdso64_kbase: %p, 0x%x pages\n", vdso64_kbase, vdso64_pages);
+#else
+	vdso_data->dcache_block_size = L1_CACHE_BYTES;
+	vdso_data->dcache_log_block_size = L1_CACHE_SHIFT;
+	vdso_data->icache_block_size = L1_CACHE_BYTES;
+	vdso_data->icache_log_block_size = L1_CACHE_SHIFT;
 #endif /* CONFIG_PPC64 */
 
 
diff --git a/arch/powerpc/kernel/vdso32/cacheflush.S b/arch/powerpc/kernel/vdso32/cacheflush.S
index 9cb3199..1ba6feb 100644
--- a/arch/powerpc/kernel/vdso32/cacheflush.S
+++ b/arch/powerpc/kernel/vdso32/cacheflush.S
@@ -23,29 +23,46 @@
  *
  * Flushes the data cache & invalidate the instruction cache for the
  * provided range [start, end[
- *
- * Note: all CPUs supported by this kernel have a 128 bytes cache
- * line size so we don't have to peek that info from the datapage
  */
 V_FUNCTION_BEGIN(__kernel_sync_dicache)
   .cfi_startproc
-	li	r5,127
-	andc	r6,r3,r5		/* round low to line bdy */
+	mflr	r12
+  .cfi_register lr,r12
+	mr	r11,r3
+	bl	__get_datapage@local
+	mtlr	r12
+	mr	r10,r3
+
+	lwz	r7,CFG_DCACHE_BLOCKSZ(r10)
+	addi	r5,r7,-1
+	andc	r6,r11,r5		/* round low to line bdy */
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5		/* ensure we get enough */
-	srwi.	r8,r8,7			/* compute line count */
+	lwz	r9,CFG_DCACHE_LOGBLOCKSZ(r10)
+	srw.	r8,r8,r9		/* compute line count */
 	crclr	cr0*4+so
 	beqlr				/* nothing to do? */
 	mtctr	r8
-	mr	r3,r6
-1:	dcbst	0,r3
-	addi	r3,r3,128
+1:	dcbst	0,r6
+	add	r6,r6,r7
 	bdnz	1b
 	sync
+
+/* Now invalidate the instruction cache */
+
+	lwz	r7,CFG_ICACHE_BLOCKSZ(r10)
+	addi	r5,r7,-1
+	andc	r6,r11,r5		/* round low to line bdy */
+	subf	r8,r6,r4		/* compute length */
+	add	r8,r8,r5
+	lwz	r9,CFG_ICACHE_LOGBLOCKSZ(r10)
+	srw.	r8,r8,r9		/* compute line count */
+	crclr	cr0*4+so
+	beqlr				/* nothing to do? */
 	mtctr	r8
-1:	icbi	0,r6
-	addi	r6,r6,128
-	bdnz	1b
+2:	icbi	0,r6
+	add	r6,r6,r7
+	bdnz	2b
 	isync
 	li	r3,0
 	blr
diff --git a/arch/powerpc/kernel/vdso64/cacheflush.S b/arch/powerpc/kernel/vdso64/cacheflush.S
index 66a36d3..69c5af2 100644
--- a/arch/powerpc/kernel/vdso64/cacheflush.S
+++ b/arch/powerpc/kernel/vdso64/cacheflush.S
@@ -23,29 +23,46 @@
  *
  * Flushes the data cache & invalidate the instruction cache for the
  * provided range [start, end[
- *
- * Note: all CPUs supported by this kernel have a 128 bytes cache
- * line size so we don't have to peek that info from the datapage
  */
 V_FUNCTION_BEGIN(__kernel_sync_dicache)
   .cfi_startproc
-	li	r5,127
-	andc	r6,r3,r5		/* round low to line bdy */
+	mflr	r12
+  .cfi_register lr,r12
+	mr	r11,r3
+	bl	V_LOCAL_FUNC(__get_datapage)
+	mtlr	r12
+	mr	r10,r3
+
+	lwz	r7,CFG_DCACHE_BLOCKSZ(r10)
+	addi	r5,r7,-1
+	andc	r6,r11,r5		/* round low to line bdy */
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5		/* ensure we get enough */
-	srwi.	r8,r8,7			/* compute line count */
+	lwz	r9,CFG_DCACHE_LOGBLOCKSZ(r10)
+	srw.	r8,r8,r9		/* compute line count */
 	crclr	cr0*4+so
 	beqlr				/* nothing to do? */
 	mtctr	r8
-	mr	r3,r6
-1:	dcbst	0,r3
-	addi	r3,r3,128
+1:	dcbst	0,r6
+	add	r6,r6,r7
 	bdnz	1b
 	sync
+
+/* Now invalidate the instruction cache */
+
+	lwz	r7,CFG_ICACHE_BLOCKSZ(r10)
+	addi	r5,r7,-1
+	andc	r6,r11,r5		/* round low to line bdy */
+	subf	r8,r6,r4		/* compute length */
+	add	r8,r8,r5
+	lwz	r9,CFG_ICACHE_LOGBLOCKSZ(r10)
+	srw.	r8,r8,r9		/* compute line count */
+	crclr	cr0*4+so
+	beqlr				/* nothing to do? */
 	mtctr	r8
-1:	icbi	0,r6
-	addi	r6,r6,128
-	bdnz	1b
+2:	icbi	0,r6
+	add	r6,r6,r7
+	bdnz	2b
 	isync
 	li	r3,0
 	blr
diff --git a/include/asm-powerpc/vdso_datapage.h b/include/asm-powerpc/vdso_datapage.h
index 8a94f0e..f013932 100644
--- a/include/asm-powerpc/vdso_datapage.h
+++ b/include/asm-powerpc/vdso_datapage.h
@@ -77,6 +77,10 @@ struct vdso_data {
 	/* those additional ones don't have to be located anywhere
 	 * special as they were not part of the original systemcfg
 	 */
+	__u32 dcache_block_size;		/* L1 d-cache block size     */
+	__u32 icache_block_size;		/* L1 i-cache block size     */
+	__u32 dcache_log_block_size;		/* L1 d-cache log block size */
+	__u32 icache_log_block_size;		/* L1 i-cache log block size */
 	__s32 wtom_clock_sec;			/* Wall to monotonic clock */
 	__s32 wtom_clock_nsec;
    	__u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls  */
@@ -99,6 +103,10 @@ struct vdso_data {
 	__s32 wtom_clock_sec;			/* Wall to monotonic clock */
 	__s32 wtom_clock_nsec;
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
+	__u32 dcache_block_size;	/* L1 d-cache block size     */
+	__u32 icache_block_size;	/* L1 i-cache block size     */
+	__u32 dcache_log_block_size;	/* L1 d-cache log block size */
+	__u32 icache_log_block_size;	/* L1 i-cache log block size */
 };
 
 #endif /* CONFIG_PPC64 */
