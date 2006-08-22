Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 5E75A67BB9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 16:05:24 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <E1G9jpY-0004Nv-2d@kmac.watson.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <aa3478a76dd7fb5bff781350a7538fb0@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: Take 2: [RFC] Debugging with a HW probe.
Date: Tue, 22 Aug 2006 01:04:57 -0500
To: Jimi Xenidis <jimix@watson.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 14, 2006, at 5:16 AM, Jimi Xenidis jimix at watson.ibm.com  
wrote:

> A rework of the original patch, some on and off list comments had
> suggested that this be a generic service, and to make it very hard
> to unintentionally turn it on.  I fact we should make sure that the
> feature is indeed turned off.
>
> Any suggestions on how to operate on the HID bits of all CPUs based on
> the value of the config _and_ 'hw_probe_enabled' would be welcom.
>
> I'd also like to wait for Olof's:
>   http://ozlabs.org/pipermail/linuxppc-dev/2006-August/025024.html
> patch to make it to the tree (or not).
>
> Signed-off-by: Jimi Xenidis <jimix at watson.ibm.com>

[sorry for the list archive patch munging]

> ---
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index e29ef77..bc4cdf9 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -61,6 +61,17 @@ config KGDB_CONSOLE
>           over the gdb stub.
>           If unsure, say N.
>
> +config ENABLE_HW_PROBE
> +       bool "Allow instructions that contact a hardware probe 
> (dangerous)"
> +       depends on PPC64

Not having this depend on DEBUGGER but in the middle of things that do 
will
get you scorn from the auto-indenting police.

Since we can only call this from xmon, should it depend on XMON (and be
placed after that)?

> +       help
> +         If you enable this AND you add "hwprobe" to the cmdline, the
> +         processor will enable instructions that contact the hardware
> +         probe.  These instructions ca be used in all processor modes

can

> +         _including_ user mode and are only useful for kernel

not sure this _highlighting_ is used elsewhere in Kconfig help ...

Should we mention that a hardware probe is required to continue 
exectuion?
In other words, its not just contact, but signal and wait for a hw 
probe?

> +         development and debugging.  DO NOT enable this unless you
> +         plan to use it.
> +
>  config XMON
>         bool "Include xmon kernel debugger"
>         depends on DEBUGGER && !PPC_ISERIES
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index bf2005b..02c5b83 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -68,6 +68,9 @@ int __initdata iommu_is_off;
>  int __initdata iommu_force_on;
>  unsigned long tce_alloc_start, tce_alloc_end;
>  #endif
> +#ifdef CONFIG_ENABLE_HW_PROBE
> +int hw_probe_enabled;
> +#endif
>
>  typedef u32 cell_t;
>
> @@ -693,6 +696,11 @@ #ifdef CONFIG_PPC64
>         if (of_get_flat_dt_prop(node, "linux,iommu-force-on", NULL) != 
> NULL)
>                 iommu_force_on = 1;
>  #endif
> +#ifdef CONFIG_HW_PROBE_ENABLE
> +       if (of_get_flat_dt_prop(node, "linux,hw-probe-enable", NULL) 
> != NULL) {
> +               hw_probe_enabled = 1;
> +               DBG("HW Probe will be enabled\n");
> +#endif

No.  [see next comment]

>
>         /* mem=x on the command line is the preferred mechanism */
>         lprop = of_get_flat_dt_prop(node, "linux,memory-limit", NULL);
> diff --git a/arch/powerpc/kernel/prom_init.c 
> b/arch/powerpc/kernel/prom_init.c
> index 90972ef..26428de 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -587,6 +587,14 @@ #ifdef CONFIG_PPC64
>                         RELOC(iommu_force_on) = 1;
>         }
>  #endif
> +#ifdef CONFIG_HW_PROBE_ENABLE
> +       opt = strstr(RELOC(prom_cmd_line), RELOC("hwprobe"));
> +       if (opt) {
> +               prom_printf("WARNING! HW Probe will be activated!\n");
> +               prom_setprop(_prom->chosen, "/chosen",
> +                            "linux,hw-probe-enable", NULL, 0);
> +       }
> +#endif
>  }

Please, PLEASE do NOT do this.

prom_init.c is only used by one of the many flat device tree generators,
namely the open-firmware client.  Adding a property like this requires 
us
to update all the other clients.

And there is no reason to parse it this early.

Instead, parse it from the command line like the other early parsing.

I thing a generic early_param would be fine.  However, xmon_init is an
early_parm in setup-common, so if you really require it before the first
call, then you could parse it next to mem= at the bottom of
early_init_dt_scan_chosen.

Which .h is hw_probe_enabled in?  (none?)

>
>  #ifdef CONFIG_PPC_PSERIES
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 179b10c..51a1e4e 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -189,7 +189,12 @@ #endif
>    dd   dump double values\n\
>    dr   dump stream of raw bytes\n\
>    e    print exception information\n\
> -  f    flush cache\n\
> +  f    flush cache\n"
> +#ifdef CONFIG_ENABLE_HW_PROBE
> +  "\
> +  H     Contact hardware probe, if available\n"
> +#endif
> +  "\

While this style does keep the lines aligned in the source, it adds 
veritcal
almost-whitespace.  And I notice a different choice was made at the 
bottom.

>    la   lookup symbol+offset of specified address\n\
>    ls   lookup address of specified symbol\n\
>    m    examine/change memory\n\
> @@ -217,6 +222,18 @@ #endif
>    zh   halt\n"
>  ;
>
> +#ifdef CONFIG_ENABLE_HW_PROBE
> +/* try to keep this funtion from being inlined so its easier to move
> + * around the ATTN instruction */
> +extern int hw_probe_enabled;
> +static noinline void xmon_hw_probe(void)
> +{
> +       if (!hw_probe_enabled)
> +               return;
> +       ATTN();
> +}
> +#endif
> +
>  static struct pt_regs *xmon_regs;
>
>  static inline void sync(void)
> @@ -819,6 +836,11 @@ #endif /* CONFIG_SMP */
>                         if (cpu_cmd())
>                                 return 0;
>                         break;
> +#ifdef CONFIG_ENABLE_HW_PROBE
> +               case 'H':
> +                       xmon_hw_probe();
> +                       break;
> +#endif
>                 case 'z':
>                         bootcmds();
>                         break;
> diff --git a/include/asm-powerpc/reg.h b/include/asm-powerpc/reg.h
> index cf73475..478097e 100644
> --- a/include/asm-powerpc/reg.h
> +++ b/include/asm-powerpc/reg.h
> @@ -207,6 +207,13 @@ #define SPRN_EAR   0x11A           /* External 
> Addr
>  #define SPRN_HASH1     0x3D2           /* Primary Hash Address 
> Register */
>  #define SPRN_HASH2     0x3D3           /* Secondary Hash Address 
> Resgister */
>  #define SPRN_HID0      0x3F0           /* Hardware Implementation 
> Register 0 */
> +#ifdef __ASSEMBLY__
> +#define HID0_QATTN     (1<<35)         /* Sup. Proc. attn insn all 
> threads */
> +#define HID0_ATTN      (1<<32)         /* Sup. Proc. attn insn */
> +#else
> +#define HID0_QATTN     (1UL<<35)       /* Sup. Proc. attn insn all 
> threads */
> +#define HID0_ATTN      (1UL<<32)       /* Sup. Proc. attn insn */
> +#endif
>  #define HID0_EMCP      (1<<31)         /* Enable Machine Check pin */
>  #define HID0_EBA       (1<<29)         /* Enable Bus Address Parity */
>  #define HID0_EBD       (1<<28)         /* Enable Bus Data Parity */
> @@ -641,6 +648,13 @@ extern void ppc64_runlatch_off(void);
>  extern unsigned long scom970_read(unsigned int address);
>  extern void scom970_write(unsigned int address, unsigned long value);
>
> +/*
> + * Support Processor Attention Instruction instroduced in POWER
> + * architecture processors as of RS64, tho may not be supported by
> + * POWER 3.
> + */
> +#define ATTN() asm volatile("attn; nop")
> +


Fairly certian POWER3 does NOT implement this, but I don't have book IV 
handy.
Does one of the processors require the nop ?



>  #else
>  #define ppc64_runlatch_on()
>  #define ppc64_runlatch_off()
>

milton
