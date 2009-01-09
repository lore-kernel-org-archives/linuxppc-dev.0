Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BE34CDDF9E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 23:59:11 +1100 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: rework dma-noncoherent to use generic vmap/vunmap
	functions
Date: Fri,  9 Jan 2009 15:58:35 +0300
Message-Id: <1231505915-16082-1-git-send-email-yanok@emcraft.com>
Cc: Ilya Yanok <yanok@emcraft.com>, dzu@denx.de, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch rewrites consistent dma allocations support to use vmalloc
layer to allocate virtual memory space from vmalloc pool and get rid
of CONFIG_CONSISTENT_{START,SIZE}.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 arch/powerpc/Kconfig                           |   25 --
 arch/powerpc/configs/40x/acadia_defconfig      |    2 -
 arch/powerpc/configs/40x/ep405_defconfig       |    2 -
 arch/powerpc/configs/40x/hcu4_defconfig        |    2 -
 arch/powerpc/configs/40x/kilauea_defconfig     |    2 -
 arch/powerpc/configs/40x/makalu_defconfig      |    2 -
 arch/powerpc/configs/40x/virtex_defconfig      |    2 -
 arch/powerpc/configs/40x/walnut_defconfig      |    2 -
 arch/powerpc/configs/44x/arches_defconfig      |    2 -
 arch/powerpc/configs/44x/bamboo_defconfig      |    2 -
 arch/powerpc/configs/44x/canyonlands_defconfig |    2 -
 arch/powerpc/configs/44x/ebony_defconfig       |    2 -
 arch/powerpc/configs/44x/katmai_defconfig      |    2 -
 arch/powerpc/configs/44x/rainier_defconfig     |    2 -
 arch/powerpc/configs/44x/sam440ep_defconfig    |    2 -
 arch/powerpc/configs/44x/sequoia_defconfig     |    2 -
 arch/powerpc/configs/44x/taishan_defconfig     |    2 -
 arch/powerpc/configs/44x/virtex5_defconfig     |    2 -
 arch/powerpc/configs/44x/warp_defconfig        |    2 -
 arch/powerpc/configs/adder875_defconfig        |    2 -
 arch/powerpc/configs/c2k_defconfig             |    2 -
 arch/powerpc/configs/ep88xc_defconfig          |    2 -
 arch/powerpc/configs/mgsuvd_defconfig          |    2 -
 arch/powerpc/configs/mpc866_ads_defconfig      |    2 -
 arch/powerpc/configs/mpc885_ads_defconfig      |    2 -
 arch/powerpc/configs/ppc40x_defconfig          |    2 -
 arch/powerpc/configs/ppc44x_defconfig          |    2 -
 arch/powerpc/configs/prpmc2800_defconfig       |    2 -
 arch/powerpc/lib/dma-noncoherent.c             |  278 +++--------------------
 29 files changed, 37 insertions(+), 320 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 525c13a..a451a06 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -777,31 +777,6 @@ config TASK_SIZE
 	default "0x80000000" if PPC_PREP || PPC_8xx
 	default "0xc0000000"
 
-config CONSISTENT_START_BOOL
-	bool "Set custom consistent memory pool address"
-	depends on ADVANCED_OPTIONS && NOT_COHERENT_CACHE
-	help
-	  This option allows you to set the base virtual address
-	  of the consistent memory pool.  This pool of virtual
-	  memory is used to make consistent memory allocations.
-
-config CONSISTENT_START
-	hex "Base virtual address of consistent memory pool" if CONSISTENT_START_BOOL
-	default "0xfd000000" if (NOT_COHERENT_CACHE && 8xx)
-	default "0xff100000" if NOT_COHERENT_CACHE
-
-config CONSISTENT_SIZE_BOOL
-	bool "Set custom consistent memory pool size"
-	depends on ADVANCED_OPTIONS && NOT_COHERENT_CACHE
-	help
-	  This option allows you to set the size of the
-	  consistent memory pool.  This pool of virtual memory
-	  is used to make consistent memory allocations.
-
-config CONSISTENT_SIZE
-	hex "Size of consistent memory pool" if CONSISTENT_SIZE_BOOL
-	default "0x00200000" if NOT_COHERENT_CACHE
-
 config PIN_TLB
 	bool "Pinned Kernel TLBs (860 ONLY)"
 	depends on ADVANCED_OPTIONS && 8xx
diff --git a/arch/powerpc/configs/40x/acadia_defconfig b/arch/powerpc/configs/40x/acadia_defconfig
index 25572cc..ea5d89c 100644
--- a/arch/powerpc/configs/40x/acadia_defconfig
+++ b/arch/powerpc/configs/40x/acadia_defconfig
@@ -265,8 +265,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/40x/ep405_defconfig b/arch/powerpc/configs/40x/ep405_defconfig
index b80ba7a..1f3ebea 100644
--- a/arch/powerpc/configs/40x/ep405_defconfig
+++ b/arch/powerpc/configs/40x/ep405_defconfig
@@ -267,8 +267,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/40x/hcu4_defconfig b/arch/powerpc/configs/40x/hcu4_defconfig
index 45dcb82..bfb010d 100644
--- a/arch/powerpc/configs/40x/hcu4_defconfig
+++ b/arch/powerpc/configs/40x/hcu4_defconfig
@@ -265,8 +265,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/40x/kilauea_defconfig b/arch/powerpc/configs/40x/kilauea_defconfig
index e2f3695..40e181f 100644
--- a/arch/powerpc/configs/40x/kilauea_defconfig
+++ b/arch/powerpc/configs/40x/kilauea_defconfig
@@ -265,8 +265,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/40x/makalu_defconfig b/arch/powerpc/configs/40x/makalu_defconfig
index 413c778..bb2c4ae 100644
--- a/arch/powerpc/configs/40x/makalu_defconfig
+++ b/arch/powerpc/configs/40x/makalu_defconfig
@@ -265,8 +265,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/40x/virtex_defconfig b/arch/powerpc/configs/40x/virtex_defconfig
index 9a9350d..d082d98 100644
--- a/arch/powerpc/configs/40x/virtex_defconfig
+++ b/arch/powerpc/configs/40x/virtex_defconfig
@@ -273,8 +273,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/40x/walnut_defconfig b/arch/powerpc/configs/40x/walnut_defconfig
index 5820e0a..c1c37eb 100644
--- a/arch/powerpc/configs/40x/walnut_defconfig
+++ b/arch/powerpc/configs/40x/walnut_defconfig
@@ -268,8 +268,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/44x/arches_defconfig b/arch/powerpc/configs/44x/arches_defconfig
index 082158d..2784aa4 100644
--- a/arch/powerpc/configs/44x/arches_defconfig
+++ b/arch/powerpc/configs/44x/arches_defconfig
@@ -272,8 +272,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/44x/bamboo_defconfig b/arch/powerpc/configs/44x/bamboo_defconfig
index f47c2f3..4821b4f 100644
--- a/arch/powerpc/configs/44x/bamboo_defconfig
+++ b/arch/powerpc/configs/44x/bamboo_defconfig
@@ -276,8 +276,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/44x/canyonlands_defconfig b/arch/powerpc/configs/44x/canyonlands_defconfig
index 0694756..be68259 100644
--- a/arch/powerpc/configs/44x/canyonlands_defconfig
+++ b/arch/powerpc/configs/44x/canyonlands_defconfig
@@ -272,8 +272,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/44x/ebony_defconfig b/arch/powerpc/configs/44x/ebony_defconfig
index c993757..8e0ce20 100644
--- a/arch/powerpc/configs/44x/ebony_defconfig
+++ b/arch/powerpc/configs/44x/ebony_defconfig
@@ -274,8 +274,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/44x/katmai_defconfig b/arch/powerpc/configs/44x/katmai_defconfig
index e326ee8..d1767b4 100644
--- a/arch/powerpc/configs/44x/katmai_defconfig
+++ b/arch/powerpc/configs/44x/katmai_defconfig
@@ -270,8 +270,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/44x/rainier_defconfig b/arch/powerpc/configs/44x/rainier_defconfig
index 927f829..fb1309f 100644
--- a/arch/powerpc/configs/44x/rainier_defconfig
+++ b/arch/powerpc/configs/44x/rainier_defconfig
@@ -274,8 +274,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/44x/sam440ep_defconfig b/arch/powerpc/configs/44x/sam440ep_defconfig
index 15f48e0..79ded88 100644
--- a/arch/powerpc/configs/44x/sam440ep_defconfig
+++ b/arch/powerpc/configs/44x/sam440ep_defconfig
@@ -275,8 +275,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/44x/sequoia_defconfig b/arch/powerpc/configs/44x/sequoia_defconfig
index 562beea..ef65b9f 100644
--- a/arch/powerpc/configs/44x/sequoia_defconfig
+++ b/arch/powerpc/configs/44x/sequoia_defconfig
@@ -276,8 +276,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/44x/taishan_defconfig b/arch/powerpc/configs/44x/taishan_defconfig
index 427bb6a..6e97ae9 100644
--- a/arch/powerpc/configs/44x/taishan_defconfig
+++ b/arch/powerpc/configs/44x/taishan_defconfig
@@ -274,8 +274,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/44x/virtex5_defconfig b/arch/powerpc/configs/44x/virtex5_defconfig
index 7513d36..5b2ccd6 100644
--- a/arch/powerpc/configs/44x/virtex5_defconfig
+++ b/arch/powerpc/configs/44x/virtex5_defconfig
@@ -278,8 +278,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index 59cbd27..126be06 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -266,8 +266,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/adder875_defconfig b/arch/powerpc/configs/adder875_defconfig
index 024f279..f5e50c0 100644
--- a/arch/powerpc/configs/adder875_defconfig
+++ b/arch/powerpc/configs/adder875_defconfig
@@ -265,8 +265,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0x80000000
-CONFIG_CONSISTENT_START=0xfd000000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/c2k_defconfig b/arch/powerpc/configs/c2k_defconfig
index 5078594..b877f07 100644
--- a/arch/powerpc/configs/c2k_defconfig
+++ b/arch/powerpc/configs/c2k_defconfig
@@ -307,8 +307,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/ep88xc_defconfig b/arch/powerpc/configs/ep88xc_defconfig
index 870d289..8aacae7 100644
--- a/arch/powerpc/configs/ep88xc_defconfig
+++ b/arch/powerpc/configs/ep88xc_defconfig
@@ -265,8 +265,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0x80000000
-CONFIG_CONSISTENT_START=0xfd000000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/mgsuvd_defconfig b/arch/powerpc/configs/mgsuvd_defconfig
index fbaa67f..0da7b58 100644
--- a/arch/powerpc/configs/mgsuvd_defconfig
+++ b/arch/powerpc/configs/mgsuvd_defconfig
@@ -262,8 +262,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0x80000000
-CONFIG_CONSISTENT_START=0xfd000000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/mpc866_ads_defconfig b/arch/powerpc/configs/mpc866_ads_defconfig
index 8272b1a..e16bd69 100644
--- a/arch/powerpc/configs/mpc866_ads_defconfig
+++ b/arch/powerpc/configs/mpc866_ads_defconfig
@@ -262,8 +262,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0x80000000
-CONFIG_CONSISTENT_START=0xfd000000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
index a4283b6..0937771 100644
--- a/arch/powerpc/configs/mpc885_ads_defconfig
+++ b/arch/powerpc/configs/mpc885_ads_defconfig
@@ -272,8 +272,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0x80000000
-CONFIG_CONSISTENT_START=0xfd000000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/ppc40x_defconfig b/arch/powerpc/configs/ppc40x_defconfig
index 4256e2c..0cbb6c3 100644
--- a/arch/powerpc/configs/ppc40x_defconfig
+++ b/arch/powerpc/configs/ppc40x_defconfig
@@ -275,8 +275,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
index cfc94cf..54e5583 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -286,8 +286,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/configs/prpmc2800_defconfig b/arch/powerpc/configs/prpmc2800_defconfig
index 6046dc0..bb61e21 100644
--- a/arch/powerpc/configs/prpmc2800_defconfig
+++ b/arch/powerpc/configs/prpmc2800_defconfig
@@ -272,8 +272,6 @@ CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
 CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_CONSISTENT_START=0xff100000
-CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_NET=y
 
 #
diff --git a/arch/powerpc/lib/dma-noncoherent.c b/arch/powerpc/lib/dma-noncoherent.c
index 31734c0..f6c932f 100644
--- a/arch/powerpc/lib/dma-noncoherent.c
+++ b/arch/powerpc/lib/dma-noncoherent.c
@@ -29,121 +29,11 @@
 #include <linux/types.h>
 #include <linux/highmem.h>
 #include <linux/dma-mapping.h>
+#include <linux/vmalloc.h>
 
 #include <asm/tlbflush.h>
 
 /*
- * This address range defaults to a value that is safe for all
- * platforms which currently set CONFIG_NOT_COHERENT_CACHE. It
- * can be further configured for specific applications under
- * the "Advanced Setup" menu. -Matt
- */
-#define CONSISTENT_BASE	(CONFIG_CONSISTENT_START)
-#define CONSISTENT_END	(CONFIG_CONSISTENT_START + CONFIG_CONSISTENT_SIZE)
-#define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
-
-/*
- * This is the page table (2MB) covering uncached, DMA consistent allocations
- */
-static pte_t *consistent_pte;
-static DEFINE_SPINLOCK(consistent_lock);
-
-/*
- * VM region handling support.
- *
- * This should become something generic, handling VM region allocations for
- * vmalloc and similar (ioremap, module space, etc).
- *
- * I envisage vmalloc()'s supporting vm_struct becoming:
- *
- *  struct vm_struct {
- *    struct vm_region	region;
- *    unsigned long	flags;
- *    struct page	**pages;
- *    unsigned int	nr_pages;
- *    unsigned long	phys_addr;
- *  };
- *
- * get_vm_area() would then call vm_region_alloc with an appropriate
- * struct vm_region head (eg):
- *
- *  struct vm_region vmalloc_head = {
- *	.vm_list	= LIST_HEAD_INIT(vmalloc_head.vm_list),
- *	.vm_start	= VMALLOC_START,
- *	.vm_end		= VMALLOC_END,
- *  };
- *
- * However, vmalloc_head.vm_start is variable (typically, it is dependent on
- * the amount of RAM found at boot time.)  I would imagine that get_vm_area()
- * would have to initialise this each time prior to calling vm_region_alloc().
- */
-struct vm_region {
-	struct list_head	vm_list;
-	unsigned long		vm_start;
-	unsigned long		vm_end;
-};
-
-static struct vm_region consistent_head = {
-	.vm_list	= LIST_HEAD_INIT(consistent_head.vm_list),
-	.vm_start	= CONSISTENT_BASE,
-	.vm_end		= CONSISTENT_END,
-};
-
-static struct vm_region *
-vm_region_alloc(struct vm_region *head, size_t size, gfp_t gfp)
-{
-	unsigned long addr = head->vm_start, end = head->vm_end - size;
-	unsigned long flags;
-	struct vm_region *c, *new;
-
-	new = kmalloc(sizeof(struct vm_region), gfp);
-	if (!new)
-		goto out;
-
-	spin_lock_irqsave(&consistent_lock, flags);
-
-	list_for_each_entry(c, &head->vm_list, vm_list) {
-		if ((addr + size) < addr)
-			goto nospc;
-		if ((addr + size) <= c->vm_start)
-			goto found;
-		addr = c->vm_end;
-		if (addr > end)
-			goto nospc;
-	}
-
- found:
-	/*
-	 * Insert this entry _before_ the one we found.
-	 */
-	list_add_tail(&new->vm_list, &c->vm_list);
-	new->vm_start = addr;
-	new->vm_end = addr + size;
-
-	spin_unlock_irqrestore(&consistent_lock, flags);
-	return new;
-
- nospc:
-	spin_unlock_irqrestore(&consistent_lock, flags);
-	kfree(new);
- out:
-	return NULL;
-}
-
-static struct vm_region *vm_region_find(struct vm_region *head, unsigned long addr)
-{
-	struct vm_region *c;
-
-	list_for_each_entry(c, &head->vm_list, vm_list) {
-		if (c->vm_start == addr)
-			goto out;
-	}
-	c = NULL;
- out:
-	return c;
-}
-
-/*
  * Allocate DMA-coherent memory space and return both the kernel remapped
  * virtual and bus address for that space.
  */
@@ -151,19 +41,17 @@ void *
 __dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp)
 {
 	struct page *page;
-	struct vm_region *c;
 	unsigned long order;
+	void *v;
+	int i;
+	struct page *pages[PAGE_ALIGN(size)>>PAGE_SHIFT];
+	struct page *end;
 	u64 mask = 0x00ffffff, limit; /* ISA default */
 
-	if (!consistent_pte) {
-		printk(KERN_ERR "%s: not initialised\n", __func__);
-		dump_stack();
-		return NULL;
-	}
-
+	BUG_ON(!mem_init_done);
 	size = PAGE_ALIGN(size);
 	limit = (mask + 1) & ~mask;
-	if ((limit && size >= limit) || size >= (CONSISTENT_END - CONSISTENT_BASE)) {
+	if (limit && size >= limit) {
 		printk(KERN_WARNING "coherent allocation too big (requested %#x mask %#Lx)\n",
 		       size, mask);
 		return NULL;
@@ -178,6 +66,8 @@ __dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp)
 	if (!page)
 		goto no_page;
 
+	end = page + (1 << order);
+
 	/*
 	 * Invalidate any data that might be lurking in the
 	 * kernel direct-mapped region for device DMA.
@@ -188,45 +78,34 @@ __dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp)
 		flush_dcache_range(kaddr, kaddr + size);
 	}
 
+	split_page(page, order);
+
 	/*
-	 * Allocate a virtual address in the consistent mapping region.
+	 * Set the "dma handle"
 	 */
-	c = vm_region_alloc(&consistent_head, size,
-			    gfp & ~(__GFP_DMA | __GFP_HIGHMEM));
-	if (c) {
-		unsigned long vaddr = c->vm_start;
-		pte_t *pte = consistent_pte + CONSISTENT_OFFSET(vaddr);
-		struct page *end = page + (1 << order);
-
-		split_page(page, order);
-
-		/*
-		 * Set the "dma handle"
-		 */
-		*handle = page_to_phys(page);
-
-		do {
-			BUG_ON(!pte_none(*pte));
-
-			SetPageReserved(page);
-			set_pte_at(&init_mm, vaddr,
-				   pte, mk_pte(page, pgprot_noncached(PAGE_KERNEL)));
-			page++;
-			pte++;
-			vaddr += PAGE_SIZE;
-		} while (size -= PAGE_SIZE);
+	*handle = page_to_phys(page);
+	for (i = 0; i < size>>PAGE_SHIFT; i++)
+		pages[i] = page + i;
+	v = vmap(pages, size>>PAGE_SHIFT, VM_IOREMAP,
+			pgprot_noncached(PAGE_KERNEL));
+	if (!v)
+		goto out;
 
-		/*
-		 * Free the otherwise unused pages.
-		 */
-		while (page < end) {
-			__free_page(page);
-			page++;
-		}
+	do {
+		SetPageReserved(page);
+		page++;
+	} while (size -= PAGE_SIZE);
 
-		return (void *)c->vm_start;
+	/*
+	 * Free the otherwise unused pages.
+	 */
+	while (page < end) {
+		__free_page(page);
+		page++;
 	}
 
+	return v;
+     out:
 	if (page)
 		__free_pages(page, order);
  no_page:
@@ -239,105 +118,22 @@ EXPORT_SYMBOL(__dma_alloc_coherent);
  */
 void __dma_free_coherent(size_t size, void *vaddr)
 {
-	struct vm_region *c;
-	unsigned long flags, addr;
-	pte_t *ptep;
+	struct page *page;
 
 	size = PAGE_ALIGN(size);
+	page = vmalloc_to_page(vaddr);
 
-	spin_lock_irqsave(&consistent_lock, flags);
+	vunmap(vaddr);
 
-	c = vm_region_find(&consistent_head, (unsigned long)vaddr);
-	if (!c)
-		goto no_area;
-
-	if ((c->vm_end - c->vm_start) != size) {
-		printk(KERN_ERR "%s: freeing wrong coherent size (%ld != %d)\n",
-		       __func__, c->vm_end - c->vm_start, size);
-		dump_stack();
-		size = c->vm_end - c->vm_start;
-	}
-
-	ptep = consistent_pte + CONSISTENT_OFFSET(c->vm_start);
-	addr = c->vm_start;
 	do {
-		pte_t pte = ptep_get_and_clear(&init_mm, addr, ptep);
-		unsigned long pfn;
-
-		ptep++;
-		addr += PAGE_SIZE;
-
-		if (!pte_none(pte) && pte_present(pte)) {
-			pfn = pte_pfn(pte);
-
-			if (pfn_valid(pfn)) {
-				struct page *page = pfn_to_page(pfn);
-				ClearPageReserved(page);
-
-				__free_page(page);
-				continue;
-			}
-		}
-
-		printk(KERN_CRIT "%s: bad page in kernel page table\n",
-		       __func__);
+		ClearPageReserved(page);
+		__free_page(page);
+		page++;
 	} while (size -= PAGE_SIZE);
-
-	flush_tlb_kernel_range(c->vm_start, c->vm_end);
-
-	list_del(&c->vm_list);
-
-	spin_unlock_irqrestore(&consistent_lock, flags);
-
-	kfree(c);
-	return;
-
- no_area:
-	spin_unlock_irqrestore(&consistent_lock, flags);
-	printk(KERN_ERR "%s: trying to free invalid coherent area: %p\n",
-	       __func__, vaddr);
-	dump_stack();
 }
 EXPORT_SYMBOL(__dma_free_coherent);
 
 /*
- * Initialise the consistent memory allocation.
- */
-static int __init dma_alloc_init(void)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	int ret = 0;
-
-	do {
-		pgd = pgd_offset(&init_mm, CONSISTENT_BASE);
-		pud = pud_alloc(&init_mm, pgd, CONSISTENT_BASE);
-		pmd = pmd_alloc(&init_mm, pud, CONSISTENT_BASE);
-		if (!pmd) {
-			printk(KERN_ERR "%s: no pmd tables\n", __func__);
-			ret = -ENOMEM;
-			break;
-		}
-		WARN_ON(!pmd_none(*pmd));
-
-		pte = pte_alloc_kernel(pmd, CONSISTENT_BASE);
-		if (!pte) {
-			printk(KERN_ERR "%s: no pte tables\n", __func__);
-			ret = -ENOMEM;
-			break;
-		}
-
-		consistent_pte = pte;
-	} while (0);
-
-	return ret;
-}
-
-core_initcall(dma_alloc_init);
-
-/*
  * make an area consistent.
  */
 void __dma_sync(void *vaddr, size_t size, int direction)
-- 
1.6.0.6
