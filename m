Return-Path: <walt.wimer@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id C7F76681E8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Sep 2005 03:44:04 +1000 (EST)
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Fri, 09 Sep 2005 13:31:32 -0400
Message-Id: <1126287092.21092.14.camel@excalibur.timesys.com>
Mime-Version: 1.0
Subject: Marvell MV64360 interrupt question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi All,

I'm looking at arch/ppc/syslib/mv64360_pic.c in the 2.6.13 kernel and I
see the following code:

    int
    mv64360_get_irq(struct pt_regs *regs)
    {
        .
        .
        .
        if (irq == -1) {
            irq = mv64x60_read(&bh, MV64360_IC_MAIN_CAUSE_HI);
            irq = __ilog2((irq & 0x1f0003f7) & ppc_cached_irq_mask[1]);

            if (irq == -1)
                irq = -2; /* bogus interrupt, should never happen */
            else {
                if ((irq >= 24) && (irq < MV64x60_IRQ_DOORBELL)) {
                    irq_gpp = mv64x60_read(&bh, MV64x60_GPP_INTR_CAUSE);
                    irq_gpp = __ilog2(irq_gpp & ppc_cached_irq_mask[2]);

                    if (irq_gpp == -1)
                        irq = -2;
                    else {
                        irq = irq_gpp + 64;
                        mv64x60_write(&bh,
                                      MV64x60_GPP_INTR_CAUSE,
                                      (1 << (irq - 64)));
                    }
                }
                else
		    irq += 32;
            }
        }

        (void)mv64x60_read(&bh, MV64x60_GPP_INTR_CAUSE);
        .
        .
        .
    }

Does anybody know what the last mv64x60_read() is intended to do?  It
*looks* like it's clearing/acknowledging the interrupt, but I don't see
anything in the Marvell documentation that suggests that *reading* the
interrupt cause register has such an effect.  From my reading, the
documentation says that you should write a '0' into the appropriate bit
position to clear the interrupt.

Hmmm...  There's an mv64x60_write() a little earlier in the code...  Is
the "extra" mv64x60_read() here to enforce ordering?  If so, should it
be moved inside the "if" statement so that it's only executed when
actually necessary?

And what about locking?  The mv64x60_xxxx() functions are protected by a
spinlock, but if we're trying to enforce ordering, shouldn't we hold the
lock during the entire write+read operation, rather than dropping and
reacquiring the lock in between?


At the moment, I'm not running into any actual problems here; this just
caught my eye and I started wondering about it.

BTW, the reason I'm looking at this code is that the board I'm working
on has a cascaded interrupt controller (implemented in an FPGA) feeding
into the MV64360 interrupt controller.  I'm thinking about adding a
cascade mechanism to mv64360_pic.c similar to the one in the OpenPIC
code (i.e. like the openpic_hookup_cascade() function).  Any opinions on
whether this is a good idea or a bad one?



Thanks!!!

Walt
