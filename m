Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2DxT3rvQzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 20:45:33 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8RAiBUd059578
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 06:45:30 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2d87tvgu87-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 06:45:30 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 27 Sep 2017 20:45:26 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8RAjO9C39518340
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 20:45:24 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8RAjDUT007238
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 20:45:15 +1000
Subject: Re: [PATCH v8 1/6] powerpc/fadump: reduce memory consumption for
 capture kernel
To: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
 Rusty Russell <rusty@rustcorp.com.au>, Jason Baron <jbaron@akamai.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Daniel Axtens
 <dja@axtens.net>, Nicholas Piggin <npiggin@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Neuling <mikey@neuling.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 "Sylvain 'ythier' Hitier" <sylvain.hitier@gmail.com>,
 David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Steven Rostedt," <rostedt@goodmis.org>,
 Michal Hocko <mhocko@suse.com>, Laura Abbott <lauraa@codeaurora.org>,
 Tejun Heo <tj@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Lokesh Vutla <lokeshvutla@ti.com>, Baoquan He <bhe@redhat.com>,
 Ilya Matveychikov <matvejchikov@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ee9b1eefc4057e45c5c8ec56c10513a21802543b.1505231820.git.msuchanek@suse.de>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 27 Sep 2017 16:15:13 +0530
MIME-Version: 1.0
In-Reply-To: <ee9b1eefc4057e45c5c8ec56c10513a21802543b.1505231820.git.msuchanek@suse.de>
Content-Type: multipart/alternative;
 boundary="------------E3F0F65FF6AC0C7D9EFBB6E0"
Message-Id: <b30c24da-ee8d-6da4-b07a-82b88f43d412@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------E3F0F65FF6AC0C7D9EFBB6E0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On Tuesday 12 September 2017 09:31 PM, Michal Suchanek wrote:
> With fadump (dump capture) kernel booting like a regular kernel, it needs
> almost the same amount of memory to boot as the production kernel, which is
> unwarranted for a dump capture kernel. But with no option to disable some
> of the unnecessary subsystems in fadump kernel, that much memory is wasted
> on fadump, depriving the production kernel of that memory.
>
> Introduce kernel parameter 'fadump_extra_args=' that would take regular
> parameters as a space separated quoted string, to be enforced when fadump
> is active. This 'fadump_extra_args=' parameter can be leveraged to pass
> parameters like nr_cpus=1, cgroup_disable=memory and numa=off, to disable
> unwarranted resources/subsystems.
>
> Also, ensure the log "Firmware-assisted dump is active" is printed early
> in the boot process to put the subsequent fadump messages in context.
>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

For the series..
Tested-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

> ---
> Changes from v6:
> Correct and simplify quote handling. Ideally I would like to extend
> parse_args to give the length of the original quoted value to callback.
> However, parse_args removes at most one doubel-quote from the start and
> one from the end so that is easy to detect. Otherwise all other users
> will have to be updated to trash the new argument.
> Changes from v7:
> Handle leading quote in parameter name.
> ---
>   arch/powerpc/include/asm/fadump.h |   2 +
>   arch/powerpc/kernel/fadump.c      | 122 +++++++++++++++++++++++++++++++++++++-
>   arch/powerpc/kernel/prom.c        |   7 +++
>   3 files changed, 128 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
> index 5a23010af600..41b50b317a67 100644
> --- a/arch/powerpc/include/asm/fadump.h
> +++ b/arch/powerpc/include/asm/fadump.h
> @@ -208,12 +208,14 @@ extern int early_init_dt_scan_fw_dump(unsigned long node,
>   		const char *uname, int depth, void *data);
>   extern int fadump_reserve_mem(void);
>   extern int setup_fadump(void);
> +extern void enforce_fadump_extra_args(char *cmdline);
>   extern int is_fadump_active(void);
>   extern int should_fadump_crash(void);
>   extern void crash_fadump(struct pt_regs *, const char *);
>   extern void fadump_cleanup(void);
>
>   #else	/* CONFIG_FA_DUMP */
> +static inline void enforce_fadump_extra_args(char *cmdline) { }
>   static inline int is_fadump_active(void) { return 0; }
>   static inline int should_fadump_crash(void) { return 0; }
>   static inline void crash_fadump(struct pt_regs *regs, const char *str) { }
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index e1431800bfb9..0e08f1a80af2 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -78,8 +78,10 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
>   	 * dump data waiting for us.
>   	 */
>   	fdm_active = of_get_flat_dt_prop(node, "ibm,kernel-dump", NULL);
> -	if (fdm_active)
> +	if (fdm_active) {
> +		pr_info("Firmware-assisted dump is active.\n");
>   		fw_dump.dump_active = 1;
> +	}
>
>   	/* Get the sizes required to store dump data for the firmware provided
>   	 * dump sections.
> @@ -339,8 +341,11 @@ int __init fadump_reserve_mem(void)
>   {
>   	unsigned long base, size, memory_boundary;
>
> -	if (!fw_dump.fadump_enabled)
> +	if (!fw_dump.fadump_enabled) {
> +		if (fw_dump.dump_active)
> +			pr_warn("Firmware-assisted dump was active but kernel booted with fadump disabled!\n");
>   		return 0;
> +	}
>
>   	if (!fw_dump.fadump_supported) {
>   		printk(KERN_INFO "Firmware-assisted dump is not supported on"
> @@ -380,7 +385,6 @@ int __init fadump_reserve_mem(void)
>   		memory_boundary = memblock_end_of_DRAM();
>
>   	if (fw_dump.dump_active) {
> -		printk(KERN_INFO "Firmware-assisted dump is active.\n");
>   		/*
>   		 * If last boot has crashed then reserve all the memory
>   		 * above boot_memory_size so that we don't touch it until
> @@ -467,6 +471,118 @@ static int __init early_fadump_reserve_mem(char *p)
>   }
>   early_param("fadump_reserve_mem", early_fadump_reserve_mem);
>
> +#define FADUMP_EXTRA_ARGS_PARAM		"fadump_extra_args="
> +#define FADUMP_EXTRA_ARGS_LEN		(strlen(FADUMP_EXTRA_ARGS_PARAM) - 1)
> +
> +struct param_info {
> +	char		*cmdline;
> +	char		*tmp_cmdline;
> +	int		 shortening;
> +};
> +
> +static void __init fadump_update_params(struct param_info *param_info,
> +					char *param, char *val)
> +{
> +	ptrdiff_t param_offset = param - param_info->tmp_cmdline;
> +	size_t vallen = val ? strlen(val) : 0;
> +	char *tgt = param_info->cmdline + param_offset
> +				- param_info->shortening;
> +	int shortening = 0;
> +	int quoted = 0;
> +
> +	if (!val)
> +		return;
> +
> +	/* leading '"' removed from parameter */
> +	if ((param > param_info->tmp_cmdline) && *(param - 1) == '"') {
> +		quoted = 1;
> +		shortening += 1;
> +		tgt--;
> +	}
> +
> +	/* next_arg removes one leading and one trailing '"' */
> +	if (*(tgt + FADUMP_EXTRA_ARGS_LEN + 1) == '"')
> +		shortening += 1;
> +	if (*(tgt + FADUMP_EXTRA_ARGS_LEN + 1 + vallen + shortening) == '"')
> +		shortening += 1;
> +
> +	/* remove one leading and one trailing quote if both are present */
> +	if ((val[0] == '"') && (val[vallen - 1] == '"')) {
> +		shortening += 2;
> +		vallen -= 2;
> +		val++;
> +	}
> +
> +	/* some characters were removed - move the trailing part of cmdline */
> +	if (shortening) {
> +		char *src;
> +
> +		strncpy(tgt, FADUMP_EXTRA_ARGS_PARAM, FADUMP_EXTRA_ARGS_LEN);
> +		tgt += FADUMP_EXTRA_ARGS_LEN;
> +		*tgt++ = ' ';
> +
> +		strncpy(tgt, val, vallen);
> +		tgt += vallen;
> +
> +		src = tgt + shortening;
> +		memmove(tgt, src, strlen(src) + 1);
> +	} else {
> +		/* remove the '=' */
> +		*(tgt + FADUMP_EXTRA_ARGS_LEN) = ' ';
> +	}
> +
> +	param_info->shortening += shortening;
> +}
> +
> +/*
> + * Reworks command line parameters and splits 'fadump_extra_args=' param
> + * to enforce the parameters passed through it
> + */
> +static int __init fadump_rework_cmdline_params(char *param, char *val,
> +					       const char *unused, void *arg)
> +{
> +	struct param_info *param_info = (struct param_info *)arg;
> +
> +	if (strncmp(param, FADUMP_EXTRA_ARGS_PARAM,
> +		     strlen(FADUMP_EXTRA_ARGS_PARAM) - 1))
> +		return 0;
> +
> +	fadump_update_params(param_info, param, val);
> +
> +	return 0;
> +}
> +
> +/*
> + * Replace every occurrence of 'fadump_extra_args="param1 param2 param3"'
> + * in cmdline with 'fadump_extra_args param1 param2 param3' by stripping
> + * off '=' and quotes, if any. This ensures that the additional parameters
> + * passed with 'fadump_extra_args=' are enforced.
> + */
> +void __init enforce_fadump_extra_args(char *cmdline)
> +{
> +	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> +	static char init_cmdline[COMMAND_LINE_SIZE] __initdata;
> +	struct param_info param_info;
> +
> +	if (strstr(cmdline, FADUMP_EXTRA_ARGS_PARAM) == NULL)
> +		return;
> +
> +	pr_info("Modifying command line to enforce the additional parameters passed through 'fadump_extra_args='");
> +
> +	param_info.cmdline = cmdline;
> +	param_info.tmp_cmdline = tmp_cmdline;
> +	param_info.shortening = 0;
> +
> +	strlcpy(init_cmdline, cmdline, COMMAND_LINE_SIZE);
> +
> +	strlcpy(tmp_cmdline, cmdline, COMMAND_LINE_SIZE);
> +	parse_args("fadump params", tmp_cmdline, NULL, 0, 0, 0,
> +			&param_info, &fadump_rework_cmdline_params);
> +
> +	pr_info("Original command line: %s\n", init_cmdline);
> +	pr_info("Modified command line: %s\n", cmdline);
> +}
> +
>   static int register_fw_dump(struct fadump_mem_struct *fdm)
>   {
>   	int rc, err;
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index f83056297441..2e6f40217266 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -693,6 +693,13 @@ void __init early_init_devtree(void *params)
>   	of_scan_flat_dt(early_init_dt_scan_root, NULL);
>   	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
>
> +	/*
> +	 * Look for 'fadump_extra_args=' parameter and enfore the additional
> +	 * parameters passed to it if fadump is active.
> +	 */
> +	if (is_fadump_active())
> +		enforce_fadump_extra_args(boot_command_line);
> +
>   	parse_early_param();
>
>   	/* make sure we've parsed cmdline for mem= before this */


--------------E3F0F65FF6AC0C7D9EFBB6E0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On Tuesday 12 September 2017 09:31 PM,
      Michal Suchanek wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:ee9b1eefc4057e45c5c8ec56c10513a21802543b.1505231820.git.msuchanek@suse.de">
      <pre wrap="">With fadump (dump capture) kernel booting like a regular kernel, it needs
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

Suggested-by: Michael Ellerman <a class="moz-txt-link-rfc2396E" href="mailto:mpe@ellerman.id.au">&lt;mpe@ellerman.id.au&gt;</a>
Signed-off-by: Hari Bathini <a class="moz-txt-link-rfc2396E" href="mailto:hbathini@linux.vnet.ibm.com">&lt;hbathini@linux.vnet.ibm.com&gt;</a>
Signed-off-by: Michal Suchanek <a class="moz-txt-link-rfc2396E" href="mailto:msuchanek@suse.de">&lt;msuchanek@suse.de&gt;</a>
</pre>
    </blockquote>
    <br>
    For the series..<br>
    Tested-by: Hari Bathini <a class="moz-txt-link-rfc2396E"
      href="mailto:hbathini@linux.vnet.ibm.com">&lt;hbathini@linux.vnet.ibm.com&gt;</a><br>
    <br>
    <blockquote type="cite"
cite="mid:ee9b1eefc4057e45c5c8ec56c10513a21802543b.1505231820.git.msuchanek@suse.de">
      <pre wrap="">---
Changes from v6:
Correct and simplify quote handling. Ideally I would like to extend
parse_args to give the length of the original quoted value to callback.
However, parse_args removes at most one doubel-quote from the start and
one from the end so that is easy to detect. Otherwise all other users
will have to be updated to trash the new argument.
Changes from v7:
Handle leading quote in parameter name.
---
 arch/powerpc/include/asm/fadump.h |   2 +
 arch/powerpc/kernel/fadump.c      | 122 +++++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/prom.c        |   7 +++
 3 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 5a23010af600..41b50b317a67 100644
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
index e1431800bfb9..0e08f1a80af2 100644
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
 		printk(KERN_INFO "Firmware-assisted dump is not supported on<a class="moz-txt-link-rfc2396E" href="mailto:@@-380,7+385,6@@int__initfadump_reserve_mem(void)memory_boundary=memblock_end_of_DRAM();if(fw_dump.dump_active){-printk(KERN_INFO">"
@@ -380,7 +385,6 @@ int __init fadump_reserve_mem(void)
 		memory_boundary = memblock_end_of_DRAM();

 	if (fw_dump.dump_active) {
-		printk(KERN_INFO "</a>Firmware-assisted dump is active.\n");
 		/*
 		 * If last boot has crashed then reserve all the memory
 		 * above boot_memory_size so that we don't touch it until
@@ -467,6 +471,118 @@ static int __init early_fadump_reserve_mem(char *p)
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
+					char *param, char *val)
+{
+	ptrdiff_t param_offset = param - param_info-&gt;tmp_cmdline;
+	size_t vallen = val ? strlen(val) : 0;
+	char *tgt = param_info-&gt;cmdline + param_offset
+				- param_info-&gt;shortening;
+	int shortening = 0;
+	int quoted = 0;
+
+	if (!val)
+		return;
+
+	/* leading '"' removed from parameter */
+	if ((param &gt; param_info-&gt;tmp_cmdline) &amp;&amp; *(param - 1) == '"') {
+		quoted = 1;
+		shortening += 1;
+		tgt--;
+	}
+
+	/* next_arg removes one leading and one trailing '"' */
+	if (*(tgt + FADUMP_EXTRA_ARGS_LEN + 1) == '"')
+		shortening += 1;
+	if (*(tgt + FADUMP_EXTRA_ARGS_LEN + 1 + vallen + shortening) == '"')
+		shortening += 1;
+
+	/* remove one leading and one trailing quote if both are present */
+	if ((val[0] == '"') &amp;&amp; (val[vallen - 1] == '"')) {
+		shortening += 2;
+		vallen -= 2;
+		val++;
+	}
+
+	/* some characters were removed - move the trailing part of cmdline */
+	if (shortening) {
+		char *src;
+
+		strncpy(tgt, FADUMP_EXTRA_ARGS_PARAM, FADUMP_EXTRA_ARGS_LEN);
+		tgt += FADUMP_EXTRA_ARGS_LEN;
+		*tgt++ = ' ';
+
+		strncpy(tgt, val, vallen);
+		tgt += vallen;
+
+		src = tgt + shortening;
+		memmove(tgt, src, strlen(src) + 1);
+	} else {
+		/* remove the '=' */
+		*(tgt + FADUMP_EXTRA_ARGS_LEN) = ' ';
+	}
+
+	param_info-&gt;shortening += shortening;
+}
+
+/*
+ * Reworks command line parameters and splits 'fadump_extra_args=' param
+ * to enforce the parameters passed through it
+ */
+static int __init fadump_rework_cmdline_params(char *param, char *val,
+					       const char *unused, void *arg)
+{
+	struct param_info *param_info = (struct param_info *)arg;
+
+	if (strncmp(param, FADUMP_EXTRA_ARGS_PARAM,
+		     strlen(FADUMP_EXTRA_ARGS_PARAM) - 1))
+		return 0;
+
+	fadump_update_params(param_info, param, val);
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
+			&amp;param_info, &amp;fadump_rework_cmdline_params);
+
+	pr_info("Original command line: %s\n", init_cmdline);
+	pr_info("Modified command line: %s\n", cmdline);
+}
+
 static int register_fw_dump(struct fadump_mem_struct *fdm)
 {
 	int rc, err;
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f83056297441..2e6f40217266 100644
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
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------E3F0F65FF6AC0C7D9EFBB6E0--
