Return-Path: <srs0=fjvl=cn=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ycShf2cBhzDqn7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 02:19:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3ycShf1srnz8t1V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 02:19:14 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3ycShd57fgz9sBW
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2017 02:19:13 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAFFJ3CO140052
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2017 10:19:11 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e8qjdt81v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2017 10:19:11 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 15 Nov 2017 15:19:09 -0000
Subject: [PATCH v9 7/8] powerpc/fadump: reduce memory consumption for
 capture kernel
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 lkml <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>,
 Michal =?utf-8?b?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 15 Nov 2017 20:49:02 +0530
In-Reply-To: <151075897205.14434.9005256552409420263.stgit@hbathini.in.ibm.com>
References: <151075897205.14434.9005256552409420263.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151075914051.14434.6145946050744368934.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With fadump (dump capture) kernel booting like a regular kernel, it needs
almost the same amount of memory to boot as the production kernel, which is
unwarranted for a dump capture kernel. But with no option to disable some
of the unnecessary subsystems in fadump kernel, that much memory is wasted
on fadump, depriving the production kernel of that memory.

Introduce kernel parameter 'fadump_extra_args=' that would take regular
parameters as a space separated quoted string, to be enforced when fadump
is active. This 'fadump_extra_args=' parameter can be leveraged to pass
parameters like nr_cpus=1, cgroup_disable=memory and numa=off, to disable
unwarranted resources/subsystems.

Also, ensure the log "Firmware-assisted dump is active" is printed early
in the boot process to put the subsequent fadump messages in context.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/include/asm/fadump.h |    2 +
 arch/powerpc/kernel/fadump.c      |   97 ++++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/prom.c        |    7 +++
 3 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 5a23010..41b50b3 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -208,12 +208,14 @@ extern int early_init_dt_scan_fw_dump(unsigned long node,
 		const char *uname, int depth, void *data);
 extern int fadump_reserve_mem(void);
 extern int setup_fadump(void);
+extern void enforce_fadump_extra_args(char *cmdline);
 extern int is_fadump_active(void);
 extern int should_fadump_crash(void);
 extern void crash_fadump(struct pt_regs *, const char *);
 extern void fadump_cleanup(void);
 
 #else	/* CONFIG_FA_DUMP */
+static inline void enforce_fadump_extra_args(char *cmdline) { }
 static inline int is_fadump_active(void) { return 0; }
 static inline int should_fadump_crash(void) { return 0; }
 static inline void crash_fadump(struct pt_regs *regs, const char *str) { }
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index e143180..275ea42 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -78,8 +78,10 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
 	 * dump data waiting for us.
 	 */
 	fdm_active = of_get_flat_dt_prop(node, "ibm,kernel-dump", NULL);
-	if (fdm_active)
+	if (fdm_active) {
+		pr_info("Firmware-assisted dump is active.\n");
 		fw_dump.dump_active = 1;
+	}
 
 	/* Get the sizes required to store dump data for the firmware provided
 	 * dump sections.
@@ -339,8 +341,11 @@ int __init fadump_reserve_mem(void)
 {
 	unsigned long base, size, memory_boundary;
 
-	if (!fw_dump.fadump_enabled)
+	if (!fw_dump.fadump_enabled) {
+		if (fw_dump.dump_active)
+			pr_warn("Firmware-assisted dump was active but kernel booted with fadump disabled!\n");
 		return 0;
+	}
 
 	if (!fw_dump.fadump_supported) {
 		printk(KERN_INFO "Firmware-assisted dump is not supported on"
@@ -380,7 +385,6 @@ int __init fadump_reserve_mem(void)
 		memory_boundary = memblock_end_of_DRAM();
 
 	if (fw_dump.dump_active) {
-		printk(KERN_INFO "Firmware-assisted dump is active.\n");
 		/*
 		 * If last boot has crashed then reserve all the memory
 		 * above boot_memory_size so that we don't touch it until
@@ -467,6 +471,93 @@ static int __init early_fadump_reserve_mem(char *p)
 }
 early_param("fadump_reserve_mem", early_fadump_reserve_mem);
 
+#define FADUMP_EXTRA_ARGS_PARAM		"fadump_extra_args="
+#define FADUMP_EXTRA_ARGS_LEN		(strlen(FADUMP_EXTRA_ARGS_PARAM) - 1)
+
+struct param_info {
+	char		*cmdline;
+	char		*tmp_cmdline;
+	int		 shortening;
+};
+
+static void __init fadump_update_params(struct param_info *param_info,
+					char *param, char *val,
+					char *currant, char *next)
+{
+	ptrdiff_t param_offset = currant - param_info->tmp_cmdline;
+	size_t vallen = val ? strlen(val) : 0;
+	char *tgt = param_info->cmdline + param_offset
+				- param_info->shortening;
+	int shortening = ((next - 1) - (currant))
+		- (FADUMP_EXTRA_ARGS_LEN + 1 + vallen);
+
+	if (!val)
+		return;
+
+	strncpy(tgt, FADUMP_EXTRA_ARGS_PARAM, FADUMP_EXTRA_ARGS_LEN);
+	tgt += FADUMP_EXTRA_ARGS_LEN;
+	*tgt++ = ' ';
+	strncpy(tgt, val, vallen);
+	tgt += vallen;
+
+	if (shortening) {
+		char *src = tgt + shortening;
+		memmove(tgt, src, strlen(src) + 1);
+	}
+
+	param_info->shortening += shortening;
+}
+
+/*
+ * Reworks command line parameters and splits 'fadump_extra_args=' param
+ * to enforce the parameters passed through it
+ */
+static int __init fadump_rework_cmdline_params(char *param, char *val,
+					       char *currant, char *next,
+					       const char *unused, void *arg)
+{
+	struct param_info *param_info = (struct param_info *)arg;
+
+	if (strncmp(param, FADUMP_EXTRA_ARGS_PARAM,
+		     strlen(FADUMP_EXTRA_ARGS_PARAM) - 1))
+		return 0;
+
+	fadump_update_params(param_info, param, val, currant, next);
+
+	return 0;
+}
+
+/*
+ * Replace every occurrence of 'fadump_extra_args="param1 param2 param3"'
+ * in cmdline with 'fadump_extra_args param1 param2 param3' by stripping
+ * off '=' and quotes, if any. This ensures that the additional parameters
+ * passed with 'fadump_extra_args=' are enforced.
+ */
+void __init enforce_fadump_extra_args(char *cmdline)
+{
+	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
+	static char init_cmdline[COMMAND_LINE_SIZE] __initdata;
+	struct param_info param_info;
+
+	if (strstr(cmdline, FADUMP_EXTRA_ARGS_PARAM) == NULL)
+		return;
+
+	pr_info("Modifying command line to enforce the additional parameters passed through 'fadump_extra_args='");
+
+	param_info.cmdline = cmdline;
+	param_info.tmp_cmdline = tmp_cmdline;
+	param_info.shortening = 0;
+
+	strlcpy(init_cmdline, cmdline, COMMAND_LINE_SIZE);
+
+	strlcpy(tmp_cmdline, cmdline, COMMAND_LINE_SIZE);
+	parse_args("fadump params", tmp_cmdline, NULL, 0, 0, 0,
+			&param_info, &fadump_rework_cmdline_params);
+
+	pr_info("Original command line: %s\n", init_cmdline);
+	pr_info("Modified command line: %s\n", cmdline);
+}
+
 static int register_fw_dump(struct fadump_mem_struct *fdm)
 {
 	int rc, err;
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f830562..2e6f4021 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -693,6 +693,13 @@ void __init early_init_devtree(void *params)
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
 
+	/*
+	 * Look for 'fadump_extra_args=' parameter and enfore the additional
+	 * parameters passed to it if fadump is active.
+	 */
+	if (is_fadump_active())
+		enforce_fadump_extra_args(boot_command_line);
+
 	parse_early_param();
 
 	/* make sure we've parsed cmdline for mem= before this */
