Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id E6E2068229
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Sep 2005 05:27:42 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 9 Sep 2005 12:27:39 -0700
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050909192739.GA5171@xyzzy.farnsworth.org>
References: <1126287092.21092.14.camel@excalibur.timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1126287092.21092.14.camel@excalibur.timesys.com>
Subject: Re: Marvell MV64360 interrupt question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Sep 09, 2005 at 05:31:32PM +0000, Walter L. Wimer III wrote:
> I'm looking at arch/ppc/syslib/mv64360_pic.c in the 2.6.13 kernel and I
> see the following code:
> 
>     int
>     mv64360_get_irq(struct pt_regs *regs)
>     {
>         .
>         .
>         .
>         if (irq == -1) {
>             irq = mv64x60_read(&bh, MV64360_IC_MAIN_CAUSE_HI);
>             irq = __ilog2((irq & 0x1f0003f7) & ppc_cached_irq_mask[1]);
> 
>             if (irq == -1)
>                 irq = -2; /* bogus interrupt, should never happen */
>             else {
>                 if ((irq >= 24) && (irq < MV64x60_IRQ_DOORBELL)) {
>                     irq_gpp = mv64x60_read(&bh, MV64x60_GPP_INTR_CAUSE);
>                     irq_gpp = __ilog2(irq_gpp & ppc_cached_irq_mask[2]);
> 
>                     if (irq_gpp == -1)
>                         irq = -2;
>                     else {
>                         irq = irq_gpp + 64;
>                         mv64x60_write(&bh,
>                                       MV64x60_GPP_INTR_CAUSE,
>                                       (1 << (irq - 64)));

You dropped a ~ on the above line.  It confused me for a bit.

>                     }
>                 }
>                 else
> 		    irq += 32;
>             }
>         }
> 
>         (void)mv64x60_read(&bh, MV64x60_GPP_INTR_CAUSE);
>         .
>         .
>         .
>     }
> 
> Does anybody know what the last mv64x60_read() is intended to do?  It
> *looks* like it's clearing/acknowledging the interrupt, but I don't see
> anything in the Marvell documentation that suggests that *reading* the
> interrupt cause register has such an effect.  From my reading, the
> documentation says that you should write a '0' into the appropriate bit
> position to clear the interrupt.
> 
> Hmmm...  There's an mv64x60_write() a little earlier in the code...  Is
> the "extra" mv64x60_read() here to enforce ordering?  If so, should it
> be moved inside the "if" statement so that it's only executed when
> actually necessary?

Yes.  It's there to make sure that the clearing of the GPP interrupt
is seen by the hardware and takes effect before we return from the function.

> And what about locking?  The mv64x60_xxxx() functions are protected by a
> spinlock, but if we're trying to enforce ordering, shouldn't we hold the
> lock during the entire write+read operation, rather than dropping and
> reacquiring the lock in between?

No additional locking is necessary.  In fact, it seems to me that the 32-bit
register reads and writes are already atomic and all of the locking using
mv64x60_lock is superfluous.

> At the moment, I'm not running into any actual problems here; this just
> caught my eye and I started wondering about it.
> 
> BTW, the reason I'm looking at this code is that the board I'm working
> on has a cascaded interrupt controller (implemented in an FPGA) feeding
> into the MV64360 interrupt controller.  I'm thinking about adding a
> cascade mechanism to mv64360_pic.c similar to the one in the OpenPIC
> code (i.e. like the openpic_hookup_cascade() function).  Any opinions on
> whether this is a good idea or a bad one?

Sounds reasonable to me.

-Dale
