Return-Path: <srs0=oqq6=4j=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJ63j2QtpzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 04:23:29 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wJ63h29mZz8svY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 04:23:28 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wJ63g47Yhz9rvt
 for <linuxppc-dev@ozlabs.org>; Thu,  4 May 2017 04:23:27 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v43IIoZl060323
 for <linuxppc-dev@ozlabs.org>; Wed, 3 May 2017 14:23:18 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a7cyt795w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 03 May 2017 14:23:17 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 4 May 2017 04:23:15 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v43IN4ZN64749816
 for <linuxppc-dev@ozlabs.org>; Thu, 4 May 2017 04:23:12 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v43IMdPC032186
 for <linuxppc-dev@ozlabs.org>; Thu, 4 May 2017 04:22:40 +1000
Subject: [PATCH v5 1/2] powerpc/fadump: reduce memory consumption for
 capture kernel
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michal =?utf-8?b?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 03 May 2017 23:52:17 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149383572199.1694.10940679065871920087.stgit@hbathini.in.ibm.com>
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

Introduce kernel parameter 'fadump_append=' that would take regular kernel
parameters as a comma separated list, to be enforced when fadump is active.
This 'fadump_append=' parameter can be leveraged to pass parameters like
nr_cpus=1, cgroup_disable=memory and numa=off, to disable unwarranted
resources/subsystems.

Also, ensure the log "Firmware-assisted dump is active" is printed early
in the boot process to put the subsequent fadump messages in context.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---

Changes from v4:
* Reverted to using comma-separated list for fadump_append parameters.
* Modifying command line to replace 'fadump_append=param1,param2' with
  "param1 param2" to enforce them when fadump is active.
* Based on top of patchset that includes
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=akpm&id=c2afb7ce9d088696427018ba2135b898058507b8


 arch/powerpc/include/asm/fadump.h |    2 +
 arch/powerpc/kernel/fadump.c      |   72 +++++++++++++++++++++++++++++++++++--
 arch/powerpc/kernel/prom.c        |    4 ++
 3 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 60b9108..2fadae5 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -204,11 +204,13 @@ extern int early_init_dt_scan_fw_dump(unsigned long node,
 		const char *uname, int depth, void *data);
 extern int fadump_reserve_mem(void);
 extern int setup_fadump(void);
+extern void update_command_line_with_fadump_append(char *cmdline);
 extern int is_fadump_active(void);
 extern void crash_fadump(struct pt_regs *, const char *);
 extern void fadump_cleanup(void);
 
 #else	/* CONFIG_FA_DUMP */
+static inline void update_command_line_with_fadump_append(char *cmdline) { }
 static inline int is_fadump_active(void) { return 0; }
 static inline void crash_fadump(struct pt_regs *regs, const char *str) { }
 #endif
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index e013f8f..b6f64c6 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -79,8 +79,10 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
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
@@ -263,8 +265,12 @@ int __init fadump_reserve_mem(void)
 {
 	unsigned long base, size, memory_boundary;
 
-	if (!fw_dump.fadump_enabled)
+	if (!fw_dump.fadump_enabled) {
+		if (fw_dump.dump_active)
+			pr_warn("Firmware-assisted dump was active but kernel"
+				" booted with fadump disabled!\n");
 		return 0;
+	}
 
 	if (!fw_dump.fadump_supported) {
 		printk(KERN_INFO "Firmware-assisted dump is not supported on"
@@ -304,7 +310,6 @@ int __init fadump_reserve_mem(void)
 		memory_boundary = memblock_end_of_DRAM();
 
 	if (fw_dump.dump_active) {
-		printk(KERN_INFO "Firmware-assisted dump is active.\n");
 		/*
 		 * If last boot has crashed then reserve all the memory
 		 * above boot_memory_size so that we don't touch it until
@@ -359,6 +364,67 @@ static int __init early_fadump_param(char *p)
 }
 early_param("fadump", early_fadump_param);
 
+#define FADUMP_APPEND_CMDLINE_PREFIX		"fadump_append="
+
+static __init char *get_last_fadump_append(char *p)
+{
+	char *fadump_cmdline = NULL;
+
+	/* find fadump_append and use the last one if there are more */
+	p = strstr(p, FADUMP_APPEND_CMDLINE_PREFIX);
+	while (p) {
+		fadump_cmdline = p;
+		p = strstr(p+1, FADUMP_APPEND_CMDLINE_PREFIX);
+	}
+
+	return fadump_cmdline;
+}
+
+/*
+ * Replace "fadump_append=param1,param2,param3" in cmdline with
+ * "param1 param2 param3". This will ensure that the additional
+ * parameters passed with 'fadump_append=' are enforced.
+ */
+void __init update_command_line_with_fadump_append(char *cmdline)
+{
+	static char fadump_cmdline[COMMAND_LINE_SIZE] __initdata;
+	static char append_cmdline[COMMAND_LINE_SIZE] __initdata;
+	size_t fadump_append_size = 0;
+	char *last, *p, *token;
+
+	/* get the last occurrence of fadump_append= parameter */
+	last = get_last_fadump_append(cmdline);
+	if (!last)
+		return;
+
+	/* Extract what is passed in 'fadump_append=' */
+	p = last + strlen(FADUMP_APPEND_CMDLINE_PREFIX);
+	token = strchr(p, ' ');
+	if (token) {
+		fadump_append_size = token - p + 1;
+		strlcpy(append_cmdline, token, COMMAND_LINE_SIZE);
+	} else
+		fadump_append_size = strlen(p) + 1;
+
+	/*
+	 * Change parameters passed in 'fadump_append=' from being
+	 * comma-separated to space-separated.
+	 */
+	strlcpy(fadump_cmdline, p, fadump_append_size);
+	token = strchr(fadump_cmdline, ',');
+	while (token) {
+		*token = ' ';
+		token = strchr(token, ',');
+	}
+
+	strlcpy(last, fadump_cmdline, fadump_append_size);
+	strlcat(cmdline, append_cmdline, COMMAND_LINE_SIZE);
+
+	pr_info("Modifying command line to enforce the additional parameters"
+		" passed through 'fadump_append=' parameter.");
+	pr_info("Modified command line: %s\n", cmdline);
+}
+
 static void register_fw_dump(struct fadump_mem_struct *fdm)
 {
 	int rc;
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f5d399e..dabcf25 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -683,6 +683,10 @@ void __init early_init_devtree(void *params)
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
 
+#ifdef CONFIG_FA_DUMP
+	if (is_fadump_active())
+		update_command_line_with_fadump_append(boot_command_line);
+#endif
 	parse_early_param();
 
 	/* make sure we've parsed cmdline for mem= before this */
