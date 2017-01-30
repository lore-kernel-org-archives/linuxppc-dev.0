Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBwNM6WvvzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 03:49:39 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vBwNM1YgZz9sdm
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jan 2017 03:49:38 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0UGn9fm131163
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jan 2017 11:49:37 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28a5rn336t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jan 2017 11:49:36 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 30 Jan 2017 22:19:31 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7005D125801A
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jan 2017 22:21:13 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0UGmXC424641716
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jan 2017 22:18:33 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0UGnRwC011418
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jan 2017 22:19:27 +0530
Subject: [PATCH v1 1/2] fadump: reduce memory consumption for capture kernel
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 30 Jan 2017 22:19:26 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148579496610.5530.15397162335672437574.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In case of fadump, capture (fadump) kernel boots like a normal kernel.
While this has its advantages, the capture kernel would initialize all
the components like normal kernel, which may not necessarily be needed
for a typical dump capture kernel. So, fadump capture kernel ends up
needing more memory than a typical (read kdump) capture kernel to boot.

This can be overcome by introducing parameters like fadump_nr_cpus=1,
similar to nr_cpus=1 parameter, applicable only when fadump is active.
But this approach needs introduction of special parameters applicable
only when fadump is active (capture kernel), for every parameter that
reduces memory/resource consumption.

A better approach would be to pass extra parameters to fadump capture
kernel. As firmware leaves the memory contents intact from the time of
crash till the new kernel is booted up, parameters to append to capture
kernel can be saved in real memory region and retrieved later when the
capture kernel is in its early boot process for appending to command
line parameters.

This patch introduces a new node /sys/kernel/fadump_cmdline_append to
specify the parameters to pass to fadump capture kernel, saves them in
real memory region and appends these parameters to capture kernel early
in its boot process.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/fadump.h |   28 ++++++++
 arch/powerpc/kernel/fadump.c      |  125 ++++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/prom.c        |   19 ++++++
 3 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 0031806..484083a 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -24,6 +24,8 @@
 
 #ifdef CONFIG_FA_DUMP
 
+#include <asm/setup.h>
+
 /*
  * The RMA region will be saved for later dumping when kernel crashes.
  * RMA is Real Mode Area, the first block of logical memory address owned
@@ -45,6 +47,8 @@
 
 #define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
 
+#define FADUMP_FORMAT_VERSION	0x00000002
+
 /* Firmware provided dump sections */
 #define FADUMP_CPU_STATE_DATA	0x0001
 #define FADUMP_HPTE_REGION	0x0002
@@ -126,6 +130,13 @@ struct fw_dump {
 	/* cmd line option during boot */
 	unsigned long	reserve_bootvar;
 
+	/*
+	 * Area to pass info to capture (fadump) kernel. For now,
+	 * we are only passing parameters to append.
+	 */
+	unsigned long	handover_area_start;
+	unsigned long	handover_area_size;
+
 	unsigned long	fadumphdr_addr;
 	unsigned long	cpu_notes_buf;
 	unsigned long	cpu_notes_buf_size;
@@ -159,6 +170,22 @@ static inline u64 str_to_u64(const char *str)
 #define FADUMP_CRASH_INFO_MAGIC		STR_TO_HEX("FADMPINF")
 #define REGSAVE_AREA_MAGIC		STR_TO_HEX("REGSAVE")
 
+/*
+ * The start address for an area to pass off certain configuration details
+ * like parameters to append to the commandline for a capture (fadump) kernel.
+ * Setting it to 128MB as this needs to be accessed in realmode.
+ */
+#define FADUMP_HANDOVER_AREA_START	(1UL << 27)
+
+#define FADUMP_PARAMS_AREA_MARKER	STR_TO_HEX("FADMPCMD")
+#define FADUMP_PARAMS_INFO_SIZE		sizeof(struct fadump_params_info)
+
+/* fadump parameters info */
+struct fadump_params_info {
+	u64		params_area_marker;
+	char		params[COMMAND_LINE_SIZE/2];
+};
+
 /* The firmware-assisted dump format.
  *
  * The register save area is an area in the partition's memory used to preserve
@@ -200,6 +227,7 @@ struct fad_crash_memory_ranges {
 
 extern int early_init_dt_scan_fw_dump(unsigned long node,
 		const char *uname, int depth, void *data);
+extern char *get_fadump_parameters_realmode(void);
 extern int fadump_reserve_mem(void);
 extern int setup_fadump(void);
 extern int is_fadump_active(void);
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 8f0c7c5..bc82d22 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -41,7 +41,6 @@
 #include <asm/rtas.h>
 #include <asm/fadump.h>
 #include <asm/debug.h>
-#include <asm/setup.h>
 
 static struct fw_dump fw_dump;
 static struct fadump_mem_struct fdm;
@@ -74,6 +73,9 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
 	fw_dump.fadump_supported = 1;
 	fw_dump.ibm_configure_kernel_dump = be32_to_cpu(*token);
 
+	fw_dump.handover_area_start = FADUMP_HANDOVER_AREA_START;
+	fw_dump.handover_area_size = PAGE_ALIGN(FADUMP_PARAMS_INFO_SIZE);
+
 	/*
 	 * The 'ibm,kernel-dump' rtas node is present only if there is
 	 * dump data waiting for us.
@@ -147,7 +149,7 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
 	memset(fdm, 0, sizeof(struct fadump_mem_struct));
 	addr = addr & PAGE_MASK;
 
-	fdm->header.dump_format_version = cpu_to_be32(0x00000001);
+	fdm->header.dump_format_version = cpu_to_be32(FADUMP_FORMAT_VERSION);
 	fdm->header.dump_num_sections = cpu_to_be16(3);
 	fdm->header.dump_status_flag = 0;
 	fdm->header.offset_first_dump_section =
@@ -253,6 +255,29 @@ static unsigned long get_fadump_area_size(void)
 	return size;
 }
 
+static char *get_fadump_params_buf(struct fadump_params_info *params_info)
+{
+	char *params = NULL;
+
+	if (params_info->params_area_marker == FADUMP_PARAMS_AREA_MARKER)
+		params = params_info->params;
+
+	return params;
+}
+
+char * __init get_fadump_parameters_realmode(void)
+{
+	char *params = NULL;
+	struct fadump_params_info *params_info =
+		(struct fadump_params_info *)fw_dump.handover_area_start;
+
+	if (fdm_active && fdm_active->header.dump_format_version ==
+	    cpu_to_be32(FADUMP_FORMAT_VERSION))
+		params = get_fadump_params_buf(params_info);
+
+	return params;
+}
+
 int __init fadump_reserve_mem(void)
 {
 	unsigned long base, size, memory_boundary;
@@ -297,6 +322,15 @@ int __init fadump_reserve_mem(void)
 	else
 		memory_boundary = memblock_end_of_DRAM();
 
+	/*
+	 * Reserve some memory to pass config info like parameters to append
+	 * to fadump (capture) kernel.
+	 */
+	memblock_reserve(fw_dump.handover_area_start, fw_dump.handover_area_size);
+	printk(KERN_INFO "Reserved %lu bytes at 0x%lx for passing "
+	       "some config info to fadump kernel\n",
+	       fw_dump.handover_area_size, fw_dump.handover_area_start);
+
 	if (fw_dump.dump_active) {
 		printk(KERN_INFO "Firmware-assisted dump is active.\n");
 		/*
@@ -926,6 +960,20 @@ static int fadump_create_elfcore_headers(char *bufp)
 	return 0;
 }
 
+static void init_fadump_params_area(void)
+{
+	struct fadump_params_info *params_info;
+
+	params_info = __va(fw_dump.handover_area_start);
+	memset(params_info, 0, sizeof(*params_info));
+	params_info->params_area_marker = FADUMP_PARAMS_AREA_MARKER;
+}
+
+static void init_fadump_handover_area(void)
+{
+	init_fadump_params_area();
+}
+
 static unsigned long init_fadump_header(unsigned long addr)
 {
 	struct fadump_crash_info_header *fdh;
@@ -1137,6 +1185,14 @@ static ssize_t fadump_register_show(struct kobject *kobj,
 	return sprintf(buf, "%d\n", fw_dump.dump_registered);
 }
 
+static ssize_t fadump_params_show(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   char *buf)
+{
+	return sprintf(buf, "%s\n",
+		get_fadump_params_buf(__va(fw_dump.handover_area_start)));
+}
+
 static ssize_t fadump_register_store(struct kobject *kobj,
 					struct kobj_attribute *attr,
 					const char *buf, size_t count)
@@ -1175,6 +1231,61 @@ static ssize_t fadump_register_store(struct kobject *kobj,
 	return ret < 0 ? ret : count;
 }
 
+static ssize_t fadump_params_store(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int ret;
+	bool is_truncated = false;
+	char *ptr;
+	size_t size;
+	struct fadump_params_info *params_info;
+
+	if (!fw_dump.fadump_enabled || fdm_active)
+		return -EPERM;
+
+	mutex_lock(&fadump_mutex);
+
+	ret = count;
+
+	/*
+	 * Passing 'fadump=' here is counter-intuitive.
+	 * So, throw an error when that happens.
+	 */
+	ptr = strstr(buf, "fadump=");
+	if (ptr) {
+		pr_err("'fadump=' parameter not supported here.\n");
+		ret = -EINVAL;
+		goto unlock_out;
+	}
+
+	params_info = __va(fw_dump.handover_area_start);
+	size = sizeof(params_info->params) - 1;
+	memset(params_info->params, 0, (size + 1));
+
+	if (buf[0] != ' ') {
+		params_info->params[0] = ' ';
+		size--;
+	}
+
+	if (count > size) {
+		is_truncated = true;
+		count = size;
+	}
+
+	strncat(params_info->params, buf, count);
+	size = strlen(params_info->params);
+	if (size && params_info->params[size-1] == '\n')
+		params_info->params[size-1] = 0;
+
+	if (is_truncated)
+		pr_warn("Modified: %s\n", params_info->params);
+
+unlock_out:
+	mutex_unlock(&fadump_mutex);
+	return ret;
+}
+
 static int fadump_region_show(struct seq_file *m, void *private)
 {
 	const struct fadump_mem_struct *fdm_ptr;
@@ -1245,6 +1356,10 @@ static struct kobj_attribute fadump_attr = __ATTR(fadump_enabled,
 static struct kobj_attribute fadump_register_attr = __ATTR(fadump_registered,
 						0644, fadump_register_show,
 						fadump_register_store);
+static struct
+kobj_attribute fadump_cmdline_append_attr = __ATTR(fadump_cmdline_append,
+						   0644, fadump_params_show,
+						   fadump_params_store);
 
 static int fadump_region_open(struct inode *inode, struct file *file)
 {
@@ -1273,6 +1388,11 @@ static void fadump_init_files(void)
 		printk(KERN_ERR "fadump: unable to create sysfs file"
 			" fadump_registered (%d)\n", rc);
 
+	rc = sysfs_create_file(kernel_kobj, &fadump_cmdline_append_attr.attr);
+	if (rc)
+		printk(KERN_ERR "fadump: unable to create sysfs file"
+			" fadump_cmdline_append (%d)\n", rc);
+
 	debugfs_file = debugfs_create_file("fadump_region", 0444,
 					powerpc_debugfs_root, NULL,
 					&fadump_region_fops);
@@ -1319,6 +1439,7 @@ int __init setup_fadump(void)
 	/* Initialize the kernel dump memory structure for FAD registration. */
 	else if (fw_dump.reserve_dump_area_size)
 		init_fadump_mem_struct(&fdm, fw_dump.reserve_dump_area_start);
+	init_fadump_handover_area();
 	fadump_init_files();
 
 	return 1;
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f5d399e..4b2edd0 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -683,6 +683,25 @@ void __init early_init_devtree(void *params)
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
 
+#ifdef CONFIG_FA_DUMP
+	if (is_fadump_active()) {
+		char *fadump_params = get_fadump_parameters_realmode();
+
+		/* Parameters to append to fadump (capture) kernel */
+		if (fadump_params) {
+			size_t len = strlen(fadump_params);
+			size_t boot_cmdline_len = strlen(boot_command_line);
+
+			if ((boot_cmdline_len + len) > COMMAND_LINE_SIZE)
+				len = COMMAND_LINE_SIZE - boot_cmdline_len - 1;
+
+			strncat(boot_command_line, fadump_params, len);
+			printk(KERN_INFO "fadump: appending parameters meant "
+			       "for capture kernel.\nModified cmdline: %s\n",
+			       boot_command_line);
+		}
+	}
+#endif
 	parse_early_param();
 
 	/* make sure we've parsed cmdline for mem= before this */
