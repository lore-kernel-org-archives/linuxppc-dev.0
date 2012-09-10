Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/6] powerpc: Add enable_ppr kernel parameter to enable
 PPR save/restore
In-reply-to: <1347235922.2385.138.camel@pasglop>
References: <1347190671.3418.12.camel@hbabu-laptop>
 <1347235922.2385.138.camel@pasglop>
Date: Mon, 10 Sep 2012 10:22:38 +1000
Message-ID: <13010.1347236558@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org,
 Haren Myneni <haren@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sun, 2012-09-09 at 04:37 -0700, Haren Myneni wrote:
> > enable_ppr kernel parameter is used to enable PPR save and restore.
> > Supported on Power7 and later processors.
> > 
> > By default, CPU_FTR_HAS_PPR is set for POWER7. If this parameter is not
> > passed, disable CPU_FTR_HAS_PPR.
> 
> What is the point ? Obscure / magic kernel command line options to turn
> on a feature are pointless. Nobody knows about them, nobody enables
> them.
> 
> What you are doing is guarantee that nobody's ever going to enable your
> code, so your whole patch series is thus irrelevant :-)
> 
> If there's a good reason to *avoid* your option, then maybe consider
> adding an option to *disable* the PPR save/restore, though of course
> that would bring the argument that if it needs to be disabled maybe we
> shouldn't do it in the first place, or you might want to think of a
> reasonable way to intuit what the option should be.

IIRC, Haren was saying there's a 6% hit on null syscall for this.  So we
suggested having a cmdline option to disable it for distros.

Haren, is my recollection correct?  If so, can you add this info the
change log and change the sex of the option. 

Mikey

> 
> Ben.
> 
> > Signed-off-by: Haren Myneni <haren@us.ibm.com>
> > 
> > ---
> >  Documentation/kernel-parameters.txt |    4 ++++
> >  arch/powerpc/include/asm/cputable.h |    6 ++++--
> >  arch/powerpc/kernel/setup_64.c      |   14 ++++++++++++++
> >  3 files changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> > index ad7e2e5..2881e5f 100644
> > --- a/Documentation/kernel-parameters.txt
> > +++ b/Documentation/kernel-parameters.txt
> > @@ -809,6 +809,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
> >  			to discrete, to make X server driver able to add WB
> >  			entry later. This parameter enables that.
> >  
> > +	enable_ppr	[PPC/PSERIES]
> > +			Saves user defined PPR when process enters to kernel 
> > +			and restores PPR at exit. But it impacts performance.
> > +
> >  	enable_timer_pin_1 [X86]
> >  			Enable PIN 1 of APIC timer
> >  			Can be useful to work around chipset bugs
> > diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> > index b3c083d..880c469 100644
> > --- a/arch/powerpc/include/asm/cputable.h
> > +++ b/arch/powerpc/include/asm/cputable.h
> > @@ -203,6 +203,7 @@ extern const char *powerpc_base_platform;
> >  #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
> >  #define CPU_FTR_ICSWX			LONG_ASM_CONST(0x1000000000000000)
> >  #define CPU_FTR_VMX_COPY		LONG_ASM_CONST(0x2000000000000000)
> > +#define CPU_FTR_HAS_PPR			LONG_ASM_CONST(0x4000000000000000)
> >  
> >  #ifndef __ASSEMBLY__
> >  
> > @@ -432,7 +433,8 @@ extern const char *powerpc_base_platform;
> >  	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
> >  	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
> >  	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
> > -	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY)
> > +	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | \
> > +	    CPU_FTR_VMX_COPY | CPU_FTR_HAS_PPR)
> >  #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
> >  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
> >  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> > @@ -454,7 +456,7 @@ extern const char *powerpc_base_platform;
> >  	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
> >  	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
> >  	    CPU_FTRS_POWER7 | CPU_FTRS_CELL | CPU_FTRS_PA6T |		\
> > -	    CPU_FTR_VSX)
> > +	    CPU_FTR_VSX | CPU_FTR_HAS_PPR)
> >  #endif
> >  #else
> >  enum {
> > diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> > index 389bd4f..e4c1945 100644
> > --- a/arch/powerpc/kernel/setup_64.c
> > +++ b/arch/powerpc/kernel/setup_64.c
> > @@ -98,6 +98,8 @@ int dcache_bsize;
> >  int icache_bsize;
> >  int ucache_bsize;
> >  
> > +static u32 enable_ppr = 0;
> > +
> >  #ifdef CONFIG_SMP
> >  
> >  static char *smt_enabled_cmdline;
> > @@ -357,6 +359,9 @@ void __init setup_system(void)
> >  {
> >  	DBG(" -> setup_system()\n");
> >  
> > +	if (cpu_has_feature(CPU_FTR_HAS_PPR) && !enable_ppr)
> > +		cur_cpu_spec->cpu_features &= ~CPU_FTR_HAS_PPR;
> > +
> >  	/* Apply the CPUs-specific and firmware specific fixups to kernel
> >  	 * text (nop out sections not relevant to this CPU or this firmware)
> >  	 */
> > @@ -683,6 +688,15 @@ void __init setup_per_cpu_areas(void)
> >  }
> >  #endif
> >  
> > +/* early_ppr kernel parameter to save/restore PPR register */
> > +static int __init early_ppr_enabled(char *str)
> > +{
> > +	enable_ppr = 1;
> > +
> > +	return 0;
> > +}
> > +
> > +early_param("enable_ppr", early_ppr_enabled);
> >  
> >  #ifdef CONFIG_PPC_INDIRECT_IO
> >  struct ppc_pci_io ppc_pci_io;
> 
> 
