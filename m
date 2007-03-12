Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id B76FEDDDE5
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 08:52:35 +1100 (EST)
Received: from ubuntu (achn-4db49677.pool.einsundeins.de [77.180.150.119])
	by post.webmailer.de (klopstock mo13) (RZmta 4.10)
	with ESMTP id A04705j2CKaBeJ for <linuxppc-dev@ozlabs.org>;
	Mon, 12 Mar 2007 22:52:33 +0100 (MET)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
Date: Mon, 12 Mar 2007 22:54:26 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200703122254.27087.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for the PAGE_SIZE set equal to 64 KB on
PPC32 platforms. Increasing the PAGE_SIZE may improve the performance
of the system in some cases.

The RAID processing with the dedicated hardware that offloads the CPU
is one of such cases. Using the bigger PAGE_SIZE we decrease the number
of CPU operations required to process the data blocks, decrease the
control overheads and so improve the overall performance. For example,
changing the PAGE_SIZE from 4KB to 64KB on a Yucca (440SPe) gives ~300%
performance benefit of the full-stripe writing in the (7d+1p) RAID-5
setup.

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
Acked-by: Wolfgang Denk <wd@denx.de>
Acked-by: Stefan Roese <sr@denx.de>

---
commit 1222edca342590c856ca05aa5fed1281ba23c8a3
tree 3bea891dcdee9444b1800a00a1e0f33c157b254d
parent be521466feb3bb1cd89de82a2b1d080e9ebd3cb6
author Yuri Tikhonov <yur@emcraft.com> Mon, 12 Mar 2007 22:49:21 +0100
committer Stefan Roese <sr@denx.de> Mon, 12 Mar 2007 22:49:21 +0100

 arch/ppc/Kconfig               |   10 ++++++++
 arch/ppc/kernel/head_44x.S     |   23 ++++++++++---------
 arch/ppc/kernel/misc.S         |   13 ++++++-----
 arch/ppc/kernel/vmlinux.lds.S  |   15 +++++++-----
 include/asm-ppc/page.h         |    6 ++++-
 include/asm-ppc/ppc_page_asm.h |   49 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 91 insertions(+), 25 deletions(-)

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index ccce2a4..c087f5a 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1174,6 +1174,16 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config PPC_PAGE_SHIFT
+	int "Page size (12=>4KB; 16=>64KB)"
+	default "12"
+	range 12 16
+	help
+	  The PAGE_SIZE definition. Increasing the page size may 
+	  improve the system performance in some dedicated cases.
+
+	  If unsure, set it to 12 (4KB).
+
 endmenu
 
 config ISA_DMA_API
diff --git a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
index 7e44de5..65c6a11 100644
--- a/arch/ppc/kernel/head_44x.S
+++ b/arch/ppc/kernel/head_44x.S
@@ -38,6 +38,7 @@
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/ppc_page_asm.h>
 #include "head_booke.h"
 
 
@@ -183,7 +184,7 @@ skpinv:	addi	r4,r4,1				/* Increment */
 	 */
  	/* pageid fields */
 	lis	r3,UART0_IO_BASE@h
-	ori	r3,r3,PPC44x_TLB_VALID | PPC44x_TLB_4K
+	ori	r3,r3,PPC44x_TLB_VALID | PPC44x_TLB_SIZE
 
 	/* xlat fields */
 	lis	r4,UART0_PHYS_IO_BASE@h		/* RPN depends on SoC */
@@ -363,12 +364,12 @@ interrupt_base:
 4:
 	mtspr   SPRN_MMUCR,r12
 
-	rlwinm  r12, r10, 13, 19, 29    /* Compute pgdir/pmd offset */
+	rlwinm  r12, r10, PPC44x_PGD_OFF_SH, PPC44x_PGD_OFF_M1, 29 /* Compute pgdir/pmd offset */
 	lwzx    r11, r12, r11           /* Get pgd/pmd entry */
 	rlwinm. r12, r11, 0, 0, 20      /* Extract pt base address */
 	beq     2f                      /* Bail if no table */
 
-	rlwimi  r12, r10, 23, 20, 28    /* Compute pte address */
+	rlwimi  r12, r10, PPC44x_PTE_ADD_SH, PPC44x_PTE_ADD_M1, 28    /* Compute pte address */
 	lwz     r11, 4(r12)             /* Get pte entry */
 
 	andi.	r13, r11, _PAGE_RW	/* Is it writeable? */
@@ -502,12 +503,12 @@ interrupt_base:
 4:
 	mtspr	SPRN_MMUCR,r12
 
-	rlwinm 	r12, r10, 13, 19, 29	/* Compute pgdir/pmd offset */
+	rlwinm 	r12, r10, PPC44x_PGD_OFF_SH, PPC44x_PGD_OFF_M1, 29 /* Compute pgdir/pmd offset */
 	lwzx	r11, r12, r11		/* Get pgd/pmd entry */
 	rlwinm.	r12, r11, 0, 0, 20	/* Extract pt base address */
 	beq	2f			/* Bail if no table */
 
-	rlwimi	r12, r10, 23, 20, 28	/* Compute pte address */
+	rlwimi	r12, r10, PPC44x_PTE_ADD_SH, PPC44x_PTE_ADD_M1, 28	/* Compute pte address */
 	lwz	r11, 4(r12)		/* Get pte entry */
 	andi.	r13, r11, _PAGE_PRESENT	/* Is the page present? */
 	beq	2f			/* Bail if not present */
@@ -572,12 +573,12 @@ interrupt_base:
 4:
 	mtspr	SPRN_MMUCR,r12
 
-	rlwinm	r12, r10, 13, 19, 29	/* Compute pgdir/pmd offset */
+	rlwinm	r12, r10, PPC44x_PGD_OFF_SH, PPC44x_PGD_OFF_M1, 29 /* Compute pgdir/pmd offset */
 	lwzx	r11, r12, r11		/* Get pgd/pmd entry */
 	rlwinm.	r12, r11, 0, 0, 20	/* Extract pt base address */
 	beq	2f			/* Bail if no table */
 
-	rlwimi	r12, r10, 23, 20, 28	/* Compute pte address */
+	rlwimi	r12, r10, PPC44x_PTE_ADD_SH, PPC44x_PTE_ADD_M1, 28	/* Compute pte address */
 	lwz	r11, 4(r12)		/* Get pte entry */
 	andi.	r13, r11, _PAGE_PRESENT	/* Is the page present? */
 	beq	2f			/* Bail if not present */
@@ -656,14 +657,14 @@ finish_tlb_load:
 
 	lwz	r11, 0(r12)			/* Get MS word of PTE */
 	lwz	r12, 4(r12)			/* Get LS word of PTE */
-	rlwimi	r11, r12, 0, 0 , 19		/* Insert RPN */
+	rlwimi	r11, r12, 0, 0 , PPC44x_RPN_M2	/* Insert RPN */
 	tlbwe	r11, r13, PPC44x_TLB_XLAT	/* Write XLAT */
 
 	/*
 	 * Create PAGEID. This is the faulting address,
 	 * page size, and valid flag.
 	 */
-	li	r11, PPC44x_TLB_VALID | PPC44x_TLB_4K
+	li	r11, PPC44x_TLB_VALID | PPC44x_TLB_SIZE
 	rlwimi	r10, r11, 0, 20, 31		/* Insert valid and page size */
 	tlbwe	r10, r13, PPC44x_TLB_PAGEID	/* Write PAGEID */
 
@@ -740,12 +741,12 @@ _GLOBAL(set_context)
  * goes at the beginning of the data segment, which is page-aligned.
  */
 	.data
-	.align	12
+	.align	PAGE_SHIFT
 	.globl	sdata
 sdata:
 	.globl	empty_zero_page
 empty_zero_page:
-	.space	4096
+	.space	PAGE_SIZE
 
 /*
  * To support >32-bit physical addresses, we use an 8KB pgdir.
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
index d319f9b..38a819b 100644
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -17,6 +17,7 @@
 #include <asm/errno.h>
 #include <asm/processor.h>
 #include <asm/page.h>
+#include <asm/ppc_page_asm.h>
 #include <asm/cache.h>
 #include <asm/cputable.h>
 #include <asm/mmu.h>
@@ -473,8 +474,8 @@ _GLOBAL(__flush_dcache_icache)
 BEGIN_FTR_SECTION
 	blr					/* for 601, do nothing */
 END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)
-	rlwinm	r3,r3,0,0,19			/* Get page base address */
-	li	r4,4096/L1_CACHE_BYTES	/* Number of lines in a page */
+	rlwinm	r3,r3,0,0,PPC44x_RPN_M2		/* Get page base address */
+	li	r4,PAGE_SIZE/L1_CACHE_BYTES	/* Number of lines in a page */
 	mtctr	r4
 	mr	r6,r3
 0:	dcbst	0,r3				/* Write line to ram */
@@ -505,8 +506,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)
 	rlwinm	r0,r10,0,28,26			/* clear DR */
 	mtmsr	r0
 	isync
-	rlwinm	r3,r3,0,0,19			/* Get page base address */
-	li	r4,4096/L1_CACHE_BYTES	/* Number of lines in a page */
+	rlwinm	r3,r3,0,0,PPC44x_RPN_M2		/* Get page base address */
+	li	r4,PAGE_SIZE/L1_CACHE_BYTES	/* Number of lines in a page */
 	mtctr	r4
 	mr	r6,r3
 0:	dcbst	0,r3				/* Write line to ram */
@@ -530,7 +531,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)
  * void clear_pages(void *page, int order) ;
  */
 _GLOBAL(clear_pages)
-	li	r0,4096/L1_CACHE_BYTES
+	li	r0,PAGE_SIZE/L1_CACHE_BYTES
 	slw	r0,r0,r4
 	mtctr	r0
 #ifdef CONFIG_8xx
@@ -588,7 +589,7 @@ _GLOBAL(copy_page)
 	dcbt	r5,r4
 	li	r11,L1_CACHE_BYTES+4
 #endif /* MAX_COPY_PREFETCH */
-	li	r0,4096/L1_CACHE_BYTES - MAX_COPY_PREFETCH
+	li	r0,PAGE_SIZE/L1_CACHE_BYTES - MAX_COPY_PREFETCH
 	crclr	4*cr0+eq
 2:
 	mtctr	r0
diff --git a/arch/ppc/kernel/vmlinux.lds.S b/arch/ppc/kernel/vmlinux.lds.S
index a062556..73cd0b3 100644
--- a/arch/ppc/kernel/vmlinux.lds.S
+++ b/arch/ppc/kernel/vmlinux.lds.S
@@ -1,4 +1,5 @@
 #include <asm-generic/vmlinux.lds.h>
+#include <asm/page.h>
 
 OUTPUT_ARCH(powerpc:common)
 jiffies = jiffies_64 + 4;
@@ -64,7 +65,7 @@ SECTIONS
 	}
 
   /* Read-write section, merged into data segment: */
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
   .data    :
   {
     *(.data)
@@ -76,10 +77,10 @@ SECTIONS
     CONSTRUCTORS
   }
 
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
   __nosave_begin = .;
   .data_nosave : { *(.data.nosave) }
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
   __nosave_end = .;
 
   . = ALIGN(32);
@@ -91,7 +92,7 @@ SECTIONS
   . = ALIGN(8192);
   .data.init_task : { *(.data.init_task) }
 
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
   __init_begin = .;
   .init.text : {
 	_sinittext = .;
@@ -136,16 +137,16 @@ SECTIONS
   __per_cpu_end = .;
 
 #ifdef CONFIG_BLK_DEV_INITRD
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
 #endif
 
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
   __init_end = .;
 
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
   _sextratext = .;
   _eextratext = .;
 
diff --git a/include/asm-ppc/page.h b/include/asm-ppc/page.h
index fe95c82..61698ac 100644
--- a/include/asm-ppc/page.h
+++ b/include/asm-ppc/page.h
@@ -4,7 +4,7 @@
 #include <asm/asm-compat.h>
 
 /* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	12
+#define PAGE_SHIFT	CONFIG_PPC_PAGE_SHIFT
 #define PAGE_SIZE	(ASM_CONST(1) << PAGE_SHIFT)
 
 /*
@@ -28,7 +28,11 @@
  */
 #ifdef CONFIG_PTE_64BIT
 typedef unsigned long long pte_basic_t;
+#if (PAGE_SHIFT == 16) && defined(CONFIG_PPC32)
+#define PTE_SHIFT	(PAGE_SHIFT - 11)	/* 256 ptes per table*/
+#else
 #define PTE_SHIFT	(PAGE_SHIFT - 3)	/* 512 ptes per page */
+#endif
 #define PTE_FMT		"%16Lx"
 #else
 typedef unsigned long pte_basic_t;
diff --git a/include/asm-ppc/ppc_page_asm.h b/include/asm-ppc/ppc_page_asm.h
new file mode 100644
index 0000000..518ee27
--- /dev/null
+++ b/include/asm-ppc/ppc_page_asm.h
@@ -0,0 +1,49 @@
+/*
+ * include/asm/ppc_page_asm.h
+ *
+ * 2007 (C) DENX Software Engineering.
+ *
+ *  This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of
+ * any kind, whether express or implied.
+ *
+ *  The page definitions used in the asm files ppc_44x.S and misc.S. 
+ * PAGE_SIZE = 4K and 64K are only supported on the PPC44x.
+ *
+ */
+#ifndef PPC_PAGE_ASM_H
+#define PPC_PAGE_ASM_H
+
+#include <asm/page.h>
+
+#if (PAGE_SHIFT == 12)
+/* 
+ * PAGE_SIZE  4K 
+ * PAGE_SHIFT 12
+ * PTE_SHIFT   9
+ * PMD_SHIFT  21
+ */
+#define PPC44x_TLB_SIZE		PPC44x_TLB_4K
+#define PPC44x_PGD_OFF_SH	13 /*(32 - PMD_SHIFT + 2)*/
+#define PPC44x_PGD_OFF_M1	19 /*(PMD_SHIFT - 2)*/
+#define PPC44x_PTE_ADD_SH	23 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
+#define PPC44x_PTE_ADD_M1	20 /*32 - 3 - PTE_SHIFT*/
+#define PPC44x_RPN_M2		19 /*31 - PAGE_SHIFT*/
+#elif (PAGE_SHIFT == 16)
+/*
+ * PAGE_SIZE  64K
+ * PAGE_SHIFT 16
+ * PTE_SHIFT   5
+ * PMD_SHIFT  21
+ */
+#define PPC44x_TLB_SIZE		PPC44x_TLB_64K
+#define PPC44x_PGD_OFF_SH	13 /*(32 - PMD_SHIFT + 2)*/
+#define PPC44x_PGD_OFF_M1	19 /*(PMD_SHIFT - 2)*/
+#define PPC44x_PTE_ADD_SH	19 /*32 - PMD_SHIFT + PTE_SHIFT + 3*/
+#define PPC44x_PTE_ADD_M1	24 /*32 - 3 - PTE_SHIFT*/
+#define PPC44x_RPN_M2		15 /*31 - PAGE_SHIFT*/
+#else
+#error "Unsupported PAGE_SIZE"
+#endif
+
+#endif
