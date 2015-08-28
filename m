Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0147.outbound.protection.outlook.com [157.56.110.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5DEC1A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 15:13:50 +1000 (AEST)
Message-ID: <1440738814.16577.171.camel@freescale.com>
Subject: Re: [PATCH v2,5/5] PowerPC/mpc85xx: Add CPU hotplug support for E6500
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <Jason.Jin@freescale.com>
Date: Fri, 28 Aug 2015 00:13:34 -0500
In-Reply-To: <1440726149.31670.2@remotesmtp.freescale.net>
References: <1440590988-25594-1-git-send-email-chenhui.zhao@freescale.com>
 <1440590988-25594-5-git-send-email-chenhui.zhao@freescale.com>
 <20150826224213.GC10582@home.buserror.net>
 <1440726149.31670.2@remotesmtp.freescale.net>
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

On Fri, 2015-08-28 at 09:42 +0800, Chenhui Zhao wrote:
> On Thu, Aug 27, 2015 at 6:42 AM, Scott Wood <scottwood@freescale.com> 
> wrote:
> > On Wed, Aug 26, 2015 at 08:09:48PM +0800, Chenhui Zhao wrote:
> > >  +        .globl  booting_thread_hwid
> > >  +booting_thread_hwid:
> > >  +        .long  INVALID_THREAD_HWID
> > >  +        .align 3
> > 
> > The commit message goes into no detail about the changes you're 
> > making to
> > thread handling, nor are there relevant comments.
> 
> OK. Will add some comments.
> 
> > 
> > >  +/*
> > >  + * r3 = the thread physical id
> > >  + */
> > >  +_GLOBAL(book3e_stop_thread)
> > >  +        li      r4, 1
> > >  +        sld     r4, r4, r3
> > >  +        mtspr   SPRN_TENC, r4
> > >  +        isync
> > >  +        blr
> > 
> > Why did the C code not have an isync, if it's required here?
> 
> Just make sure "mtspr" has completed before the routine returns.
> 
> > 
> > 
> > >   _GLOBAL(fsl_secondary_thread_init)
> > >           /* Enable branch prediction */
> > >           lis     r3,BUCSR_INIT@h
> > >  @@ -197,8 +236,10 @@ _GLOBAL(fsl_secondary_thread_init)
> > >            * but the low bit right by two bits so that the cpu numbering is
> > >            * continuous.
> > >            */
> > >  -        mfspr   r3, SPRN_PIR
> > >  -        rlwimi  r3, r3, 30, 2, 30
> > >  +        bl      10f
> > >  +10:     mflr    r5
> > >  +        addi    r5,r5,(booting_thread_hwid - 10b)
> > >  +        lwz     r3,0(r5)
> > >           mtspr   SPRN_PIR, r3
> > >   #endif
> > 
> > I assume the reason for this is that, unlike the kexec case, the cpu 
> > has
> > been reset so PIR has been reset?  Don't make me guess -- document.
> 
> We can not rely on the value saved in SPRN_PIR. Every time running 
> fsl_secondary_thread_init, SPRN_PIR may not always has a reset value.
> Using booting_thread_hwid to ensure SPRN_PIR has a correct value.

But when will the cpu ever be in a state other than "reset PIR value and 
reset BUCSR value" or "Software-desired PIR value and BUCSR value"?

> > >  @@ -245,6 +286,30 @@ _GLOBAL(generic_secondary_smp_init)
> > >           mr      r3,r24
> > >           mr      r4,r25
> > >           bl      book3e_secondary_core_init
> > >  +
> > >  +/*
> > >  + * If we want to boot Thread1, start Thread1 and stop Thread0.
> > >  + * Note that only Thread0 will run the piece of code.
> > >  + */
> > 
> > What ensures that only thread 0 runs this?  Especially if we're 
> > entering
> > via kdump on thread 1?
> 
> This piece of code will be executed only when core resets (Thead0 will 
> start first). 

This is not true with kexec/kdump.

> Thead1 will run fsl_secondary_thread_init() to start.
> 
> How can kdump run this on Thread1? I know little about kexec.

kexec/kdump involves booting a new kernel image without resetting the 
hardware.

 +      /* start Thread1 */
> > >  +        LOAD_REG_ADDR(r5, fsl_secondary_thread_init)
> > >  +        ld      r4, 0(r5)
> > >  +        li      r3, 1
> > >  +        bl      book3e_start_thread
> > >  +
> > >  +        /* stop Thread0 */
> > >  +        li      r3, 0
> > >  +        bl      book3e_stop_thread
> > >  +10:
> > >  +        b       10b
> > >  +20:
> > >   #endif
> > > 
> > >   generic_secondary_common_init:
> > >  diff --git a/arch/powerpc/platforms/85xx/smp.c 
> > > b/arch/powerpc/platforms/85xx/smp.c
> > >  index 73eb994..61f68ad 100644
> > >  --- a/arch/powerpc/platforms/85xx/smp.c
> > >  +++ b/arch/powerpc/platforms/85xx/smp.c
> > >  @@ -181,17 +181,11 @@ static inline u32 read_spin_table_addr_l(void 
> > > *spin_table)
> > >   static void wake_hw_thread(void *info)
> > >   {
> > >           void fsl_secondary_thread_init(void);
> > >  -        unsigned long imsr1, inia1;
> > >  -        int nr = *(const int *)info;
> > >  +        unsigned long inia;
> > >  +        int hw_cpu = get_hard_smp_processor_id(*(const int *)info);
> > > 
> > >  -        imsr1 = MSR_KERNEL;
> > >  -        inia1 = *(unsigned long *)fsl_secondary_thread_init;
> > >  -
> > >  -        mttmr(TMRN_IMSR1, imsr1);
> > >  -        mttmr(TMRN_INIA1, inia1);
> > >  -        mtspr(SPRN_TENS, TEN_THREAD(1));
> > >  -
> > >  -        smp_generic_kick_cpu(nr);
> > >  +        inia = *(unsigned long *)fsl_secondary_thread_init;
> > >  +        book3e_start_thread(cpu_thread_in_core(hw_cpu), inia);
> > >   }
> > >   #endif
> > > 
> > >  @@ -279,7 +273,6 @@ static int smp_85xx_kick_cpu(int nr)
> > >           int ret = 0;
> > >   #ifdef CONFIG_PPC64
> > >           int primary = nr;
> > >  -        int primary_hw = get_hard_smp_processor_id(primary);
> > >   #endif
> > > 
> > >           WARN_ON(nr < 0 || nr >= num_possible_cpus());
> > >  @@ -287,33 +280,43 @@ static int smp_85xx_kick_cpu(int nr)
> > >           pr_debug("kick CPU #%d\n", nr);
> > > 
> > >   #ifdef CONFIG_PPC64
> > >  +        booting_thread_hwid = INVALID_THREAD_HWID;
> > >           /* Threads don't use the spin table */
> > >  -        if (cpu_thread_in_core(nr) != 0) {
> > >  -                int primary = cpu_first_thread_sibling(nr);
> > >  +        if (threads_per_core == 2) {
> > >  +                booting_thread_hwid = get_hard_smp_processor_id(nr);
> > 
> > What does setting booting_thread_hwid to INVALID_THREAD_HWID here
> > accomplish?  If threads_per_core != 2 it would never have been set to
> > anything else, and if threads_per_core == 2 you immediately overwrite 
> > it.
> 
> booting_thread_hwid is valid only for the case that one core has two 
> threads (e6500). For e5500 and e500mc, one core one thread, 
> "booting_thread_hwid" is invalid.
> 
> "booting_thread_hwid" will determine starting which thread in 
> generic_secondary_smp_init().

You didn't answer my question.

> > > +         /*
> > >  +                 * If either one of threads in the same core is online,
> > >  +                 * use the online one to start the other.
> > >  +                 */
> > >  +                if (qoriq_pm_ops)
> > >  +                        qoriq_pm_ops->cpu_up_prepare(nr);
> > 
> > cpu_up_prepare does rcpm_v2_cpu_exit_state(cpu, E500_PM_PH20).  How do
> > you know the cpu is already in PH20?  What if this is initial boot?  
> > Are
> > you relying on it being a no-op in that case?
> 
> Yes, if the cpu is in PH20, it will exit; if not, cpu_up_prepare() is 
> equal to a no-op.

This warrants a comment.

-Scott
