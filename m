Date: Thu, 7 Jan 1999 10:22:58 +1100
Message-Id: <199901062322.KAA00858@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990106110256.031920@mail.mipsys.com> (message from Benjamin
	Herrenschmidt on Wed, 6 Jan 1999 11:02:56 +0100)
Subject: Re: Strange PMAC IDE performance problem
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <19990106110256.031920@mail.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <bh40@calva.net> wrote:

> By curiousity, did someone tried to locate the exact instruction in
> do_IRQ when those bogus interrupt happens ? Looks it's always the same...

It's usually the instruction that reenables interrupts globally, after
we have disabled the particular interrupt we are servicing.  I think
what happens is this: we write to the interrupt controller enable
register to disable the interrupt.  This write percolates through the
PCI bridge down into the gc/ohare/heathrow/whatever chip, and some
time later that chip will negate the interrupt request signal
(assuming there are no other enabled interrupts).  In the meantime the
CPU has been proceeding from the write to the instruction where it
reenables interrupts (by putting a new value in the MSR).  If the CPU
gets there first, you can get a bogus interrupt.

I put in a sync instruction after the write to make the cpu wait at
least until the pci bridge has acknowledged the write.  That helps on
many machines but isn't sufficient on some.  Reading a register in the
interrupt controller should help, especially if there was an eieio
between the read and the write.  (The eieio goes out onto the system
bus and should therefore be seen by the PCI host bridge.  Whether the
bridge honors it by not allowing subsequent reads to bypass previous
writes is another question. :-)

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
