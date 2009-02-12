Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71021DDDB5
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 09:46:52 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n1CMkmmc018836
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 16:46:49 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 1/2] powerpc/fsl-booke: Add new ISA 2.06 page sizes and MAS
	defines
Date: Thu, 12 Feb 2009 16:46:47 -0600
Message-Id: <1234478808-31883-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Power ISA 2.06 added power of two page sizes to the embedded MMU
architecture.  Its done it such a way to be code compatiable with the
existing HW.  Made the minor code changes to support both power of two
and power of four page sizes.  Also added some new MAS bits and macros
that are defined as part of the 2.06 ISA.  Renamed some things to use
the 'Book-3e' concept to convey the new MMU that is based on the
Freescale Book-E MMU programming model.

Note, its still invalid to try and use a page size that isn't supported
by cpu.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
* Some minor changes to prime for the rename of mmu-fsl-booke.h -> mmu-book3e.h

 arch/powerpc/include/asm/mmu-fsl-booke.h |   66 +++++++++++++++++++-----------
 arch/powerpc/kernel/head_fsl_booke.S     |   14 +++---
 arch/powerpc/mm/fsl_booke_mmu.c          |    2 +-
 3 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-fsl-booke.h b/arch/powerpc/include/asm/mmu-fsl-booke.h
index 3f941c0..c5363c3 100644
--- a/arch/powerpc/include/asm/mmu-fsl-booke.h
+++ b/arch/powerpc/include/asm/mmu-fsl-booke.h
@@ -1,26 +1,42 @@
-#ifndef _ASM_POWERPC_MMU_FSL_BOOKE_H_
-#define _ASM_POWERPC_MMU_FSL_BOOKE_H_
+#ifndef _ASM_POWERPC_MMU_BOOK3E_H_
+#define _ASM_POWERPC_MMU_BOOK3E_H_
 /*
- * Freescale Book-E MMU support
+ * Freescale Book-E/Book-3e (ISA 2.06+) MMU support
  */
 
-/* Book-E defined page sizes */
-#define BOOKE_PAGESZ_1K		0
-#define BOOKE_PAGESZ_4K		1
-#define BOOKE_PAGESZ_16K	2
-#define BOOKE_PAGESZ_64K	3
-#define BOOKE_PAGESZ_256K	4
-#define BOOKE_PAGESZ_1M		5
-#define BOOKE_PAGESZ_4M		6
-#define BOOKE_PAGESZ_16M	7
-#define BOOKE_PAGESZ_64M	8
-#define BOOKE_PAGESZ_256M	9
-#define BOOKE_PAGESZ_1GB	10
-#define BOOKE_PAGESZ_4GB	11
-#define BOOKE_PAGESZ_16GB	12
-#define BOOKE_PAGESZ_64GB	13
-#define BOOKE_PAGESZ_256GB	14
-#define BOOKE_PAGESZ_1TB	15
+/* Book-3e defined page sizes */
+#define BOOK3E_PAGESZ_1K	0
+#define BOOK3E_PAGESZ_2K	1
+#define BOOK3E_PAGESZ_4K	2
+#define BOOK3E_PAGESZ_8K	3
+#define BOOK3E_PAGESZ_16K	4
+#define BOOK3E_PAGESZ_32K	5
+#define BOOK3E_PAGESZ_64K	6
+#define BOOK3E_PAGESZ_128K	7
+#define BOOK3E_PAGESZ_256K	8
+#define BOOK3E_PAGESZ_512K	9
+#define BOOK3E_PAGESZ_1M	10
+#define BOOK3E_PAGESZ_2M	11
+#define BOOK3E_PAGESZ_4M	12
+#define BOOK3E_PAGESZ_8M	13
+#define BOOK3E_PAGESZ_16M	14
+#define BOOK3E_PAGESZ_32M	15
+#define BOOK3E_PAGESZ_64M	16
+#define BOOK3E_PAGESZ_128M	17
+#define BOOK3E_PAGESZ_256M	18
+#define BOOK3E_PAGESZ_512M	19
+#define BOOK3E_PAGESZ_1GB	20
+#define BOOK3E_PAGESZ_2GB	21
+#define BOOK3E_PAGESZ_4GB	22
+#define BOOK3E_PAGESZ_8GB	23
+#define BOOK3E_PAGESZ_16GB	24
+#define BOOK3E_PAGESZ_32GB	25
+#define BOOK3E_PAGESZ_64GB	26
+#define BOOK3E_PAGESZ_128GB	27
+#define BOOK3E_PAGESZ_256GB	28
+#define BOOK3E_PAGESZ_512GB	29
+#define BOOK3E_PAGESZ_1TB	30
+#define BOOK3E_PAGESZ_2TB	31
 
 #define MAS0_TLBSEL(x)	((x << 28) & 0x30000000)
 #define MAS0_ESEL(x)	((x << 16) & 0x0FFF0000)
@@ -29,8 +45,9 @@
 #define MAS1_VALID 	0x80000000
 #define MAS1_IPROT	0x40000000
 #define MAS1_TID(x)	((x << 16) & 0x3FFF0000)
+#define MAS1_IND	0x00002000
 #define MAS1_TS		0x00001000
-#define MAS1_TSIZE(x)	((x << 8) & 0x00000F00)
+#define MAS1_TSIZE(x)	((x << 7) & 0x00000F80)
 
 #define MAS2_EPN	0xFFFFF000
 #define MAS2_X0		0x00000040
@@ -40,7 +57,7 @@
 #define MAS2_M		0x00000004
 #define MAS2_G		0x00000002
 #define MAS2_E		0x00000001
-#define MAS2_EPN_MASK(size)		(~0 << (2*(size) + 10))
+#define MAS2_EPN_MASK(size)		(~0 << (size + 10))
 #define MAS2_VAL(addr, size, flags)	((addr) & MAS2_EPN_MASK(size) | (flags))
 
 #define MAS3_RPN	0xFFFFF000
@@ -56,7 +73,7 @@
 #define MAS3_SR		0x00000001
 
 #define MAS4_TLBSELD(x) MAS0_TLBSEL(x)
-#define MAS4_TIDDSEL	0x000F0000
+#define MAS4_INDD	0x00008000
 #define MAS4_TSIZED(x)	MAS1_TSIZE(x)
 #define MAS4_X0D	0x00000040
 #define MAS4_X1D	0x00000020
@@ -68,6 +85,7 @@
 
 #define MAS6_SPID0	0x3FFF0000
 #define MAS6_SPID1	0x00007FFE
+#define MAS6_ISIZE(x)	MAS1_TSIZE(x)
 #define MAS6_SAS	0x00000001
 #define MAS6_SPID	MAS6_SPID0
 
@@ -82,4 +100,4 @@ typedef struct {
 } mm_context_t;
 #endif /* !__ASSEMBLY__ */
 
-#endif /* _ASM_POWERPC_MMU_FSL_BOOKE_H_ */
+#endif /* _ASM_POWERPC_MMU_BOOK3E_H_ */
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 64ecb16..4ea6e1a 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -173,7 +173,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 
 	/* grab and fixup the RPN */
 	mfspr	r6,SPRN_MAS1	/* extract MAS1[SIZE] */
-	rlwinm	r6,r6,25,27,30
+	rlwinm	r6,r6,25,27,31
 	li	r8,-1
 	addi	r6,r6,10
 	slw	r6,r8,r6	/* convert to mask */
@@ -199,7 +199,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	xori	r6,r4,1		/* Setup TMP mapping in the other Address space */
 	slwi	r6,r6,12
 	oris	r6,r6,(MAS1_VALID|MAS1_IPROT)@h
-	ori	r6,r6,(MAS1_TSIZE(BOOKE_PAGESZ_4K))@l
+	ori	r6,r6,(MAS1_TSIZE(BOOK3E_PAGESZ_4K))@l
 	mtspr	SPRN_MAS1,r6
 	mfspr	r6,SPRN_MAS2
 	li	r7,0		/* temp EPN = 0 */
@@ -257,10 +257,10 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	lis	r6,0x1000		/* Set MAS0(TLBSEL) = TLB1(1), ESEL = 0 */
 	mtspr	SPRN_MAS0,r6
 	lis	r6,(MAS1_VALID|MAS1_IPROT)@h
-	ori	r6,r6,(MAS1_TSIZE(BOOKE_PAGESZ_64M))@l
+	ori	r6,r6,(MAS1_TSIZE(BOOK3E_PAGESZ_64M))@l
 	mtspr	SPRN_MAS1,r6
-	lis	r6,MAS2_VAL(PAGE_OFFSET, BOOKE_PAGESZ_64M, M_IF_SMP)@h
-	ori	r6,r6,MAS2_VAL(PAGE_OFFSET, BOOKE_PAGESZ_64M, M_IF_SMP)@l
+	lis	r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_SMP)@h
+	ori	r6,r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_SMP)@l
 	mtspr	SPRN_MAS2,r6
 	mtspr	SPRN_MAS3,r8
 	tlbwe
@@ -315,7 +315,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	mtspr	SPRN_IVPR,r4
 
 	/* Setup the defaults for TLB entries */
-	li	r2,(MAS4_TSIZED(BOOKE_PAGESZ_4K))@l
+	li	r2,(MAS4_TSIZED(BOOK3E_PAGESZ_4K))@l
 #ifdef CONFIG_E200
 	oris	r2,r2,MAS4_TLBSELD(1)@h
 #endif
@@ -1116,7 +1116,7 @@ __secondary_start:
 	mtspr	SPRN_SPRG3,r4
 
 	/* Setup the defaults for TLB entries */
-	li	r4,(MAS4_TSIZED(BOOKE_PAGESZ_4K))@l
+	li	r4,(MAS4_TSIZED(BOOK3E_PAGESZ_4K))@l
 	mtspr	SPRN_MAS4,r4
 
 	/* Jump to start_secondary */
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 3d8cf01..6d38d77 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -111,7 +111,7 @@ void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 	unsigned int tsize, lz;
 
 	asm ("cntlzw %0,%1" : "=r" (lz) : "r" (size));
-	tsize = (21 - lz) / 2;
+	tsize = 21 - lz;
 
 #ifdef CONFIG_SMP
 	if ((flags & _PAGE_NO_CACHE) == 0)
-- 
1.5.6.6
