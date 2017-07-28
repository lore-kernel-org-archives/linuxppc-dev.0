Return-Path: <srs0=roly=67=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xK1Rt6sqhzDrKR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 06:59:22 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xK1Rt66Srz8syC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 06:59:22 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xK1Rt27Drz9s75
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Jul 2017 06:59:21 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6SKx5iN050721
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2017 16:59:20 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c0a7vee0r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2017 16:59:18 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Sat, 29 Jul 2017 06:58:47 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6SKvUWr18153658
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Jul 2017 06:57:30 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6SKvLeK015699
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Jul 2017 06:57:21 +1000
Subject: [PATCH v6 1/2] powerpc/fadump: reduce memory consumption for
 capture kernel
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>,
 Michal =?utf-8?b?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Sat, 29 Jul 2017 02:27:22 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <150127542322.3236.985689008735814219.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With fadump (dump capture) kernel booting like a regular kernel, it almost
needs the same amount of memory to boot as the production kernel, which is
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
---

Changes from v5:
* Using 'fadump_extra_args=' instead of 'fadump_append=' to pass
  additional parameters, to be enforced when fadump is active.
* Using space-separated quoted list as syntax for 'fadump_extra_args='
  parameter.


 arch/powerpc/include/asm/fadump.h |    2 +
 arch/powerpc/kernel/fadump.c      |  125 ++++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/prom.c        |    7 ++
 3 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index ce88bbe..98ae009 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -208,11 +208,13 @@ extern int early_init_dt_scan_fw_dump(unsigned long node,
 		const char *uname, int depth, void *data);
 extern int fadump_reserve_mem(void);
 extern int setup_fadump(void);
+extern void enforce_fadump_extra_args(char *cmdline);
 extern int is_fadump_active(void);
 extern void crash_fadump(struct pt_regs *, const char *);
 extern void fadump_cleanup(void);
 
 #else	/* CONFIG_FA_DUMP */
+static inline void enforce_fadump_extra_args(char *cmdline) { }
 static inline int is_fadump_active(void) { return 0; }
 static inline void crash_fadump(struct pt_regs *regs, const char *str) { }
 #endif
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index dc0c49c..d8cb829 100644
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
@@ -332,8 +334,11 @@ int __init fadump_reserve_mem(void)
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
@@ -373,7 +378,6 @@ int __init fadump_reserve_mem(void)
 		memory_boundary = memblock_end_of_DRAM();
 
 	if (fw_dump.dump_active) {
-		printk(KERN_INFO "Firmware-assisted dump is active.\n");
 		/*
 		 * If last boot has crashed then reserve all the memory
 		 * above boot_memory_size so that we don't touch it until
@@ -460,6 +464,121 @@ static int __init early_fadump_reserve_mem(char *p)
 }
 early_param("fadump_reserve_mem", early_fadump_reserve_mem);
 
+#define FADUMP_EXTRA_ARGS_PARAM		"fadump_extra_args="
+#define INIT_ARGS_START			"-- "
+#define INIT_ARGS_START_LEN		strlen(INIT_ARGS_START)
+
+struct param_info {
+	char		*params;
+	unsigned int	len;
+	unsigned int	index;
+};
+
+static void __init fadump_update_params(struct param_info *param_info,
+					char *val, unsigned int len,
+					bool split_params)
+{
+	bool add_quotes = (split_params ? false :
+			   ((strchr(val, ' ') != NULL) ? true : false));
+
+	if (add_quotes)
+		param_info->params[param_info->index++] = '"';
+
+	strncpy(param_info->params + param_info->index, val, len);
+	param_info->index += len;
+
+	if (add_quotes)
+		param_info->params[param_info->index++] = '"';
+}
+
+/*
+ * Reworks command line parameters and splits 'fadump_extra_args=' param
+ * to enforce the parameters passed through it
+ */
+static int __init fadump_rework_cmdline_params(char *param, char *val,
+					       const char *unused, void *arg)
+{
+	unsigned int len;
+	struct param_info *param_info = (struct param_info *)arg;
+	bool split_params = false;
+
+	if (!strncmp(param, FADUMP_EXTRA_ARGS_PARAM,
+		     (strlen(FADUMP_EXTRA_ARGS_PARAM) - 1)))
+		split_params = true;
+
+	len = strlen(param);
+	fadump_update_params(param_info, param, len, split_params);
+
+	len = (val != NULL) ? strlen(val) : 0;
+	if (len) {
+		param_info->params[param_info->index++] =
+						split_params ? ' ' : '=';
+		fadump_update_params(param_info, val, len, split_params);
+	}
+
+	param_info->params[param_info->index++] = ' ';
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
+	char *args;
+
+	if (strstr(cmdline, FADUMP_EXTRA_ARGS_PARAM) == NULL)
+		return;
+
+	pr_info("Modifying command line to enforce the additional parameters passed through 'fadump_extra_args='");
+
+	param_info.params = cmdline;
+	param_info.len = strlen(cmdline);
+	param_info.index = 0;
+
+	strlcpy(init_cmdline, cmdline, COMMAND_LINE_SIZE);
+
+	strlcpy(tmp_cmdline, cmdline, COMMAND_LINE_SIZE);
+	while (1) {
+		parse_args("fadump params", tmp_cmdline, NULL, 0, 0, 0,
+			   &param_info, &fadump_rework_cmdline_params);
+
+		/*
+		 * parse_args() stops at '--'. Keep going if there are more
+		 * parameters as we are supposed to look at all parameters
+		 * in this case. Otherwise, break.
+		 */
+		args = strstr(init_cmdline + param_info.index, INIT_ARGS_START);
+		if (args == NULL)
+			break;
+
+		strncpy(param_info.params + param_info.index,
+			INIT_ARGS_START, INIT_ARGS_START_LEN);
+		param_info.index += INIT_ARGS_START_LEN;
+		strlcpy(tmp_cmdline, (args + INIT_ARGS_START_LEN),
+			(COMMAND_LINE_SIZE - param_info.index));
+	}
+
+	/*
+	 * Length of the processed cmdline could come down owing to the
+	 * stripping of quotes. Fill that much length with '\0' to
+	 * compensate for that.
+	 */
+	if (param_info.len > param_info.index) {
+		memset(param_info.params + param_info.index, '\0',
+		       (param_info.len - param_info.index));
+	}
+
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
