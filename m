Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYhQg1n0czDrLM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 21:57:15 +1000 (AEST)
Date: Fri, 18 Aug 2017 13:57:07 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Jonathan Corbet
 <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>, Rusty Russell
 <rusty@rustcorp.com.au>, Jason Baron <jbaron@akamai.com>, Mahesh J
 Salgaonkar <mahesh@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
 Andrew Morton <akpm@linux-foundation.org>, Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Christophe Leroy
 <christophe.leroy@c-s.fr>, Scott Wood <oss@buserror.net>, "Oliver
 O'Halloran" <oohall@gmail.com>, David Howells <dhowells@redhat.com>,
 "Sylvain 'ythier' Hitier" <sylvain.hitier@gmail.com>, Ingo Molnar
 <mingo@kernel.org>, Kees Cook <keescook@chromium.org>, Thomas Gleixner
 <tglx@linutronix.de>, Baoquan He <bhe@redhat.com>,
 linux-doc@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>, Viresh Kumar
 <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, "Steven Rostedt, "
 <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, Ilya Matveychikov
 <matvejchikov@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 1/4] powerpc/fadump: reduce memory consumption for
 capture kernel
Message-ID: <20170818135707.40a814ff@kitsune.suse.cz>
In-Reply-To: <975190aa-fff4-6a1f-70b5-27341cb70f97@linux.vnet.ibm.com>
References: <78655b3689f6cd0c76b787b8ef2c824ef75a99a5.1503000577.git.msuchanek@suse.de>
 <975190aa-fff4-6a1f-70b5-27341cb70f97@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 18 Aug 2017 16:20:53 +0530
Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:

> Hi Michal,
> 
> 
> Thanks for the patches. I tried testing with the patches:
> 
> [    0.000000] fadump: Firmware-assisted dump is active.
> [    0.000000] fadump: Modifying command line to enforce the
> additional parameters passed through 'fadump_extra_args='
> [    0.000000] fadump: Original command line: 
> BOOT_IMAGE=/vmlinux-4.13.0-rc1-bz155783+ root=/dev/mapper/rhel-root
> ro crashkernel=2048M fadump=on fadump_reserve_mem=1024M 
> "fadump_extra_args=nr_cpus=1 numa=off udev.childern-max=2" 
> rd.lvm.lv=rhel/root rd.lvm.lv=rhel/swap
> [    0.000000] fadump: Modified command line: 
> BOOT_IMAGE=/vmlinux-4.13.0-rc1-bz155783+ root=/dev/mapper/rhel-root
> ro crashkernel=2048M fadump=on fadump_reserve_mem=1024M
> "fadump_extra_args nr_cpus=1 numa=off udev.childern-max=2"
> rd.lvm.lv=rhel/root rd.lvm.lv=rhel/swap
> 
> Looks like the quotes are retained not enforcing the parameters...

Hello,

You are passing an argument >>"fadump_extra_args<<  - that is an
argument containing a quote in the name. I did not test this scenario
assuming the argument name would not match in this case. It would
probably not match if the quote was in the middle of the argument
name but at the start it is skipped. Note that due to the requirement
to remove quotes symmetrically which is added in the third patch this
case does not break the commandline - it merely makes the arguments
ineffective.

The format suggested in the documentation is
>>fadump_extra_args="nr_cpus=1 numa=off udev.childern-max=2"<< - that
is quotes around the value. This format worked in my testing.

Unfortunately, the format with quote before argument name would
probably require another extra parameter to the callback to detect
properly.

Thanks

Michal

> 
> I am yet to test the patches in other scenarios though..
> 
> 
> Thanks
> 
> Hari
> 
> 
> On Friday 18 August 2017 01:44 AM, Michal Suchanek wrote:
> > From: Hari Bathini <hbathini@linux.vnet.ibm.com>
> >
> > With fadump (dump capture) kernel booting like a regular kernel, it
> > needs almost the same amount of memory to boot as the production
> > kernel, which is unwarranted for a dump capture kernel. But with no
> > option to disable some of the unnecessary subsystems in fadump
> > kernel, that much memory is wasted on fadump, depriving the
> > production kernel of that memory.
> >
> > Introduce kernel parameter 'fadump_extra_args=' that would take
> > regular parameters as a space separated quoted string, to be
> > enforced when fadump is active. This 'fadump_extra_args=' parameter
> > can be leveraged to pass parameters like nr_cpus=1,
> > cgroup_disable=memory and numa=off, to disable unwarranted
> > resources/subsystems.
> >
> > Also, ensure the log "Firmware-assisted dump is active" is printed
> > early in the boot process to put the subsequent fadump messages in
> > context.
> >
> > Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > Changes from v6:
> > Correct and simplify quote handling. Ideally I would like to extend
> > parse_args to give the length of the original quoted value to
> > callback. However, parse_args removes at most one doubel-quote from
> > the start and one from the end so that is easy to detect. Otherwise
> > all other users will have to be updated to trash the new argument.
> > ---
> >   arch/powerpc/include/asm/fadump.h |   2 +
> >   arch/powerpc/kernel/fadump.c      | 109
> > ++++++++++++++++++++++++++++++++++++--
> > arch/powerpc/kernel/prom.c        |   7 +++ 3 files changed, 115
> > insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/fadump.h
> > b/arch/powerpc/include/asm/fadump.h index
> > ce88bbe1d809..98ae00943fb3 100644 ---
> > a/arch/powerpc/include/asm/fadump.h +++
> > b/arch/powerpc/include/asm/fadump.h @@ -208,11 +208,13 @@ extern
> > int early_init_dt_scan_fw_dump(unsigned long node, const char
> > *uname, int depth, void *data); extern int fadump_reserve_mem(void);
> >   extern int setup_fadump(void);
> > +extern void enforce_fadump_extra_args(char *cmdline);
> >   extern int is_fadump_active(void);
> >   extern void crash_fadump(struct pt_regs *, const char *);
> >   extern void fadump_cleanup(void);
> >
> >   #else	/* CONFIG_FA_DUMP */
> > +static inline void enforce_fadump_extra_args(char *cmdline) { }
> >   static inline int is_fadump_active(void) { return 0; }
> >   static inline void crash_fadump(struct pt_regs *regs, const char
> > *str) { } #endif
> > diff --git a/arch/powerpc/kernel/fadump.c
> > b/arch/powerpc/kernel/fadump.c index dc0c49cfd90a..a1614d9b8a21
> > 100644 --- a/arch/powerpc/kernel/fadump.c
> > +++ b/arch/powerpc/kernel/fadump.c
> > @@ -78,8 +78,10 @@ int __init early_init_dt_scan_fw_dump(unsigned
> > long node,
> >   	 * dump data waiting for us.
> >   	 */
> >   	fdm_active = of_get_flat_dt_prop(node, "ibm,kernel-dump",
> > NULL);
> > -	if (fdm_active)
> > +	if (fdm_active) {
> > +		pr_info("Firmware-assisted dump is active.\n");
> >   		fw_dump.dump_active = 1;
> > +	}
> >
> >   	/* Get the sizes required to store dump data for the
> > firmware provided
> >   	 * dump sections.
> > @@ -332,8 +334,11 @@ int __init fadump_reserve_mem(void)
> >   {
> >   	unsigned long base, size, memory_boundary;
> >
> > -	if (!fw_dump.fadump_enabled)
> > +	if (!fw_dump.fadump_enabled) {
> > +		if (fw_dump.dump_active)
> > +			pr_warn("Firmware-assisted dump was active
> > but kernel booted with fadump disabled!\n"); return 0;
> > +	}
> >
> >   	if (!fw_dump.fadump_supported) {
> >   		printk(KERN_INFO "Firmware-assisted dump is not
> > supported on" @@ -373,7 +378,6 @@ int __init
> > fadump_reserve_mem(void) memory_boundary = memblock_end_of_DRAM();
> >
> >   	if (fw_dump.dump_active) {
> > -		printk(KERN_INFO "Firmware-assisted dump is
> > active.\n"); /*
> >   		 * If last boot has crashed then reserve all the
> > memory
> >   		 * above boot_memory_size so that we don't touch
> > it until @@ -460,6 +464,105 @@ static int __init
> > early_fadump_reserve_mem(char *p) }
> >   early_param("fadump_reserve_mem", early_fadump_reserve_mem);
> >
> > +#define FADUMP_EXTRA_ARGS_PARAM		"fadump_extra_args="
> > +#define FADUMP_EXTRA_ARGS_LEN
> > (strlen(FADUMP_EXTRA_ARGS_PARAM) - 1) +
> > +struct param_info {
> > +	char		*cmdline;
> > +	char		*tmp_cmdline;
> > +	int		 shortening;
> > +};
> > +
> > +static void __init fadump_update_params(struct param_info
> > *param_info,
> > +					char *param, char *val)
> > +{
> > +	ptrdiff_t param_offset = param - param_info->tmp_cmdline;
> > +	size_t vallen = val ? strlen(val) : 0;
> > +	char *tgt = param_info->cmdline + param_offset +
> > +		FADUMP_EXTRA_ARGS_LEN - param_info->shortening;
> > +	int shortening = 0;
> > +
> > +	if (!val)
> > +		return;
> > +
> > +	/* remove '=' */
> > +	*tgt++ = ' ';
> > +
> > +	/* next_arg removes one leading and one trailing '"' */
> > +	if (*tgt == '"')
> > +		shortening += 1;
> > +	if (*(tgt + vallen + shortening) == '"')
> > +		shortening += 1;
> > +
> > +	/* remove one leading and one trailing quote if both are
> > present */
> > +	if ((val[0] == '"') && (val[vallen - 1] == '"')) {
> > +		shortening += 2;
> > +		vallen -= 2;
> > +		val++;
> > +	}
> > +
> > +	/* some characters were removed - move the trailing part
> > of cmdline */
> > +	if (shortening) {
> > +		char *src;
> > +
> > +		strncpy(tgt, val, vallen);
> > +		tgt += vallen;
> > +		src = tgt + shortening;
> > +		memmove(tgt, src, strlen(src) + 1);
> > +	}
> > +
> > +	param_info->shortening += shortening;
> > +}
> > +
> > +/*
> > + * Reworks command line parameters and splits 'fadump_extra_args='
> > param
> > + * to enforce the parameters passed through it
> > + */
> > +static int __init fadump_rework_cmdline_params(char *param, char
> > *val,
> > +					       const char *unused,
> > void *arg) +{
> > +	struct param_info *param_info = (struct param_info *)arg;
> > +
> > +	if (strncmp(param, FADUMP_EXTRA_ARGS_PARAM,
> > +		     strlen(FADUMP_EXTRA_ARGS_PARAM) - 1))
> > +		return 0;
> > +
> > +	fadump_update_params(param_info, param, val);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Replace every occurrence of 'fadump_extra_args="param1 param2
> > param3"'
> > + * in cmdline with 'fadump_extra_args param1 param2 param3' by
> > stripping
> > + * off '=' and quotes, if any. This ensures that the additional
> > parameters
> > + * passed with 'fadump_extra_args=' are enforced.
> > + */
> > +void __init enforce_fadump_extra_args(char *cmdline)
> > +{
> > +	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> > +	static char init_cmdline[COMMAND_LINE_SIZE] __initdata;
> > +	struct param_info param_info;
> > +
> > +	if (strstr(cmdline, FADUMP_EXTRA_ARGS_PARAM) == NULL)
> > +		return;
> > +
> > +	pr_info("Modifying command line to enforce the additional
> > parameters passed through 'fadump_extra_args='"); +
> > +	param_info.cmdline = cmdline;
> > +	param_info.tmp_cmdline = tmp_cmdline;
> > +	param_info.shortening = 0;
> > +
> > +	strlcpy(init_cmdline, cmdline, COMMAND_LINE_SIZE);
> > +
> > +	strlcpy(tmp_cmdline, cmdline, COMMAND_LINE_SIZE);
> > +	parse_args("fadump params", tmp_cmdline, NULL, 0, 0, 0,
> > +			&param_info,
> > &fadump_rework_cmdline_params); +
> > +	pr_info("Original command line: %s\n", init_cmdline);
> > +	pr_info("Modified command line: %s\n", cmdline);
> > +}
> > +
> >   static int register_fw_dump(struct fadump_mem_struct *fdm)
> >   {
> >   	int rc, err;
> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> > index f83056297441..2e6f40217266 100644
> > --- a/arch/powerpc/kernel/prom.c
> > +++ b/arch/powerpc/kernel/prom.c
> > @@ -693,6 +693,13 @@ void __init early_init_devtree(void *params)
> >   	of_scan_flat_dt(early_init_dt_scan_root, NULL);
> >   	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
> >
> > +	/*
> > +	 * Look for 'fadump_extra_args=' parameter and enfore the
> > additional
> > +	 * parameters passed to it if fadump is active.
> > +	 */
> > +	if (is_fadump_active())
> > +		enforce_fadump_extra_args(boot_command_line);
> > +
> >   	parse_early_param();
> >
> >   	/* make sure we've parsed cmdline for mem= before this
> > */  
> 
