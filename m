From: ghannon@cspi.com
To: "???" <ksshin@essetel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <85256D8F.004ABAE9.00@pine.cspi.com>
Date: Wed, 27 Aug 2003 09:38:13 -0400
Subject: Re: interrupt handling in 7410+64260
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> 2. request_irq(77, ...)
>    77 means bit 15 of GPP_INTERRUPT_CAUSE register.

There is an offset of 64, try 79 vs 77 to get bit 15.

"???" <ksshin@essetel.com> on 08/27/2003 12:23:55 AM

I use 2.4.18 kernel from montavista.
I set MPP_CNTL_x reigster as gpp,
 GPP_IO_CNTL as input, GPP_LEVEL_CNTL as active low
after that, I call request_irq(irq_num, ...); function.

when I call request_irq(), I try two type.
1. request_irq(57, ...)
   57 means bit 25 of MAIN_INTERRUPT_CAUSE register.
2. request_irq(77, ...)
   77 means bit 15 of GPP_INTERRUPT_CAUSE register.

in case of 1.
when interrupt is occurred, then kernel is dead. and no message
is printed.

in case of 2.
when interrupt is occurred, but nothing is happened and also
bit 25 of MAIN_INTERRUPT_MASK_HI is not set.
also try to set that bit, but not setted...

In Linux kernel, there is a example about handling internal
interrupt(mpsc as serial, ethernet), but I can't find the example for
about handling external interrupt with GPP.

Is there anyone who know that how to handle the external interrupt
with GPP in 7410/64260?

----- Original Message -----
From: "Paul White" <pwhite@bivio.net>
Sent: Wednesday, August 27, 2003 12:18 PM
Subject: Re: interrupt handling in 7410+64260

> Its been a little while since I've looked at the GT64260 manual, but I
> believe you configure the MPP pins as interrupt pins. These then are
> masked/seen via the GPP_INTR_CAUSE (0xf108) and GPP_INTR_MASK (0xf10c)
> registers. Then, I believe that somewhere in the CPU's mask, you can
> enable/disable the GPP/MPP interrupts.
>
> This is what I recall from memory, but hopefully it'll get you
> started.

> On Wed, 27 Aug 2003, [ks_c_5601-1987]
> >
> > I have a custom MPC7410 + GT64260 board and I successfully ported
> > linux to that board. Now, I am trying to handle the mii interrupt.
> > The MII INT Line is connected to MPP 14, 15. How to handle that
> > interrupt or where I can find out the example for external interrupt
> > with MPP

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
