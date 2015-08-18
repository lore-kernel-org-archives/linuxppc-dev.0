Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0118.outbound.protection.outlook.com [207.46.100.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D93F1A0151
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 15:09:39 +1000 (AEST)
Message-ID: <1439874559.15601.70.camel@freescale.com>
Subject: Re: [RFC,14/17] powerpc/book3e-64/kexec: Enable SMP release
From: Scott Wood <scottwood@freescale.com>
To: Michael Ellerman <mpe@ellerman.id.au>
CC: <linuxppc-dev@lists.ozlabs.org>, Tiejun Chen <tiejun.chen@intel.com>,
 <kexec@lists.infradead.org>
Date: Tue, 18 Aug 2015 00:09:19 -0500
In-Reply-To: <20150818045141.D1E8C14032F@ozlabs.org>
References: <20150818045141.D1E8C14032F@ozlabs.org>
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

On Tue, 2015-08-18 at 14:51 +1000, Michael Ellerman wrote:
> On Sat, 2015-18-07 at 20:08:51 UTC, Scott Wood wrote:
> > booted_from_exec is similar to __run_at_load, except that it is set for
>               ^
>             missing k.
> 
> Also do you mind using __booted_from_kexec to keep the naming similar to the
> other variables down there, and also make it clear it's low level guts.
> 
> I see you asked for them to be removed on the original patch but all the 
> other
> vars in there are named that way.

I'm not a fan of it as it isn't distinguishing from a non-underscore version, 
isn't there for namespacing reasons, and it's not even a private 
implementation detail -- it's part of the interface with kexec tools.  I'll 
change it if you want, though.

> > diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> > index 1b77956..ae2d6b5 100644
> > --- a/arch/powerpc/kernel/head_64.S
> > +++ b/arch/powerpc/kernel/head_64.S
> > @@ -91,6 +91,21 @@ __secondary_hold_spinloop:
> >  __secondary_hold_acknowledge:
> >     .llong  0x0
> >  
> > +   /* Do not move this variable as kexec-tools knows about it. */
> > +   . = 0x58
> > +   .globl  booted_from_kexec
> > +booted_from_kexec:
> > +   /*
> > +    * "nkxc" -- not (necessarily) from kexec by default
> > +    *
> > +    * This flag is set to 1 by a loader if the kernel is being
> > +    * booted by kexec.  Older kexec-tools don't know about this
> > +    * flag, so platforms other than fsl-book3e should treat a value
> > +    * of "nkxc" as inconclusive.  fsl-book3e relies on this to
> > +    * know how to release secondary cpus.
> > +    */
> > +   .long   0x6e6b7863
> 
> Couldn't we say that "nkxc" (whatever that stands for)

It stands for "no kexec", which is true if that value is not overwritten.

>  means "unknown", and
> have kexec-tools write "yes" to indicate yes. I realise that's not 100% 
> bullet

That is what I implemented (other than "1" versus "yes").

> > diff --git a/arch/powerpc/kernel/setup_64.c 
> > b/arch/powerpc/kernel/setup_64.c
> > index 505ec2c..baeddcc 100644
> > --- a/arch/powerpc/kernel/setup_64.c
> > +++ b/arch/powerpc/kernel/setup_64.c
> > @@ -340,11 +340,23 @@ void early_setup_secondary(void)
> >  #endif /* CONFIG_SMP */
> >  
> >  #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC)
> > +static bool use_spinloop(void)
> > +{
> > +#ifdef CONFIG_PPC_FSL_BOOK3E
> > +   return booted_from_kexec == 1;
> > +#else
> > +   return true;
> > +#endif
> 
> Ugh, more ifdefs.
> 
> What about:
> 
>       return IS_ENABLED(CONFIG_PPC_FSL_BOOK3E) && (booted_from_kexec == 1);
> 
> If that works, I haven't checked. It's slightly less ugly?

That would return "false" for non-book3e which isn't correct.

If it has to be done with a single expression, then it'd be:

        return !IS_ENABLED(CONFIG_PPC_FSL_BOOK3E) || booted_from_kexec == 1;

-Scott
