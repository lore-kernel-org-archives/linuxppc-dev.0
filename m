Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21E0FDDF09
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 05:24:27 +1100 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC/PATCH] powerpc: consistent memory mapping.
Date: Tue,  9 Dec 2008 21:23:46 +0300
Message-Id: <1228847026-5857-1-git-send-email-yanok@emcraft.com>
Cc: Ilya Yanok <yanok@emcraft.com>, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 Defining the start virtual address of the consistent memory
in configs leads to overlapping of the consistent area with
the other virtual regions (fixmap, pkmap, vmalloc). Defaults from
current kernel just set consistent memory area to be somewhere
high in the vmalloc area and then you need to pray there will be
not enough vmalloc allocations to overlap.

 So, this patch makes the virtual address of the consistent memory
to be assigned dynamically, at the end of the virtual address area.
The fixmap area is now shifted to the low addresses, and ends before
start of the consistent virtual addresses. User is now allowed to
configure the size of the consistent memory area only.

 The exception has been made for 8xx archs, where the start
of the consistent memory is still configurable: this is to avoid
overlapping with the IMM space of 8xx. Actually this is wrong. We
have a possibility to overlap not only for consistent memory but
for IMM space too. But we don't have much expertise in 8xx so we
are looking forward for some advice here.

 The following items remain to be done to complete supporting of
the consistent memory fully:

a) we missing 1 (last) page of addresses at the end of the consistent
memory area;

b) if CONFIG_CONSISTENT_SIZE is such that we cover more address
regions than served by 1 pgd level, then mapping of the pages to
these additional areas won't work (this 'feature' isn't introduced
by this patch, but is the consequence of the current consistent
memory support code, where consistent_pte is set in dma_alloc_init()
in accordance with the pgd of the CONSISTENT_BASE address).

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
---
 arch/powerpc/Kconfig               |    7 ++++---
 arch/powerpc/lib/dma-noncoherent.c |    5 +++++
 arch/powerpc/mm/pgtable_32.c       |    2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index aa2eb46..4d62446 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -809,7 +809,7 @@ config TASK_SIZE
 
 config CONSISTENT_START_BOOL
 	bool "Set custom consistent memory pool address"
-	depends on ADVANCED_OPTIONS && NOT_COHERENT_CACHE
+	depends on ADVANCED_OPTIONS && NOT_COHERENT_CACHE && 8xx
 	help
 	  This option allows you to set the base virtual address
 	  of the consistent memory pool.  This pool of virtual
@@ -817,8 +817,8 @@ config CONSISTENT_START_BOOL
 
 config CONSISTENT_START
 	hex "Base virtual address of consistent memory pool" if CONSISTENT_START_BOOL
-	default "0xfd000000" if (NOT_COHERENT_CACHE && 8xx)
-	default "0xff100000" if NOT_COHERENT_CACHE
+	depends on 8xx
+	default "0xfd000000" if NOT_COHERENT_CACHE
 
 config CONSISTENT_SIZE_BOOL
 	bool "Set custom consistent memory pool size"
@@ -831,6 +831,7 @@ config CONSISTENT_SIZE_BOOL
 config CONSISTENT_SIZE
 	hex "Size of consistent memory pool" if CONSISTENT_SIZE_BOOL
 	default "0x00200000" if NOT_COHERENT_CACHE
+	default "0x00000000" if !NOT_COHERENT_CACHE
 
 config PIN_TLB
 	bool "Pinned Kernel TLBs (860 ONLY)"
diff --git a/arch/powerpc/lib/dma-noncoherent.c b/arch/powerpc/lib/dma-noncoherent.c
index 31734c0..3c12577 100644
--- a/arch/powerpc/lib/dma-noncoherent.c
+++ b/arch/powerpc/lib/dma-noncoherent.c
@@ -38,8 +38,13 @@
  * can be further configured for specific applications under
  * the "Advanced Setup" menu. -Matt
  */
+#ifdef CONFIG_CONSISTENT_START
 #define CONSISTENT_BASE	(CONFIG_CONSISTENT_START)
 #define CONSISTENT_END	(CONFIG_CONSISTENT_START + CONFIG_CONSISTENT_SIZE)
+#else
+#define CONSISTENT_BASE	((unsigned long)(-CONFIG_CONSISTENT_SIZE))
+#define CONSISTENT_END	((unsigned long)(-PAGE_SIZE))
+#endif /* CONFIG_CONSISTENT_START */
 #define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
 
 /*
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 10d21c3..fda24c7 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -395,7 +395,7 @@ void kernel_map_pages(struct page *page, int numpages, int enable)
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
 static int fixmaps;
-unsigned long FIXADDR_TOP = (-PAGE_SIZE);
+unsigned long FIXADDR_TOP = (-PAGE_SIZE-CONFIG_CONSISTENT_SIZE);
 EXPORT_SYMBOL(FIXADDR_TOP);
 
 void __set_fixmap (enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
-- 
1.5.6.1
