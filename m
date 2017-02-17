Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPsG55ZxlzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 23:07:09 +1100 (AEDT)
Message-ID: <1487333213.11368.2.camel@russell.cc>
Subject: Re: [PATCH v2] powerpc: Add POWER9 architected mode to cputable
From: Russell Currey <ruscur@russell.cc>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org
Date: Fri, 17 Feb 2017 23:06:53 +1100
In-Reply-To: <87y3x5i04k.fsf@concordia.ellerman.id.au>
References: <20170217020135.6361-1-ruscur@russell.cc>
 <87y3x5i04k.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-17 at 21:26 +1100, Michael Ellerman wrote:
> Russell Currey <ruscur@russell.cc> writes:
> 
> > diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> > index 6a82ef039c50..d23a54b09436 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -386,6 +386,25 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.machine_check_early	=
> > __machine_check_early_realmode_p8,
> >  		.platform		= "power8",
> >  	},
> > +	{	/* 3.00-compliant processor, i.e. Power9 "architected"
> > mode */
> > +		.pvr_mask		= 0xffffffff,
> > +		.pvr_value		= 0x0f000005,
> > +		.cpu_name		= "POWER9 (architected)",
> > +		.cpu_features		= CPU_FTRS_POWER9,
> > +		.cpu_user_features	= COMMON_USER_POWER9,
> > +		.cpu_user_features2	= COMMON_USER2_POWER9,
> > +		.mmu_features		= MMU_FTRS_POWER9,
> > +		.icache_bsize		= 128,
> > +		.dcache_bsize		= 128,
> > +		.num_pmcs		= 6,
> 
> It's important *not* to set num_pmcs for the architected PVRs.
> 
> See the comment in setup_cpu_spec():
> 
> 	/*
> 	 * If we are overriding a previous value derived from the real
> 	 * PVR with a new value obtained using a logical PVR value,
> 	 * don't modify the performance monitor fields.
> 	 */
> 	if (old.num_pmcs && !s->num_pmcs) {
> 		t->num_pmcs = old.num_pmcs;
> 		t->pmc_type = old.pmc_type;
> 
> I realise that having that requirement in the code is serious foot gun
> material on our part, but c'est la vie.
> 
> The reason we do that is there's no "compat mode" for the PMU. So if you
> boot on a Power9, and then the logical PVR says "actually pretend you're
> on a Power8", we flip most of the cpu_spec to have the Power8 values,
> but *not* the PMU fields. That way the Power9 PMU code will still detect
> that it's on a Power9 and work correctly.
> 
> Possibly now that oprofile is more or less dead we can rip all that crap
> out, and have perf just look at the PVR directly.

Oh and also, do you want me to respin or are you happy to drop it on your end?

- Russell

> 
> cheers
