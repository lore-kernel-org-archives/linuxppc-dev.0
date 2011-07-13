Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3518510CB5A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jul 2011 04:08:26 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p6DI7gI1010856
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2011 04:07:42 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6DI8Pnv577702
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2011 04:08:25 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p6DI8P4e002957
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2011 04:08:25 +1000
Subject: [RFC PATCH 08/10] fadump: Invalidate registration and release
	reserved memory for general use.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 13 Jul 2011 23:38:22 +0530
Message-ID: <20110713180808.6210.73370.stgit@mars.in.ibm.com>
In-Reply-To: <20110713180252.6210.34810.stgit@mars.in.ibm.com>
References: <20110713180252.6210.34810.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michael Ellerman <michael@ellerman.id.au>,
	Anton Blanchard <anton@samba.org>, Milton Miller <miltonm@bga.com>,
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

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/fadump.h |    3 +
 arch/powerpc/kernel/fadump.c      |  153 +++++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 1faa980..52fa1db 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -187,5 +187,8 @@ extern int fadump_reserve_mem(void);
 extern int setup_fadump(void);
 extern int is_fadump_active(void);
 extern void crash_fadump(struct pt_regs *, const char *);
+extern void fadump_cleanup(void);
+
+extern void vmcore_cleanup(void);
 #endif
 #endif
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index fee132b..22c72cb 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -30,6 +30,8 @@
 #include <linux/memblock.h>
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
 
 #include <asm/page.h>
 #include <asm/prom.h>
@@ -963,6 +965,137 @@ static void register_fadump(void)
 	register_fw_dump(&fdm);
 }
 
+static int fadump_invalidate_dump(struct fadump_mem_struct *fdm)
+{
+	int rc = 0;
+	unsigned int wait_time;
+
+	DBG("Invalidating firmware-assisted dump registration\n");
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
+static void fadump_release_memory(unsigned long begin, unsigned long end,
+							int early_boot)
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
+		if (early_boot) {
+			memblock_free(addr, PAGE_SIZE);
+			continue;
+		}
+
+		ClearPageReserved(pfn_to_page(addr >> PAGE_SHIFT));
+		init_page_count(pfn_to_page(addr >> PAGE_SHIFT));
+		free_page((unsigned long)__va(addr));
+		totalram_pages++;
+	}
+}
+
+static void fadump_invalidate_release_mem(int early_boot)
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
+	fadump_release_memory(reserved_area_start, reserved_area_end,
+							early_boot);
+	if (fw_dump.cpu_notes_buf) {
+		fadump_release_memory(fw_dump.cpu_notes_buf,
+					fw_dump.cpu_notes_buf_size,
+					early_boot);
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
+		fadump_invalidate_release_mem(0);
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
@@ -1028,6 +1161,9 @@ static ssize_t fadump_region_show(struct kobject *kobj,
 	return n;
 }
 
+static struct kobj_attribute fadump_release_attr = __ATTR(fadump_release_mem,
+						0200, NULL,
+						fadump_release_memory_store);
 static struct kobj_attribute fadump_attr = __ATTR(fadump_enabled,
 						0444, fadump_enabled_show,
 						NULL);
@@ -1047,6 +1183,12 @@ static int fadump_init_sysfs(void)
 	if (rc)
 		printk(KERN_ERR "fadump: unable to create sysfs file"
 			" (%d)\n", rc);
+	if (fw_dump.dump_active) {
+		rc = sysfs_create_file(kernel_kobj, &fadump_release_attr.attr);
+		if (rc)
+			printk(KERN_ERR "fadump: unable to create sysfs file"
+				" (%d)\n", rc);
+	}
 	return rc;
 }
 subsys_initcall(fadump_init_sysfs);
@@ -1069,8 +1211,15 @@ int __init setup_fadump(void)
 	 * saving it to the disk.
 	 */
 	if (fw_dump.dump_active) {
-		process_fadump(fdm_active);
-		return 1;
+		/*
+		 * if dump process fails then invalidate the registration
+		 * and release memory before proceeding for re-registration.
+		 */
+		if (process_fadump(fdm_active) < 0) {
+			fadump_invalidate_release_mem(1);
+			/* fall through for Re-registration. */
+		} else
+			return 1;
 	}
 
 	register_fadump();
