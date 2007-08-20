Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5EA76DDE04
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 14:58:39 +1000 (EST)
Date: Mon, 20 Aug 2007 14:58:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] iSeries: clean up lparmap mess
Message-Id: <20070820145836.3fd8af11.sfr@canb.auug.org.au>
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

We need to have xLparMap in ead_64.S so that it is at a fixed address
(because the linker will not resolve (address & 0xffffffff) for us).
But the assembler miscalculates the KERNEL_VSID() expressions.  So put
the confusing expressions into asm-offset.c.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/Makefile           |    7 -------
 arch/powerpc/kernel/asm-offsets.c      |    8 ++++++++
 arch/powerpc/kernel/head_64.S          |   27 +++++++++++++++++++--------
 arch/powerpc/kernel/lparmap.c          |   32 --------------------------------
 include/asm-powerpc/iseries/lpar_map.h |    3 +++
 include/asm-powerpc/page_64.h          |    2 +-
 6 files changed, 31 insertions(+), 48 deletions(-)
 delete mode 100644 arch/powerpc/kernel/lparmap.c

This has been built and booted for iseries_defconfig and ppc64_defconfig
and built for allmodconfig.  Tony Breeds cross built
arch/powerpc/kernel/head_64.s on i386 for me and we verified the
constants all had the correct values.

Segher: this was plan C  :-)
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index b0cb2e6..5987912 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -80,13 +80,6 @@ ifneq ($(CONFIG_PPC_INDIRECT_IO),y)
 obj-y				+= iomap.o
 endif
 
-ifeq ($(CONFIG_PPC_ISERIES),y)
-CFLAGS_lparmap.s		+= -g0
-extra-y += lparmap.s
-$(obj)/head_64.o:	$(obj)/lparmap.s
-AFLAGS_head_64.o += -I$(obj)
-endif
-
 else
 # stuff used from here for ARCH=ppc
 smpobj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 2cb1d94..a408053 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -312,5 +312,13 @@ int main(void)
 #ifdef CONFIG_BUG
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
 #endif
+
+#ifdef CONFIG_PPC_ISERIES
+	/* the assembler miscalculates the VSID values */
+	DEFINE(PAGE_OFFSET_ESID, GET_ESID(PAGE_OFFSET));
+	DEFINE(PAGE_OFFSET_VSID, KERNEL_VSID(PAGE_OFFSET));
+	DEFINE(VMALLOC_START_ESID, GET_ESID(VMALLOC_START));
+	DEFINE(VMALLOC_START_VSID, KERNEL_VSID(VMALLOC_START));
+#endif
 	return 0;
 }
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 1718000..1e6d9cc 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -34,6 +34,7 @@
 #include <asm/iseries/lpar_map.h>
 #include <asm/thread_info.h>
 #include <asm/firmware.h>
+#include <asm/page_64.h>
 
 #define DO_SOFT_DISABLE
 
@@ -1519,8 +1520,8 @@ _GLOBAL(do_stab_bolted)
  * Space for CPU0's segment table.
  *
  * On iSeries, the hypervisor must fill in at least one entry before
- * we get control (with relocate on).  The address is give to the hv
- * as a page number (see xLparMap in lpardata.c), so this must be at a
+ * we get control (with relocate on).  The address is given to the hv
+ * as a page number (see xLparMap below), so this must be at a
  * fixed address (the linker can't compute (u64)&initial_stab >>
  * PAGE_SHIFT).
  */
@@ -1542,12 +1543,22 @@ fwnmi_data_area:
 	 * both pSeries and iSeries */
 #ifdef CONFIG_PPC_ISERIES
         . = LPARMAP_PHYS
-#include "lparmap.s"
-/*
- * This ".text" is here for old compilers that generate a trailing
- * .note section when compiling .c files to .s
- */
-	.text
+	.globl xLparMap
+xLparMap:
+	.quad	HvEsidsToMap		/* xNumberEsids */
+	.quad	HvRangesToMap		/* xNumberRanges */
+	.quad	STAB0_PAGE		/* xSegmentTableOffs */
+	.zero	40			/* xRsvd */
+	/* xEsids (HvEsidsToMap entries of 2 quads) */
+	.quad	PAGE_OFFSET_ESID	/* xKernelEsid */
+	.quad	PAGE_OFFSET_VSID	/* xKernelVsid */
+	.quad	VMALLOC_START_ESID	/* xKernelEsid */
+	.quad	VMALLOC_START_VSID	/* xKernelVsid */
+	/* xRanges (HvRangesToMap entries of 3 quads) */
+	.quad	HvPagesToMap		/* xPages */
+	.quad	0			/* xOffset */
+	.quad	PAGE_OFFSET_VSID << (SID_SHIFT - HW_PAGE_SHIFT)	/* xVPN */
+
 #endif /* CONFIG_PPC_ISERIES */
 
         . = 0x8000
diff --git a/arch/powerpc/kernel/lparmap.c b/arch/powerpc/kernel/lparmap.c
deleted file mode 100644
index af11285..0000000
--- a/arch/powerpc/kernel/lparmap.c
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * Copyright (C) 2005  Stephen Rothwell  IBM Corp.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <asm/mmu.h>
-#include <asm/pgtable.h>
-#include <asm/iseries/lpar_map.h>
-
-/* The # is to stop gcc trying to make .text nonexecutable */
-const struct LparMap __attribute__((__section__(".text #"))) xLparMap = {
-	.xNumberEsids = HvEsidsToMap,
-	.xNumberRanges = HvRangesToMap,
-	.xSegmentTableOffs = STAB0_PAGE,
-
-	.xEsids = {
-		{ .xKernelEsid = GET_ESID(PAGE_OFFSET),
-		  .xKernelVsid = KERNEL_VSID(PAGE_OFFSET), },
-		{ .xKernelEsid = GET_ESID(VMALLOC_START),
-		  .xKernelVsid = KERNEL_VSID(VMALLOC_START), },
-	},
-
-	.xRanges = {
-		{ .xPages = HvPagesToMap,
-		  .xOffset = 0,
-		  .xVPN = KERNEL_VSID(PAGE_OFFSET) << (SID_SHIFT - HW_PAGE_SHIFT),
-		},
-	},
-};
diff --git a/include/asm-powerpc/iseries/lpar_map.h b/include/asm-powerpc/iseries/lpar_map.h
index 2ec384d..5e9f3e1 100644
--- a/include/asm-powerpc/iseries/lpar_map.h
+++ b/include/asm-powerpc/iseries/lpar_map.h
@@ -22,6 +22,8 @@
 
 #include <asm/types.h>
 
+#endif
+
 /*
  * The iSeries hypervisor will set up mapping for one or more
  * ESID/VSID pairs (in SLB/segment registers) and will set up
@@ -56,6 +58,7 @@
 /* Hypervisor initially maps 32MB of the load area */
 #define HvPagesToMap	8192
 
+#ifndef __ASSEMBLY__
 struct LparMap {
 	u64	xNumberEsids;	// Number of ESID/VSID pairs
 	u64	xNumberRanges;	// Number of VA ranges to map
diff --git a/include/asm-powerpc/page_64.h b/include/asm-powerpc/page_64.h
index 4ceb113..56a2df0 100644
--- a/include/asm-powerpc/page_64.h
+++ b/include/asm-powerpc/page_64.h
@@ -28,7 +28,7 @@
 
 /* Segment size */
 #define SID_SHIFT		28
-#define SID_MASK		0xfffffffffUL
+#define SID_MASK		ASM_CONST(0xfffffffff)
 #define ESID_MASK		0xfffffffff0000000UL
 #define GET_ESID(x)		(((x) >> SID_SHIFT) & SID_MASK)
 
-- 
1.5.2.4
