Date: Tue, 10 Aug 1999 10:10:54 +1000
Message-Id: <199908100010.KAA19153@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: mlan@cpu.lu
CC: drow@false.org, mj@ucw.cz, linuxppc-dev@lists.linuxppc.org
In-reply-to: <199908092023.WAA00328@piglet.cpu.lu> (message from Michel
	Lanners on Mon, 9 Aug 1999 22:23:25 +0200 (CEST))
Subject: Re: Trying a Promise Ultra/66 on powerpc
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199908092023.WAA00328@piglet.cpu.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners <mlan@cpu.lu> wrote:

> I'd vote for making I/O ports a memory addresss like any other, and
> making sure drivers get this address right. See my other post for
> details..

The problem is, there are PCI device drivers which assume you can get
an address in I/O space from a PCI device (either directly from the
config-space base address registers or from the pci_dev struct) and
then just do inb and outb on that port address.  That's why inb/outb
add _IO_BASE to the port number.

One way might be to adjust the base addresses in all the pci_dev
structs and then make sure all drivers use the address from the
pci_dev struct rather than reading config space themselves.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
