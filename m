Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1128463190.22452.29.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 04 Oct 2005 16:59:50 -0500
Subject: PATCH powerpc Move LMB from ppc64 to powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move the LMB code from ppc64 to powerpc.
Only compile ppc32's tlb.c code on "standard" mmu machines.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

 arch/powerpc/mm/Makefile   |    8 +
 arch/powerpc/mm/lmb.c      |  303 ++++++++++++++++++++++++++++++++++++++++++++
 arch/ppc64/kernel/Makefile |    1 
 arch/ppc64/kernel/lmb.c    |  299 -------------------------------------------
 include/asm-powerpc/lmb.h  |   78 +++++++++++
 include/asm-ppc/page.h     |    6 +
 6 files changed, 391 insertions(+), 304 deletions(-)


diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -2,11 +2,11 @@
 # Makefile for the linux ppc-specific parts of the memory manager.
 #
 
-obj-y				:= fault.o mem.o
-obj-$(CONFIG_PPC32)		+= init.o pgtable.o mmu_context.o \
-				   mem_pieces.o tlb.o
+obj-y				:= fault.o lmb.o mem.o
+
+obj-$(CONFIG_PPC32)		+= init.o pgtable.o mmu_context.o mem_pieces.o
 obj-$(CONFIG_PPC64)		+= init64.o pgtable64.o mmu_context64.o
-obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu.o hash_32.o
+obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu.o hash_32.o tlb.o
 obj-$(CONFIG_40x)		+= 4xx_mmu.o
 obj-$(CONFIG_44x)		+= 44x_mmu.o
 obj-$(CONFIG_FSL_BOOKE)		+= fsl_booke_mmu.o
diff --git a/arch/powerpc/mm/lmb.c b/arch/powerpc/mm/lmb.c
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/mm/lmb.c
@@ -0,0 +1,303 @@
+/*
+ * Procedures for interfacing to Open Firmware.
+ *
+ * Peter Bergner, IBM Corp.	June 2001.
+ * Copyright (C) 2001 Peter Bergner.
+ * 
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/bitops.h>
+#include <asm/types.h>
+#include <asm/page.h>
+#include <asm/prom.h>
+#include <asm/lmb.h>
+
+struct lmb lmb;
+
+#undef DEBUG
+
+void lmb_dump_all(void)
+{
+#ifdef DEBUG
+	unsigned long i;
+
+	udbg_printf("lmb_dump_all:\n");
+	udbg_printf("    memory.cnt		  = 0x%lx\n",
+		    lmb.memory.cnt);
+	udbg_printf("    memory.size		  = 0x%lx\n",
+		    lmb.memory.size);
+	for (i=0; i < lmb.memory.cnt ;i++) {
+		udbg_printf("    memory.region[0x%x].base       = 0x%lx\n",
+			    i, lmb.memory.region[i].base);
+		udbg_printf("		      .size     = 0x%lx\n",
+			    lmb.memory.region[i].size);
+	}
+
+	udbg_printf("\n    reserved.cnt	  = 0x%lx\n",
+		    lmb.reserved.cnt);
+	udbg_printf("    reserved.size	  = 0x%lx\n",
+		    lmb.reserved.size);
+	for (i=0; i < lmb.reserved.cnt ;i++) {
+		udbg_printf("    reserved.region[0x%x].base       = 0x%lx\n",
+			    i, lmb.reserved.region[i].base);
+		udbg_printf("		      .size     = 0x%lx\n",
+			    lmb.reserved.region[i].size);
+	}
+#endif /* DEBUG */
+}
+
+static unsigned long __init
+lmb_addrs_overlap(unsigned long base1, unsigned long size1,
+                  unsigned long base2, unsigned long size2)
+{
+	return ((base1 < (base2+size2)) && (base2 < (base1+size1)));
+}
+
+static long __init
+lmb_addrs_adjacent(unsigned long base1, unsigned long size1,
+		   unsigned long base2, unsigned long size2)
+{
+	if (base2 == base1 + size1)
+		return 1;
+	else if (base1 == base2 + size2)
+		return -1;
+
+	return 0;
+}
+
+static long __init
+lmb_regions_adjacent(struct lmb_region *rgn,
+		     unsigned long r1, unsigned long r2)
+{
+	unsigned long base1 = rgn->region[r1].base;
+	unsigned long size1 = rgn->region[r1].size;
+	unsigned long base2 = rgn->region[r2].base;
+	unsigned long size2 = rgn->region[r2].size;
+
+	return lmb_addrs_adjacent(base1, size1, base2, size2);
+}
+
+/* Assumption: base addr of region 1 < base addr of region 2 */
+static void __init
+lmb_coalesce_regions(struct lmb_region *rgn,
+		     unsigned long r1, unsigned long r2)
+{
+	unsigned long i;
+
+	rgn->region[r1].size += rgn->region[r2].size;
+	for (i=r2; i < rgn->cnt-1; i++) {
+		rgn->region[i].base = rgn->region[i+1].base;
+		rgn->region[i].size = rgn->region[i+1].size;
+	}
+	rgn->cnt--;
+}
+
+/* This routine called with relocation disabled. */
+void __init
+lmb_init(void)
+{
+	/* Create a dummy zero size LMB which will get coalesced away later.
+	 * This simplifies the lmb_add() code below...
+	 */
+	lmb.memory.region[0].base = 0;
+	lmb.memory.region[0].size = 0;
+	lmb.memory.cnt = 1;
+
+	/* Ditto. */
+	lmb.reserved.region[0].base = 0;
+	lmb.reserved.region[0].size = 0;
+	lmb.reserved.cnt = 1;
+}
+
+/* This routine called with relocation disabled. */
+void __init
+lmb_analyze(void)
+{
+	int i;
+
+	lmb.memory.size = 0;
+
+	for (i = 0; i < lmb.memory.cnt; i++)
+		lmb.memory.size += lmb.memory.region[i].size;
+}
+
+/* This routine called with relocation disabled. */
+static long __init
+lmb_add_region(struct lmb_region *rgn, unsigned long base, unsigned long size)
+{
+	unsigned long i, coalesced = 0;
+	long adjacent;
+
+	/* First try and coalesce this LMB with another. */
+	for (i=0; i < rgn->cnt; i++) {
+		unsigned long rgnbase = rgn->region[i].base;
+		unsigned long rgnsize = rgn->region[i].size;
+
+		adjacent = lmb_addrs_adjacent(base,size,rgnbase,rgnsize);
+		if ( adjacent > 0 ) {
+			rgn->region[i].base -= size;
+			rgn->region[i].size += size;
+			coalesced++;
+			break;
+		}
+		else if ( adjacent < 0 ) {
+			rgn->region[i].size += size;
+			coalesced++;
+			break;
+		}
+	}
+
+	if ((i < rgn->cnt-1) && lmb_regions_adjacent(rgn, i, i+1) ) {
+		lmb_coalesce_regions(rgn, i, i+1);
+		coalesced++;
+	}
+
+	if ( coalesced ) {
+		return coalesced;
+	} else if ( rgn->cnt >= MAX_LMB_REGIONS ) {
+		return -1;
+	}
+
+	/* Couldn't coalesce the LMB, so add it to the sorted table. */
+	for (i=rgn->cnt-1; i >= 0; i--) {
+		if (base < rgn->region[i].base) {
+			rgn->region[i+1].base = rgn->region[i].base;
+			rgn->region[i+1].size = rgn->region[i].size;
+		}  else {
+			rgn->region[i+1].base = base;
+			rgn->region[i+1].size = size;
+			break;
+		}
+	}
+	rgn->cnt++;
+
+	return 0;
+}
+
+/* This routine called with relocation disabled. */
+long __init
+lmb_add(unsigned long base, unsigned long size)
+{
+	struct lmb_region *_rgn = &(lmb.memory);
+
+	/* On pSeries LPAR systems, the first LMB is our RMO region. */
+	if ( base == 0 )
+		lmb.rmo_size = size;
+
+	return lmb_add_region(_rgn, base, size);
+
+}
+
+long __init
+lmb_reserve(unsigned long base, unsigned long size)
+{
+	struct lmb_region *_rgn = &(lmb.reserved);
+
+	return lmb_add_region(_rgn, base, size);
+}
+
+long __init
+lmb_overlaps_region(struct lmb_region *rgn,
+		    unsigned long base, unsigned long size)
+{
+	unsigned long i;
+
+	for (i=0; i < rgn->cnt; i++) {
+		unsigned long rgnbase = rgn->region[i].base;
+		unsigned long rgnsize = rgn->region[i].size;
+		if ( lmb_addrs_overlap(base,size,rgnbase,rgnsize) ) {
+			break;
+		}
+	}
+
+	return (i < rgn->cnt) ? i : -1;
+}
+
+unsigned long __init
+lmb_alloc(unsigned long size, unsigned long align)
+{
+	return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE);
+}
+
+unsigned long __init
+lmb_alloc_base(unsigned long size, unsigned long align, unsigned long max_addr)
+{
+	long i, j;
+	unsigned long base = 0;
+
+	for (i=lmb.memory.cnt-1; i >= 0; i--) {
+		unsigned long lmbbase = lmb.memory.region[i].base;
+		unsigned long lmbsize = lmb.memory.region[i].size;
+
+		if ( max_addr == LMB_ALLOC_ANYWHERE )
+			base = _ALIGN_DOWN(lmbbase+lmbsize-size, align);
+		else if ( lmbbase < max_addr )
+			base = _ALIGN_DOWN(min(lmbbase+lmbsize,max_addr)-size,
+					   align);
+		else
+			continue;
+
+		while ( (lmbbase <= base) &&
+			((j = lmb_overlaps_region(&lmb.reserved,base,size)) >= 0) ) {
+			base = _ALIGN_DOWN(lmb.reserved.region[j].base-size,
+					   align);
+		}
+
+		if ( (base != 0) && (lmbbase <= base) )
+			break;
+	}
+
+	if ( i < 0 )
+		return 0;
+
+	lmb_add_region(&lmb.reserved, base, size);
+
+	return base;
+}
+
+/* You must call lmb_analyze() before this. */
+unsigned long __init
+lmb_phys_mem_size(void)
+{
+	return lmb.memory.size;
+}
+
+unsigned long __init
+lmb_end_of_DRAM(void)
+{
+	int idx = lmb.memory.cnt - 1;
+
+	return (lmb.memory.region[idx].base + lmb.memory.region[idx].size);
+}
+
+/*
+ * Truncate the lmb list to memory_limit if it's set
+ * You must call lmb_analyze() after this.
+ */
+void __init lmb_enforce_memory_limit(void)
+{
+	extern unsigned long memory_limit;
+	unsigned long i, limit;
+
+	if (! memory_limit)
+		return;
+
+	limit = memory_limit;
+	for (i = 0; i < lmb.memory.cnt; i++) {
+		if (limit > lmb.memory.region[i].size) {
+			limit -= lmb.memory.region[i].size;
+			continue;
+		}
+
+		lmb.memory.region[i].size = limit;
+		lmb.memory.cnt = i + 1;
+		break;
+	}
+}
diff --git a/arch/ppc64/kernel/Makefile b/arch/ppc64/kernel/Makefile
--- a/arch/ppc64/kernel/Makefile
+++ b/arch/ppc64/kernel/Makefile
@@ -76,3 +76,4 @@ endif
 
 # These are here while we do the architecture merge
 vecemu-y			+= ../../powerpc/kernel/vecemu.o
+lmb-y				+= ../../powerpc/mm/lmb.o
diff --git a/arch/ppc64/kernel/lmb.c b/arch/ppc64/kernel/lmb.c
deleted file mode 100644
--- a/arch/ppc64/kernel/lmb.c
+++ /dev/null
@@ -1,299 +0,0 @@
-/*
- * Procedures for interfacing to Open Firmware.
- *
- * Peter Bergner, IBM Corp.	June 2001.
- * Copyright (C) 2001 Peter Bergner.
- * 
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
- */
-
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/bitops.h>
-#include <asm/types.h>
-#include <asm/page.h>
-#include <asm/prom.h>
-#include <asm/lmb.h>
-#include <asm/abs_addr.h>
-
-struct lmb lmb;
-
-#undef DEBUG
-
-void lmb_dump_all(void)
-{
-#ifdef DEBUG
-	unsigned long i;
-
-	udbg_printf("lmb_dump_all:\n");
-	udbg_printf("    memory.cnt		  = 0x%lx\n",
-		    lmb.memory.cnt);
-	udbg_printf("    memory.size		  = 0x%lx\n",
-		    lmb.memory.size);
-	for (i=0; i < lmb.memory.cnt ;i++) {
-		udbg_printf("    memory.region[0x%x].base       = 0x%lx\n",
-			    i, lmb.memory.region[i].base);
-		udbg_printf("		      .size     = 0x%lx\n",
-			    lmb.memory.region[i].size);
-	}
-
-	udbg_printf("\n    reserved.cnt	  = 0x%lx\n",
-		    lmb.reserved.cnt);
-	udbg_printf("    reserved.size	  = 0x%lx\n",
-		    lmb.reserved.size);
-	for (i=0; i < lmb.reserved.cnt ;i++) {
-		udbg_printf("    reserved.region[0x%x].base       = 0x%lx\n",
-			    i, lmb.reserved.region[i].base);
-		udbg_printf("		      .size     = 0x%lx\n",
-			    lmb.reserved.region[i].size);
-	}
-#endif /* DEBUG */
-}
-
-static unsigned long __init
-lmb_addrs_overlap(unsigned long base1, unsigned long size1,
-                  unsigned long base2, unsigned long size2)
-{
-	return ((base1 < (base2+size2)) && (base2 < (base1+size1)));
-}
-
-static long __init
-lmb_addrs_adjacent(unsigned long base1, unsigned long size1,
-		   unsigned long base2, unsigned long size2)
-{
-	if (base2 == base1 + size1)
-		return 1;
-	else if (base1 == base2 + size2)
-		return -1;
-
-	return 0;
-}
-
-static long __init
-lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r1, unsigned long r2)
-{
-	unsigned long base1 = rgn->region[r1].base;
-	unsigned long size1 = rgn->region[r1].size;
-	unsigned long base2 = rgn->region[r2].base;
-	unsigned long size2 = rgn->region[r2].size;
-
-	return lmb_addrs_adjacent(base1, size1, base2, size2);
-}
-
-/* Assumption: base addr of region 1 < base addr of region 2 */
-static void __init
-lmb_coalesce_regions(struct lmb_region *rgn, unsigned long r1, unsigned long r2)
-{
-	unsigned long i;
-
-	rgn->region[r1].size += rgn->region[r2].size;
-	for (i=r2; i < rgn->cnt-1; i++) {
-		rgn->region[i].base = rgn->region[i+1].base;
-		rgn->region[i].size = rgn->region[i+1].size;
-	}
-	rgn->cnt--;
-}
-
-/* This routine called with relocation disabled. */
-void __init
-lmb_init(void)
-{
-	/* Create a dummy zero size LMB which will get coalesced away later.
-	 * This simplifies the lmb_add() code below...
-	 */
-	lmb.memory.region[0].base = 0;
-	lmb.memory.region[0].size = 0;
-	lmb.memory.cnt = 1;
-
-	/* Ditto. */
-	lmb.reserved.region[0].base = 0;
-	lmb.reserved.region[0].size = 0;
-	lmb.reserved.cnt = 1;
-}
-
-/* This routine called with relocation disabled. */
-void __init
-lmb_analyze(void)
-{
-	int i;
-
-	lmb.memory.size = 0;
-
-	for (i = 0; i < lmb.memory.cnt; i++)
-		lmb.memory.size += lmb.memory.region[i].size;
-}
-
-/* This routine called with relocation disabled. */
-static long __init
-lmb_add_region(struct lmb_region *rgn, unsigned long base, unsigned long size)
-{
-	unsigned long i, coalesced = 0;
-	long adjacent;
-
-	/* First try and coalesce this LMB with another. */
-	for (i=0; i < rgn->cnt; i++) {
-		unsigned long rgnbase = rgn->region[i].base;
-		unsigned long rgnsize = rgn->region[i].size;
-
-		adjacent = lmb_addrs_adjacent(base,size,rgnbase,rgnsize);
-		if ( adjacent > 0 ) {
-			rgn->region[i].base -= size;
-			rgn->region[i].size += size;
-			coalesced++;
-			break;
-		}
-		else if ( adjacent < 0 ) {
-			rgn->region[i].size += size;
-			coalesced++;
-			break;
-		}
-	}
-
-	if ((i < rgn->cnt-1) && lmb_regions_adjacent(rgn, i, i+1) ) {
-		lmb_coalesce_regions(rgn, i, i+1);
-		coalesced++;
-	}
-
-	if ( coalesced ) {
-		return coalesced;
-	} else if ( rgn->cnt >= MAX_LMB_REGIONS ) {
-		return -1;
-	}
-
-	/* Couldn't coalesce the LMB, so add it to the sorted table. */
-	for (i=rgn->cnt-1; i >= 0; i--) {
-		if (base < rgn->region[i].base) {
-			rgn->region[i+1].base = rgn->region[i].base;
-			rgn->region[i+1].size = rgn->region[i].size;
-		}  else {
-			rgn->region[i+1].base = base;
-			rgn->region[i+1].size = size;
-			break;
-		}
-	}
-	rgn->cnt++;
-
-	return 0;
-}
-
-/* This routine called with relocation disabled. */
-long __init
-lmb_add(unsigned long base, unsigned long size)
-{
-	struct lmb_region *_rgn = &(lmb.memory);
-
-	/* On pSeries LPAR systems, the first LMB is our RMO region. */
-	if ( base == 0 )
-		lmb.rmo_size = size;
-
-	return lmb_add_region(_rgn, base, size);
-
-}
-
-long __init
-lmb_reserve(unsigned long base, unsigned long size)
-{
-	struct lmb_region *_rgn = &(lmb.reserved);
-
-	return lmb_add_region(_rgn, base, size);
-}
-
-long __init
-lmb_overlaps_region(struct lmb_region *rgn, unsigned long base, unsigned long size)
-{
-	unsigned long i;
-
-	for (i=0; i < rgn->cnt; i++) {
-		unsigned long rgnbase = rgn->region[i].base;
-		unsigned long rgnsize = rgn->region[i].size;
-		if ( lmb_addrs_overlap(base,size,rgnbase,rgnsize) ) {
-			break;
-		}
-	}
-
-	return (i < rgn->cnt) ? i : -1;
-}
-
-unsigned long __init
-lmb_alloc(unsigned long size, unsigned long align)
-{
-	return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE);
-}
-
-unsigned long __init
-lmb_alloc_base(unsigned long size, unsigned long align, unsigned long max_addr)
-{
-	long i, j;
-	unsigned long base = 0;
-
-	for (i=lmb.memory.cnt-1; i >= 0; i--) {
-		unsigned long lmbbase = lmb.memory.region[i].base;
-		unsigned long lmbsize = lmb.memory.region[i].size;
-
-		if ( max_addr == LMB_ALLOC_ANYWHERE )
-			base = _ALIGN_DOWN(lmbbase+lmbsize-size, align);
-		else if ( lmbbase < max_addr )
-			base = _ALIGN_DOWN(min(lmbbase+lmbsize,max_addr)-size, align);
-		else
-			continue;
-
-		while ( (lmbbase <= base) &&
-			((j = lmb_overlaps_region(&lmb.reserved,base,size)) >= 0) ) {
-			base = _ALIGN_DOWN(lmb.reserved.region[j].base-size, align);
-		}
-
-		if ( (base != 0) && (lmbbase <= base) )
-			break;
-	}
-
-	if ( i < 0 )
-		return 0;
-
-	lmb_add_region(&lmb.reserved, base, size);
-
-	return base;
-}
-
-/* You must call lmb_analyze() before this. */
-unsigned long __init
-lmb_phys_mem_size(void)
-{
-	return lmb.memory.size;
-}
-
-unsigned long __init
-lmb_end_of_DRAM(void)
-{
-	int idx = lmb.memory.cnt - 1;
-
-	return (lmb.memory.region[idx].base + lmb.memory.region[idx].size);
-}
-
-/*
- * Truncate the lmb list to memory_limit if it's set
- * You must call lmb_analyze() after this.
- */
-void __init lmb_enforce_memory_limit(void)
-{
-	extern unsigned long memory_limit;
-	unsigned long i, limit;
-
-	if (! memory_limit)
-		return;
-
-	limit = memory_limit;
-	for (i = 0; i < lmb.memory.cnt; i++) {
-		if (limit > lmb.memory.region[i].size) {
-			limit -= lmb.memory.region[i].size;
-			continue;
-		}
-
-		lmb.memory.region[i].size = limit;
-		lmb.memory.cnt = i + 1;
-		break;
-	}
-}
diff --git a/include/asm-powerpc/lmb.h b/include/asm-powerpc/lmb.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/lmb.h
@@ -0,0 +1,78 @@
+#ifndef _ASM_POWERPC_LMB_H
+#define _ASM_POWERPC_LMB_H
+
+/*
+ * Low-level Memory Block management.
+ *
+ * Copyright (C) 2001 Peter Bergner, IBM Corp.
+ */
+
+#include <linux/init.h>
+#include <asm/prom.h>
+
+#define MAX_LMB_REGIONS 128
+
+#define LMB_ALLOC_ANYWHERE	0
+
+struct lmb_block {
+	unsigned long base;
+	unsigned long size;
+};
+
+struct lmb_region {
+	unsigned long cnt;
+	unsigned long size;
+	struct lmb_block region[MAX_LMB_REGIONS+1];
+};
+
+struct lmb {
+	unsigned long debug;
+	unsigned long rmo_size;
+	struct lmb_region memory;
+	struct lmb_region reserved;
+};
+
+extern struct lmb lmb;
+
+extern void __init lmb_init(void);
+extern void __init lmb_analyze(void);
+extern long __init lmb_add(unsigned long, unsigned long);
+extern long __init lmb_reserve(unsigned long, unsigned long);
+extern unsigned long __init lmb_alloc(unsigned long, unsigned long);
+extern unsigned long __init lmb_alloc_base(unsigned long, unsigned long,
+					   unsigned long);
+extern unsigned long __init lmb_phys_mem_size(void);
+extern unsigned long __init lmb_end_of_DRAM(void);
+extern unsigned long __init lmb_abs_to_phys(unsigned long);
+extern void __init lmb_enforce_memory_limit(void);
+
+extern void lmb_dump_all(void);
+
+extern unsigned long io_hole_start;
+
+static inline unsigned long
+lmb_size_bytes(struct lmb_region *type, unsigned long region_nr)
+{
+	return type->region[region_nr].size;
+}
+
+static inline unsigned long
+lmb_size_pages(struct lmb_region *type, unsigned long region_nr)
+{
+	return lmb_size_bytes(type, region_nr) >> PAGE_SHIFT;
+}
+
+static inline unsigned long
+lmb_start_pfn(struct lmb_region *type, unsigned long region_nr)
+{
+	return type->region[region_nr].base >> PAGE_SHIFT;
+}
+
+static inline unsigned long
+lmb_end_pfn(struct lmb_region *type, unsigned long region_nr)
+{
+	return lmb_start_pfn(type, region_nr) +
+	       lmb_size_pages(type, region_nr);
+}
+
+#endif	/* _ASM_POWERPC_LMB_H */
diff --git a/include/asm-ppc/page.h b/include/asm-ppc/page.h
--- a/include/asm-ppc/page.h
+++ b/include/asm-ppc/page.h
@@ -77,8 +77,12 @@ typedef unsigned long pgprot_t;
 #endif
 
 
+/* align addr on a size boundary - adjust address up/down if needed */
+#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
+#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
+
 /* align addr on a size boundary - adjust address up if needed -- Cort */
-#define _ALIGN(addr,size)	(((addr)+(size)-1)&(~((size)-1)))
+#define _ALIGN(addr,size)	_ALIGN_UP(addr,size)
 
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
