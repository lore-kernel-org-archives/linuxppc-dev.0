Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mpic: don't reset affinity for secondary MPIC
	on boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200811201823.25263.arnd@arndb.de>
References: <200811191450.59361.arnd@arndb.de>
	<1227166240.7185.207.camel@pasglop> <200811201823.25263.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 21 Nov 2008 13:44:10 +1100
Message-Id: <1227235450.7185.214.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kexec@lists.infradead.org,
	cbe-oss-dev@ozlabs.org, Max Krasnyansky <maxk@qualcomm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-11-20 at 18:23 +0100, Arnd Bergmann wrote:
> Kexec/kdump currently fails on the IBM QS2x blades when the kexec happens
> on a CPU other than the initial boot CPU.  It turns out that this is the
> result of mpic_init trying to set affinity of each interrupt vector to the
> current boot CPU.
> 
> As far as I can tell,  the same problem is likely to exist on any
> secondary MPIC, because they have to deliver interrupts to the first
> output all the time. There are two potential solutions for this: either
> not set up affinity at all for secondary MPICs, or assume that a single
> CPU output is connected to the upstream interrupt controller and hardcode
> affinity to that per architecture.
> 
> This patch implements the second approach, defaulting to the first output.
> An architecture that has a secondary MPIC connected upstream using a
> different output needs to set the mpic default_dest to the correct
> value before calling mpic_init.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> ---
>  include/asm/mpic.h |    3 +++
>  sysdev/mpic.c      |    9 +++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> On Thursday 20 November 2008, Benjamin Herrenschmidt wrote:
> 
> > I would rather, for non primary, set it to a cpu provided as
> > either a new argument or an mpic struct member initially set to 1 with
> > an accessor to change it if necessary. 
> 
> How about this one?
> 
> > Or should we define a flag to have it read it at init time from the chip ?
> 
> I don't understand. This is init time, where we write it to the chip,
> what do you mean with reading from it? If I understand you correctly,
> we can't trust that value to start with.

Oh just that for powermac for example, I know I'm resetting the thing,
so can't rely on init values, and on some BML embedded boxes too, while
on things like cell I don't off hand know what the right CPU number is
to hit the right C3PO interrupt, so I'm better off reading what SLOF
did :-)

But if you think on Cell we can just hard wire in the platform code,
then I'm ok.

Cheers,
Ben.

> 	Arnd <><
> 
> diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
> index fe566a3..543d51c 100644
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -295,6 +295,9 @@ struct mpic
>  	/* Protected sources */
>  	unsigned long		*protected;
>  
> +	/* destination for non-primary MPICs */
> +	int			default_dest;
> +
>  #ifdef CONFIG_MPIC_WEIRD
>  	/* Pointer to HW info array */
>  	u32			*hw_set;
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 8e3478c..cf154c9 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1220,6 +1220,7 @@ void __init mpic_set_default_senses(struct mpic *mpic, u8 *senses, int count)
>  void __init mpic_init(struct mpic *mpic)
>  {
>  	int i;
> +	int cpu;
>  
>  	BUG_ON(mpic->num_sources == 0);
>  
> @@ -1262,6 +1263,11 @@ void __init mpic_init(struct mpic *mpic)
>  
>  	mpic_pasemi_msi_init(mpic);
>  
> +	if (mpic->flags & MPIC_PRIMARY)
> +		cpu = hard_smp_processor_id();
> +	else
> +		cpu = mpic->default_dest;
> +
>  	for (i = 0; i < mpic->num_sources; i++) {
>  		/* start with vector = source number, and masked */
>  		u32 vecpri = MPIC_VECPRI_MASK | i |
> @@ -1272,8 +1278,7 @@ void __init mpic_init(struct mpic *mpic)
>  			continue;
>  		/* init hw */
>  		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
> -		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
> -			       1 << hard_smp_processor_id());
> +		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION), 1 << cpu);
>  	}
>  	
>  	/* Init spurious vector */
