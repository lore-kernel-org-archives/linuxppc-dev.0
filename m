Message-Id: <199908082000.WAA02943@piglet.cpu.lu>
Date: Sun, 8 Aug 1999 22:00:28 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying a Promise Ultra/66 on powerpc
To: bh40@calva.net
cc: linuxppc-dev@lists.linuxppc.org, mj@ucw.cz,
        Geert.Uytterhoeven@cs.kuleuven.ac.be
In-Reply-To: <19990729111632.009845@mail.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  29 Jul, this message from Benjamin Herrenschmidt echoed through cyberspace:
> On Wed, Jul 28, 1999, Michel Lanners <mlan@cpu.lu> wrote:
> 
>>It seems that OpenFirmware is not doing its job well in initializing all
>>PCI devices.For the planb driver, which uses an onboard PCI device
>>(video input) known to OF (i.e Apple device), I need to set
>>PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE. Or is
>>it just a problem with IO space enabling, and memory is already
>>switched on by OF?
> 
> OF will not enable memory space if there's no OF boot code on the board.
> I beleive it doesn the same with IO space (but I didn't check). The lack
> of PCI_COMMAND_INVALIDATE can be considered as an OF bug if the card
> already has PCI_COMMAND_MASTER set as a default. I think the kernel
> should add this to all devices at fixup time. (It should be harmless for
> non-master devices anyway).

Right, according to 'Designing PCI cards and Drivers..', OF never
enables neither memory space, nor IO space, neither ROM. It should,
however, set both PCI_COMMAND_MASTER and PCI_COMMAND_INVALIDATE. I
didn't chek, though...

I'm getting a patch ready that fixes this on the PMac plkatform. Geert,
how about OF in your CHRP box? Does it need the enable fix as well?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
