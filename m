Return-Path: <rashmica.g@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdbdY0BydzDqFy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 15:34:57 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id w69so6541877pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 22:34:56 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, anton@samba.org,
 npiggin@gmail.com, bsingharora@gmail.com, oohall@gmail.com,
 khandual@linux.vnet.ibm.com
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Subject: [PATCH v3 2/3] powerpc/powernv: Enable removal of memory for in
 memory tracing
Date: Thu,  1 Jun 2017 15:34:39 +1000
Message-Id: <20170601053440.28976-2-rashmica.g@gmail.com>
In-Reply-To: <20170601053440.28976-1-rashmica.g@gmail.com>
References: <20170601053440.28976-1-rashmica.g@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hardware trace macro feature requires access to a chunk of real
memory. This patch provides a debugfs interface to do this. By
writing an integer containing the size of memory to be unplugged into
/sys/kernel/debug/powerpc/memtrace/enable, the code will attempt to
remove that much memory from the end of each NUMA node.

This patch also adds additional debugsfs files for each node that
allows the tracer to interact with the removed memory, as well as
a trace file that allows userspace to read the generated trace.

Note that this patch does not invoke the hardware trace macro, it
only allows memory to be removed during runtime for the trace macro
to utilise.

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---
v2 -> v3 : - Some changes required to compile with 4.12-rc3.
	- Iterating from end of node rather than the start.
	- As io_remap_pfn_range is defined as remap_pfn_range, just use remap_pfn_range.
	- Removed the creation of the node debugsfs file as it had no use.

 arch/powerpc/platforms/powernv/memtrace.c | 289 ++++++++++++++++++++++++++++++
 1 file changed, 289 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/memtrace.c

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
new file mode 100644
index 0000000..21fa2e4
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -0,0 +1,289 @@
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
+ * Copyright (C) IBM Corporation, 2014
+ *
+ * Author: Anton Blanchard <anton@au.ibm.com>
+ */
+
+#define pr_fmt(fmt) "powernv-memtrace: " fmt
+
+#include <linux/bitops.h>
+#include <linux/string.h>
+#include <linux/memblock.h>
+#include <linux/init.h>
+#include <linux/moduleparam.h>
+#include <linux/fs.h>
+#include <linux/debugfs.h>
+#include <linux/slab.h>
+#include <linux/memory.h>
+#include <linux/memory_hotplug.h>
+#include <asm/machdep.h>
+#include <asm/debugfs.h>
+
+/* This enables us to keep track of the memory removed from each node. */
+struct memtrace_entry {
+	void *mem;
+	u64 start;
+	u64 size;
+	u32 nid;
+	struct dentry *dir;
+	char name[16];
+};
+
+static struct memtrace_entry *memtrace_array;
+static unsigned int memtrace_array_nr;
+
+static ssize_t memtrace_read(struct file *filp, char __user *ubuf,
+			     size_t count, loff_t *ppos)
+{
+	struct memtrace_entry *ent = filp->private_data;
+
+	return simple_read_from_buffer(ubuf, count, ppos, ent->mem, ent->size);
+}
+
+static bool valid_memtrace_range(struct memtrace_entry *dev,
+				 unsigned long start, unsigned long size)
+{
+	if ((start >= dev->start) &&
+	    ((start + size) <= (dev->start + dev->size)))
+		return true;
+
+	return false;
+}
+
+static int memtrace_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	unsigned long size = vma->vm_end - vma->vm_start;
+	struct memtrace_entry *dev = filp->private_data;
+
+	if (!valid_memtrace_range(dev, vma->vm_pgoff << PAGE_SHIFT, size))
+		return -EINVAL;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	if (remap_pfn_range(vma, vma->vm_start,
+			       vma->vm_pgoff + (dev->start >> PAGE_SHIFT),
+			       size, vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static const struct file_operations memtrace_fops = {
+	.llseek = default_llseek,
+	.read	= memtrace_read,
+	.mmap	= memtrace_mmap,
+	.open	= simple_open,
+};
+
+static void flush_memory_region(u64 base, u64 size)
+{
+	unsigned long line_size = ppc64_caches.l1d.size;
+	u64 end = base + size;
+	u64 addr;
+
+	base = round_down(base, line_size);
+	end = round_up(end, line_size);
+
+	for (addr = base; addr < end; addr += line_size)
+		asm volatile("dcbf 0,%0" : "=r" (addr) :: "memory");
+}
+
+static int check_memblock_online(struct memory_block *mem, void *arg)
+{
+	if (mem->state != MEM_ONLINE)
+		return -1;
+
+	return 0;
+}
+
+static int change_memblock_state(struct memory_block *mem, void *arg)
+{
+	unsigned long state = (unsigned long)arg;
+
+	mem->state = state;
+	return 0;
+}
+
+static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
+{
+	u64 end_pfn = start_pfn + nr_pages - 1;
+
+	if (walk_memory_range(start_pfn, end_pfn, NULL,
+	    check_memblock_online))
+		return false;
+
+	walk_memory_range(start_pfn, end_pfn, (void *)MEM_GOING_OFFLINE,
+			  change_memblock_state);
+
+	if (offline_pages(start_pfn, nr_pages)) {
+		walk_memory_range(start_pfn, end_pfn, (void *)MEM_ONLINE,
+				  change_memblock_state);
+		return false;
+	}
+
+	walk_memory_range(start_pfn, end_pfn, (void *)MEM_OFFLINE,
+			  change_memblock_state);
+
+	/* RCU grace period? */
+	flush_memory_region((u64)__va(start_pfn << PAGE_SHIFT),
+						nr_pages << PAGE_SHIFT);
+
+	lock_device_hotplug();
+	remove_memory(nid, start_pfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);
+	unlock_device_hotplug();
+
+	return true;
+}
+
+static u64 memtrace_alloc_node(u32 nid, u64 size)
+{
+	u64 start_pfn, end_pfn, nr_pages;
+	u64 base_pfn;
+
+	if (!NODE_DATA(nid) || !node_spanned_pages(nid))
+		return 0;
+
+	start_pfn = node_start_pfn(nid);
+	end_pfn = node_end_pfn(nid);
+	nr_pages = size >> PAGE_SHIFT;
+
+	/* Trace memory needs to be aligned to the size */
+	end_pfn = round_down(end_pfn - nr_pages, nr_pages);
+
+	for (base_pfn = end_pfn; base_pfn > start_pfn; base_pfn -= nr_pages) {
+		if (memtrace_offline_pages(nid, base_pfn, nr_pages) == true)
+			return base_pfn << PAGE_SHIFT;
+	}
+
+	return 0;
+}
+
+static int memtrace_init_regions_runtime(u64 size)
+{
+	u64 m;
+	u32 nid;
+
+	memtrace_array = kcalloc(num_online_nodes(),
+				sizeof(struct memtrace_entry), GFP_KERNEL);
+	if (!memtrace_array) {
+		pr_err("Failed to allocate memtrace_array\n");
+		return -EINVAL;
+	}
+
+	for_each_online_node(nid) {
+		m = memtrace_alloc_node(nid, size);
+		/*
+		 * A node might not have any local memory, so warn but
+		 * continue on.
+		 */
+		if (!m) {
+			pr_err("Failed to allocate trace memory on node %d\n",
+				 nid);
+		} else {
+			pr_info("Allocated trace memory on node %d at "
+				"0x%016llx\n", nid, m);
+
+			memtrace_array[memtrace_array_nr].start = m;
+			memtrace_array[memtrace_array_nr].size = size;
+			memtrace_array[memtrace_array_nr].nid = nid;
+			memtrace_array_nr++;
+		}
+	}
+
+	return 0;
+}
+
+static struct dentry *memtrace_debugfs_dir;
+
+static int memtrace_init_debugfs(void)
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < memtrace_array_nr; i++) {
+		struct dentry *dir;
+		struct memtrace_entry *ent = &memtrace_array[i];
+
+		ent->mem = ioremap(ent->start, ent->size);
+		/* Warn but continue on */
+		if (!ent->mem) {
+			pr_err("Failed to map trace memory at 0x%llx\n",
+				 ent->start);
+			ret = -1;
+			continue;
+		}
+
+		snprintf(ent->name, 16, "%08x", ent->nid);
+		dir = debugfs_create_dir(ent->name, memtrace_debugfs_dir);
+		if (!dir)
+			return -1;
+
+		ent->dir = dir;
+		debugfs_create_file("trace", 0400, dir, ent, &memtrace_fops);
+		debugfs_create_x64("start", 0400, dir, &ent->start);
+		debugfs_create_x64("size", 0400, dir, &ent->size);
+	}
+
+	return ret;
+}
+
+static u64 memtrace_size;
+
+static int memtrace_enable_set(void *data, u64 val)
+{
+	if (memtrace_size)
+		return -EINVAL;
+
+	if (!val)
+		return -EINVAL;
+
+	/* Make sure size is aligned to a memory block */
+	if (val & (memory_block_size_bytes() - 1))
+		return -EINVAL;
+
+	if (memtrace_init_regions_runtime(val))
+		return -EINVAL;
+
+	if (memtrace_init_debugfs())
+		return -EINVAL;
+
+	memtrace_size = val;
+
+	return 0;
+}
+
+static int memtrace_enable_get(void *data, u64 *val)
+{
+	*val = memtrace_size;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(memtrace_init_fops, memtrace_enable_get,
+					memtrace_enable_set, "0x%016llx\n");
+
+static int memtrace_init(void)
+{
+	memtrace_debugfs_dir = debugfs_create_dir("memtrace",
+						powerpc_debugfs_root);
+	if (!memtrace_debugfs_dir)
+		return -1;
+
+	debugfs_create_file("enable", 0600, memtrace_debugfs_dir,
+			    NULL, &memtrace_init_fops);
+
+	return 0;
+}
+machine_device_initcall(powernv, memtrace_init);
+
+
+
-- 
2.9.3
