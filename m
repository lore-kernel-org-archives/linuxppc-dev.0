Date: Tue, 16 Feb 1999 18:39:38 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Rob Hagopian <hagopiar@vuser.vu.union.edu>,
        Peter De Schrijver <Peter.De_schrijver@alcatel.be>,
        Ulrik De Bie <winmute@kotnet.org>, David Edelsohn <dje@watson.ibm.com>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: bootstrap stuffs 
In-Reply-To: <Pine.LNX.4.03.9902161741290.20281-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.HPP.3.96.990216174706.1977L-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 16 Feb 1999, Geert Uytterhoeven wrote:

> > Actually I have come to the conclusion that the best way to handle this is
> > to add a sync instruction in the mask/disable interrupt routines (the ones
> > that access the interrupt controllers), so that all following __cli/__sti
> > only need to access the MSR (for enable/unmask you don't care to
> > synchronize of course).
> 
> Then do we need sync in the OpenPIC routines, too?

I think so. I would even say that you need to read again the OpenPIC
_Vector_Priority register when you mask an interrupt to make sure
that the interrupt has actually been masked. I don't see any problem 
with my Raven/Falcon right now because the OpenPIC is integrated with the
host bridge so there is actually no arbitration to access the register and
almost no write posting issue with a 603 which has at most 6 instructions
in flight (although the write buffers might delay the actual write for
quite some time). 

However, on the Hydra in the Longtrail, if the GG2 suppports write posting
(which is hopefully true), the delays between even the sync operation
on the bus and the actual update of the OpenPIC register might cause
strange side effects (I don't know how the GG2 reacts to a sync bus
operation on the 604). 

I think that some bridges are even allowed to reorder reads before posted
writes if the addresses do not match, but I should check the specs.
This is probably not possible with processors that do not run bus cycles
to signal the bridges on eieio and sync instructions (603 and 750).

So, if I'm not mistaken, a read from the same location is the only
operation that guarantees that the register has actually been updated, but
it's even slower than a sync :-(

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
