Date: Tue, 16 Feb 1999 17:43:14 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Gabriel Paubert <paubert@iram.es>,
        Rob Hagopian <hagopiar@vuser.vu.union.edu>,
        Peter De Schrijver <Peter.De_schrijver@alcatel.be>,
        Ulrik De Bie <winmute@kotnet.org>
cc: David Edelsohn <dje@watson.ibm.com>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: bootstrap stuffs 
In-Reply-To: <Pine.HPP.3.96.990216123042.1977B-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.03.9902161741290.20281-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 16 Feb 1999, Gabriel Paubert wrote:
> On Mon, 15 Feb 1999, David Edelsohn wrote:
> 
> > 	As Gabriel correctly explained, a "sync" instruction may be
> > necessary before interrupts are enabled if some off-chip operation, like
> > modifying an interrupt controller on the bus, was performed.  That is
> > because of the bus operations which need to complete before interrupts can
> > be enabled, not because of the enabling itself.
> 
> Actually I have come to the conclusion that the best way to handle this is
> to add a sync instruction in the mask/disable interrupt routines (the ones
> that access the interrupt controllers), so that all following __cli/__sti
> only need to access the MSR (for enable/unmask you don't care to
> synchronize of course).

Then do we need sync in the OpenPIC routines, too?

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
