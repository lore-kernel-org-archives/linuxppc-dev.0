Message-ID: <3B4A0D54.8EB7B10E@aps.anl.gov>
Date: Mon, 09 Jul 2001 15:00:20 -0500
From: Andrew Johnson <anj@aps.anl.gov>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: James F Dougherty <jfd@GigabitNetworks.COM>,
	linuxppc-embedded@lists.linuxppc.org, cort@cs.nmt.edu
Subject: Re: ppc-linux EPIC (OpenPIC) and Interrupts on MPC8240
References: <200107062139.OAA14875@krakatoa.gigabitnetworks.com> <3B49F097.DABAF972@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James F Dougherty wrote:
>
> I am sure someone out there has had to deal with this issue before, so any
> pointers in the right direction would be greatly appreciated.

I have HHL2.0 (Linux-2.4.2) running on an MVME2100 board (MPC8240) which
only uses the interrupts on the built-in EPIC device, no 8259.  I don't
pretend to fully understand PCI interrupts, but I did discover that the
OpenPIC_InitSenses[] array is critical to getting interrupts to work, and
I also had to edit openpic.c to remove the 8259 stuff from
openpic_get_irq() in my configuration.  You're working with an earlier
version though, so YMMV.

The openpic driver gets the default number of IRQs from the register on
the EPIC chip to be 24, but these are not contiguous nor in their
canonical places, so you need to provide the InitSenses array to let it
know the real configuration.  I start with 16 zero entries as the first
EPIC IRQ is offset by 16, then provide up to 16 entries for the real
serial IRQ inputs to the EPIC.  The value you give to each entry
determines the polarity / edge-sensitivity; my setup needs 1 for PCI
devices, but 0 for the 16550 UART.  I'm not sure how you cope with the
large gap before the I2C and DMA IRQ numbers; it looks like openpic.c
needs modifying to properly cope with holes in the IRQ space, but it may
be that you can do this with a cannonicalize_irq() routine (I don't have
one, but I don't need the high IRQs and they're not essential for Linux to
run).

I discovered that even without serial interrupts working it was possible
to type commands to my init shell (mount /proc;cat /proc/interrupts was
very useful); you just have to wait up to 10 seconds for them to arrive,
and don't type more than will fill the FIFO; be prepared to wait a while
for the output to appear too!

- Andrew
--
The world is such a cheerful place when viewed from upside-down
It makes a rise of every fall, a smile of every frown

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
