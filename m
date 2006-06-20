Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] mpic: add support for serial mode interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060619200811.GA15524@mag.az.mvista.com>
References: <20060619200811.GA15524@mag.az.mvista.com>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 14:01:26 +1000
Message-Id: <1150776086.23600.329.camel@localhost.localdomain>
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

On Mon, 2006-06-19 at 13:08 -0700, Mark A. Greer wrote:
> MPC10x-style interrupt controllers have a serial mode that allows
> several interrupts to be clocked in through one INT signal.
> 
> This patch adds the software support for that mode.

You hard code the clock ratio... why not add a separate call to be
called after mpic_init,
something like mpic_set_serial_int(int mpic, int enable, int
clock_ratio) ?

Ben.

> Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> --
> 
>  arch/powerpc/sysdev/mpic.c |    6 ++++++
>  include/asm-powerpc/mpic.h |    2 ++
>  2 files changed, 8 insertions(+)
> --
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 7dcdfcb..1829aed 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -629,6 +629,12 @@ #endif /* CONFIG_SMP */
>  			mb();
>  	}
>  
> +	/* For serial interrupts & set clock ratio */
> +	if (flags & MPIC_SERIAL_MODE)
> +		mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1,
> +			mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1)
> +				| (1<<27) | (0x7<<28));
> +
>  	/* Read feature register, calculate num CPUs and, for non-ISU
>  	 * MPICs, num sources as well. On ISU MPICs, sources are counted
>  	 * as ISUs are added
> diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
> index 6b9e781..f35ccdc 100644
> --- a/include/asm-powerpc/mpic.h
> +++ b/include/asm-powerpc/mpic.h
> @@ -186,6 +186,8 @@ #define MPIC_BROKEN_U3			0x00000004
>  #define MPIC_BROKEN_IPI			0x00000008
>  /* MPIC wants a reset */
>  #define MPIC_WANTS_RESET		0x00000010
> +/* MPIC serial mode */
> +#define MPIC_SERIAL_MODE		0x00000020
>  
>  /* Allocate the controller structure and setup the linux irq descs
>   * for the range if interrupts passed in. No HW initialization is
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
