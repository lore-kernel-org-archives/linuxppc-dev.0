Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 970491007DE
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2011 01:10:10 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p8TFA8kq019551
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2011 01:10:08 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8TFA8wJ1347658
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2011 01:10:08 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8TFA8oW017567
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2011 01:10:08 +1000
Subject: [RFC PATCH v2 08/10] fadump: Invalidate registration and release
	reserved memory for general use.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 29 Sep 2011 20:39:16 +0530
Message-ID: <20110929150916.26689.26900.stgit@mars.in.ibm.com>
In-Reply-To: <20110929150117.26689.62053.stgit@mars.in.ibm.com>
References: <20110929150117.26689.62053.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Anton Blanchard <anton@samba.org>, Milton Miller <miltonm@bga.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
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

Change in v2:
- Introduced cpu_notes_buf_free() function to free memory allocated for
  cpu notes buffer.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/fadump.h |    3 +
 arch/powerpc/kernel/fadump.c      |  159 +++++++++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index ace2920..9943be9 100644
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
index 13c830c..abb0173 100644
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
@@ -559,6 +561,19 @@ static void *cpu_notes_buf_alloc(unsigned long size)
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
@@ -918,6 +933,129 @@ static void register_fadump(void)
 	register_fw_dump(&fdm);
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
+
+	if (!fw_dump.dump_active)
+		return;
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
+	fw_dump.reserve_dump_area_start =
+			fdm_active->cpu_state_data.destination_address;
+	fw_dump.reserve_dump_area_size = get_dump_area_size();
+
+	fadump_cleanup();
+	fadump_release_memory(reserved_area_start, reserved_area_end);
+	if (fw_dump.cpu_notes_buf) {
+		cpu_notes_buf_free((unsigned long)__va(fw_dump.cpu_notes_buf),
+					fw_dump.cpu_notes_buf_size);
+		fw_dump.cpu_notes_buf = 0;
+		fw_dump.cpu_notes_buf_size = 0;
+	}
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
+		/*
+		 * We are done saving the dump and have release the memory
+		 * for general use. Now Re-register for firmware-assisted dump
+		 * for future kernel dump.
+		 */
+		register_fadump();
+	} else
+		return -EINVAL;
+	return count;
+}
+
 static ssize_t fadump_enabled_show(struct kobject *kobj,
 					struct kobj_attribute *attr,
 					char *buf)
@@ -980,6 +1118,9 @@ static int fadump_region_show(struct seq_file *m, void *private)
 	return 0;
 }
 
+static struct kobj_attribute fadump_release_attr = __ATTR(fadump_release_mem,
+						0200, NULL,
+						fadump_release_memory_store);
 static struct kobj_attribute fadump_attr = __ATTR(fadump_enabled,
 						0444, fadump_enabled_show,
 						NULL);
@@ -1012,6 +1153,13 @@ static void fadump_init_files(void)
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
 
@@ -1033,8 +1181,15 @@ int __init setup_fadump(void)
 	 * saving it to the disk.
 	 */
 	if (fw_dump.dump_active) {
-		process_fadump(fdm_active);
-		goto out;
+		/*
+		 * if dump process fails then invalidate the registration
+		 * and release memory before proceeding for re-registration.
+		 */
+		if (process_fadump(fdm_active) < 0) {
+			fadump_invalidate_release_mem();
+			/* fall through for Re-registration. */
+		} else
+			goto out;
 	}
 
 	register_fadump();
