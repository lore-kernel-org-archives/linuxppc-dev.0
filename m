Message-Id: <199908100538.HAA00316@piglet.cpu.lu>
Date: Tue, 10 Aug 1999 07:38:38 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying a Promise Ultra/66 on powerpc
To: Paul.Mackerras@cs.anu.edu.au
cc: paulus@cs.anu.edu.au, drow@false.org, mj@ucw.cz,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199908100010.KAA19153@tango.anu.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  10 Aug, this message from Paul Mackerras echoed through cyberspace:
> Michel Lanners <mlan@cpu.lu> wrote:
> 
>> I'd vote for making I/O ports a memory addresss like any other, and
>> making sure drivers get this address right. See my other post for
>> details..
> 
> The problem is, there are PCI device drivers which assume you can get
> an address in I/O space from a PCI device (either directly from the
> config-space base address registers or from the pci_dev struct) and
> then just do inb and outb on that port address.  That's why inb/outb
> add _IO_BASE to the port number.
> 
> One way might be to adjust the base addresses in all the pci_dev
> structs and then make sure all drivers use the address from the
> pci_dev struct rather than reading config space themselves.

Exactly what I meant. I feel drivers shouldn't read addresses directly
from config space, but rather from the pci_dev struct, so that any
necessary pcibios_fixup() can be made. By the way, the same is true for
interrupts....

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
