Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F1B9667A3F
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 11:56:12 +1000 (EST)
Date: Wed, 28 Jun 2006 11:55:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] Consolidate some of kernel/misc*.S
Message-Id: <20060628115549.64a00962.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


There were some common functions (mainly i/o).

Also some small white space cleanups and remove a couple of small unused
functions.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/Makefile  |    3 -
 arch/powerpc/kernel/misc.S    |  203 +++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/misc_32.S |  156 --------------------------------
 arch/powerpc/kernel/misc_64.S |  181 +------------------------------------
 4 files changed, 209 insertions(+), 334 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 803858e..814f242 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -50,7 +50,8 @@ extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_bo
 extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-y				+= vmlinux.lds
 
-obj-y				+= time.o prom.o traps.o setup-common.o udbg.o
+obj-y				+= time.o prom.o traps.o setup-common.o \
+				   udbg.o misc.o
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o misc_32.o
 obj-$(CONFIG_PPC64)		+= misc_64.o dma_64.o iommu.o
 obj-$(CONFIG_PPC_MULTIPLATFORM)	+= prom_init.o
diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
new file mode 100644
index 0000000..fc23040
--- /dev/null
+++ b/arch/powerpc/kernel/misc.S
@@ -0,0 +1,203 @@
+/*
+ * This file contains miscellaneous low-level functions.
+ *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
+ *
+ * Largely rewritten by Cort Dougan (cort@cs.nmt.edu)
+ * and Paul Mackerras.
+ *
+ * Adapted for iSeries by Mike Corrigan (mikejc@us.ibm.com)
+ * PPC64 updates by Dave Engebretsen (engebret@us.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <asm/ppc_asm.h>
+
+	.text
+
+#ifdef CONFIG_PPC64
+#define IN_SYNC		twi	0,r5,0; isync
+#define EIEIO_32
+#define SYNC_64		sync
+#else /* CONFIG_PPC32 */
+#define IN_SYNC
+#define EIEIO_32	eieio
+#define SYNC_64
+#endif
+/*
+ * Returns (address we are running at) - (address we were linked at)
+ * for use before the text and data are mapped to KERNELBASE.
+ */
+
+_GLOBAL(reloc_offset)
+	mflr	r0
+	bl	1f
+1:	mflr	r3
+	LOAD_REG_IMMEDIATE(r4,1b)
+	subf	r3,r4,r3
+	mtlr	r0
+	blr
+
+/*
+ * add_reloc_offset(x) returns x + reloc_offset().
+ */
+_GLOBAL(add_reloc_offset)
+	mflr	r0
+	bl	1f
+1:	mflr	r5
+	LOAD_REG_IMMEDIATE(r4,1b)
+	subf	r5,r4,r5
+	add	r3,r3,r5
+	mtlr	r0
+	blr
+
+/*
+ * I/O string operations
+ *
+ * insb(port, buf, len)
+ * outsb(port, buf, len)
+ * insw(port, buf, len)
+ * outsw(port, buf, len)
+ * insl(port, buf, len)
+ * outsl(port, buf, len)
+ * insw_ns(port, buf, len)
+ * outsw_ns(port, buf, len)
+ * insl_ns(port, buf, len)
+ * outsl_ns(port, buf, len)
+ *
+ * The *_ns versions don't do byte-swapping.
+ */
+_GLOBAL(_insb)
+	cmpwi	0,r5,0
+	mtctr	r5
+	subi	r4,r4,1
+	blelr-
+00:	lbz	r5,0(r3)
+	eieio
+	stbu	r5,1(r4)
+	bdnz	00b
+	IN_SYNC
+	blr
+
+_GLOBAL(_outsb)
+	cmpwi	0,r5,0
+	mtctr	r5
+	subi	r4,r4,1
+	blelr-
+00:	lbzu	r5,1(r4)
+	stb	r5,0(r3)
+	EIEIO_32
+	bdnz	00b
+	SYNC_64
+	blr
+
+_GLOBAL(_insw)
+	cmpwi	0,r5,0
+	mtctr	r5
+	subi	r4,r4,2
+	blelr-
+00:	lhbrx	r5,0,r3
+	eieio
+	sthu	r5,2(r4)
+	bdnz	00b
+	IN_SYNC
+	blr
+
+_GLOBAL(_outsw)
+	cmpwi	0,r5,0
+	mtctr	r5
+	subi	r4,r4,2
+	blelr-
+00:	lhzu	r5,2(r4)
+	EIEIO_32
+	sthbrx	r5,0,r3
+	bdnz	00b
+	SYNC_64
+	blr
+
+_GLOBAL(_insl)
+	cmpwi	0,r5,0
+	mtctr	r5
+	subi	r4,r4,4
+	blelr-
+00:	lwbrx	r5,0,r3
+	eieio
+	stwu	r5,4(r4)
+	bdnz	00b
+	IN_SYNC
+	blr
+
+_GLOBAL(_outsl)
+	cmpwi	0,r5,0
+	mtctr	r5
+	subi	r4,r4,4
+	blelr-
+00:	lwzu	r5,4(r4)
+	stwbrx	r5,0,r3
+	EIEIO_32
+	bdnz	00b
+	SYNC_64
+	blr
+
+#ifdef CONFIG_PPC32
+_GLOBAL(__ide_mm_insw)
+#endif
+_GLOBAL(_insw_ns)
+	cmpwi	0,r5,0
+	mtctr	r5
+	subi	r4,r4,2
+	blelr-
+00:	lhz	r5,0(r3)
+	eieio
+	sthu	r5,2(r4)
+	bdnz	00b
+	IN_SYNC
+	blr
+
+#ifdef CONFIG_PPC32
+_GLOBAL(__ide_mm_outsw)
+#endif
+_GLOBAL(_outsw_ns)
+	cmpwi	0,r5,0
+	mtctr	r5
+	subi	r4,r4,2
+	blelr-
+00:	lhzu	r5,2(r4)
+	sth	r5,0(r3)
+	EIEIO_32
+	bdnz	00b
+	SYNC_64
+	blr
+
+#ifdef CONFIG_PPC32
+_GLOBAL(__ide_mm_insl)
+#endif
+_GLOBAL(_insl_ns)
+	cmpwi	0,r5,0
+	mtctr	r5
+	subi	r4,r4,4
+	blelr-
+00:	lwz	r5,0(r3)
+	eieio
+	stwu	r5,4(r4)
+	bdnz	00b
+	IN_SYNC
+	blr
+
+#ifdef CONFIG_PPC32
+_GLOBAL(__ide_mm_outsl)
+#endif
+_GLOBAL(_outsl_ns)
+	cmpwi	0,r5,0
+	mtctr	r5
+	subi	r4,r4,4
+	blelr-
+00:	lwzu	r5,4(r4)
+	stw	r5,0(r3)
+	EIEIO_32
+	bdnz	00b
+	SYNC_64
+	blr
+
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 01d3916..c74774e 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -61,32 +61,6 @@ _GLOBAL(mulhdu)
 	blr
 
 /*
- * Returns (address we're running at) - (address we were linked at)
- * for use before the text and data are mapped to KERNELBASE.
- */
-_GLOBAL(reloc_offset)
-	mflr	r0
-	bl	1f
-1:	mflr	r3
-	LOAD_REG_IMMEDIATE(r4,1b)
-	subf	r3,r4,r3
-	mtlr	r0
-	blr
-
-/*
- * add_reloc_offset(x) returns x + reloc_offset().
- */
-_GLOBAL(add_reloc_offset)
-	mflr	r0
-	bl	1f
-1:	mflr	r5
-	LOAD_REG_IMMEDIATE(r4,1b)
-	subf	r5,r4,r5
-	add	r3,r3,r5
-	mtlr	r0
-	blr
-
-/*
  * sub_reloc_offset(x) returns x - reloc_offset().
  */
 _GLOBAL(sub_reloc_offset)
@@ -781,136 +755,6 @@ _GLOBAL(atomic_set_mask)
 	blr
 
 /*
- * I/O string operations
- *
- * insb(port, buf, len)
- * outsb(port, buf, len)
- * insw(port, buf, len)
- * outsw(port, buf, len)
- * insl(port, buf, len)
- * outsl(port, buf, len)
- * insw_ns(port, buf, len)
- * outsw_ns(port, buf, len)
- * insl_ns(port, buf, len)
- * outsl_ns(port, buf, len)
- *
- * The *_ns versions don't do byte-swapping.
- */
-_GLOBAL(_insb)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,1
-	blelr-
-00:	lbz	r5,0(r3)
-	eieio
-	stbu	r5,1(r4)
-	bdnz	00b
-	blr
-
-_GLOBAL(_outsb)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,1
-	blelr-
-00:	lbzu	r5,1(r4)
-	stb	r5,0(r3)
-	eieio
-	bdnz	00b
-	blr
-
-_GLOBAL(_insw)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,2
-	blelr-
-00:	lhbrx	r5,0,r3
-	eieio
-	sthu	r5,2(r4)
-	bdnz	00b
-	blr
-
-_GLOBAL(_outsw)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,2
-	blelr-
-00:	lhzu	r5,2(r4)
-	eieio
-	sthbrx	r5,0,r3
-	bdnz	00b
-	blr
-
-_GLOBAL(_insl)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,4
-	blelr-
-00:	lwbrx	r5,0,r3
-	eieio
-	stwu	r5,4(r4)
-	bdnz	00b
-	blr
-
-_GLOBAL(_outsl)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,4
-	blelr-
-00:	lwzu	r5,4(r4)
-	stwbrx	r5,0,r3
-	eieio
-	bdnz	00b
-	blr
-
-_GLOBAL(__ide_mm_insw)
-_GLOBAL(_insw_ns)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,2
-	blelr-
-00:	lhz	r5,0(r3)
-	eieio
-	sthu	r5,2(r4)
-	bdnz	00b
-	blr
-
-_GLOBAL(__ide_mm_outsw)
-_GLOBAL(_outsw_ns)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,2
-	blelr-
-00:	lhzu	r5,2(r4)
-	sth	r5,0(r3)
-	eieio
-	bdnz	00b
-	blr
-
-_GLOBAL(__ide_mm_insl)
-_GLOBAL(_insl_ns)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,4
-	blelr-
-00:	lwz	r5,0(r3)
-	eieio
-	stwu	r5,4(r4)
-	bdnz	00b
-	blr
-
-_GLOBAL(__ide_mm_outsl)
-_GLOBAL(_outsl_ns)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,4
-	blelr-
-00:	lwzu	r5,4(r4)
-	stw	r5,0(r3)
-	eieio
-	bdnz	00b
-	blr
-
-/*
  * Extended precision shifts.
  *
  * Updated to be valid for shift counts from 0 to 63 inclusive.
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 6bf4a46..580891c 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -1,14 +1,12 @@
 /*
- *  arch/powerpc/kernel/misc64.S
- *
  * This file contains miscellaneous low-level functions.
  *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
  *
  * Largely rewritten by Cort Dougan (cort@cs.nmt.edu)
  * and Paul Mackerras.
  * Adapted for iSeries by Mike Corrigan (mikejc@us.ibm.com)
- * PPC64 updates by Dave Engebretsen (engebret@us.ibm.com) 
- * 
+ * PPC64 updates by Dave Engebretsen (engebret@us.ibm.com)
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
@@ -30,41 +28,10 @@ #include <asm/thread_info.h>
 
 	.text
 
-/*
- * Returns (address we are running at) - (address we were linked at)
- * for use before the text and data are mapped to KERNELBASE.
- */
-
-_GLOBAL(reloc_offset)
-	mflr	r0
-	bl	1f
-1:	mflr	r3
-	LOAD_REG_IMMEDIATE(r4,1b)
-	subf	r3,r4,r3
-	mtlr	r0
-	blr
-
-/*
- * add_reloc_offset(x) returns x + reloc_offset().
- */
-_GLOBAL(add_reloc_offset)
-	mflr	r0
-	bl	1f
-1:	mflr	r5
-	LOAD_REG_IMMEDIATE(r4,1b)
-	subf	r5,r4,r5
-	add	r3,r3,r5
-	mtlr	r0
-	blr
-
 _GLOBAL(get_msr)
 	mfmsr	r3
 	blr
 
-_GLOBAL(get_dar)
-	mfdar	r3
-	blr
-
 _GLOBAL(get_srr0)
 	mfsrr0  r3
 	blr
@@ -72,10 +39,6 @@ _GLOBAL(get_srr0)
 _GLOBAL(get_srr1)
 	mfsrr1  r3
 	blr
-	
-_GLOBAL(get_sp)
-	mr	r3,r1
-	blr
 
 #ifdef CONFIG_IRQSTACKS
 _GLOBAL(call_do_softirq)
@@ -281,144 +244,6 @@ _GLOBAL(__flush_dcache_icache)
 	bdnz	1b
 	isync
 	blr
-	
-/*
- * I/O string operations
- *
- * insb(port, buf, len)
- * outsb(port, buf, len)
- * insw(port, buf, len)
- * outsw(port, buf, len)
- * insl(port, buf, len)
- * outsl(port, buf, len)
- * insw_ns(port, buf, len)
- * outsw_ns(port, buf, len)
- * insl_ns(port, buf, len)
- * outsl_ns(port, buf, len)
- *
- * The *_ns versions don't do byte-swapping.
- */
-_GLOBAL(_insb)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,1
-	blelr-
-00:	lbz	r5,0(r3)
-	eieio
-	stbu	r5,1(r4)
-	bdnz	00b
-	twi	0,r5,0
-	isync
-	blr
-
-_GLOBAL(_outsb)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,1
-	blelr-
-00:	lbzu	r5,1(r4)
-	stb	r5,0(r3)
-	bdnz	00b
-	sync
-	blr	
-
-_GLOBAL(_insw)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,2
-	blelr-
-00:	lhbrx	r5,0,r3
-	eieio
-	sthu	r5,2(r4)
-	bdnz	00b
-	twi	0,r5,0
-	isync
-	blr
-
-_GLOBAL(_outsw)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,2
-	blelr-
-00:	lhzu	r5,2(r4)
-	sthbrx	r5,0,r3	
-	bdnz	00b
-	sync
-	blr	
-
-_GLOBAL(_insl)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,4
-	blelr-
-00:	lwbrx	r5,0,r3
-	eieio
-	stwu	r5,4(r4)
-	bdnz	00b
-	twi	0,r5,0
-	isync
-	blr
-
-_GLOBAL(_outsl)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,4
-	blelr-
-00:	lwzu	r5,4(r4)
-	stwbrx	r5,0,r3
-	bdnz	00b
-	sync
-	blr	
-
-/* _GLOBAL(ide_insw) now in drivers/ide/ide-iops.c */
-_GLOBAL(_insw_ns)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,2
-	blelr-
-00:	lhz	r5,0(r3)
-	eieio
-	sthu	r5,2(r4)
-	bdnz	00b
-	twi	0,r5,0
-	isync
-	blr
-
-/* _GLOBAL(ide_outsw) now in drivers/ide/ide-iops.c */
-_GLOBAL(_outsw_ns)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,2
-	blelr-
-00:	lhzu	r5,2(r4)
-	sth	r5,0(r3)
-	bdnz	00b
-	sync
-	blr	
-
-_GLOBAL(_insl_ns)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,4
-	blelr-
-00:	lwz	r5,0(r3)
-	eieio
-	stwu	r5,4(r4)
-	bdnz	00b
-	twi	0,r5,0
-	isync
-	blr
-
-_GLOBAL(_outsl_ns)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,4
-	blelr-
-00:	lwzu	r5,4(r4)
-	stw	r5,0(r3)
-	bdnz	00b
-	sync
-	blr	
 
 /*
  * identify_cpu and calls setup_cpu
@@ -563,6 +388,7 @@ _GLOBAL(real_writeb)
 	blr
 #endif /* defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE) */
 
+#ifdef CONFIG_CPU_FREQ_PMAC64
 /*
  * SCOM access functions for 970 (FX only for now)
  *
@@ -631,6 +457,7 @@ _GLOBAL(scom970_write)
 	/* restore interrupts */
 	mtmsrd	r5,1
 	blr
+#endif /* CONFIG_CPU_FREQ_PMAC64 */
 
 
 /*
-- 
1.4.0
