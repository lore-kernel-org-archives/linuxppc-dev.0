Date: Tue, 11 Jan 2000 21:34:22 -0800 (PST)
From: Ted Merrill <ted@arraycomm.com>
To: Pai Chou <chou@ece.uci.edu>
cc: Linux PPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux for the Motorola Excimer board?
In-Reply-To: <Pine.SOL.4.05.10001100115420.20562-100000@malibu.ece.uci.edu>
Message-ID: <Pine.SOL.4.21.0001111952200.23784-100000@eunice.arraycomm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Since i haven't seen anyone else respond, i'll venture a reply.
Someone with more experience, please flame or correct me as required.
There are lots and lots of boards and computer systems out there,
a lucky few of which can be configured in the standard linux kernel.
Yours is not one of them i guess...
If you want to port to a new board, it is not a straight-forward matter,
even if there are already drivers for all the chips on the board.

For example, i have been fooling around in my spare time to port
linux to a custom board using a PowerPC 603e,
a MPC106 PCI Bridge/Controller, a Signetics s2681 serial chip,
and a DEC 21040-PCI ethernet controller.
The last two parts would probably not be used for a new design i guess,
i.e. there a little on the obsolete side.

Support for the 603e is the simplest. 
Select the power pc processor family by 
modifying the line in the Makefile to read ARCH =ppc,
and select 6xx architecture when doing make config.
Don't forget to configure the cross-compiler in Makefile also.
Compiling the cross compiler isn't too bad really once you figure
out a few secrets such as exactly what target string to use.
The magic target string is "powerpc-anything-linux-gnu" .
I've been using gcc as a cross compiler for years, and every time
i have to do it for a new architecture, it is always a wild guess
as to what to use.
But after that it usually goes pretty well, especially if you do 
"make -k" to ignore errors in making auxillary code i really didn't
want anyway.
And if you have any need to move the location where you installed
gcc (as i do... we have version control to worry about) then
it is possible to write a front end that will drive gcc to find all
its components in the new place.
Once running, gcc is almost faultless.
For the two cases where i did benchmark comparisons with competive
compilers, the code gcc produced was not quite as tight the very best
compiler... in one case the difference mattered (we were very tight
on cycles) but in the other case the estimated 10% difference really
was not important.

In the linux kernel source code,
there appears to be some redundant code for the mpc106 for different
board types; as i'll explain below, board types are a pain.
It is hard to figure out what these codes for the mpc106 are doing.
Typically a controller like this is initialized in some sort of "boot bios"
code and the linux code kind of builds on top of that i guess... ? 
i'm sure enough hours of careful thought and scholarship and
just plain hacking around will get me somewhere. Eventually.
I happen to know that this chip was once known as the "grackle"
and sure enough there are comments about grackle here and there.
This is a common problem; the same or compatible chip can be called
by various names (or you can use a driver for a similar chip with
a different name, etc.).
How i would love to see a summary description of all known names 
in this realm, with cross references to all aliases, work-alikes, etc. !

Re. the s2681 uart chip, grepping around in "linux/drivers/char/*.c"
shows that istallion.c has "port information" for "2681".
So probably this driver supports the chip; problem is it probably only
supports it in the context of some particular board.
The header of the file gives all of five words of description of
what this driver is for -- "stallion intelligent multiport serial driver".
But this is more informative than some.
Some clue as to what Stallion is can be deduced by looking at the
copyright below; Copyright ...by... Stallion Technologies.
A good guess would be that this driver is for a multiport serial >>board<< .
A few comments in the code talk a little of outb(), ISA, EISA etc... this
code probably only runs on x86 PCs.
Well, anyway, i've written serial drivers for real-time o.s.'s before
and they were pretty easy... how hard could be it be to write one
from scratch for linux?
Of course, i should search harder first; probably the s2681 is a work-alike
to something else which might even have a driver usable with a powerpc...
Time for a web search. Well, if the s2681 is the same as an mc2681
(also a uart chip) then another name is the mc68681 ... hmmm,
grep doesn't find anything in linux/drivers/char/*.c for 68681 .
Well, so i spend the happy hours searching for clues.
I should just write this driver from scratch i guess; good educational
experience.

I happened to pick up somewhere that the DEC 21040 ethernet chip
is sometimes called a "tulip".
Either way, i have a win because linux/drivers/net/tulip.c has lots
of documentation in it (with both the words "tulip" and "21040" appearing) ! 
This is clearly a welcome break... Donald Becker, you are my hero!
There is even a website to look at... and it is alive!
The documentation gives a strong hint at the dependencies upon the generic
PCI software and the system BIOS for setting up the PCI...
now if i can get the pci working right ... 

Regarding board types.
When i do "make xconfig" or similar, choosing any of the supported
boards/systems is something of a loser.
It is a mystery to me how to add another board to the config menu,
(or if i add it to the config menu, so what?)
so i took the easy way of running "make xconfig"
and selecting a board that sounded kind of similar; the "gemini" board.
Exactly how "make xconfig" works is pretty confusing, but at
least it eventually became clear that it generates ".config" (which is included
into the Makefile) and "include/linux/autoconf.h" (which is included
into lots and lots of source code).
(I did look for documentation on this... sigh).
Despite my attempts to deselect almost everything in "make xconfig",
i had to manually deselect things in ".config" and "include/linux/autoconf.h"
because it was still pulling code for things like floppy disk controllers
(or whatever it was... i need to keep better notes).
I then made extensive modifications to arch/ppc/kernel/head.S,
arch/ppc/kernel/setup.c, linux/ppc/kernel/irq.c, linux/arch/ppc/mm/init.c,
and various other files, trying to imitate the
code for various boards while doing something that made sense for my board...
not an easy matter to see what the intent of the code is.
I'm not even trying to get PCI working yet... if i could get
something simple with just a serial line, i'd be happy for a moment.
One helpful advice i got from someone was to write a very simple uart
output routine to output diagnostics while booting; 
i hooked this into printk and i can see some early printk messages.
At the moment it is dying in linux/ppc/kernel/mm/mem_pieces.c ,
apparently i haven't initialized things properly.

I am sure (?) that if i could devote myself full time to this that
i would have working code by now. Or soon. 
And i am sure getting quite an education.

In my dreams, the linux kernel will become well documented and
better modularized. 
Currently, it is merely at par with average commercial software.
I believe it has a great future...
for the moment, prepare to be determined.

Ted Merrill
ArrayComm, Inc.



On Mon, 10 Jan 2000, Pai Chou wrote:

> 
> Hello from a new subscriber,
> 
> I'm looking for a minimal version for the Motorola Excimer board
> (http://www.mot.com/SPS/PowerPC/teksupport/teklibrary/excimer.html)
> 	PowerPC 603e, 1MB SRAM, 4MB Flash, 2 serial ports, COP connector,
> 	Berg I/O, DINK monitor on flash, no Ethernet
> 
> I'm hoping to get a stripped down version like uCLinux but with TCP/IP
> (over PPP) and a few useful things like telnetd, httpd, etc.  I got the
> i960 port as a starting point and trying to patch it with the latest
> embedded LinuxPPC sources, but the source trees are pretty different.
> 
> Thanks,
> --
> Pai H. Chou, Assistant Professor                    email chou@ece.uci.edu
> Electrical & Computer Engineering, UC Irvine        phone (949) 824-3229
> Irvine, CA 92697-2625, USA                          fax   (949) 824-3203
> 
> 
> 


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
