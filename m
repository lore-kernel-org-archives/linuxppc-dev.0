In-Reply-To: <199901062322.KAA00858@tango.anu.edu.au>
Date: Thu, 7 Jan 1999 10:11:37 +0100
To: linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Strange PMAC IDE performance problem
Message-Id: <19990107101137.025655@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 7, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:

>It's usually the instruction that reenables interrupts globally, after
>we have disabled the particular interrupt we are servicing.  I think
>what happens is this: we write to the interrupt controller enable
>register to disable the interrupt.  This write percolates through the
>PCI bridge down into the gc/ohare/heathrow/whatever chip, and some
>time later that chip will negate the interrupt request signal
>(assuming there are no other enabled interrupts).  In the meantime the
>CPU has been proceeding from the write to the instruction where it
>reenables interrupts (by putting a new value in the MSR).  If the CPU
>gets there first, you can get a bogus interrupt.
>
>I put in a sync instruction after the write to make the cpu wait at
>least until the pci bridge has acknowledged the write.  That helps on
>many machines but isn't sufficient on some.  Reading a register in the
>interrupt controller should help, especially if there was an eieio
>between the read and the write.  (The eieio goes out onto the system
>bus and should therefore be seen by the PCI host bridge.  Whether the
>bridge honors it by not allowing subsequent reads to bypass previous
>writes is another question. :-)

I discussed this with Cort not so long ago, since in theory, the write to
the ack register could still be in the bridge when you re-enable EE,
regardless of the sync (posted writes are always handled async by the
bridge, and I don't see why sync would sync anything with the PCI bridge,
at least not with an ordinary bridge but maybe Grackle has some
PPC-specific features here). I suggest adding a read from the controller
(with it's eieio) anyway. This will ensure that all bridges on the path
to the interrupt controller have been flushed (at least according to PCI
standard). A bridge that allow a read to bypass a previous write is
definitely a broken bridge (do you know one ?)

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
