Subject: Re: [PATCH] pmac_zilog.c: Fix break handling, add sysrq support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040806104328.GL11638@sunbeam2>
References: <20040806104328.GL11638@sunbeam2>
Content-Type: text/plain
Message-Id: <1091789077.5227.236.camel@gaston>
Mime-Version: 1.0
Date: Fri, 06 Aug 2004 20:44:38 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-08-06 at 20:43, Harald Welte wrote:
> Hi!
>
> This patch fixes the BREAK handling in pmac_zilog.c, and also adds
> support for SYSRQ via BREAK.
>
> Please note that I had to remove locking in pmz_consolw_write(), since
> it is called from handle_sysrq(), which is in turn called from
> pmz_receive_chars(), which is called from with the lock held...
>
> while trying to find out how other drivers handle this problem, I found
> out that sn_sal_console_write() has some elaborate code that tries to
> steal the lock, etc.

I noticed some locking bugs in other drivers too... it may be better to
drop the lock when calling handle_sysrq, no ?

> Either something like this is added, or the locking in pmac_zilog()
> needs to be reworked.  But that's of course the maintainers' job ;)
>
> Please consider kernel inclusion,

I'll have a look, thanks much.

Ben.

> 	Harald
>
> --- linux-2.6.8-rc3-plain/drivers/serial/pmac_zilog.c	2004-08-05 14:48:36.000000000 +0200
> +++ linux-2.6.8-rc3-hw1/drivers/serial/pmac_zilog.c	2004-08-06 14:37:17.003886152 +0200
> @@ -29,6 +29,10 @@
>   * along with this program; if not, write to the Free Software
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>   *
> + * 2004-08-06 Harald Welte <laforge@gnumonks.org>
> + *	- Enable BREAK interrupt
> + *	- Add support for sysreq
> + *
>   * TODO:   - Add DMA support
>   *         - Defer port shutdown to a few seconds after close
>   *         - maybe put something right into uap->clk_divisor
> @@ -53,6 +57,7 @@
>  #include <linux/slab.h>
>  #include <linux/adb.h>
>  #include <linux/pmu.h>
> +#include <linux/sysrq.h>
>  #include <asm/sections.h>
>  #include <asm/io.h>
>  #include <asm/irq.h>
> @@ -64,6 +69,10 @@
>  #include <asm/macio.h>
>  #include <asm/semaphore.h>
>
> +#if defined (CONFIG_SERIAL_PMACZILOG_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
> +#define SUPPORT_SYSRQ
> +#endif
> +
>  #include <linux/serial.h>
>  #include <linux/serial_core.h>
>
> @@ -259,8 +268,10 @@
>  		}
>
>  		ch &= uap->parity_mask;
> -		if (ch == 0 && uap->prev_status & BRK_ABRT)
> +		if (ch == 0 && uap->flags & PMACZILOG_FLAG_BREAK) {
> +			uap->flags &= ~PMACZILOG_FLAG_BREAK;
>  			r1 |= BRK_ABRT;
> +		}
>
>  		/* A real serial line, record the character and status.  */
>  		if (drop)
> @@ -273,6 +284,7 @@
>  		if (r1 & (PAR_ERR | Rx_OVR | CRC_ERR | BRK_ABRT)) {
>  			error = 1;
>  			if (r1 & BRK_ABRT) {
> +				printk(KERN_DEBUG "pmz:got break !\n");
>  				pmz_debug("pmz: got break !\n");
>  				r1 &= ~(PAR_ERR | CRC_ERR);
>  				uap->port.icount.brk++;
> @@ -364,6 +376,9 @@
>  		wake_up_interruptible(&uap->port.info->delta_msr_wait);
>  	}
>
> +	if (status & BRK_ABRT)
> +		uap->flags |= PMACZILOG_FLAG_BREAK;
> +
>  	uap->prev_status = status;
>  }
>
> @@ -872,8 +887,8 @@
>  	uap->curregs[R13] = 0;
>  	uap->curregs[R14] = BRENAB;
>
> -	/* Clear handshaking */
> -	uap->curregs[R15] = 0;
> +	/* Clear handshaking, enable BREAK interrupts */
> +	uap->curregs[R15] = BRKIE;
>
>  	/* Master interrupt enable */
>  	uap->curregs[R9] |= NV | MIE;
> @@ -1919,10 +1934,11 @@
>  static void pmz_console_write(struct console *con, const char *s, unsigned int count)
>  {
>  	struct uart_pmac_port *uap = &pmz_ports[con->index];
> -	unsigned long flags;
>  	int i;
>
> -	spin_lock_irqsave(&uap->port.lock, flags);
> +	/* Don't do any locking here, since we might get called from within
> +	 * sysreq() handling and already hold a lock.  Ideally we would need
> +	 * something like the 'steal lock' code in sn_sal_console_write -HW */
>
>  	/* Turn of interrupts and enable the transmitter. */
>  	write_zsreg(uap, R1, uap->curregs[1] & ~TxINT_ENAB);
> @@ -1943,8 +1959,6 @@
>  	/* Restore the values in the registers. */
>  	write_zsreg(uap, R1, uap->curregs[1]);
>  	/* Don't disable the transmitter. */
> -
> -	spin_unlock_irqrestore(&uap->port.lock, flags);
>  }
>
>  /*
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
