Message-Id: <199908092015.WAA00324@piglet.cpu.lu>
Date: Mon, 9 Aug 1999 22:15:19 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying a Promise Ultra/66 on powerpc
To: bh40@calva.net
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990809085029.001336@smtp.calvacom.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi gentlemen (any ladies around?),

On   9 Aug, this message from Benjamin Herrenschmidt echoed through cyberspace:
> On Mon, Aug 9, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:
>>Basically the problem is that the IDE driver assumes that you access
>>all IDE controllers via I/O ports.  When you have a controller that
>>has memory-mapped registers, there is a problem.  When you have a
>>system where one IDE controller has I/O ports and another has memory-
>>mapped registers, you have a bigger problem.  The current approach to
>>solving this problem is to map the addresses of the memory-mapped
>>registers into pseudo I/O port numbers (by subtracting _IO_BASE).  If
>>there is a better way, somebody let me know. :-)
> 
> Looks like the best way would be to store the port base or pointers to
> the in/out functions in the HWIF structure.

How about fixing this in the kernel's PCI bus structures, by adding any
required offsets in the pci_fixup() routines? This would make for clean
inb()/outb() definitions (no offset), and also accomodates multiple I/O
spaces behind more than one bridge. For instance, on the 7x00, both
bandit and chaos have I/O space; the one for the PCI cards, the other
for control (yes, control has an I/O port range! Not sure it serves,
though...).

Any fixed-offset approach would break with multiple I/O ranges.... Not
to mention the 9x00 machines (two separate host bridges, each three
slots), where you can't work around the problem by using hardcoded
addresses for the known motherboard chips.

I guess this approach could be made to work across the PPC
architecture, not only on the PMac, as the PPC in general lacks anything
special about I/O space... after all, those are just small memory
spaces ;-)

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
