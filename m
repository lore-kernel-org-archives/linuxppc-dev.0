Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3FC3DE007
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 09:59:18 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH][v4] powerpc 44x: support for 256KB PAGE_SIZE
Date: Tue, 13 Jan 2009 01:49:43 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200901130149.43588.yur@emcraft.com>
Cc: wd@denx.de, dzu@denx.de, miltonm@bga.com, paulus@samba.org,
	hugh@veritas.com, akpm@linux-foundation.org, prodyuth@gmail.com,
	yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for 256KB pages on ppc44x-based boards.

For simplification of implementation with 256KB pages we still assume
2-level paging. As a side effect this leads to wasting extra memory space
reserved for PTE tables: only 1/4 of pages allocated for PTEs are
actually used. But this may be an acceptable trade-off to achieve the
high performance we have with big PAGE_SIZEs in some applications (e.g.
RAID).

Also with 256KB PAGE_SIZE we increase THREAD_SIZE up to 32KB to minimize
the risk of stack overflows in the cases of on-stack arrays, which size
depends on the page size (e.g. multipage BIOs, NTFS, etc.).

With 256KB PAGE_SIZE we need to decrease the PKMAP_ORDER at least down
to 9, otherwise all high memory (2 ^ 10 * PAGE_SIZE == 256MB) we'll be
occupied by PKMAP addresses leaving no place for vmalloc. We do not
separate PKMAP_ORDER for 256K from 16K/64K PAGE_SIZE here; actually that
value of 10 in support for 16K/64K had been selected rather intuitively.
Thus now for all cases of PAGE_SIZE on ppc44x (including the default, 4KB,
one) we have 512 pages for PKMAP.

Because ELF standard supports only page sizes up to 64K, then you should
use binutils later than 2.17.50.0.3 with '-zmax-page-size' set to 256K
for building applications, which are to be run with the 256KB-page sized
kernel. If using the older binutils, then you should patch them like follows:

--- binutils/bfd/elf32-ppc.c.orig
+++ binutils/bfd/elf32-ppc.c

-#define ELF_MAXPAGESIZE                0x10000
+#define ELF_MAXPAGESIZE                0x40000

One more restriction we currently have with 256KB page sizes is inability
to use shmem safely, so, for now, the 256KB is available only if you turn
the CONFIG_SHMEM option off.
Though, if you need shmem with 256KB pages, you can always remove the !SHMEM
dependency in 'config PPC_256K_PAGES', and use the workaround available here:
 http://lkml.org/lkml/2008/12/19/20

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 arch/powerpc/Kconfig                   |   15 +++++++++++++++
 arch/powerpc/include/asm/highmem.h     |   10 +++++-----
 arch/powerpc/include/asm/mmu-44x.h     |    2 ++
 arch/powerpc/include/asm/page.h        |    6 ++++--
 arch/powerpc/include/asm/page_32.h     |    4 ++++
 arch/powerpc/include/asm/thread_info.h |    4 +++-
 arch/powerpc/kernel/head_booke.h       |   11 ++++++++++-
 arch/powerpc/platforms/44x/Kconfig     |   12 ++++++++++++
 8 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 84b8613..18f33ef 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -443,6 +443,19 @@ config PPC_64K_PAGES
 	bool "64k page size" if 44x || PPC_STD_MMU_64
 	select PPC_HAS_HASH_64K if PPC_STD_MMU_64
 
+config PPC_256K_PAGES
+	bool "256k page size" if 44x
+	depends on !STDBINUTILS && !SHMEM
+	help
+	  Make the page size 256k.
+
+	  As the ELF standard only requires alignment to support page
+	  sizes up to 64k, you will need to compile all of your user
+	  space applications with a non-standard binutils settings
+	  (see the STDBINUTILS description for details).
+
+	  Say N unless you know what you are doing.
+
 endchoice
 
 config FORCE_MAX_ZONEORDER
@@ -455,6 +468,8 @@ config FORCE_MAX_ZONEORDER
 	default "9" if PPC_STD_MMU_32 && PPC_16K_PAGES
 	range 7 64 if PPC_STD_MMU_32 && PPC_64K_PAGES
 	default "7" if PPC_STD_MMU_32 && PPC_64K_PAGES
+	range 5 64 if PPC_STD_MMU_32 && PPC_256K_PAGES
+	default "5" if PPC_STD_MMU_32 && PPC_256K_PAGES
 	range 11 64
 	default "11"
 	help
diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/asm/highmem.h
index 04e4a62..a290759 100644
--- a/arch/powerpc/include/asm/highmem.h
+++ b/arch/powerpc/include/asm/highmem.h
@@ -39,15 +39,15 @@ extern pte_t *pkmap_page_table;
  * chunk of RAM.
  */
 /*
- * We use one full pte table with 4K pages. And with 16K/64K pages pte
- * table covers enough memory (32MB and 512MB resp.) that both FIXMAP
- * and PKMAP can be placed in single pte table. We use 1024 pages for
- * PKMAP in case of 16K/64K pages.
+ * We use one full pte table with 4K pages. And with 16K/64K/256K pages pte
+ * table covers enough memory (32MB/512MB/2GB resp.), so that both FIXMAP
+ * and PKMAP can be placed in a single pte table. We use 512 pages for PKMAP
+ * in case of 16K/64K/256K page sizes.
  */
 #ifdef CONFIG_PPC_4K_PAGES
 #define PKMAP_ORDER	PTE_SHIFT
 #else
-#define PKMAP_ORDER	10
+#define PKMAP_ORDER	9
 #endif
 #define LAST_PKMAP	(1 << PKMAP_ORDER)
 #ifndef CONFIG_PPC_4K_PAGES
diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
index 27cc6fd..3c86576 100644
--- a/arch/powerpc/include/asm/mmu-44x.h
+++ b/arch/powerpc/include/asm/mmu-44x.h
@@ -83,6 +83,8 @@ typedef struct {
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_16K
 #elif (PAGE_SHIFT == 16)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_64K
+#elif (PAGE_SHIFT == 18)
+#define PPC44x_TLBE_SIZE	PPC44x_TLB_256K
 #else
 #error "Unsupported PAGE_SIZE"
 #endif
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 197d569..32cbf16 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -19,12 +19,14 @@
 #include <asm/kdump.h>
 
 /*
- * On regular PPC32 page size is 4K (but we support 4K/16K/64K pages
+ * On regular PPC32 page size is 4K (but we support 4K/16K/64K/256K pages
  * on PPC44x). For PPC64 we support either 4K or 64K software
  * page size. When using 64K pages however, whether we are really supporting
  * 64K pages in HW or not is irrelevant to those definitions.
  */
-#if defined(CONFIG_PPC_64K_PAGES)
+#if defined(CONFIG_PPC_256K_PAGES)
+#define PAGE_SHIFT		18
+#elif defined(CONFIG_PPC_64K_PAGES)
 #define PAGE_SHIFT		16
 #elif defined(CONFIG_PPC_16K_PAGES)
 #define PAGE_SHIFT		14
diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
index 1458d95..a0e3f6e 100644
--- a/arch/powerpc/include/asm/page_32.h
+++ b/arch/powerpc/include/asm/page_32.h
@@ -19,7 +19,11 @@
 #define PTE_FLAGS_OFFSET	0
 #endif
 
+#ifdef CONFIG_PPC_256K_PAGES
+#define PTE_SHIFT	(PAGE_SHIFT - PTE_T_LOG2 - 2)	/* 1/4 of a page */
+#else
 #define PTE_SHIFT	(PAGE_SHIFT - PTE_T_LOG2)	/* full page */
+#endif
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 9665a26..e04286f 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -12,8 +12,10 @@
 
 /* We have 8k stacks on ppc32 and 16k on ppc64 */
 
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64)
 #define THREAD_SHIFT		14
+#elif defined(CONFIG_PPC_256K_PAGES)
+#define THREAD_SHIFT		15
 #else
 #define THREAD_SHIFT		13
 #endif
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index fce2df9..17803ad 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -10,6 +10,15 @@
 		mtspr	SPRN_IVOR##vector_number,r26;	\
 		sync
 
+#if (THREAD_SHIFT < 15)
+#define ALLOC_STACK_FRAME(reg, val)			\
+	addi reg,reg,val
+#else
+#define ALLOC_STACK_FRAME(reg, val)			\
+	addis	reg,reg,val@ha;				\
+	addi	reg,reg,val@l
+#endif
+
 #define NORMAL_EXCEPTION_PROLOG						     \
 	mtspr	SPRN_SPRG0,r10;		/* save two registers to work with */\
 	mtspr	SPRN_SPRG1,r11;						     \
@@ -20,7 +29,7 @@
 	beq	1f;							     \
 	mfspr	r1,SPRN_SPRG3;		/* if from user, start at top of   */\
 	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
-	addi	r1,r1,THREAD_SIZE;					     \
+	ALLOC_STACK_FRAME(r1, THREAD_SIZE);				     \
 1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
 	mr	r11,r1;							     \
 	stw	r10,_CCR(r11);          /* save various registers	   */\
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 3496bc0..d02e8c8 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -214,6 +214,18 @@ config 440SPe
 	bool
 	select IBM_NEW_EMAC_EMAC4
 
+config STDBINUTILS
+	bool "Using standard binutils settings"
+	depends on 44x
+	default y
+	help
+	  Turning this option off allows you to select 256KB PAGE_SIZE on 44x.
+	  Note, that kernel will be able to run only those applications,
+	  which had been compiled using binutils later than 2.17.50.0.3 with
+	  '-zmax-page-size' set to 256K (the default is 64K). Or, if using
+	  the older binutils, you can patch them with a trivial patch, which
+	  changes the ELF_MAXPAGESIZE definition from 0x10000 to 0x40000.
+
 config 460EX
 	bool
 	select PPC_FPU
-- 
1.6.0.6
