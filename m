Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D904DDF45
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:33:25 +1000 (EST)
Date: Wed, 11 Apr 2007 03:32:56 -0500 (CDT)
Subject: [PATCH 3/8] bootwrapper: occuppied memory ranges
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-4-03.miltonm@bga.com>
In-Reply-To: <boot-4-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a set of library routines to manage gross memory allocations.

It uses an array in bss to store upto 32 entrys with merging representing
a range of memory below rmo_end (aka end of real mode memory at 0).

To use this code, set rmo_end to the highest address (32 bits) you can
access and wish to manage.   Then follow with calls to occupy memory,
followed by calls init_malloc for fine grain allocation.

Also, an optional vmlinux_alloc with hooks into the smp marshaling code.   

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 

Index: kernel/arch/powerpc/boot/memranges.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/memranges.c	2007-04-09 00:53:45.000000000 -0500
@@ -0,0 +1,230 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright (C) IBM Corporation 2007
+ *
+ * Authors: Milton Miller <miltonm@bga.com>
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "flatdevtree.h"
+#include "page.h"
+#include "types.h"
+
+extern char _start[], _end[];
+
+void *rmo_end;
+
+static struct {
+	void *start, *end;
+} ranges[32];
+static int num_ranges;
+
+/**
+ * add_occupied_range - mark a range as occupied
+ * Mark the range from @start to @end as occupied.
+ * Ignore anything above rmo_end.
+ */
+void add_occupied_range(void *start, void *end)
+{
+	int i, j;
+
+	if (start == end)
+		return;
+	if (start > rmo_end)
+		return;
+	if (end > rmo_end)
+		end = rmo_end;
+	if (start > end)
+		fatal("%s: BUG: start %p > end %p\n\r", __FUNCTION__,
+				start, end);
+
+	printf("add %p %p: ", start, end);
+
+	for (i=0; i < num_ranges; i++)
+		if (start <= ranges[i].end)
+			break;
+
+	/* extend and merge any overlapping ranges */
+	if (i < num_ranges && end >= ranges[i].start) {
+		ranges[i].start = min(start, ranges[i].start);
+		for (j=i; j < num_ranges; j++)
+			if (end >= ranges[j].start)
+				end = ranges[j].end;
+			else
+				break;
+		ranges[i].end = end;
+
+		if (j == i + 1) {
+			printf("extending range %d to %p %p\n\r", i,
+				ranges[i].start, ranges[i].end);
+		} else {
+			printf("merged ranges %d to %d now %p %p\n\r", i, j,
+				ranges[i].start, ranges[i].end);
+
+			++i;
+			memmove(&ranges[i], &ranges[j],
+				(num_ranges - j) * sizeof(ranges[0]));
+			num_ranges -= j-i;
+		}
+	} else {
+		/* insert a new range */
+		if (num_ranges >= ARRAY_SIZE(ranges) - 1)
+			fatal("Too many memory ranges to track\n");
+
+		printf("inserting range %d between %p and %p\n\r",
+				i, i ? ranges[i-1].end : 0,
+				i == num_ranges ? rmo_end : ranges[i].start);
+
+		memmove(&ranges[i+1], &ranges[i],
+				(num_ranges - i) * sizeof(ranges[0]));
+		num_ranges++;
+
+		ranges[i].start = start;
+		ranges[i].end = end;
+	}
+}
+
+/**
+ * add_occupied_range_ulong - mark a range as occupied
+ * Call add_occupied_range_ulong after casting to ulong @start and @end to
+ * void * pointers.
+ */
+void add_occupied_range_ulong(unsigned long start, unsigned long end)
+{
+	add_occupied_range((void *)start, (void *)end);
+}
+
+/**
+ * add_known_ranges - occupy some known regions
+ * call add_occupied_range for the wrapper, loader supplied initrd, and,
+ * if not %NULL, the device tree blob @dt_blob and any reserved memory
+ * ranges therein.
+ */
+void add_known_ranges(struct boot_param_header *dt_blob)
+{
+	unsigned long long rstart, rlen, rend, *rsrv;
+
+	add_occupied_range(_start, _end);
+
+	add_occupied_range_ulong(loader_info.initrd_addr,
+		loader_info.initrd_addr + loader_info.initrd_size);
+
+	if (dt_blob == NULL)
+		return;
+
+	add_occupied_range(dt_blob, (void *)dt_blob + dt_blob->totalsize);
+	/* only support 8-byte reserve map.  Only care about < 4G */
+	rsrv = (void *)dt_blob + dt_blob->off_mem_rsvmap;
+	do {
+		rstart = *rsrv++;
+		rlen = *rsrv++;
+		rend = rstart + rlen;
+
+		if (rlen && rstart < UINT_MAX) {
+			if (rend < UINT_MAX)
+				add_occupied_range_ulong(rstart, rend);
+			else
+				add_occupied_range_ulong(rstart, UINT_MAX);
+		}
+	} while (rlen);
+}
+
+/**
+ * ranges_init_malloc - initialize malloc heap in a free memory range.
+ * Call simple_alloc_init using the largest gap between occupied ranges.
+ * Does not consider before the first or after the last range.
+ */
+void ranges_init_malloc(void)
+{
+	int i;
+	unsigned long size = 0;
+	void *heap_start, *heap_end;
+
+	/*
+	 * Allow the beginning for the kernel and the end for
+	 * other things the platform might want to have reserved.
+	 */
+
+	heap_start = NULL;		/* avoid gcc warning */
+	for (i=1; i < num_ranges; i++) {
+		unsigned long newsize;
+
+		newsize = ranges[i].start - ranges[i-1].end;
+		if (newsize > size) {
+			size = newsize;
+			heap_start = ranges[i-1].end;
+		}
+	}
+
+	if (size < 4 * 1024 * 1024)
+		fatal("Can't find a sutiable gap (largest 0x%lx)", size);
+
+	printf("putting heap between %p and %p size 0x%lx\n\r", heap_start,
+			heap_start + size, size);
+	heap_end = simple_alloc_init(heap_start, size * 7 / 8,
+			PAGE_SIZE, /* max num alloc */ 4096);
+	if (heap_end > (heap_start + size))
+		fatal("heap alloc overflowed gap (%p)\n\r", heap_end);
+
+	add_occupied_range(heap_start, heap_end);
+}
+
+/**
+ * ranges_vmlinux_alloc - an optonal kernel allocator.
+ * Searches for a location to put the kernel.   Ideally at 0, which could
+ * be blocked by a range_add.  If not, check if the kernel @size will
+ * overwrite the image, and if so, tack on space for the slaves.  Find
+ * space either through malloc() or free space between the occupied
+ * ranges, including after the last range to rmo_end.
+ */
+void *ranges_vmlinux_alloc(unsigned long size)
+{
+	void *addr;
+	int i;
+
+	/* Assume _start to _end is occupied */
+	addr = (void *)0;
+	if (addr + size < ranges[0].start)
+		goto occupy;
+
+	addr = malloc(size);
+	if (addr)
+		goto out;
+
+	for (i=1; i < num_ranges; i++) {
+		if (size < ranges[i].start - ranges[i-1].end)
+			goto occupy_range;
+	}
+	if (size < rmo_end - ranges[i-1].end)
+		goto occupy_range;
+
+	fatal("Unable to find a 0x%lx byte gap for the kernel\n", size);
+
+occupy_range:
+	addr = ranges[i-1].end;
+occupy:
+	add_occupied_range(addr, addr + size);
+out:
+	/*
+	 * Assume the kernel will decompress to 0, but don't implicity
+	 * create a new gap below the current first range.
+	 */
+	if ((unsigned long)ranges[0].end < size)
+		add_occupied_range_ulong(0, size);
+
+	return addr;
+}
Index: kernel/arch/powerpc/boot/ops.h
===================================================================
--- kernel.orig/arch/powerpc/boot/ops.h	2007-04-09 00:49:01.000000000 -0500
+++ kernel/arch/powerpc/boot/ops.h	2007-04-09 00:53:59.000000000 -0500
@@ -20,6 +20,8 @@
 #define	MAX_PROP_LEN		256 /* What should this be? */
 #define	SMP_SLAVE_SIZE		256 /* Size of SMP slave block, kexec/kernel */
 
+struct boot_param_header;
+
 /* Platform specific operations */
 struct platform_ops {
 	void	(*fixups)(void);
@@ -89,6 +91,14 @@ void send_slaves_to_kernel(void *vmlinux
 void slaves_are_low(void);
 void wait_slaves_moved(void);
 
+/* memory ranges */
+extern void *rmo_end;
+void add_occupied_range(void *start, void *end);
+void add_occupied_range_ulong(unsigned long start, unsigned long end);
+void add_known_ranges(struct boot_param_header *dt_blob);
+void ranges_init_malloc(void);
+void *ranges_vmlinux_alloc(unsigned long size);
+
 static inline void *finddevice(const char *name)
 {
 	return (dt_ops.finddevice) ? dt_ops.finddevice(name) : NULL;
Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-04-09 00:49:01.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-04-09 00:53:45.000000000 -0500
@@ -41,7 +41,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 		$(addprefix $(obj)/,$(zlibheader))
 
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
-		marshal.c \
+		marshal.c memranges.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c $(zlib)
 src-plat := of.c
Index: kernel/arch/powerpc/boot/types.h
===================================================================
--- kernel.orig/arch/powerpc/boot/types.h	2007-04-09 00:47:05.000000000 -0500
+++ kernel/arch/powerpc/boot/types.h	2007-04-09 00:53:45.000000000 -0500
@@ -1,6 +1,9 @@
 #ifndef _TYPES_H_
 #define _TYPES_H_
 
+#define _LIBC_LIMITS_H_		/* don't recurse to system's headers */
+#include <limits.h>		/* MAX_UINT, etc */
+
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 typedef unsigned char		u8;
