Return-Path: <michael.neuling@au1.ibm.com>
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id F1A502C00EB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 09:41:45 +1000 (EST)
From: Michael Neuling <michael.neuling@au1.ibm.com>
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH v2 2/4] powerpc/cputable: advertise DSCR support on P7/P7+
In-reply-to: <1369062258.18289.3.camel@brimstone>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <2889.1367625894@ale.ozlabs.ibm.com>
 <20130504004756.GA3532@linux.vnet.ibm.com>
 <20130504004838.GB3532@linux.vnet.ibm.com>
 <1369062258.18289.3.camel@brimstone>
Date: Tue, 21 May 2013 09:41:45 +1000
Message-ID: <2921.1369093305@ale.ozlabs.ibm.com>
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Steve Munroe <sjmunroe@us.ibm.com>, Peter Bergner <bergner@us.ibm.com>,
 Ryan Arnold <ryanarn@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Michael R Meissner <mrmeissn@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Will Schmidt <will_schmidt@vnet.ibm.com> wrote:

> On Fri, 2013-05-03 at 17:48 -0700, Nishanth Aravamudan wrote:
> > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > 
> > diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> > index ae9f433..a792157 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -98,6 +98,7 @@ extern void __restore_cpu_e6500(void);
> >  				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
> >  				 PPC_FEATURE_TRUE_LE | \
> >  				 PPC_FEATURE_PSERIES_PERFMON_COMPAT)
> > +#define COMMON_USER2_POWER7	(PPC_FEATURE2_DSCR)
> >  #define COMMON_USER_POWER8	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_06 |\
> >  				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
> >  				 PPC_FEATURE_TRUE_LE | \
> > @@ -428,6 +429,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.cpu_name		= "POWER7 (architected)",
> >  		.cpu_features		= CPU_FTRS_POWER7,
> >  		.cpu_user_features	= COMMON_USER_POWER7,
> > +		.cpu_user_features2	= COMMON_USER2_POWER7,
> >  		.mmu_features		= MMU_FTRS_POWER7,
> >  		.icache_bsize		= 128,
> >  		.dcache_bsize		= 128,
> > @@ -458,6 +460,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.cpu_name		= "POWER7 (raw)",
> >  		.cpu_features		= CPU_FTRS_POWER7,
> >  		.cpu_user_features	= COMMON_USER_POWER7,
> > +		.cpu_user_features2	= COMMON_USER2_POWER7,
> >  		.mmu_features		= MMU_FTRS_POWER7,
> >  		.icache_bsize		= 128,
> >  		.dcache_bsize		= 128,
> > @@ -475,6 +478,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
> >  		.cpu_name		= "POWER7+ (raw)",
> >  		.cpu_features		= CPU_FTRS_POWER7,
> >  		.cpu_user_features	= COMMON_USER_POWER7,
> > +		.cpu_user_features	= COMMON_USER2_POWER7,
> 
> ^ Oops here, I think.    Please consider applying this on top.
> Untested, but seems obvious.
> 
> Fix a typo in setting COMMON_USER2_POWER7 bits to .cpu_user_features2
> cpu specs table.

Nice catch.  Thanks

Acked-by: Michael Neuling <mikey@neuling.org>


> 
> Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
> 
> 
> diff --git a/arch/powerpc/kernel/cputable.c
> b/arch/powerpc/kernel/cputable.c
> index c60bbec..51eecb5 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -482,7 +482,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>                 .cpu_name               = "POWER7+ (raw)",
>                 .cpu_features           = CPU_FTRS_POWER7,
>                 .cpu_user_features      = COMMON_USER_POWER7,
> -               .cpu_user_features      = COMMON_USER2_POWER7,
> +               .cpu_user_features2     = COMMON_USER2_POWER7,
>                 .mmu_features           = MMU_FTRS_POWER7,
>                 .icache_bsize           = 128,
>                 .dcache_bsize           = 128,
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> >  		.mmu_features		= MMU_FTRS_POWER7,
> >  		.icache_bsize		= 128,
> >  		.dcache_bsize		= 128,
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > 
> 
> 
