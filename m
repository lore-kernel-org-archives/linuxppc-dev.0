Message-Id: <199908201710.TAA00326@piglet.cpu.lu>
Date: Fri, 20 Aug 1999 19:10:32 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Various PMac PCI patches
To: ran@krazynet.com
cc: mj@ucw.cz, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990819233530.A138@gondolin.asf>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  19 Aug, this message from Ryan Nielsen echoed through cyberspace:
> Michel Lanners wrote:
>> > isa_io_base is set to the address of bus 0 !
>> > so inl() and friends use wrong address for cards on bus 1.
>> 
>> That's expected (and broken) behaviour right now; I know how to correct
>> the problem, but I need to do some hacking to get it coded right.
> 
> What are you plannering ?
> 
> I got tulip working by #define _IO_BASE DRIVER_IO_BASE (ifdef) in asm/io.h
> and define DRIVER_IO_BASE to a value from pci_io_base(bus) in tulip.c

Fixing IO space addresses in the kernel pci structs, so that any driver
referencing the pci structs gets the right kernel virtual address for
the  ports without fiddling with _IO_BASE. In fact, it means adding an
offset to the address reported in the PCI device's config registers.
This offset id provided by the parent bus bridge.

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
