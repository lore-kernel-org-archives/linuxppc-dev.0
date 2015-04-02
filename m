Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0109.outbound.protection.outlook.com [207.46.100.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 204EE1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 22:16:52 +1100 (AEDT)
From: "chenhui.zhao@freescale.com" <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [3/4] powerpc: support CPU hotplug for e500mc, e5500 and e6500
Date: Thu, 2 Apr 2015 11:16:45 +0000
Message-ID: <1427973405260.57477@freescale.com>
References: <1427365095-26396-3-git-send-email-chenhui.zhao@freescale.com>,
 <20150331020722.GC5667@home.buserror.net>
In-Reply-To: <20150331020722.GC5667@home.buserror.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



________________________________________
From: Wood Scott-B07421
Sent: Tuesday, March 31, 2015 10:07
To: Zhao Chenhui-B35336
Cc: linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org; linux-kernel=
@vger.kernel.org; Jin Zhengxiong-R64188
Subject: Re: [3/4] powerpc: support CPU hotplug for e500mc, e5500 and e6500

On Thu, Mar 26, 2015 at 06:18:14PM +0800, chenhui zhao wrote:
> Implemented CPU hotplug on e500mc, e5500 and e6500, and support
> multiple threads mode and 64-bits mode.
>
> For e6500 with two threads, if one thread is online, it can
> enable/disable the other thread in the same core. If two threads of
> one core are offline, the core will enter the PH20 state (a low power
> state). When the core is up again, Thread0 is up first, and it will be
> bound with the present booting cpu. This way, all CPUs can hotplug
> separately.
>
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> ---
>  arch/powerpc/Kconfig              |   2 +-
>  arch/powerpc/include/asm/fsl_pm.h |   4 +
>  arch/powerpc/include/asm/smp.h    |   2 +
>  arch/powerpc/kernel/head_64.S     |  20 +++--
>  arch/powerpc/kernel/smp.c         |   5 ++
>  arch/powerpc/platforms/85xx/smp.c | 182 +++++++++++++++++++++++++++++---=
------
>  arch/powerpc/sysdev/fsl_rcpm.c    |  56 ++++++++++++
>  7 files changed, 220 insertions(+), 51 deletions(-)

Please factor out changes to generic code (including but not limited to
cur_boot_cpu and PIR handling) into separate patches with clear
explanations.

[chenhui] OK.

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 22b0940..9846c83 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -380,7 +380,7 @@ config SWIOTLB
>  config HOTPLUG_CPU
>       bool "Support for enabling/disabling CPUs"
>       depends on SMP && (PPC_PSERIES || \
> -     PPC_PMAC || PPC_POWERNV || (PPC_85xx && !PPC_E500MC))
> +     PPC_PMAC || PPC_POWERNV || FSL_SOC_BOOKE)
>       ---help---
>         Say Y here to be able to disable and re-enable individual
>         CPUs at runtime on SMP machines.
> diff --git a/arch/powerpc/include/asm/fsl_pm.h b/arch/powerpc/include/asm=
/fsl_pm.h
> index bbe6089..579f495 100644
> --- a/arch/powerpc/include/asm/fsl_pm.h
> +++ b/arch/powerpc/include/asm/fsl_pm.h
> @@ -34,6 +34,10 @@ struct fsl_pm_ops {
>       void (*cpu_enter_state)(int cpu, int state);
>       /* exit the CPU from the specified state */
>       void (*cpu_exit_state)(int cpu, int state);
> +     /* cpu up */
> +     void (*cpu_up)(int cpu);

Again, this sort of comment is useless.  Tell us what "cpu up" *does*,
when it should be called, etc.

> @@ -189,16 +193,14 @@ _GLOBAL(fsl_secondary_thread_init)
>       isync
>
>       /*
> -      * Fix PIR to match the linear numbering in the device tree.
> -      *
> -      * On e6500, the reset value of PIR uses the low three bits for
> -      * the thread within a core, and the upper bits for the core
> -      * number.  There are two threads per core, so shift everything
> -      * but the low bit right by two bits so that the cpu numbering is
> -      * continuous.

Why are you getting rid of this?  If it's to avoid doing it twice on the
same thread, in my work-in-progress kexec patches I instead check to see
whether BUCSR has already been set up -- if it has, I assume we've
already been here.

[chenhui] I didn't delete the branch prediction related code.

> +      * The current thread has been in 64-bit mode,
> +      * see the value of TMRN_IMSR.

I don't see what the relevance of this comment is here.

[chenhui] Will explain it more clear.

> +      * compute the address of __cur_boot_cpu
>        */
> -     mfspr   r3, SPRN_PIR
> -     rlwimi  r3, r3, 30, 2, 30
> +     bl      10f
> +10:  mflr    r22
> +     addi    r22,r22,(__cur_boot_cpu - 10b)
> +     lwz     r3,0(r22)

Please save non-volatile registers for things that need to stick around
for a while.

[chenhui] OK.

>       mtspr   SPRN_PIR, r3

If __cur_boot_cpu is meant to be the PIR of the currently booting CPU,
it's a misleading.  It looks like it's supposed to have something to do
with the boot cpu (not "booting").

[chenhui] I mean the PIR of the currently booting CPU. Change to "booting_c=
pu_hwid".

Also please don't put leading underscores on symbols just because the
adjacent symbols have them.

> -#ifdef CONFIG_HOTPLUG_CPU
> +#ifdef CONFIG_PPC_E500MC
> +static void qoriq_cpu_wait_die(void)
> +{
> +     unsigned int cpu =3D smp_processor_id();
> +
> +     hard_irq_disable();
> +     /* mask all irqs to prevent cpu wakeup */
> +     qoriq_pm_ops->irq_mask(cpu);
> +     idle_task_exit();
> +
> +     mtspr(SPRN_TCR, 0);
> +     mtspr(SPRN_TSR, mfspr(SPRN_TSR));
> +
> +     cur_cpu_spec->cpu_flush_caches();
> +
> +     generic_set_cpu_dead(cpu);
> +     smp_mb();

Comment memory barriers, as checkpatch says.

> +     while (1)
> +     ;

Indent the ;

[chenhui] OK

> @@ -174,17 +232,29 @@ static inline u32 read_spin_table_addr_l(void *spin=
_table)
>  static void wake_hw_thread(void *info)
>  {
>       void fsl_secondary_thread_init(void);
> -     unsigned long imsr1, inia1;
> +     unsigned long imsr, inia;
>       int nr =3D *(const int *)info;
> -
> -     imsr1 =3D MSR_KERNEL;
> -     inia1 =3D *(unsigned long *)fsl_secondary_thread_init;
> -
> -     mttmr(TMRN_IMSR1, imsr1);
> -     mttmr(TMRN_INIA1, inia1);
> -     mtspr(SPRN_TENS, TEN_THREAD(1));
> +     int hw_cpu =3D get_hard_smp_processor_id(nr);
> +     int thread_idx =3D cpu_thread_in_core(hw_cpu);
> +
> +     __cur_boot_cpu =3D (u32)hw_cpu;
> +     imsr =3D MSR_KERNEL;
> +     inia =3D *(unsigned long *)fsl_secondary_thread_init;
> +     smp_mb();
> +     if (thread_idx =3D=3D 0) {
> +             mttmr(TMRN_IMSR0, imsr);
> +             mttmr(TMRN_INIA0, inia);
> +     } else {
> +             mttmr(TMRN_IMSR1, imsr);
> +             mttmr(TMRN_INIA1, inia);
> +     }
> +     isync();
> +     mtspr(SPRN_TENS, TEN_THREAD(thread_idx));

Support for waking a secondary core should be a separate patch (I have
similar code on the way for kexec).  Likewise adding smp_mb()/isync() if
it's really needed.  In general, this patch tries to do too much at once.

>       smp_generic_kick_cpu(nr);
> +#ifdef CONFIG_HOTPLUG_CPU
> +     generic_set_cpu_up(nr);
> +#endif
>  }
>  #endif
>
> @@ -203,28 +273,46 @@ static int smp_85xx_kick_cpu(int nr)
>
>       pr_debug("smp_85xx_kick_cpu: kick CPU #%d\n", nr);
>
> +#ifdef CONFIG_HOTPLUG_CPU
> +     sync_tb =3D 0;
> +     smp_mb();
> +#endif

Timebase synchronization should also be separate.

>  #ifdef CONFIG_PPC64
> -     /* Threads don't use the spin table */
> -     if (cpu_thread_in_core(nr) !=3D 0) {
> +     if (threads_per_core > 1) {
>               int primary =3D cpu_first_thread_sibling(nr);
>
>               if (WARN_ON_ONCE(!cpu_has_feature(CPU_FTR_SMT)))
>                       return -ENOENT;
>
> -             if (cpu_thread_in_core(nr) !=3D 1) {
> -                     pr_err("%s: cpu %d: invalid hw thread %d\n",
> -                            __func__, nr, cpu_thread_in_core(nr));
> -                     return -ENOENT;
> +             /*
> +              * If either one of threads in the same core is online,
> +              * use the online one to start the other.
> +              */
> +             if (cpu_online(primary) || cpu_online(primary + 1)) {
> +                     qoriq_pm_ops->cpu_up(nr);

What if we don't have qoriq_pm_ops (e.g. VM guest, or some failure)?

[chenhui] Will put it in an if statement.

> +                     if (cpu_online(primary))
> +                             smp_call_function_single(primary,
> +                                             wake_hw_thread, &nr, 1);
> +                     else
> +                             smp_call_function_single(primary + 1,
> +                                             wake_hw_thread, &nr, 1);
> +                     return 0;
>               }
> -
> -             if (!cpu_online(primary)) {
> -                     pr_err("%s: cpu %d: primary %d not online\n",
> -                            __func__, nr, primary);
> -                     return -ENOENT;
> +             /*
> +              * If both threads are offline, reset core to start.
> +              * When core is up, Thread 0 always gets up first,
> +              * so bind the current logical cpu with Thread 0.
> +              */

What if the core is not in a PM state that requires a reset?
Where does this reset occur?

[chenhui] Reset occurs in the function mpic_reset_core().

> +             if (hw_cpu !=3D cpu_first_thread_sibling(hw_cpu)) {
> +                     int hw_cpu1, hw_cpu2;
> +
> +                     hw_cpu1 =3D get_hard_smp_processor_id(primary);
> +                     hw_cpu2 =3D get_hard_smp_processor_id(primary + 1);
> +                     set_hard_smp_processor_id(primary, hw_cpu2);
> +                     set_hard_smp_processor_id(primary + 1, hw_cpu1);
> +                     /* get new physical cpu id */
> +                     hw_cpu =3D get_hard_smp_processor_id(nr);

Why are you swapping the hard smp ids?

[chenhui] For example, Core1 has two threads, Thread0 and Thread1. In norma=
l boot, Thread0 is CPU2, and Thread1 is CPU3.
But, if CPU2 and CPU3 are all off, user wants CPU3 up first. we need to cal=
l Thread0 as CPU3 and Thead1 as CPU2, considering
the limitation, after core is reset, only Thread0 is up, then Thread0 kicks=
 up Thread1.

>               }
> -
> -             smp_call_function_single(primary, wake_hw_thread, &nr, 0);
> -             return 0;
>       }
>  #endif
>
> @@ -252,11 +340,7 @@ static int smp_85xx_kick_cpu(int nr)
>               spin_table =3D phys_to_virt(*cpu_rel_addr);
>
>       local_irq_save(flags);
> -#ifdef CONFIG_PPC32
>  #ifdef CONFIG_HOTPLUG_CPU
> -     /* Corresponding to generic_set_cpu_dead() */
> -     generic_set_cpu_up(nr);
> -

Why did you move this?

[chenhui] It would be better to set this after CPU is really up.

>       if (system_state =3D=3D SYSTEM_RUNNING) {
>               /*
>                * To keep it compatible with old boot program which uses
> @@ -269,11 +353,16 @@ static int smp_85xx_kick_cpu(int nr)
>               out_be32(&spin_table->addr_l, 0);
>               flush_spin_table(spin_table);
>
> +#ifdef CONFIG_PPC_E500MC
> +             qoriq_pm_ops->cpu_up(nr);
> +#endif

Again, you've killed a VM guest kernel (this time, even if the guest
doesn't see SMT).

> @@ -489,13 +586,16 @@ void __init mpc85xx_smp_init(void)
>                                                               __func__);
>                       return;
>               }
> -             smp_85xx_ops.give_timebase =3D mpc85xx_give_timebase;
> -             smp_85xx_ops.take_timebase =3D mpc85xx_take_timebase;
> -#ifdef CONFIG_HOTPLUG_CPU
> -             ppc_md.cpu_die =3D smp_85xx_mach_cpu_die;
> -#endif

You're moving this from a place that only runs when guts is found...

>       }
>
> +     smp_85xx_ops.cpu_die =3D generic_cpu_die;
> +     ppc_md.cpu_die =3D smp_85xx_mach_cpu_die;
> +#endif
> +     smp_85xx_ops.give_timebase =3D mpc85xx_give_timebase;
> +     smp_85xx_ops.take_timebase =3D mpc85xx_take_timebase;
> +     smp_85xx_ops.cpu_disable =3D generic_cpu_disable;
> +#endif /* CONFIG_HOTPLUG_CPU */

...to a place that runs unconditionally.  Again, you're breaking VM
guests.

-Scott

[chenhui] Will correct it.=
