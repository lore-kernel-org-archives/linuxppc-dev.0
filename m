Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] mpic: add support for serial mode interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060620211536.GA16770@mag.az.mvista.com>
References: <20060619200811.GA15524@mag.az.mvista.com>
	<1150776086.23600.329.camel@localhost.localdomain>
	<20060620211536.GA16770@mag.az.mvista.com>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 08:04:20 +1000
Message-Id: <1150841061.1901.22.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-06-20 at 14:15 -0700, Mark A. Greer wrote:
> On Tue, Jun 20, 2006 at 02:01:26PM +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2006-06-19 at 13:08 -0700, Mark A. Greer wrote:
> > > MPC10x-style interrupt controllers have a serial mode that allows
> > > several interrupts to be clocked in through one INT signal.
> > > 
> > > This patch adds the software support for that mode.
> > 
> > You hard code the clock ratio... why not add a separate call to be
> > called after mpic_init,
> > something like mpic_set_serial_int(int mpic, int enable, int
> > clock_ratio) ?
> 
> How's this?

Looks good to me.

Ben.

> --
> 
> MPC10x-style interrupt controllers have a serial mode that allows
> several interrupts to be clocked in through one INT signal.
> 
> This patch adds the software support for that mode.
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> --
> 
>  arch/powerpc/sysdev/mpic.c |   20 ++++++++++++++++++++
>  include/asm-powerpc/mpic.h |   10 ++++++++++
>  2 files changed, 30 insertions(+)
> --
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 7dcdfcb..bffe50d 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -829,7 +829,27 @@ #endif
>  	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0);
>  }
>  
> +void __init mpic_set_clk_ratio(struct mpic *mpic, u32 clock_ratio)
> +{
> +	u32 v;
> +
> +	v = mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1);
> +	v &= ~MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK;
> +	v |= MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO(clock_ratio);
> +	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1, v);
> +}
>  
> +void __init mpic_set_serial_int(struct mpic *mpic, int enable)
> +{
> +	u32 v;
> +
> +	v = mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1);
> +	if (enable)
> +		v |= MPIC_GREG_GLOBAL_CONF_1_SIE;
> +	else
> +		v &= ~MPIC_GREG_GLOBAL_CONF_1_SIE;
> +	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1, v);
> +}
>  
>  void mpic_irq_set_priority(unsigned int irq, unsigned int pri)
>  {
> diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
> index 6b9e781..f0d22ac 100644
> --- a/include/asm-powerpc/mpic.h
> +++ b/include/asm-powerpc/mpic.h
> @@ -22,6 +22,10 @@ #define		MPIC_GREG_GCONF_RESET			0x80000
>  #define		MPIC_GREG_GCONF_8259_PTHROU_DIS		0x20000000
>  #define		MPIC_GREG_GCONF_BASE_MASK		0x000fffff
>  #define MPIC_GREG_GLOBAL_CONF_1		0x00030
> +#define		MPIC_GREG_GLOBAL_CONF_1_SIE		0x08000000
> +#define		MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK	0x70000000
> +#define		MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO(r)	\
> +			(((r) << 28) & MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK)
>  #define MPIC_GREG_VENDOR_0		0x00040
>  #define MPIC_GREG_VENDOR_1		0x00050
>  #define MPIC_GREG_VENDOR_2		0x00060
> @@ -284,6 +288,12 @@ extern int mpic_get_one_irq(struct mpic 
>  /* This one gets to the primary mpic */
>  extern int mpic_get_irq(struct pt_regs *regs);
>  
> +/* Set the EPIC clock ratio */
> +void mpic_set_clk_ratio(struct mpic *mpic, u32 clock_ratio);
> +
> +/* Enable/Disable EPIC serial interrupt mode */
> +void mpic_set_serial_int(struct mpic *mpic, int enable);
> +
>  /* global mpic for pSeries */
>  extern struct mpic *pSeries_mpic;
>  
