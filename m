Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id F22DFB71BF
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2011 04:12:53 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by e28smtp04.in.ibm.com (8.14.4/8.13.1) with ESMTP id p9VHCpK1001202
 for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2011 22:42:51 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9VHCp0E4665362
 for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2011 22:42:51 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9VHCol3031083
 for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2011 22:42:51 +0530
Subject: [RFC PATCH v3 08/10] fadump: Invalidate registration and release
 reserved memory for general use.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 31 Oct 2011 22:41:58 +0530
Message-ID: <20111031171158.12259.16461.stgit@mars.in.ibm.com>
In-Reply-To: <20111031170200.12259.27663.stgit@mars.in.ibm.com>
References: <20111031170200.12259.27663.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Anton Blanchard <anton@samba.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Milton Miller <miltonm@bga.com>,
 Amerigo Wang <amwang@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

This patch introduces an sysfs interface '/sys/kernel/fadump_release_mem' to
invalidate the last fadump registration, invalidate '/proc/vmcore', release
the reserved memory for general use and re-register for future kernel dump.
Once the dump is copied to the disk, the userspace tool will echo 1 to
'/sys/kernel/fadump_release_mem'.

Release the reserved memory region excluding the size of the memory required
for future kernel dump registration.

Change in v3:
- Syncronize the fadump invalidation step to handle simultaneous writes to
  /sys/kernel/fadump_release_mem.

Change in v2:
- Introduced cpu_notes_buf_free() function to free memory allocated for
  cpu notes buffer.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/fadump.h |    3 +
 arch/powerpc/kernel/fadump.c      |  170 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 169 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 4a7d63e..2d983e8 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -196,6 +196,9 @@ extern int fadump_reserve_mem(void);
 extern int setup_fadump(void);
 extern int is_fadump_active(void);
 extern void crash_fadump(struct pt_regs *, const char *);
+extern void fadump_cleanup(void);
+
+extern void vmcore_cleanup(void);
 #else	/* CONFIG_FA_DUMP */
 static inline int is_fadump_active(void) { return 0; }
 #endif
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4d42fe5..ecdf81b 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -33,6 +33,8 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/crash_dump.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
 
 #include <asm/page.h>
 #include <asm/prom.h>
@@ -560,6 +562,19 @@ static void *cpu_notes_buf_alloc(unsigned long size)
 	return vaddr;
 }
 
+static void cpu_notes_buf_free(unsigned long vaddr, unsigned long size)
+{
+	struct page *page;
+	unsigned long order, count, i;
+
+	order = get_order(size);
+	count = 1 << order;
+	page = virt_to_page(vaddr);
+	for (i = 0; i < count; i++)
+		ClearPageReserved(page + i);
+	__free_pages(page, order);
+}
+
 /*
  * Read CPU state dump data and convert it into ELF notes.
  * The CPU dump starts with magic number "REGSAVE". NumCpusOffset should be
@@ -944,6 +959,131 @@ static int fadump_unregister_dump(struct fadump_mem_struct *fdm)
 	return 0;
 }
 
+static int fadump_invalidate_dump(struct fadump_mem_struct *fdm)
+{
+	int rc = 0;
+	unsigned int wait_time;
+
+	pr_debug("Invalidating firmware-assisted dump registration\n");
+
+	/* TODO: Add upper time limit for the delay */
+	do {
+		rc = rtas_call(fw_dump.ibm_configure_kernel_dump, 3, 1, NULL,
+			FADUMP_INVALIDATE, fdm,
+			sizeof(struct fadump_mem_struct));
+
+		wait_time = rtas_busy_delay_time(rc);
+		if (wait_time)
+			mdelay(wait_time);
+	} while (wait_time);
+
+	if (rc) {
+		printk(KERN_ERR "Failed to invalidate firmware-assisted dump "
+			"rgistration. unexpected error(%d).\n", rc);
+		return rc;
+	}
+	fw_dump.dump_active = 0;
+	fdm_active = NULL;
+	return 0;
+}
+
+void fadump_cleanup(void)
+{
+	/* Invalidate the registration only if dump is active. */
+	if (fw_dump.dump_active) {
+		init_fadump_mem_struct(&fdm,
+			fdm_active->cpu_state_data.destination_address);
+		fadump_invalidate_dump(&fdm);
+	}
+}
+
+/*
+ * Release the memory that was reserved in early boot to preserve the memory
+ * contents. The released memory will be available for general use.
+ */
+static void fadump_release_memory(unsigned long begin, unsigned long end)
+{
+	unsigned long addr;
+	unsigned long ra_start, ra_end;
+
+	ra_start = fw_dump.reserve_dump_area_start;
+	ra_end = ra_start + fw_dump.reserve_dump_area_size;
+
+	for (addr = begin; addr < end; addr += PAGE_SIZE) {
+		/*
+		 * exclude the dump reserve area. Will reuse it for next
+		 * fadump registration.
+		 */
+		if (addr <= ra_end && ((addr + PAGE_SIZE) > ra_start))
+			continue;
+
+		ClearPageReserved(pfn_to_page(addr >> PAGE_SHIFT));
+		init_page_count(pfn_to_page(addr >> PAGE_SHIFT));
+		free_page((unsigned long)__va(addr));
+		totalram_pages++;
+	}
+}
+
+static void fadump_invalidate_release_mem(void)
+{
+	unsigned long reserved_area_start, reserved_area_end;
+	unsigned long destination_address;
+
+	mutex_lock(&fadump_mutex);
+	if (!fw_dump.dump_active) {
+		mutex_unlock(&fadump_mutex);
+		return;
+	}
+
+	destination_address = fdm_active->cpu_state_data.destination_address;
+	fadump_cleanup();
+	mutex_unlock(&fadump_mutex);
+
+	/*
+	 * Save the current reserved memory bounds we will require them
+	 * later for releasing the memory for general use.
+	 */
+	reserved_area_start = fw_dump.reserve_dump_area_start;
+	reserved_area_end = reserved_area_start +
+			fw_dump.reserve_dump_area_size;
+	/*
+	 * Setup reserve_dump_area_start and its size so that we can
+	 * reuse this reserved memory for Re-registration.
+	 */
+	fw_dump.reserve_dump_area_start = destination_address;
+	fw_dump.reserve_dump_area_size = get_dump_area_size();
+
+	fadump_release_memory(reserved_area_start, reserved_area_end);
+	if (fw_dump.cpu_notes_buf) {
+		cpu_notes_buf_free((unsigned long)__va(fw_dump.cpu_notes_buf),
+					fw_dump.cpu_notes_buf_size);
+		fw_dump.cpu_notes_buf = 0;
+		fw_dump.cpu_notes_buf_size = 0;
+	}
+	/* Initialize the kernel dump memory structure for FAD registration. */
+	init_fadump_mem_struct(&fdm, fw_dump.reserve_dump_area_start);
+}
+
+static ssize_t fadump_release_memory_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	if (!fw_dump.dump_active)
+		return -EPERM;
+
+	if (buf[0] == '1') {
+		/*
+		 * Take away the '/proc/vmcore'. We are releasing the dump
+		 * memory, hence it will not be valid anymore.
+		 */
+		vmcore_cleanup();
+		fadump_invalidate_release_mem();
+
+	} else
+		return -EINVAL;
+	return count;
+}
+
 static ssize_t fadump_enabled_show(struct kobject *kobj,
 					struct kobj_attribute *attr,
 					char *buf)
@@ -1003,10 +1143,13 @@ static int fadump_region_show(struct seq_file *m, void *private)
 	if (!fw_dump.fadump_enabled)
 		return 0;
 
+	mutex_lock(&fadump_mutex);
 	if (fdm_active)
 		fdm_ptr = fdm_active;
-	else
+	else {
+		mutex_unlock(&fadump_mutex);
 		fdm_ptr = &fdm;
+	}
 
 	seq_printf(m,
 			"CPU : [%#016llx-%#016llx] %#llx bytes, "
@@ -1036,7 +1179,7 @@ static int fadump_region_show(struct seq_file *m, void *private)
 	if (!fdm_active ||
 		(fw_dump.reserve_dump_area_start ==
 		fdm_ptr->cpu_state_data.destination_address))
-		return 0;
+		goto out;
 
 	/* Dump is active. Show reserved memory region. */
 	seq_printf(m,
@@ -1048,9 +1191,15 @@ static int fadump_region_show(struct seq_file *m, void *private)
 			fw_dump.reserve_dump_area_start,
 			fdm_ptr->cpu_state_data.destination_address -
 			fw_dump.reserve_dump_area_start);
+out:
+	if (fdm_active)
+		mutex_unlock(&fadump_mutex);
 	return 0;
 }
 
+static struct kobj_attribute fadump_release_attr = __ATTR(fadump_release_mem,
+						0200, NULL,
+						fadump_release_memory_store);
 static struct kobj_attribute fadump_attr = __ATTR(fadump_enabled,
 						0444, fadump_enabled_show,
 						NULL);
@@ -1091,6 +1240,13 @@ static void fadump_init_files(void)
 	if (!debugfs_file)
 		printk(KERN_ERR "fadump: unable to create debugfs file"
 				" fadump_region\n");
+
+	if (fw_dump.dump_active) {
+		rc = sysfs_create_file(kernel_kobj, &fadump_release_attr.attr);
+		if (rc)
+			printk(KERN_ERR "fadump: unable to create sysfs file"
+				" fadump_release_mem (%d)\n", rc);
+	}
 	return;
 }
 
@@ -1110,8 +1266,14 @@ int __init setup_fadump(void)
 	 * If dump data is available then see if it is valid and prepare for
 	 * saving it to the disk.
 	 */
-	if (fw_dump.dump_active)
-		process_fadump(fdm_active);
+	if (fw_dump.dump_active) {
+		/*
+		 * if dump process fails then invalidate the registration
+		 * and release memory before proceeding for re-registration.
+		 */
+		if (process_fadump(fdm_active) < 0)
+			fadump_invalidate_release_mem();
+	}
 	/* Initialize the kernel dump memory structure for FAD registration. */
 	else if (fw_dump.reserve_dump_area_size)
 		init_fadump_mem_struct(&fdm, fw_dump.reserve_dump_area_start);
