Date: Tue, 16 Feb 1999 12:44:17 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: David Edelsohn <dje@watson.ibm.com>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: bootstrap stuffs 
In-Reply-To: <9902151757.AA75924@marc.watson.ibm.com>
Message-ID: <Pine.HPP.3.96.990216123042.1977B-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 15 Feb 1999, David Edelsohn wrote:

> 	As Gabriel correctly explained, a "sync" instruction may be
> necessary before interrupts are enabled if some off-chip operation, like
> modifying an interrupt controller on the bus, was performed.  That is
> because of the bus operations which need to complete before interrupts can
> be enabled, not because of the enabling itself.

Actually I have come to the conclusion that the best way to handle this is
to add a sync instruction in the mask/disable interrupt routines (the ones
that access the interrupt controllers), so that all following __cli/__sti
only need to access the MSR (for enable/unmask you don't care to
synchronize of course).

For a driver I'm writing, I've suppressed all references to
read/write[bwl] when accessing MMIO space because they include an eieio. 
I'm explicitly adding iobarrier() instead.

I would also like to see versions of in/out which do not have an implied
eieio so that you can control when/if you want to synchronize(sync), force
ordering and or prevent gathering (eieio), or don't care (nothing).

However, I have question about sync: how do the bridges handle a sync
bus operation after a posted write ? If they don't flush the write
queues, it means that the only solution for the 8259 is to read again the
interrupt mask after having written it when masking an interrupt. 

	Gabriel.

P.S: actually I might try a lot of these modifications once my driver
works and I have put my VME boards in operation at the telescope. But for
now I have no time.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
