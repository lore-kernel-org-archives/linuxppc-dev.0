Return-Path: <pbadari@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 70848DDE05
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 12:09:37 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2118vcb013662
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 20:08:57 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2119TwC218242
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 18:09:29 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2119TPB004828
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 18:09:29 -0700
Subject: Re: [RFC] updating lmb.memory information for hot mem add/remove
From: Badari Pulavarty <pbadari@us.ibm.com>
To: michael@ellerman.id.au
In-Reply-To: <1204307816.10146.11.camel@dyn9047017100.beaverton.ibm.com>
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
	<1204217166.28696.15.camel@dyn9047017100.beaverton.ibm.com>
	<1204243875.7729.3.camel@concordia.ozlabs.ibm.com>
	<20080229003906.GP16241@localdomain>
	<1204247002.7729.11.camel@concordia.ozlabs.ibm.com>
	<1204307816.10146.11.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 29 Feb 2008 17:12:44 -0800
Message-Id: <1204333964.10146.18.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: Nathan Lynch <ntl@pobox.com>, anton@au1.ibm.com, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-02-29 at 09:56 -0800, Badari Pulavarty wrote:
> Hi,
> 
> I am wondering if you could give me your opinion on how to proceed
> (before I code too much).
> 
> eHEA driver writers wants to know what the memory layout is - where the
> holes are and where the reserved memory is. They can get this from
> parsing through the device-tree every time, but it would be too
> expensive. And also, they would like to get information for contiguous
> ranges (instead of 16MB chunks).
> 
> Since we already have this information at boot time in lmb.memory, 
> lmb.reserve - would it be okay to update those for hotplug mem
> add/remove ? Of course, all the routines which handles updates 
> (lmb_add() etc..) are available only at boot (__init). I could
> change that. Is it acceptable ?
> 
> Other way to handle the issue is to come up with arch-neutral
> way of representing the memory layout. x86-64 and ia64 shows
> this information in /proc/iomem (even there is in chunks not 
> combined).
> 
> Ideas ? Would it be acceptable if I update lmb.memory for add/remove
> memory ? Am I missing something ?

Here is what I cooked up and it seems to work fine.
It may be easier to review the code (against my earlier patches).

Thanks,
Badari

ppc kernel maintains information about logical memory blocks in
lmb.memory structure at the boot time. Its not updated for
hotplug memory add/remove. hotplug memory notifier for memory
add/remove now updates lmb.memory.

This information is useful for eHEA driver to find out the memory 
layout and holes.

TODO: locking ?

---
 arch/powerpc/mm/lmb.c                           |   61 +++++++++++++++++++++---
 arch/powerpc/platforms/pseries/hotplug-memory.c |   42 ++++++++++++++++
 include/asm-powerpc/lmb.h                       |    3 -
 3 files changed, 98 insertions(+), 8 deletions(-)

Index: linux-2.6.25-rc2/arch/powerpc/mm/lmb.c
===================================================================
--- linux-2.6.25-rc2.orig/arch/powerpc/mm/lmb.c	2008-02-15 12:57:20.000000000 -0800
+++ linux-2.6.25-rc2/arch/powerpc/mm/lmb.c	2008-02-29 16:55:49.000000000 -0800
@@ -60,13 +60,13 @@ void lmb_dump_all(void)
 #endif /* DEBUG */
 }
 
-static unsigned long __init lmb_addrs_overlap(unsigned long base1,
+static unsigned long lmb_addrs_overlap(unsigned long base1,
 		unsigned long size1, unsigned long base2, unsigned long size2)
 {
 	return ((base1 < (base2+size2)) && (base2 < (base1+size1)));
 }
 
-static long __init lmb_addrs_adjacent(unsigned long base1, unsigned long size1,
+static long lmb_addrs_adjacent(unsigned long base1, unsigned long size1,
 		unsigned long base2, unsigned long size2)
 {
 	if (base2 == base1 + size1)
@@ -77,7 +77,7 @@ static long __init lmb_addrs_adjacent(un
 	return 0;
 }
 
-static long __init lmb_regions_adjacent(struct lmb_region *rgn,
+static long lmb_regions_adjacent(struct lmb_region *rgn,
 		unsigned long r1, unsigned long r2)
 {
 	unsigned long base1 = rgn->region[r1].base;
@@ -88,7 +88,7 @@ static long __init lmb_regions_adjacent(
 	return lmb_addrs_adjacent(base1, size1, base2, size2);
 }
 
-static void __init lmb_remove_region(struct lmb_region *rgn, unsigned long r)
+static void lmb_remove_region(struct lmb_region *rgn, unsigned long r)
 {
 	unsigned long i;
 
@@ -100,7 +100,7 @@ static void __init lmb_remove_region(str
 }
 
 /* Assumption: base addr of region 1 < base addr of region 2 */
-static void __init lmb_coalesce_regions(struct lmb_region *rgn,
+static void lmb_coalesce_regions(struct lmb_region *rgn,
 		unsigned long r1, unsigned long r2)
 {
 	rgn->region[r1].size += rgn->region[r2].size;
@@ -135,7 +135,7 @@ void __init lmb_analyze(void)
 }
 
 /* This routine called with relocation disabled. */
-static long __init lmb_add_region(struct lmb_region *rgn, unsigned long base,
+static long lmb_add_region(struct lmb_region *rgn, unsigned long base,
 				  unsigned long size)
 {
 	unsigned long coalesced = 0;
@@ -191,7 +191,7 @@ static long __init lmb_add_region(struct
 }
 
 /* This routine may be called with relocation disabled. */
-long __init lmb_add(unsigned long base, unsigned long size)
+long lmb_add(unsigned long base, unsigned long size)
 {
 	struct lmb_region *_rgn = &(lmb.memory);
 
@@ -203,6 +203,53 @@ long __init lmb_add(unsigned long base, 
 
 }
 
+long lmb_remove(unsigned long base, unsigned long size)
+{
+	struct lmb_region *rgn = &(lmb.memory);
+	unsigned long end = base + size;
+	unsigned long rgnbegin, rgnend;
+	int i;
+
+	/* Find the region where (base, size) belongs to */
+	for (i=0; i < rgn->cnt; i++) {
+		rgnbegin = rgn->region[i].base;
+		rgnend = rgnbegin + rgn->region[i].size;
+
+		if ((rgnbegin <= base) && (end <= rgnend))
+			break;
+	}
+
+	/* Didn't find the region */
+	if (i == rgn->cnt)
+		return -1;
+
+	/* Check to see if we are removing entire region */
+	if ((rgnbegin == base) && (rgnend == end)) {
+		lmb_remove_region(rgn, i);
+		return 0;
+	}
+
+	/* Check to see if region is matching at the front */
+	if (rgnbegin == base) {
+		rgn->region[i].base = end;
+		rgn->region[i].size -= size;
+		return 0;
+	}
+
+	/* Check to see if the region is matching at the end */
+	if (rgnend == end) {
+		rgn->region[i].size -= size;
+		return 0;
+	}
+
+	/*
+	 * We need to split the entry -  adjust the current one to the
+	 * beginging of the hole and add the region after hole.
+	 */
+	rgn->region[i].size = base - rgn->region[i].base;
+	return lmb_add_region(rgn, end, rgnend - end);
+}
+
 long __init lmb_reserve(unsigned long base, unsigned long size)
 {
 	struct lmb_region *_rgn = &(lmb.reserved);
Index: linux-2.6.25-rc2/include/asm-powerpc/lmb.h
===================================================================
--- linux-2.6.25-rc2.orig/include/asm-powerpc/lmb.h	2008-02-15 12:57:20.000000000 -0800
+++ linux-2.6.25-rc2/include/asm-powerpc/lmb.h	2008-02-29 13:42:03.000000000 -0800
@@ -41,7 +41,8 @@ extern struct lmb lmb;
 
 extern void __init lmb_init(void);
 extern void __init lmb_analyze(void);
-extern long __init lmb_add(unsigned long base, unsigned long size);
+extern long lmb_add(unsigned long base, unsigned long size);
+extern long lmb_remove(unsigned long base, unsigned long size);
 extern long __init lmb_reserve(unsigned long base, unsigned long size);
 extern unsigned long __init lmb_alloc(unsigned long size, unsigned long align);
 extern unsigned long __init lmb_alloc_base(unsigned long size,
Index: linux-2.6.25-rc2/arch/powerpc/platforms/pseries/hotplug-memory.c
===================================================================
--- linux-2.6.25-rc2.orig/arch/powerpc/platforms/pseries/hotplug-memory.c	2008-02-29 09:25:14.000000000 -0800
+++ linux-2.6.25-rc2/arch/powerpc/platforms/pseries/hotplug-memory.c	2008-02-29 16:58:33.000000000 -0800
@@ -12,6 +12,7 @@
 #include <asm/prom.h>
 #include <asm/firmware.h>
 #include <asm/machdep.h>
+#include <asm/lmb.h>
 #include <asm/pSeries_reconfig.h>
 
 static int pseries_remove_memory(struct device_node *np)
@@ -58,6 +59,11 @@ static int pseries_remove_memory(struct 
 		return ret;
 
 	/*
+	 * Update memory regions for memory remove
+	 */
+	lmb_remove(start_pfn << PAGE_SHIFT, regs[3]);
+
+	/*
 	 * Remove htab bloted mappings for this section of memory
 	 */
  	start = (unsigned long)__va(start_pfn << PAGE_SHIFT);
@@ -65,6 +71,40 @@ static int pseries_remove_memory(struct 
 	return ret;
 }
 
+static int pseries_add_memory(struct device_node *np)
+{
+	const char *type;
+	const unsigned int *my_index;
+	const unsigned int *regs;
+	u64 start_pfn;
+	int ret = -EINVAL;
+
+	/*
+	 * Check to see if we are actually adding memory
+	 */
+	type = of_get_property(np, "device_type", NULL);
+	if (type == NULL || strcmp(type, "memory") != 0)
+		return 0;
+
+	/*
+	 * Find the memory index and size of the removing section
+	 */
+	my_index = of_get_property(np, "ibm,my-drc-index", NULL);
+	if (!my_index)
+		return ret;
+
+	regs = of_get_property(np, "reg", NULL);
+	if (!regs)
+		return ret;
+
+	start_pfn = section_nr_to_pfn(*my_index & 0xffff);
+
+	/*
+	 * Update memory region to represent the memory add
+	 */
+	return lmb_add(start_pfn << PAGE_SHIFT, regs[3]);
+}
+
 static int pseries_memory_notifier(struct notifier_block *nb,
 				unsigned long action, void *node)
 {
@@ -72,6 +112,8 @@ static int pseries_memory_notifier(struc
 
 	switch (action) {
 	case PSERIES_RECONFIG_ADD:
+		if (pseries_add_memory(node))
+			err = NOTIFY_BAD;
 		break;
 	case PSERIES_RECONFIG_REMOVE:
 		if (pseries_remove_memory(node))
