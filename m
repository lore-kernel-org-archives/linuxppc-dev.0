Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F060FDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 11:13:40 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n1B0Dam5029740
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 18:13:37 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl-booke: Add new ISA 2.06 page sizes and MAS defines
Date: Tue, 10 Feb 2009 18:13:36 -0600
Message-Id: <1234311216-13481-1-git-send-email-galak@kernel.crashing.org>
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
that are defined as part of the 2.06 ISA.

Note, its still invalid to try and use a page size that isn't supported
by cpu.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/mmu-fsl-booke.h |   54 ++++++++++++++++++++----------
 arch/powerpc/kernel/head_fsl_booke.S     |    2 +-
 arch/powerpc/mm/fsl_booke_mmu.c          |    2 +-
 3 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-fsl-booke.h b/arch/powerpc/include/asm/mmu-fsl-booke.h
index 3f941c0..e223d3b 100644
--- a/arch/powerpc/include/asm/mmu-fsl-booke.h
+++ b/arch/powerpc/include/asm/mmu-fsl-booke.h
@@ -6,21 +6,37 @@
 
 /* Book-E defined page sizes */
 #define BOOKE_PAGESZ_1K		0
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
+#define BOOKE_PAGESZ_2K		1
+#define BOOKE_PAGESZ_4K		2
+#define BOOKE_PAGESZ_8K		3
+#define BOOKE_PAGESZ_16K	4
+#define BOOKE_PAGESZ_32K	5
+#define BOOKE_PAGESZ_64K	6
+#define BOOKE_PAGESZ_128K	7
+#define BOOKE_PAGESZ_256K	8
+#define BOOKE_PAGESZ_512K	9
+#define BOOKE_PAGESZ_1M		10
+#define BOOKE_PAGESZ_2M		11
+#define BOOKE_PAGESZ_4M		12
+#define BOOKE_PAGESZ_8M		13
+#define BOOKE_PAGESZ_16M	14
+#define BOOKE_PAGESZ_32M	15
+#define BOOKE_PAGESZ_64M	16
+#define BOOKE_PAGESZ_128M	17
+#define BOOKE_PAGESZ_256M	18
+#define BOOKE_PAGESZ_512M	19
+#define BOOKE_PAGESZ_1GB	20
+#define BOOKE_PAGESZ_2GB	21
+#define BOOKE_PAGESZ_4GB	22
+#define BOOKE_PAGESZ_8GB	23
+#define BOOKE_PAGESZ_16GB	24
+#define BOOKE_PAGESZ_32GB	25
+#define BOOKE_PAGESZ_64GB	26
+#define BOOKE_PAGESZ_128GB	27
+#define BOOKE_PAGESZ_256GB	28
+#define BOOKE_PAGESZ_512GB	29
+#define BOOKE_PAGESZ_1TB	30
+#define BOOKE_PAGESZ_2TB	31
 
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
+#define MAS6_ISIZE	MAS1_TSIZE(x)
 #define MAS6_SAS	0x00000001
 #define MAS6_SPID	MAS6_SPID0
 
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 64ecb16..7f49af7 100644
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
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 0b9ba6b..54f3631 100644
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
