Return-Path: <srs0=xksd=4c=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCX3J4C4szDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 17:37:16 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wCX3J3nN4z8wVM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 17:37:16 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wCX3J0hGpz9s7f
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 17:37:15 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3Q7Y3ax125310
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 03:37:14 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebwv0jg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 03:37:14 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 26 Apr 2017 17:36:13 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3Q7a3xl54394982
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 17:36:11 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3Q7ZXf7020763
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 17:35:34 +1000
Subject: [PATCH v3 1/2] powerpc/fadump: reduce memory consumption for
 capture kernel
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michal =?utf-8?b?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 26 Apr 2017 13:05:20 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149319210065.14869.5547128856388591456.stgit@hbathini.in.ibm.com>
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

Changes from v2:
* Introducing 'fadump_append=' parameter to pass additional kernel                          
  parameters instead of using a handover area.
        

 arch/powerpc/kernel/fadump.c |   41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 8ff0dd4..87edc7b 100644
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
@@ -257,8 +259,12 @@ int __init fadump_reserve_mem(void)
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
@@ -298,7 +304,6 @@ int __init fadump_reserve_mem(void)
 		memory_boundary = memblock_end_of_DRAM();
 
 	if (fw_dump.dump_active) {
-		printk(KERN_INFO "Firmware-assisted dump is active.\n");
 		/*
 		 * If last boot has crashed then reserve all the memory
 		 * above boot_memory_size so that we don't touch it until
@@ -338,6 +343,36 @@ unsigned long __init arch_reserved_kernel_pages(void)
 	return memblock_reserved_size() / PAGE_SIZE;
 }
 
+static void __init parse_fadump_append_params(const char *p)
+{
+	static char fadump_cmdline[COMMAND_LINE_SIZE] __initdata;
+	char *token;
+
+	strlcpy(fadump_cmdline, p, COMMAND_LINE_SIZE);
+	token = strchr(fadump_cmdline, ',');
+	while (token) {
+		*token = ' ';
+		token = strchr(token, ',');
+	}
+
+	pr_info("enforcing additional parameters (%s) passed through "
+		"'fadump_append=' parameter\n", fadump_cmdline);
+	parse_early_options(fadump_cmdline);
+}
+
+/* Look for fadump_append= cmdline option. */
+static int __init early_fadump_append_param(char *p)
+{
+	if (!p)
+		return 1;
+
+	if (fw_dump.dump_active)
+		parse_fadump_append_params(p);
+
+	return 0;
+}
+early_param("fadump_append", early_fadump_append_param);
+
 /* Look for fadump= cmdline option. */
 static int __init early_fadump_param(char *p)
 {
