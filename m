Date: Tue, 26 Mar 2002 13:05:40 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: <benh@kernel.crashing.org>
Cc: Val Henson <val@nmt.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
In-Reply-To: <20020326101419.26730@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.33.0203261249210.26486-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 26 Mar 2002 benh@kernel.crashing.org wrote:

> Also, a set BI_DEV_TYPE_PCI with just a BI_IRQ_NUMBER
> (no indication of the device class/name) can also be used
> to provide the PCI interrupt routing for PCI slots, though
> in this specific case, I'd prefer seeing the firmware fill
> the PCI_INTERRUPT_LINE register in the config space and the
> kernel retreive that.

Won't fly, this is a byte wide register and there are machines with more
than 256 interrupt lines. And they are even more likely with PCI 2.2+ so
called message passing interrupts, which is a simple way to admit that the
way of doing interrupts was so dumb that even (one physical PCB trace per
vector) the Cro-Magnon man would have done better

Basically, PCI is going to implement interrupts in the way similar to waht
VME/m68k (and even Z80) hardware have done for over 25 years. The
electrical details are different, but it is the device that puts the
interrupt vector on the bus, not some PIC (where P stands for
paleolithic) through a maze of PCB traces.

BTW, I don't even allow sharing VME interrupt vectors in my PCI<->VME
bridge driver, because I have something like 1792 (7*256) separately
identifiable interrupt sources.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
