Date: Thu, 5 Feb 2004 19:08:05 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: MERRITT Nigel <Nigel.Merritt@tenix.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Interrupts on PPC 405Gr
Message-ID: <20040206030805.GA6578@gate.ebshome.net>
References: <200402060247.NAA20760@sprint.tenix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200402060247.NAA20760@sprint.tenix.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 06, 2004 at 01:47:28PM +1100, MERRITT Nigel wrote:
>
> I am using an IBM PowerPC 405Gr and have been trying to set up IRQ5 as an interrupt.
> My problem is that the UIC0_ER (interrupt enable) register is not being set by the request_irq call.
> Does anyone know of other calls that need to be made in order to allow the interrupt enable register to stay set?
> I have used enable_irq after request_irq but this also has no affect.  As this is from a driver,
> I have even tried setting the correct bit (bit 30 for IRQ 5) directly, by reading UIC0_ER, ORing
> bit 30 and writing the value back - reading and writing were performed using mfdcr and mtdcr.
> I also use mtmsr to set the general interrupt enable bit (EE - bit 16)) in the MSR register.
>

Please, don't touch MSR and UIC registers. request_irq should work
just fine (I never had problems with UIC on 405 boards).

Probably you are doing something completely wrong.

Some questions:

1) What kernel tree are you using?

2) Are you sure IRQ5 is actually _generated_ by your external device?
Did you use scope to verify this?

3) Are you sure IRQ5 is enabled in CPC0_CR0 register and not used as
GPIO? Are the polarity and trigger settings are correct for your
external device?

Please, provide more detailed info (with all registers values and/or
code samples) if you wanted somebody to help you.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
