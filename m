Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49493DDF1E
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 17:50:31 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc 44x: support for 256KB PAGE_SIZE
Date: Fri, 19 Dec 2008 09:39:46 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200812190939.46733.yur@emcraft.com>
Cc: wd@denx.de, yanok@emcraft.com, miltonm@bga.com, paulus@samba.org,
	dzu@denx.de
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
use patched binutils for building applications to be run with the 256KB-
page sized kernel. The patch for binutils is rather trivial, and may
look as follows:

--- binutils/bfd/elf32-ppc.c.orig
+++ binutils/bfd/elf32-ppc.c

-#define ELF_MAXPAGESIZE		0x10000
+#define ELF_MAXPAGESIZE		0x40000

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 arch/powerpc/Kconfig                   |   10 ++++++++++
 arch/powerpc/include/asm/highmem.h     |   10 +++++-----
 arch/powerpc/include/asm/mmu-44x.h     |    2 ++
 arch/powerpc/include/asm/page.h        |    6 ++++--
 arch/powerpc/include/asm/page_32.h     |    4 ++++
 arch/powerpc/include/asm/thread_info.h |    4 ++++
 arch/powerpc/kernel/head_booke.h       |   10 +++++++++-
 init/Kconfig                           |   10 ++++++++++
 8 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index cd8ff7c..348702c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -436,6 +436,14 @@ config PPC_64K_PAGES
 	bool "64k page size" if 44x || PPC_STD_MMU_64
 	select PPC_HAS_HASH_64K if PPC_STD_MMU_64
 
+config PPC_256K_PAGES
+	bool "256k page size" if 44x
+	depends on !STDBINUTILS
+	help
+	  ELF standard supports only page sizes up to 64K so you need a patched
+	  binutils in order to use 256K pages. Chose it only if you know what
+	  you are doing.
+
 endchoice
 
 config FORCE_MAX_ZONEORDER
@@ -448,6 +456,8 @@ config FORCE_MAX_ZONEORDER
 	default "9" if PPC_STD_MMU_32 && PPC_16K_PAGES
 	range 7 64 if PPC_STD_MMU_32 && PPC_64K_PAGES
 	default "7" if PPC_STD_MMU_32 && PPC_64K_PAGES
+	range 5 64 if PPC_STD_MMU_32 && PPC_256K_PAGES
+	default "5" if PPC_STD_MMU_32 && PPC_256K_PAGES
 	range 11 64
 	default "11"
 	help
diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/asm/highmem.h
index 7d6bb37..0d1333f 100644
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
index 73e1909..52a2339 100644
--- a/arch/powerpc/include/asm/mmu-44x.h
+++ b/arch/powerpc/include/asm/mmu-44x.h
@@ -81,6 +81,8 @@ typedef struct {
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
index 9665a26..3c8bbab 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -15,8 +15,12 @@
 #ifdef CONFIG_PPC64
 #define THREAD_SHIFT		14
 #else
+#ifdef CONFIG_PPC_256K_PAGES
+#define THREAD_SHIFT		15
+#else
 #define THREAD_SHIFT		13
 #endif
+#endif
 
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index fce2df9..bc6a26c 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -10,6 +10,14 @@
 		mtspr	SPRN_IVOR##vector_number,r26;	\
 		sync
 
+#ifndef CONFIG_PPC_256K_PAGES
+#define ALLOC_STACK_FRAME(reg, val)	addi reg,reg,val
+#else
+#define ALLOC_STACK_FRAME(reg, val)			\
+	addis	reg,reg,val@ha;				\
+	addi	reg,reg,val@l
+#endif
+
 #define NORMAL_EXCEPTION_PROLOG						     \
 	mtspr	SPRN_SPRG0,r10;		/* save two registers to work with */\
 	mtspr	SPRN_SPRG1,r11;						     \
@@ -20,7 +28,7 @@
 	beq	1f;							     \
 	mfspr	r1,SPRN_SPRG3;		/* if from user, start at top of   */\
 	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
-	addi	r1,r1,THREAD_SIZE;					     \
+	ALLOC_STACK_FRAME(r1, THREAD_SIZE);				     \
 1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
 	mr	r11,r1;							     \
 	stw	r10,_CCR(r11);          /* save various registers	   */\
diff --git a/init/Kconfig b/init/Kconfig
index f763762..96229b9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -635,6 +635,16 @@ config ELF_CORE
 	help
 	  Enable support for generating core dumps. Disabling saves about 4k.
 
+config STDBINUTILS
+	bool "Using standard binutils" if EMBEDDED
+	depends on 44x
+	default y
+	help
+	  Turning this option off allows you to select 256KB PAGE_SIZE on 44x.
+	  Note, that kernel will be able to run only those applications,
+	  which had been compiled using the patched binutils (ELF standard
+	  supports only page sizes up to 64K).
+
 config PCSPKR_PLATFORM
 	bool "Enable PC-Speaker support" if EMBEDDED
 	depends on ALPHA || X86 || MIPS || PPC_PREP || PPC_CHRP || PPC_PSERIES
-- 
1.6.0.4
