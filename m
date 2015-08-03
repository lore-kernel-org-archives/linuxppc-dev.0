Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0134.outbound.protection.outlook.com [65.55.169.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7ABB1A0075
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 07:19:03 +1000 (AEST)
Message-ID: <1438636720.2097.63.camel@freescale.com>
Subject: Re: [PATCH 2/3] PowerPC/mpc85xx: Add hotplug support on E5500 and
 E500MC cores
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
CC: <b29983@freescale.com>, <b07421@freescale.com>,
 <linux-kernel@vger.kernel.org>, Tang Yuantian <Yuantian.Tang@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 3 Aug 2015 16:18:40 -0500
In-Reply-To: <1438602724.7515.3@remotesmtp.freescale.net>
References: <1438334444-31919-1-git-send-email-b29983@freescale.com>
 <1438334444-31919-2-git-send-email-b29983@freescale.com>
 <1438388082.19345.85.camel@freescale.com>
 <1438602724.7515.3@remotesmtp.freescale.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Added linuxppc-dev@lists.ozlabs.org.  Besides that list being required for 
review of PPC patches, it feeds the patchwork that I use to track and apply 
patches.]

On Mon, 2015-08-03 at 19:52 +0800, Chenhui Zhao wrote:
> On Sat, Aug 1, 2015 at 8:14 AM, Scott Wood <scottwood@freescale.com> 
> wrote:
> > On Fri, 2015-07-31 at 17:20 +0800,  b29983@freescale.comwrote:
> > >  From: Tang Yuantian <Yuantian.Tang@freescale.com>
> > > 
> > >  Freescale E500MC and E5500 core-based platforms, like P4080, T1040,
> > >  support disabling/enabling CPU dynamically.
> > >  This patch adds this feature on those platforms.
> > > 
> > >  Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> > >  Signed-off-by: Tang Yuantian <Yuantian.Tang@feescale.com>
> > >  ---
> > >   arch/powerpc/Kconfig              |  2 +-
> > >   arch/powerpc/include/asm/smp.h    |  1 +
> > >   arch/powerpc/kernel/smp.c         |  5 +++++
> > >   arch/powerpc/platforms/85xx/smp.c | 39 
> > > ++++++++++++++++++++++++++++++++----
> > >  ---
> > >   4 files changed, 39 insertions(+), 8 deletions(-)
> > > 
> > >  diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > >  index 5ef2711..dd9e252 100644
> > >  --- a/arch/powerpc/Kconfig
> > >  +++ b/arch/powerpc/Kconfig
> > >  @@ -386,7 +386,7 @@ config SWIOTLB
> > >   config HOTPLUG_CPU
> > >        bool "Support for enabling/disabling CPUs"
> > >        depends on SMP && (PPC_PSERIES || \
> > >  -     PPC_PMAC || PPC_POWERNV || (PPC_85xx && !PPC_E500MC))
> > >  +     PPC_PMAC || PPC_POWERNV || FSL_SOC_BOOKE)
> > >        ---help---
> > >          Say Y here to be able to disable and re-enable individual
> > >          CPUs at runtime on SMP machines.
> > 
> > 
> > 
> > >  diff --git a/arch/powerpc/include/asm/smp.h 
> > > b/arch/powerpc/include/asm/smp.h
> > >  index 825663c..bf37d17 100644
> > >  --- a/arch/powerpc/include/asm/smp.h
> > >  +++ b/arch/powerpc/include/asm/smp.h
> > >  @@ -67,6 +67,7 @@ void generic_cpu_die(unsigned int cpu);
> > >   void generic_set_cpu_dead(unsigned int cpu);
> > >   void generic_set_cpu_up(unsigned int cpu);
> > >   int generic_check_cpu_restart(unsigned int cpu);
> > >  +int generic_check_cpu_dead(unsigned int cpu);
> > >   #endif
> > > 
> > >   #ifdef CONFIG_PPC64
> > >  diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > >  index ec9ec20..2cca27a 100644
> > >  --- a/arch/powerpc/kernel/smp.c
> > >  +++ b/arch/powerpc/kernel/smp.c
> > >  @@ -454,6 +454,11 @@ int generic_check_cpu_restart(unsigned int cpu)
> > >        return per_cpu(cpu_state, cpu) == CPU_UP_PREPARE;
> > >   }
> > > 
> > >  +int generic_check_cpu_dead(unsigned int cpu)
> > >  +{
> > >  +     return per_cpu(cpu_state, cpu) == CPU_DEAD;
> > >  +}
> > 
> > Is there a non-generic check_cpu_dead()?
> 
> NO, just follow the name "generic_check_cpu_restart()".

But it's not the same situation as generic_check_cpu_restart().

> > It gets open-coded in generic_cpu_die()... Either open-code it 
> > elsewhere, or
> > call it check_cpu_dead() and use it everywhere there's a CPU_DEAD 
> > check.
> > 
> > 
> > >  +
> > >   static bool secondaries_inhibited(void)
> > >   {
> > >        return kvm_hv_mode_active();
> > >  diff --git a/arch/powerpc/platforms/85xx/smp.c
> > >  b/arch/powerpc/platforms/85xx/smp.c
> > >  index 6811a5b..7f0dadb 100644
> > >  --- a/arch/powerpc/platforms/85xx/smp.c
> > >  +++ b/arch/powerpc/platforms/85xx/smp.c
> > >  @@ -42,6 +42,7 @@ struct epapr_spin_table {
> > >        u32     pir;
> > >   };
> > > 
> > >  +#ifdef CONFIG_HOTPLUG_CPU
> > >   static u64 timebase;
> > >   static int tb_req;
> > >   static int tb_valid;
> > >  @@ -111,7 +112,7 @@ static void mpc85xx_take_timebase(void)
> > >        local_irq_restore(flags);
> > >   }
> > > 
> > >  -#ifdef CONFIG_HOTPLUG_CPU
> > >  +#ifndef CONFIG_PPC_E500MC
> > >   static void e500_cpu_idle(void)
> > 
> > What happens if we bisect to patch 1/3 and run this on e500mc?
> > 
> > Please move the ifdef to that patch.
> 
> OK.
> 
> > 
> > 
> > >   {
> > >        u32 tmp;
> > >  @@ -127,6 +128,7 @@ static void e500_cpu_idle(void)
> > >        mtmsr(tmp);
> > >        isync();
> > >   }
> > >  +#endif
> > > 
> > >   static void qoriq_cpu_dying(void)
> > >   {
> > >  @@ -144,11 +146,30 @@ static void qoriq_cpu_dying(void)
> > > 
> > >        generic_set_cpu_dead(cpu);
> > > 
> > >  +#ifndef CONFIG_PPC_E500MC
> > >        e500_cpu_idle();
> > >  +#endif
> > > 
> > >        while (1)
> > >                ;
> > >   }
> > >  +
> > >  +static void qoriq_real_cpu_die(unsigned int cpu)
> > 
> > Real as opposed to...?
> 
> It's hard to find a good name. :)

There are too many cpu_die() functions as is, and adding cpu_dying makes it 
worse.  Even just trying to come up with suggestions I've been having a hard 
time keeping track of which one goes in which ops struct.  This problem goes 
beyond the 85xx code, to the ridiculous and undocumented distinction between 
cpu_die() and __cpu_die().

It wouldn't be so bad if each layer were self contained, rather than multiple 
layers being defined in the same file.  I suggest keeping the existing 
convention whereby ppc_md.cpu_die ends in "_mach_cpu_die".  Don't call 
anything "cpu_dying".

I'd call qoriq_pm_ops->cpu_die something else (e.g. cpu_kill) even though it 
is in a separate file, just because of how confused and overused the name is 
elsewhere.


> +{
> > >  +     int i;
> > >  +
> > >  +     for (i = 0; i < 50000; i++) {
> > >  +             if (generic_check_cpu_dead(cpu)) {
> > >  +                     qoriq_pm_ops->cpu_die(cpu);
> > >  +#ifdef CONFIG_PPC64
> > >  +                     paca[cpu].cpu_start = 0;
> > >  +#endif
> > >  +                     return;
> > >  +             }
> > >  +             udelay(10);
> > >  +     }
> > >  +     pr_err("%s: CPU%d didn't die...\n", __func__, cpu);
> > >  +}
> > 
> > Only 500ms timeout, versus 10sec in generic_cpu_die()?
> 
> The process is fast. Maybe 10 second is too large.

Is it fast 100% of the time?  What if the CPU you intend to die is in a long 
critical section?  What harm is there to having a longer timeout, similar to 
what other platforms use?

> 
> > 
> > >   #endif
> > > 
> > >   static inline void flush_spin_table(void *spin_table)
> > >  @@ -246,11 +267,7 @@ static int smp_85xx_kick_cpu(int nr)
> > >                spin_table = phys_to_virt(*cpu_rel_addr);
> > > 
> > >        local_irq_save(flags);
> > >  -#ifdef CONFIG_PPC32
> > >   #ifdef CONFIG_HOTPLUG_CPU
> > >  -     /* Corresponding to generic_set_cpu_dead() */
> > >  -     generic_set_cpu_up(nr);
> > >  -
> > >        if (system_state == SYSTEM_RUNNING) {
> > >                /*
> > >                 * To keep it compatible with old boot program which 
> > > uses
> > >  @@ -263,6 +280,7 @@ static int smp_85xx_kick_cpu(int nr)
> > >                out_be32(&spin_table->addr_l, 0);
> > >                flush_spin_table(spin_table);
> > > 
> > >  +             qoriq_pm_ops->cpu_up(nr);
> > 
> > Again, is it possible to get here without a valid qoriq_pm_ops (i.e. 
> > is there
> > anything stopping the user from trying to initiate CPU hotplug)?
> > 
> > -Scott
> 
> For every platform running this code, should has a valid qoriq_pm_ops. 
> If not valid, it's a bug.

How do you prevent this code from running when there is no valid qoriq_pm_ops?

-Scott
