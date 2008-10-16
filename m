Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9F5BDDDFB
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 13:23:45 +1100 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: support for 256K pages on PPC 44x
Date: Thu, 16 Oct 2008 06:22:32 +0400
Message-Id: <1224123753-20907-3-git-send-email-yanok@emcraft.com>
In-Reply-To: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
References: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
Cc: yanok@emcraft.com, dzu@denx.de, pvr@emcraft.com, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for 256K pages on PPC 44x along with
some hacks needed for this.

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
Signed-off-by: Vladimir Panfilov <pvr@emcraft.com>
Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 arch/powerpc/Kconfig                   |    8 ++++++++
 arch/powerpc/include/asm/highmem.h     |    3 ++-
 arch/powerpc/include/asm/mmu-44x.h     |    2 ++
 arch/powerpc/include/asm/page.h        |    6 ++++--
 arch/powerpc/include/asm/page_32.h     |    4 ++++
 arch/powerpc/include/asm/thread_info.h |    4 ++++
 arch/powerpc/kernel/head_booke.h       |   11 +++++++++--
 7 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9627cfd..7df5528 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -425,6 +425,14 @@ config PPC_64K_PAGES
 	bool "64k page size" if 44x || PPC64
 	select PPC_HAS_HASH_64K if PPC64
 
+config PPC_256K_PAGES
+	bool "256k page size" if 44x
+	depends on BROKEN
+	help
+	  ELF standard supports only page sizes up to 64K so you need a patched
+	  binutils in order to use 256K pages. Chose it only if you know what
+	  you are doing.
+
 endchoice
 
 config FORCE_MAX_ZONEORDER
diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/asm/highmem.h
index dc1132c..0b4ac6a 100644
--- a/arch/powerpc/include/asm/highmem.h
+++ b/arch/powerpc/include/asm/highmem.h
@@ -38,7 +38,8 @@ extern pte_t *pkmap_page_table;
  * easily, subsequent pte tables have to be allocated in one physical
  * chunk of RAM.
  */
-#if defined(CONFIG_PPC_64K_PAGES) && !defined(CONFIG_PPC64)
+#if defined(CONFIG_PPC_256K_PAGES) || \
+	(defined(CONFIG_PPC_64K_PAGES) && !defined(CONFIG_PPC64))
 #define PKMAP_ORDER	(27 - PAGE_SHIFT)
 #define LAST_PKMAP	(1 << PKMAP_ORDER)
 #define PKMAP_BASE	(FIXADDR_START - PAGE_SIZE*(LAST_PKMAP + 1))
diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
index 2ca18e8..b943462 100644
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
index 537d5b1..f42c918 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -15,12 +15,14 @@
 #include <asm/types.h>
 
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
index ebfae53..273369a 100644
--- a/arch/powerpc/include/asm/page_32.h
+++ b/arch/powerpc/include/asm/page_32.h
@@ -20,7 +20,11 @@
  */
 #ifdef CONFIG_PTE_64BIT
 typedef unsigned long long pte_basic_t;
+#ifdef CONFIG_PPC_256K_PAGES
+#define PTE_SHIFT       (PAGE_SHIFT - 7)
+#else
 #define PTE_SHIFT	(PAGE_SHIFT - 3)	/* 512 ptes per page */
+#endif
 #else
 typedef unsigned long pte_basic_t;
 #define PTE_SHIFT	(PAGE_SHIFT - 2)	/* 1024 ptes per page */
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
index fce2df9..acd4b47 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -9,6 +9,13 @@
 		li	r26,vector_label@l; 		\
 		mtspr	SPRN_IVOR##vector_number,r26;	\
 		sync
+#ifndef CONFIG_PPC_256K_PAGES
+#define ALLOC_STACK_FRAME(reg, val)	addi	reg,reg,val
+#else
+#define ALLOC_STACK_FRAME(reg, val)			\
+		addis	reg,reg,val@ha;			\
+		addi	reg,reg,val@l
+#endif
 
 #define NORMAL_EXCEPTION_PROLOG						     \
 	mtspr	SPRN_SPRG0,r10;		/* save two registers to work with */\
@@ -20,7 +27,7 @@
 	beq	1f;							     \
 	mfspr	r1,SPRN_SPRG3;		/* if from user, start at top of   */\
 	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
-	addi	r1,r1,THREAD_SIZE;					     \
+	ALLOC_STACK_FRAME(r1, THREAD_SIZE);					     \
 1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
 	mr	r11,r1;							     \
 	stw	r10,_CCR(r11);          /* save various registers	   */\
@@ -112,7 +119,7 @@
 	andi.	r10,r10,MSR_PR;						     \
 	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
 	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
-	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD;	/* allocate stack frame    */\
+	ALLOC_STACK_FRAME(r11 ,EXC_LVL_FRAME_OVERHEAD);	/* allocate stack frame    */\
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
 	stw	r9,_CCR(r11);		/* save CR			   */\
-- 
1.5.6.1
