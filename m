Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0101.outbound.protection.outlook.com [157.56.111.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA4861A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 13:54:18 +1100 (AEDT)
From: "chenhui.zhao@freescale.com" <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [3/4] powerpc: support CPU hotplug for e500mc, e5500 and e6500
Date: Fri, 3 Apr 2015 02:54:08 +0000
Message-ID: <1428029650867.38904@freescale.com>
References: <1427365095-26396-3-git-send-email-chenhui.zhao@freescale.com>
 ,<20150331020722.GC5667@home.buserror.net>
 <1427973405260.57477@freescale.com>, <1427990598.22867.271.camel@freescale.com>
In-Reply-To: <1427990598.22867.271.camel@freescale.com>
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
Sent: Friday, April 3, 2015 0:03
To: Zhao Chenhui-B35336
Cc: linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org; linux-kernel=
@vger.kernel.org; Jin Zhengxiong-R64188
Subject: Re: [3/4] powerpc: support CPU hotplug for e500mc, e5500 and e6500

On Thu, 2015-04-02 at 06:16 -0500, Zhao Chenhui-B35336 wrote:
>
> ________________________________________
> From: Wood Scott-B07421
> Sent: Tuesday, March 31, 2015 10:07
> To: Zhao Chenhui-B35336
> Cc: linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org; linux-kern=
el@vger.kernel.org; Jin Zhengxiong-R64188
> Subject: Re: [3/4] powerpc: support CPU hotplug for e500mc, e5500 and e65=
00
>
> On Thu, Mar 26, 2015 at 06:18:14PM +0800, chenhui zhao wrote:
> > @@ -189,16 +193,14 @@ _GLOBAL(fsl_secondary_thread_init)
> >       isync
> >
> >       /*
> > -      * Fix PIR to match the linear numbering in the device tree.
> > -      *
> > -      * On e6500, the reset value of PIR uses the low three bits for
> > -      * the thread within a core, and the upper bits for the core
> > -      * number.  There are two threads per core, so shift everything
> > -      * but the low bit right by two bits so that the cpu numbering is
> > -      * continuous.
>
> Why are you getting rid of this?  If it's to avoid doing it twice on the
> same thread, in my work-in-progress kexec patches I instead check to see
> whether BUCSR has already been set up -- if it has, I assume we've
> already been here.
>
> [chenhui] I didn't delete the branch prediction related code.

I didn't say you did.  I'm saying that you can check whether BUCSR has
been set up, to determine whether PIR has already been adjusted, if your
concern is avoiding running this twice on a thread between core resets.
If that's not your concern, then please explain.

[chenhui] If no need to change PIR in CPU hotplug, I will change the code a=
s you mentioned.

> > +             /*
> > +              * If both threads are offline, reset core to start.
> > +              * When core is up, Thread 0 always gets up first,
> > +              * so bind the current logical cpu with Thread 0.
> > +              */
>
> What if the core is not in a PM state that requires a reset?
> Where does this reset occur?
>
> [chenhui] Reset occurs in the function mpic_reset_core().
>
> > +             if (hw_cpu !=3D cpu_first_thread_sibling(hw_cpu)) {
> > +                     int hw_cpu1, hw_cpu2;
> > +
> > +                     hw_cpu1 =3D get_hard_smp_processor_id(primary);
> > +                     hw_cpu2 =3D get_hard_smp_processor_id(primary + 1=
);
> > +                     set_hard_smp_processor_id(primary, hw_cpu2);
> > +                     set_hard_smp_processor_id(primary + 1, hw_cpu1);
> > +                     /* get new physical cpu id */
> > +                     hw_cpu =3D get_hard_smp_processor_id(nr);
>
> Why are you swapping the hard smp ids?
>
> [chenhui] For example, Core1 has two threads, Thread0 and Thread1. In nor=
mal boot, Thread0 is CPU2, and Thread1 is CPU3.
> But, if CPU2 and CPU3 are all off, user wants CPU3 up first. we need to c=
all Thread0 as CPU3 and Thead1 as CPU2, considering
> the limitation, after core is reset, only Thread0 is up, then Thread0 kic=
ks up Thread1.

There's no need for this.  I have booting from a thread1, and having it
kick its thread0, working locally without messing with the hwid/cpu
mapping.

[chenhui] Great. If you have completed your patches, can we merge our code?

> > @@ -252,11 +340,7 @@ static int smp_85xx_kick_cpu(int nr)
> >               spin_table =3D phys_to_virt(*cpu_rel_addr);
> >
> >       local_irq_save(flags);
> > -#ifdef CONFIG_PPC32
> >  #ifdef CONFIG_HOTPLUG_CPU
> > -     /* Corresponding to generic_set_cpu_dead() */
> > -     generic_set_cpu_up(nr);
> > -
>
> Why did you move this?
>
> [chenhui] It would be better to set this after CPU is really up.

Please make it a separate patch with an explanation.

-Scott

[chenhui] OK.
