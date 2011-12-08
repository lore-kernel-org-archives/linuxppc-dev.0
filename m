Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 06C6C1007D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2011 14:17:27 +1100 (EST)
Message-ID: <1323314230.12793.18.camel@pasglop>
Subject: Re: [PATCH 01/16 v3] pmac_zilog: fix unexpected irq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Finn Thain <fthain@telegraphics.com.au>
Date: Thu, 08 Dec 2011 14:17:10 +1100
In-Reply-To: <alpine.LNX.2.00.1112071427280.28552@nippy.intranet>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
 <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
 <alpine.LNX.2.00.1112071427280.28552@nippy.intranet>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-m68k@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-12-07 at 14:49 +1100, Finn Thain wrote:
> On most 68k Macs the SCC IRQ is an autovector interrupt and cannot be 
> masked. This can be a problem when pmac_zilog starts up.

Thanks. I'll test it on a powermac or two and will merge it via the
powerpc -next tree if it works out allright.

Cheers,
Ben.
 

> For example, the serial debugging code in arch/m68k/kernel/head.S may be 
> used beforehand. It disables the SCC interrupts at the chip but doesn't 
> ack them. Then when a pmac_zilog port is used, the machine locks up with 
> "unexpected interrupt".
> 
> This can happen in pmz_shutdown() since the irq is freed before the 
> channel interrupts are disabled.
> 
> Fix this by clearing interrupt enable bits before the handler is 
> uninstalled. Also move the interrupt control bit flipping into a separate 
> pmz_interrupt_control() routine. Replace all instances of these operations 
> with calls to this routine. Omit the zssync() calls that seem to serve no 
> purpose.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Acked-by: Alan Cox <alan@linux.intel.com>
> 
> ---
>    
> Re-implemented as v2 using a simpler approach that avoids messing with the 
> Master Interrupt Enable bit. As well as the ifdef problem, it turns out 
> that v1 was not sufficient to entirely fix the problem.
> 
> v3 avoids needless changes to the logic and locking in the suspend and 
> shutdown code and tries to keep register writes closer to their original 
> sequence.
> 
> This patch has been tested on a PowerBook 520 but no PowerMacs yet.
> 
> 
> Index: linux-git/drivers/tty/serial/pmac_zilog.c
> ===================================================================
> --- linux-git.orig/drivers/tty/serial/pmac_zilog.c	2011-12-07 12:36:32.000000000 +1100
> +++ linux-git/drivers/tty/serial/pmac_zilog.c	2011-12-07 14:29:21.000000000 +1100
> @@ -216,6 +216,18 @@ static void pmz_maybe_update_regs(struct
>  	}
>  }
>  
> +static void pmz_interrupt_control(struct uart_pmac_port *uap, int enable)
> +{
> +	if (enable) {
> +		uap->curregs[1] |= INT_ALL_Rx | TxINT_ENAB;
> +		if (!ZS_IS_EXTCLK(uap))
> +			uap->curregs[1] |= EXT_INT_ENAB;
> +	} else {
> +		uap->curregs[1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
> +	}
> +	write_zsreg(uap, R1, uap->curregs[1]);
> +}
> +
>  static struct tty_struct *pmz_receive_chars(struct uart_pmac_port *uap)
>  {
>  	struct tty_struct *tty = NULL;
> @@ -339,9 +351,7 @@ static struct tty_struct *pmz_receive_ch
>  
>  	return tty;
>   flood:
> -	uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
> -	write_zsreg(uap, R1, uap->curregs[R1]);
> -	zssync(uap);
> +	pmz_interrupt_control(uap, 0);
>  	pmz_error("pmz: rx irq flood !\n");
>  	return tty;
>  }
> @@ -990,12 +1000,9 @@ static int pmz_startup(struct uart_port
>  	if (ZS_IS_IRDA(uap))
>  		pmz_irda_reset(uap);
>  
> -	/* Enable interrupts emission from the chip */
> +	/* Enable interrupt requests for the channel */
>  	spin_lock_irqsave(&port->lock, flags);
> -	uap->curregs[R1] |= INT_ALL_Rx | TxINT_ENAB;
> -	if (!ZS_IS_EXTCLK(uap))
> -		uap->curregs[R1] |= EXT_INT_ENAB;
> -	write_zsreg(uap, R1, uap->curregs[R1]);
> +	pmz_interrupt_control(uap, 1);
>  	spin_unlock_irqrestore(&port->lock, flags);
>  
>  	pmz_debug("pmz: startup() done.\n");
> @@ -1015,6 +1022,25 @@ static void pmz_shutdown(struct uart_por
>  
>  	mutex_lock(&pmz_irq_mutex);
>  
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	if (!ZS_IS_ASLEEP(uap)) {
> +		/* Disable interrupt requests for the channel */
> +		pmz_interrupt_control(uap, 0);
> +
> +		if (!ZS_IS_CONS(uap)) {
> +			/* Disable receiver and transmitter */
> +			uap->curregs[R3] &= ~RxENABLE;
> +			uap->curregs[R5] &= ~TxENABLE;
> +
> +			/* Disable break assertion */
> +			uap->curregs[R5] &= ~SND_BRK;
> +			pmz_maybe_update_regs(uap);
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
>  	/* Release interrupt handler */
>  	free_irq(uap->port.irq, uap);
>  
> @@ -1025,29 +1051,8 @@ static void pmz_shutdown(struct uart_por
>  	if (!ZS_IS_OPEN(uap->mate))
>  		pmz_get_port_A(uap)->flags &= ~PMACZILOG_FLAG_IS_IRQ_ON;
>  
> -	/* Disable interrupts */
> -	if (!ZS_IS_ASLEEP(uap)) {
> -		uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
> -		write_zsreg(uap, R1, uap->curregs[R1]);
> -		zssync(uap);
> -	}
> -
> -	if (ZS_IS_CONS(uap) || ZS_IS_ASLEEP(uap)) {
> -		spin_unlock_irqrestore(&port->lock, flags);
> -		mutex_unlock(&pmz_irq_mutex);
> -		return;
> -	}
> -
> -	/* Disable receiver and transmitter.  */
> -	uap->curregs[R3] &= ~RxENABLE;
> -	uap->curregs[R5] &= ~TxENABLE;
> -
> -	/* Disable all interrupts and BRK assertion.  */
> -	uap->curregs[R5] &= ~SND_BRK;
> -	pmz_maybe_update_regs(uap);
> -
> -	/* Shut the chip down */
> -	pmz_set_scc_power(uap, 0);
> +	if (!ZS_IS_ASLEEP(uap) && !ZS_IS_CONS(uap))
> +		pmz_set_scc_power(uap, 0);	/* Shut the chip down */
>  
>  	spin_unlock_irqrestore(&port->lock, flags);
>  
> @@ -1352,19 +1357,15 @@ static void pmz_set_termios(struct uart_
>  	spin_lock_irqsave(&port->lock, flags);	
>  
>  	/* Disable IRQs on the port */
> -	uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
> -	write_zsreg(uap, R1, uap->curregs[R1]);
> +	pmz_interrupt_control(uap, 0);
>  
>  	/* Setup new port configuration */
>  	__pmz_set_termios(port, termios, old);
>  
>  	/* Re-enable IRQs on the port */
> -	if (ZS_IS_OPEN(uap)) {
> -		uap->curregs[R1] |= INT_ALL_Rx | TxINT_ENAB;
> -		if (!ZS_IS_EXTCLK(uap))
> -			uap->curregs[R1] |= EXT_INT_ENAB;
> -		write_zsreg(uap, R1, uap->curregs[R1]);
> -	}
> +	if (ZS_IS_OPEN(uap))
> +		pmz_interrupt_control(uap, 1);
> +
>  	spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
> @@ -1671,14 +1672,17 @@ static int pmz_suspend(struct macio_dev
>  	spin_lock_irqsave(&uap->port.lock, flags);
>  
>  	if (ZS_IS_OPEN(uap) || ZS_IS_CONS(uap)) {
> -		/* Disable receiver and transmitter.  */
> +		/* Disable interrupt requests for the channel */
> +		pmz_interrupt_control(uap, 0);
> +
> +		/* Disable receiver and transmitter */
>  		uap->curregs[R3] &= ~RxENABLE;
>  		uap->curregs[R5] &= ~TxENABLE;
>  
> -		/* Disable all interrupts and BRK assertion.  */
> -		uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
> +		/* Disable break assertion */
>  		uap->curregs[R5] &= ~SND_BRK;
>  		pmz_load_zsregs(uap, uap->curregs);
> +
>  		uap->flags |= PMACZILOG_FLAG_IS_ASLEEP;
>  		mb();
>  	}
> @@ -1738,14 +1742,6 @@ static int pmz_resume(struct macio_dev *
>  	/* Take care of config that may have changed while asleep */
>  	__pmz_set_termios(&uap->port, &uap->termios_cache, NULL);
>  
> -	if (ZS_IS_OPEN(uap)) {
> -		/* Enable interrupts */		
> -		uap->curregs[R1] |= INT_ALL_Rx | TxINT_ENAB;
> -		if (!ZS_IS_EXTCLK(uap))
> -			uap->curregs[R1] |= EXT_INT_ENAB;
> -		write_zsreg(uap, R1, uap->curregs[R1]);
> -	}
> -
>  	spin_unlock_irqrestore(&uap->port.lock, flags);
>  
>  	if (ZS_IS_CONS(uap))
> @@ -1757,6 +1753,12 @@ static int pmz_resume(struct macio_dev *
>  		enable_irq(uap->port.irq);
>  	}
>  
> +	if (ZS_IS_OPEN(uap)) {
> +		spin_lock_irqsave(&uap->port.lock, flags);
> +		pmz_interrupt_control(uap, 1);
> +		spin_unlock_irqrestore(&uap->port.lock, flags);
> +	}
> +
>   bail:
>  	mutex_unlock(&state->port.mutex);
>  	mutex_unlock(&pmz_irq_mutex);
