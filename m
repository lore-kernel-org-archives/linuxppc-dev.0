Date: Thu, 5 Feb 2004 22:43:49 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: MERRITT Nigel <Nigel.Merritt@tenix.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Interrupts on PPC 405Gr
Message-ID: <20040206064349.GA7205@gate.ebshome.net>
References: <200402060645.RAA20828@sprint.tenix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200402060645.RAA20828@sprint.tenix.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 06, 2004 at 05:45:17PM +1100, MERRITT Nigel wrote:
> When calling request_irq, the irq number had to be 30, which is the bit
> in the UIC0_ER register that needs setting.  I was passing it 5, which
> is the IRQ I wanted setting.  When I changed the IRQ number to 30 it
> worked!  I'm not sure if this is a screw up on my part for not passing
> the correct value in the first place, or an error in the Timesys kernel
> (surely the number passed in should be the IRQ required, not the bit
> position in the UIC registers).

It's your error, just think what you have to pass to request_irq if
you want to hook UART0 interrupt...

IRQ5 - is _external_ (to the chip) interrupt line and NOT an interrupt
number. _All_ UIC interrupts are external to the core (but not
all of them are IRQx lines).

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
