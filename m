Date: Thu, 29 Jul 1999 11:16:32 +0200
To: mlan@cpu.lu
CC: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Trying a Promise Ultra/66 on powerpc
Message-Id: <19990729111632.009845@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 28, 1999, Michel Lanners <mlan@cpu.lu> wrote:

>It seems that OpenFirmware is not doing its job well in initializing all
>PCI devices.For the planb driver, which uses an onboard PCI device
>(video input) known to OF (i.e Apple device), I need to set
>PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE. Or is
>it just a problem with IO space enabling, and memory is already
>switched on by OF?

OF will not enable memory space if there's no OF boot code on the board.
I beleive it doesn the same with IO space (but I didn't check). The lack
of PCI_COMMAND_INVALIDATE can be considered as an OF bug if the card
already has PCI_COMMAND_MASTER set as a default. I think the kernel
should add this to all devices at fixup time. (It should be harmless for
non-master devices anyway).

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
