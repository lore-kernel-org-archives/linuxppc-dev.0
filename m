Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0140.outbound.protection.outlook.com [65.55.169.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EED3A1A006B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 20:39:59 +1000 (AEST)
Date: Wed, 5 Aug 2015 18:39:46 +0800
From: Chenhui Zhao <chenhui.zhao@freescale.com>
Subject: Re: [PATCH 2/3] PowerPC/mpc85xx: Add hotplug support on E5500 and
 E500MC cores
To: Scott Wood <scottwood@freescale.com>
CC: <b29983@freescale.com>, <b07421@freescale.com>,
 <linux-kernel@vger.kernel.org>, Tang Yuantian <Yuantian.Tang@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>
Message-ID: <1438771186.21522.1@remotesmtp.freescale.net>
In-Reply-To: <1438636720.2097.63.camel@freescale.com>
References: <1438334444-31919-1-git-send-email-b29983@freescale.com>
 <1438334444-31919-2-git-send-email-b29983@freescale.com>
 <1438388082.19345.85.camel@freescale.com>
 <1438602724.7515.3@remotesmtp.freescale.net>
 <1438636720.2097.63.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tue, Aug 4, 2015 at 5:18 AM, Scott Wood <scottwood@freescale.com> 
wrote:
> [Added linuxppc-dev@lists.ozlabs.org.  Besides that list being 
> required for
> review of PPC patches, it feeds the patchwork that I use to track and 
> apply
> patches.]
> 
> On Mon, 2015-08-03 at 19:52 +0800, Chenhui Zhao wrote:
>>  On Sat, Aug 1, 2015 at 8:14 AM, Scott Wood <scottwood@freescale.com>
>>  wrote:
>>  > On Fri, 2015-07-31 at 17:20 +0800,  b29983@freescale.comwrote:
>>  > >  From: Tang Yuantian <Yuantian.Tang@freescale.com>
>>  > >
>>  > >  Freescale E500MC and E5500 core-based platforms, like P4080, 
>> T1040,
>>  > >  support disabling/enabling CPU dynamically.
>>  > >  This patch adds this feature on those platforms.
>>  > >
>>  > >  Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
>>  > >  Signed-off-by: Tang Yuantian <Yuantian.Tang@feescale.com>


>>  +{
>>  > >  +     int i;
>>  > >  +
>>  > >  +     for (i = 0; i < 50000; i++) {
>>  > >  +             if (generic_check_cpu_dead(cpu)) {
>>  > >  +                     qoriq_pm_ops->cpu_die(cpu);
>>  > >  +#ifdef CONFIG_PPC64
>>  > >  +                     paca[cpu].cpu_start = 0;
>>  > >  +#endif
>>  > >  +                     return;
>>  > >  +             }
>>  > >  +             udelay(10);
>>  > >  +     }
>>  > >  +     pr_err("%s: CPU%d didn't die...\n", __func__, cpu);
>>  > >  +}
>>  >
>>  > Only 500ms timeout, versus 10sec in generic_cpu_die()?
>> 
>>  The process is fast. Maybe 10 second is too large.
> 
> Is it fast 100% of the time?  What if the CPU you intend to die is in 
> a long
> critical section?  What harm is there to having a longer timeout, 
> similar to
> what other platforms use?

Will change the max timeout to 10 seconds.

> 
>> 
>>  >
>>  > >   #endif
>>  > >
>>  > >   static inline void flush_spin_table(void *spin_table)
>>  > >  @@ -246,11 +267,7 @@ static int smp_85xx_kick_cpu(int nr)
>>  > >                spin_table = phys_to_virt(*cpu_rel_addr);
>>  > >
>>  > >        local_irq_save(flags);
>>  > >  -#ifdef CONFIG_PPC32
>>  > >   #ifdef CONFIG_HOTPLUG_CPU
>>  > >  -     /* Corresponding to generic_set_cpu_dead() */
>>  > >  -     generic_set_cpu_up(nr);
>>  > >  -
>>  > >        if (system_state == SYSTEM_RUNNING) {
>>  > >                /*
>>  > >                 * To keep it compatible with old boot program 
>> which
>>  > > uses
>>  > >  @@ -263,6 +280,7 @@ static int smp_85xx_kick_cpu(int nr)
>>  > >                out_be32(&spin_table->addr_l, 0);
>>  > >                flush_spin_table(spin_table);
>>  > >
>>  > >  +             qoriq_pm_ops->cpu_up(nr);
>>  >
>>  > Again, is it possible to get here without a valid qoriq_pm_ops 
>> (i.e.
>>  > is there
>>  > anything stopping the user from trying to initiate CPU hotplug)?
>>  >
>>  > -Scott
>> 
>>  For every platform running this code, should has a valid 
>> qoriq_pm_ops.
>>  If not valid, it's a bug.
> 
> How do you prevent this code from running when there is no valid 
> qoriq_pm_ops?
> 
> -Scott
> 

Will check if qoriq_pm_ops is valid.

-Chenhui
