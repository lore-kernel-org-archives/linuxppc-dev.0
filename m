Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3B56EDE1A6
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 11:11:59 +1000 (EST)
Date: Fri, 11 Apr 2008 11:11:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix MAX_ORDER config problem
Message-Id: <20080411111156.8861e269.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The allyesconfig (among others) build was giving this:

In file included from include/linux/gfp.h:4,
                 from include/linux/slab.h:14,
                 from include/linux/percpu.h:5,
                 from include2/asm/time.h:18,
                 from include2/asm/cputime.h:26,
                 from include/linux/sched.h:67,
                 from
arch/powerpc/kernel/asm-offsets.c:17:
include/linux/mmzone.h:791:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE

Kconfig options are order depenendent, so move the setting of
FORCE_MAX_ZONEORDER to after the setting of PPC_64K_PAGES. Also add an
explicit !PPC_64K_PAGES.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Kconfig |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

Paul, this is a bug in the powerpc next tree.

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 625342e..1d4d19f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -211,26 +211,6 @@ source kernel/Kconfig.hz
 source kernel/Kconfig.preempt
 source "fs/Kconfig.binfmt"
 
-config FORCE_MAX_ZONEORDER
-	int "Maximum zone order"
-	default "9" if PPC_64K_PAGES
-	default "13" if PPC64
-	default "11"
-	help
-	  The kernel memory allocator divides physically contiguous memory
-	  blocks into "zones", where each zone is a power of two number of
-	  pages.  This option selects the largest power of two that the kernel
-	  keeps in the memory allocator.  If you need to allocate very large
-	  blocks of physically contiguous memory, then you may need to
-	  increase this value.
-
-	  This config option is actually maximum order plus one. For example,
-	  a value of 11 means that the largest free memory block is 2^10 pages.
-
-	  The page size is not necessarily 4KB.  For example, on 64-bit
-	  systems, 64KB pages can be enabled via CONFIG_PPC_64K_PAGES.  Keep
-	  this in mind when choosing a value for this option.
-
 config HUGETLB_PAGE_SIZE_VARIABLE
 	bool
 	depends on HUGETLB_PAGE
@@ -403,6 +383,26 @@ config PPC_64K_PAGES
 	  while on hardware with such support, it will be used to map
 	  normal application pages.
 
+config FORCE_MAX_ZONEORDER
+	int "Maximum zone order"
+	default "9" if PPC_64K_PAGES
+	default "13" if PPC64 && !PPC_64K_PAGES
+	default "11"
+	help
+	  The kernel memory allocator divides physically contiguous memory
+	  blocks into "zones", where each zone is a power of two number of
+	  pages.  This option selects the largest power of two that the kernel
+	  keeps in the memory allocator.  If you need to allocate very large
+	  blocks of physically contiguous memory, then you may need to
+	  increase this value.
+
+	  This config option is actually maximum order plus one. For example,
+	  a value of 11 means that the largest free memory block is 2^10 pages.
+
+	  The page size is not necessarily 4KB.  For example, on 64-bit
+	  systems, 64KB pages can be enabled via CONFIG_PPC_64K_PAGES.  Keep
+	  this in mind when choosing a value for this option.
+
 config PPC_SUBPAGE_PROT
 	bool "Support setting protections for 4k subpages"
 	depends on PPC_64K_PAGES
-- 
1.5.4.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
