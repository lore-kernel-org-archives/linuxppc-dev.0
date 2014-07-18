Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E86931A0810
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jul 2014 09:12:37 +1000 (EST)
Message-ID: <1405725136.5289.112.camel@pasglop>
Subject: Re: [PATCH] powerpc: Add cputable definition for POWER8 DD1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
Date: Sat, 19 Jul 2014 09:12:16 +1000
In-Reply-To: <1405660235.7952.5.camel@ale.ozlabs.ibm.com>
References: <1405649497-679-1-git-send-email-joel@jms.id.au>
 <1405660235.7952.5.camel@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, Joel Stanley <joel@jms.id.au>, preeti@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-07-18 at 15:10 +1000, Michael Neuling wrote:
> On Fri, 2014-07-18 at 11:41 +0930, Joel Stanley wrote:
> > These processors do not currently support doorbell IPIs, so remove them
> > from the feature list if we are at DD 1.xx for the 0x004d part.
> 
> We GAed with DD2.1 and generally we don't upstream anything that isn't
> GAed.  Plus, if you wanna go down this path, you are going to have to
> fix a lot more bugs than this one (not that our early chips had bugs or
> anything).  
> 
> I suggested you crush your crappy DD1 parts into cubes and ask for some
> shiny new DD2.1 parts.

This is Venice, not Murano. We are going to have some of these guys
out there with the initial batch of dev boards.

.../..

> Humm, well doorbells worked on DD1 so i'm not sure this is entirely your
> problem.  There was an issue related to powersave that Ian posted a fix
> for but we never needed it as the issue was fixed before GA.
> 
> http://patchwork.ozlabs.org/patch/240338/
> 
> So NAK again.

Actually he did what I asked him to do :-)

Between Ian's workaround and just disabling DB on DD1, I prefer just
disabling DB on DD1. The fix is more crappy obscure asm to carry around
and I think it might cause spurrious DBs on non-broken CPUs.

Cheers,
Ben.

> Mikey
> 
> > Fixes: d4e58e5928f8 (powerpc/powernv: Enable POWER8 doorbell IPIs)
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  arch/powerpc/include/asm/cputable.h |  1 +
> >  arch/powerpc/kernel/cputable.c      | 20 ++++++++++++++++++++
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> > index bc23477..0fdd7ee 100644
> > --- a/arch/powerpc/include/asm/cputable.h
> > +++ b/arch/powerpc/include/asm/cputable.h
> > @@ -447,6 +447,7 @@ extern const char *powerpc_base_platform;
> >  	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
> >  	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP)
> >  #define CPU_FTRS_POWER8E (CPU_FTRS_POWER8 | CPU_FTR_PMAO_BUG)
> > +#define CPU_FTRS_POWER8_DD1 (CPU_FTRS_POWER8 & ~CPU_FTR_DBELL)
> >  #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
> >  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
> >  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> > diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> > index 965291b..0c15764 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -527,6 +527,26 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.machine_check_early	= __machine_check_early_realmode_p8,
> >  		.platform		= "power8",
> >  	},
> > +	{	/* Power8 DD1: Does not support doorbell IPIs */
> > +		.pvr_mask		= 0xffffff00,
> > +		.pvr_value		= 0x004d0100,
> > +		.cpu_name		= "POWER8 (raw)",
> > +		.cpu_features		= CPU_FTRS_POWER8_DD1,
> > +		.cpu_user_features	= COMMON_USER_POWER8,
> > +		.cpu_user_features2	= COMMON_USER2_POWER8,
> > +		.mmu_features		= MMU_FTRS_POWER8,
> > +		.icache_bsize		= 128,
> > +		.dcache_bsize		= 128,
> > +		.num_pmcs		= 6,
> > +		.pmc_type		= PPC_PMC_IBM,
> > +		.oprofile_cpu_type	= "ppc64/power8",
> > +		.oprofile_type		= PPC_OPROFILE_INVALID,
> > +		.cpu_setup		= __setup_cpu_power8,
> > +		.cpu_restore		= __restore_cpu_power8,
> > +		.flush_tlb		= __flush_tlb_power8,
> > +		.machine_check_early	= __machine_check_early_realmode_p8,
> > +		.platform		= "power8",
> > +	},
> >  	{	/* Power8 */
> >  		.pvr_mask		= 0xffff0000,
> >  		.pvr_value		= 0x004d0000,
