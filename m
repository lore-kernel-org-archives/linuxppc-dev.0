Return-Path: <miltonm@sullivan.realtime.net>
Date: Tue, 10 Jul 2007 17:09:26 -0500 (CDT)
Subject: [PATCH 5/15] bootwrapper: occupied memory ranges
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-6-05.miltonm@bga.com>
In-Reply-To: <boot-6-00.miltonm@bga.com>
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

Add a set of library routines to manage gross memory allocations.

This code uses an array in bss to store upto 32 entrys with merging
representing a range of memory below rmo_end (aka end of real mode
memory at 0).

To use this code, a platform would set rmo_end, call occupy_memory,
then then call init_malloc for fine grain allocation.

Also, an optional vmlinux_alloc.   

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Fixed a bug when extending across multiple ranges.

Cleaned up documentation

Index: work.git/arch/powerpc/boot/memranges.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ work.git/arch/powerpc/boot/memranges.c	2007-07-10 03:48:29.000000000 -0500
@@ -0,0 +1,242 @@
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
+ * Copyright IBM Corporation 2007
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
+ * @start: start of range pointer
+ * @end: end of range pointer
+ *
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
+				end = max(end, ranges[j].end);
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
+ * @start: start of block to occupy
+ * @end: start of block to occupy
+ *
+ * Call add_occupied_range() after casting to ulong @start and @end to
+ * void * pointers.
+ */
+void add_occupied_range_ulong(unsigned long start, unsigned long end)
+{
+	add_occupied_range((void *)start, (void *)end);
+}
+
+/**
+ * add_known_ranges - occupy some known regions
+ * @dt_blob: a flattend device tree to occupy, or NULL to skip
+ *
+ * call add_occupied_range() for the wrapper, loader supplied initrd,
+ * and, if not %NULL, the device tree blob @dt_blob and any reserved
+ * memory ranges therein.
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
+
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
+ *
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
+ * @size: the image size of the kernel
+ *
+ * Searches for a location to put the kernel, then reserve that range
+ * and the area to which the kernel will relocate itself.   First try
+ * address %0.  If that is blocked by a previos call to add_occupied_range(),
+ * try malloc().  If that also fails search for free space between the
+ * occupied ranges or between the last range and rmo_end.
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
Index: work.git/arch/powerpc/boot/ops.h
===================================================================
--- work.git.orig/arch/powerpc/boot/ops.h	2007-07-10 03:48:20.000000000 -0500
+++ work.git/arch/powerpc/boot/ops.h	2007-07-10 03:48:29.000000000 -0500
@@ -22,6 +22,8 @@
 
 typedef void (*kernel_entry_t)(unsigned long r3, unsigned long r4, void *r5);
 
+struct boot_param_header;
+
 /* Platform specific operations */
 struct platform_ops {
 	void	(*fixups)(void);
@@ -96,6 +98,14 @@ void send_slaves_to_kernel(void *vmlinux
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
Index: work.git/arch/powerpc/boot/Makefile
===================================================================
--- work.git.orig/arch/powerpc/boot/Makefile	2007-07-10 03:48:20.000000000 -0500
+++ work.git/arch/powerpc/boot/Makefile	2007-07-10 03:48:29.000000000 -0500
@@ -42,7 +42,7 @@ $(addprefix $(obj)/,$(zlib) gunzip_util.
 	$(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
 
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
-		marshal.c \
+		marshal.c memranges.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c
