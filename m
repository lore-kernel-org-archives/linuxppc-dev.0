Message-ID: <3D12ACFA.1070005@embeddededge.com>
Date: Fri, 21 Jun 2002 00:35:06 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Andy Lowe <andy_lowe@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH and RFC] Remove request_8xxirq
References: <DIEAKNAFAEAMABGFAOOKCEIKDIAA.andy_lowe@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Andy Lowe wrote:

> .... My motivation for doing this in the first place was to
> make request_irq() work ....

Any 8xx that included a PCI configuration had request_irq() defined.
One of the things Wolfgang did was to map callers of request_irq() to
interrupts that made sense on a particular hardware design.  That is
the only change that should have been necessary.  None of the other
changes, especially to change all of the other irq requests to call
request_irq() were necessary.

> ..... but if it came down to it I would
> prefer to stick a #ifdef in an ISA device driver to hardcode a different IRQ
> vector than to stick a #ifdef in every PCI and PCMCIA device driver to make
> them call request_8xxirq or cpm_install_handler instead of request_irq.

The proper solution is to implement a request_irq() function that will
map interrupts properly for the board design, not modify everything to use
that function.  You can have a board design that connects the PCI interrupt
lines to GPIOs or external interrupt lines, and in that case request_irq()
would have to know what PCI interrupt numbers are used and would map them
to a CPM interrupt.  Along with that comes other special SIU configuration,
so it's uniqueness is quite evident.

This patch works for exactly one board design like the MBX, that uses an 8259
connected in a particular way for PCI interrupts.  It isn't a general solution
and may not work properly for the example I mentioned above.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
