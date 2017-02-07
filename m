Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHkQY133czDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 23:38:13 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vHkQX3sNdz9s3s
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Feb 2017 23:38:12 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v17CZ1Uo102119
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2017 07:38:10 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28faae448r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 07 Feb 2017 07:38:10 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Tue, 7 Feb 2017 18:08:05 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B998B1258018
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Feb 2017 18:09:53 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v17Cc38G26935486
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2017 18:08:03 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v17Cc2VG015522
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2017 18:08:03 +0530
Subject: [PATCH v2 1/2] fadump: reduce memory consumption for capture kernel
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 07 Feb 2017 18:08:02 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148647105867.9464.16492047069430229118.stgit@hbathini.in.ibm.com>
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

Changes from v1:
* Not changing dump format version to keep compatibility intact. Using
  start and end markers instead, to check sanity of handover area.
* Checking for memory overlap with current kernel before setting up
  a handover area.


 arch/powerpc/include/asm/fadump.h |   31 +++++++
 arch/powerpc/kernel/fadump.c      |  158 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/prom.c        |   22 +++++
 3 files changed, 210 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 0031806..e6b3dc0 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -24,6 +24,8 @@
 
 #ifdef CONFIG_FA_DUMP
 
+#include <asm/setup.h>
+
 /*
  * The RMA region will be saved for later dumping when kernel crashes.
  * RMA is Real Mode Area, the first block of logical memory address owned
@@ -126,6 +128,13 @@ struct fw_dump {
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
@@ -159,6 +168,27 @@ static inline u64 str_to_u64(const char *str)
 #define FADUMP_CRASH_INFO_MAGIC		STR_TO_HEX("FADMPINF")
 #define REGSAVE_AREA_MAGIC		STR_TO_HEX("REGSAVE")
 
+/*
+ * Start address for the area to pass off certain configuration details
+ * like parameters to append to the commandline for a capture (fadump) kernel.
+ * Will refer to this area as handover area henceforth. Setting start address
+ * of handover area to 128MB as this area needs to be accessed in realmode.
+ */
+#define FADUMP_HANDOVER_AREA_START	(1UL << 27)
+#define FADUMP_HANDOVER_AREA_SIZE	(sizeof(struct fadump_handover_info) \
+					 + H_END_MARKER_SIZE)
+
+#define H_AREA_START_MARKER		STR_TO_HEX("HDRSTART")
+#define H_AREA_END_MARKER		STR_TO_HEX("HOVEREND")
+#define H_END_MARKER_SIZE		8
+
+/* config info to be passed to capture kernel */
+struct fadump_handover_info {
+	u64		start_marker;
+	u64		size;
+	char		params[COMMAND_LINE_SIZE/2];
+};
+
 /* The firmware-assisted dump format.
  *
  * The register save area is an area in the partition's memory used to preserve
@@ -200,6 +230,7 @@ struct fad_crash_memory_ranges {
 
 extern int early_init_dt_scan_fw_dump(unsigned long node,
 		const char *uname, int depth, void *data);
+extern char *get_fadump_parameters_realmode(void);
 extern int fadump_reserve_mem(void);
 extern int setup_fadump(void);
 extern int is_fadump_active(void);
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 8f0c7c5..eab26e9 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -41,7 +41,6 @@
 #include <asm/rtas.h>
 #include <asm/fadump.h>
 #include <asm/debug.h>
-#include <asm/setup.h>
 
 static struct fw_dump fw_dump;
 static struct fadump_mem_struct fdm;
@@ -51,6 +50,8 @@ static DEFINE_MUTEX(fadump_mutex);
 struct fad_crash_memory_ranges crash_memory_ranges[INIT_CRASHMEM_RANGES];
 int crash_mem_ranges;
 
+extern char _stext[], _end[];
+
 /* Scan the Firmware Assisted dump configuration details. */
 int __init early_init_dt_scan_fw_dump(unsigned long node,
 			const char *uname, int depth, void *data)
@@ -74,6 +75,9 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
 	fw_dump.fadump_supported = 1;
 	fw_dump.ibm_configure_kernel_dump = be32_to_cpu(*token);
 
+	fw_dump.handover_area_start = FADUMP_HANDOVER_AREA_START;
+	fw_dump.handover_area_size = PAGE_ALIGN(FADUMP_HANDOVER_AREA_SIZE);
+
 	/*
 	 * The 'ibm,kernel-dump' rtas node is present only if there is
 	 * dump data waiting for us.
@@ -253,6 +257,34 @@ static unsigned long get_fadump_area_size(void)
 	return size;
 }
 
+static char *get_fadump_params_buf(struct fadump_handover_info *h_info)
+{
+	char *params = NULL;
+	u64 *end_marker;
+
+	if (h_info->start_marker == H_AREA_START_MARKER) {
+		end_marker = (u64 *)h_info;
+		end_marker += ((h_info->size - H_END_MARKER_SIZE) /
+			       sizeof(*end_marker));
+		if (*end_marker == H_AREA_END_MARKER)
+			params = h_info->params;
+	}
+
+	return params;
+}
+
+char * __init get_fadump_parameters_realmode(void)
+{
+	char *params = NULL;
+	struct fadump_handover_info *h_info =
+		(struct fadump_handover_info *)fw_dump.handover_area_start;
+
+	if (fdm_active)
+		params = get_fadump_params_buf(h_info);
+
+	return params;
+}
+
 int __init fadump_reserve_mem(void)
 {
 	unsigned long base, size, memory_boundary;
@@ -285,6 +317,7 @@ int __init fadump_reserve_mem(void)
 	 */
 	if (memory_limit && memory_limit < memblock_end_of_DRAM()) {
 		size = get_fadump_area_size();
+		size += fw_dump.handover_area_size;
 		if ((memory_limit + size) < memblock_end_of_DRAM())
 			memory_limit += size;
 		else
@@ -297,6 +330,28 @@ int __init fadump_reserve_mem(void)
 	else
 		memory_boundary = memblock_end_of_DRAM();
 
+	/*
+	 * Ensure that the memory marked for handover area doesn't overlap
+	 * with current kernel and reserve it to pass config info like
+	 * parameters to append to capture (fadump) kernel.
+	 */
+	base = __pa(_stext);
+	size = _end - _stext;
+	if (((base + size) > fw_dump.handover_area_start) && (base <=
+	    (fw_dump.handover_area_start + fw_dump.handover_area_size - 1))) {
+		/*
+		 * If the area marked for handover area overlaps with
+		 * current kernel, avoid using a handover area.
+		 */
+		fw_dump.handover_area_size = 0;
+	} else {
+		memblock_reserve(fw_dump.handover_area_start,
+				 fw_dump.handover_area_size);
+		pr_info("Reserved %lu bytes at 0x%lx for passing certain config"
+			" info to capture kernel\n", fw_dump.handover_area_size,
+			fw_dump.handover_area_start);
+	}
+
 	if (fw_dump.dump_active) {
 		printk(KERN_INFO "Firmware-assisted dump is active.\n");
 		/*
@@ -926,6 +981,23 @@ static int fadump_create_elfcore_headers(char *bufp)
 	return 0;
 }
 
+static void init_fadump_handover_area(void)
+{
+	struct fadump_handover_info *h_info;
+	u64 *end_marker;
+
+	if (fw_dump.handover_area_size == 0)
+		return;
+
+	h_info = __va(fw_dump.handover_area_start);
+	memset(h_info, 0, fw_dump.handover_area_size);
+	h_info->start_marker = H_AREA_START_MARKER;
+	h_info->size = fw_dump.handover_area_size;
+	end_marker = (u64 *)h_info;
+	end_marker += (h_info->size - H_END_MARKER_SIZE)/sizeof(*end_marker);
+	*end_marker = H_AREA_END_MARKER;
+}
+
 static unsigned long init_fadump_header(unsigned long addr)
 {
 	struct fadump_crash_info_header *fdh;
@@ -1137,6 +1209,14 @@ static ssize_t fadump_register_show(struct kobject *kobj,
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
@@ -1175,6 +1255,69 @@ static ssize_t fadump_register_store(struct kobject *kobj,
 	return ret < 0 ? ret : count;
 }
 
+static ssize_t fadump_params_store(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int i, ret;
+	bool is_truncated = false;
+	char *ptr;
+	size_t size;
+	struct fadump_handover_info *h_info;
+	char *h_params_buf;
+
+	h_info = __va(fw_dump.handover_area_start);
+	h_params_buf = get_fadump_params_buf(h_info);
+	size = sizeof(h_info->params) - 1;
+
+	if (!fw_dump.fadump_enabled || fdm_active || !h_params_buf)
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
+	memset(h_params_buf, 0, (size + 1));
+
+	/* Proceed only if something worthwhile is passed */
+	for (i = 0; (i < count) && (buf[i] == ' '); i++);
+	if ((i == count) || (buf[i] == '\n'))
+		goto unlock_out;
+
+	if (buf[0] != ' ') {
+		h_params_buf[0] = ' ';
+		size--;
+	}
+
+	if (count > size) {
+		is_truncated = true;
+		count = size;
+	}
+
+	strncat(h_params_buf, buf, count);
+	size = strlen(h_params_buf);
+	if (size && h_params_buf[size-1] == '\n')
+		h_params_buf[size-1] = 0;
+
+	if (is_truncated)
+		pr_warn("Modified: %s\n", h_params_buf);
+
+unlock_out:
+	mutex_unlock(&fadump_mutex);
+	return ret;
+}
+
 static int fadump_region_show(struct seq_file *m, void *private)
 {
 	const struct fadump_mem_struct *fdm_ptr;
@@ -1245,6 +1388,10 @@ static struct kobj_attribute fadump_attr = __ATTR(fadump_enabled,
 static struct kobj_attribute fadump_register_attr = __ATTR(fadump_registered,
 						0644, fadump_register_show,
 						fadump_register_store);
+static struct
+kobj_attribute fadump_cmdline_append_attr = __ATTR(fadump_cmdline_append,
+						   0644, fadump_params_show,
+						   fadump_params_store);
 
 static int fadump_region_open(struct inode *inode, struct file *file)
 {
@@ -1273,6 +1420,14 @@ static void fadump_init_files(void)
 		printk(KERN_ERR "fadump: unable to create sysfs file"
 			" fadump_registered (%d)\n", rc);
 
+	if (fw_dump.handover_area_size) {
+		rc = sysfs_create_file(kernel_kobj,
+				       &fadump_cmdline_append_attr.attr);
+		if (rc)
+			pr_err("unable to create sysfs file "
+			       "fadump_cmdline_append (%d)\n", rc);
+	}
+
 	debugfs_file = debugfs_create_file("fadump_region", 0444,
 					powerpc_debugfs_root, NULL,
 					&fadump_region_fops);
@@ -1319,6 +1474,7 @@ int __init setup_fadump(void)
 	/* Initialize the kernel dump memory structure for FAD registration. */
 	else if (fw_dump.reserve_dump_area_size)
 		init_fadump_mem_struct(&fdm, fw_dump.reserve_dump_area_start);
+	init_fadump_handover_area();
 	fadump_init_files();
 
 	return 1;
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f5d399e..c0cab4c 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -683,6 +683,28 @@ void __init early_init_devtree(void *params)
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
 
+#ifdef CONFIG_FA_DUMP
+	if (is_fadump_active()) {
+		size_t len = 0;
+		char *fadump_params = get_fadump_parameters_realmode();
+
+		if (fadump_params)
+			len = strlen(fadump_params);
+
+		/* Parameters to append to capture (fadump) kernel */
+		if (len) {
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
