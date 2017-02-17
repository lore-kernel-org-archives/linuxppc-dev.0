Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPZbN5LZhzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 12:06:08 +1100 (AEDT)
Message-ID: <1487293564.5352.1.camel@russell.cc>
Subject: Re: [PATCH] powerpc: Detect POWER9 architected mode
From: Russell Currey <ruscur@russell.cc>
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 17 Feb 2017 12:06:04 +1100
In-Reply-To: <1487293046.32732.3.camel@neuling.org>
References: <20170216235900.15629-1-ruscur@russell.cc>
 <1487293046.32732.3.camel@neuling.org>
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

On Fri, 2017-02-17 at 11:57 +1100, Michael Neuling wrote:
> Can you make the comment/title a bit more descriptive...  Have a look at
> c674e703cb1028e468527163074810b4a17bf379 where we added the p8.
> 

I had a look at that when I was making the commit but I didn't think it really
added anything valuable (though I suppose mentioning cputable in the commit
message might add clarity).  I guess

    A PVR of 0x0F000005 means we are arch v3.00 compliant (i.e. POWER9)

to steal from yours...

> 
> > Signed-off-by: Russell Currey <ruscur@russell.cc>
> 
> Other than that, the code looks good..
> 
> Acked-By: Michael Neuling <mikey@neuling.org>
> 
> 
> 
> > ---
> >  arch/powerpc/kernel/cputable.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
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
> > mode
> > */
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
> > +		.pmc_type		= PPC_PMC_IBM,
> > +		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
> > +		.oprofile_type		= PPC_OPROFILE_INVALID,
> > +		.cpu_setup		= __setup_cpu_power9,
> > +		.cpu_restore		= __restore_cpu_power9,
> > +		.flush_tlb		= __flush_tlb_power9,
> > +		.platform		= "power9",
> > +	},
> >  	{	/* Power7 */
> >  		.pvr_mask		= 0xffff0000,
> >  		.pvr_value		= 0x003f0000,
