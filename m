Message-ID: <3EE71F77.80200@Jaluna.COM>
Date: Wed, 11 Jun 2003 14:24:23 +0200
From: eric lescouet <eric.lescouet@Jaluna.COM>
MIME-Version: 1.0
To: Kent Borg <kentborg@borg.org>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Why ack interrupt before calling handler?
References: <20030606142939.B15725@borg.org> <1055327622.26152.70.camel@spawn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kent,

The acq_irq() routine called at the beginning of ppc_irq_dispatch_handler() is
mapped to the associated routine of the PIC driver that handles the irq.
Typically such routine would mask the interrupt source at PIC level, than
acknowledge the PIC in some way, if required (any kind of EOI).
This would prevent a level triggered interrupt to be raised again when enabling
interrupts at processor level, until the called handler clear the interrupt
condition on the device.
The, the interrupt source unmasked after processing by the handler.

Any way, note that these routines called from irq.c are PIC driver specific,
thus allowing such drivers to implement different policies depending on the
underlaying hardware capabilities:
- edge vs level triggered interrupts,
- relative priority schemes,
- "in service" interrupt management internal capability, or required explicit
masking (of currently in service interrupt).
... etc

Regards,

	Eric Lescouet.

Kenneth Johansson wrote:
> On Fri, 2003-06-06 at 20:29, Kent Borg wrote:
>
>>I am confused by something in ppc_irq_dispatch_handler().  It looks to
>>me that the interrupt is ack-ed before the handler is called.  Maybe I
>>am misunderstanding, but doesn't the ack only reset the interrupt
>>controller?  If so, the interrupting hardware could still be
>>presenting a level-triggered interrupt.  Wouldn't it make more sense
>>to let the interrupt routine get service the hardware first, then
>>reset the interrupt controller?
>>
>
>
> I don't know what code you are looking at but generally you want to
> first ack to avoid the race condition that would otherwise be present if
> you first run your interrupt routine then ack. How would you know that
> it was in fact not a new interrupt condition that you have not taken
> care of you just removed.
>
> ps. and never ever use edge triggered interrupts


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
