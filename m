In-Reply-To: <199908100538.HAA00316@piglet.cpu.lu>
Date: Tue, 10 Aug 1999 10:45:03 +0200
To: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Trying a Promise Ultra/66 on powerpc
Message-Id: <19990810104503.021289@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 10, 1999, Michel Lanners <mlan@cpu.lu> wrote:

>Exactly what I meant. I feel drivers shouldn't read addresses directly
>from config space, but rather from the pci_dev struct, so that any
>necessary pcibios_fixup() can be made. By the way, the same is true for
>interrupts....

I fully agree with that, except that we should keep a way for a driver to
know which offset to apply, in case it really needs to go thru config
space hacks. (There are some exceptional cases where devices are
incorrectly mapped).

I beleive we should fixup this way both io addresses and interrupt
numbers. OF dev tree is great, but we should keep things coherent with
other archs, especially for generic PCI drivers.

Finally, the pci subsystem could export a couple of function to
re-allocate an i/o or memory range on a given bus (and return the
appropriate offset) for the few drivers that need to hack with their
original mappings.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
