Date: Sun, 8 Aug 1999 22:52:58 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Michel Lanners <mlan@cpu.lu>
cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org, mj@ucw.cz
Subject: Re: Trying a Promise Ultra/66 on powerpc
In-Reply-To: <199908082000.WAA02943@piglet.cpu.lu>
Message-ID: <Pine.LNX.4.10.9908082252170.23564-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 8 Aug 1999, Michel Lanners wrote:
> On  29 Jul, this message from Benjamin Herrenschmidt echoed through cyberspace:
> > On Wed, Jul 28, 1999, Michel Lanners <mlan@cpu.lu> wrote:
> > 
> >>It seems that OpenFirmware is not doing its job well in initializing all
> >>PCI devices.For the planb driver, which uses an onboard PCI device
> >>(video input) known to OF (i.e Apple device), I need to set
> >>PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE. Or is
> >>it just a problem with IO space enabling, and memory is already
> >>switched on by OF?
> > 
> > OF will not enable memory space if there's no OF boot code on the board.
> > I beleive it doesn the same with IO space (but I didn't check). The lack
> > of PCI_COMMAND_INVALIDATE can be considered as an OF bug if the card
> > already has PCI_COMMAND_MASTER set as a default. I think the kernel
> > should add this to all devices at fixup time. (It should be harmless for
> > non-master devices anyway).
> 
> Right, according to 'Designing PCI cards and Drivers..', OF never
> enables neither memory space, nor IO space, neither ROM. It should,
> however, set both PCI_COMMAND_MASTER and PCI_COMMAND_INVALIDATE. I
> didn't chek, though...
> 
> I'm getting a patch ready that fixes this on the PMac plkatform. Geert,
> how about OF in your CHRP box? Does it need the enable fix as well?

Yep, my OF neither enables memory spaces on devices it doesn't have a driver
for. It even doesn't allocate space to them.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
