Message-ID: <384248F0.751F2136@agelectronics.co.uk>
Date: Mon, 29 Nov 1999 09:35:44 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Jonathan Brauer <brauer@texmemsys.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: New port
References: <199911270059.SAA07621@sun92.texmemsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jonathan Brauer wrote:
> 
> I am looking on information on porting linux to a new ppc platform.  The short
> version of my efforts are to port linux to a custom 603 sbc. 
> Essentialy from this my questions would be
> 1.  Is there a correct mode to start running head.S in (ie. translation on/off?)

Off is better.

> 2.  Where should the stack be started at?

Anywhere there's room (eg. top of memory). The stack will be moved by
the kernel once it know what memory it has.

> 3.  Where should the code be downloaded to?

Ideally physical address 0 (virtual address c0000000), but it should
relocate itself.

> 4.  Is an uncompressed kernel better than a compressed one?

Yes. An uncompressed kernel is a normal ELF file.

> 5.  If we load the kernel at address 0, should we change KERNELBASE?

Physical 0, virtual c0000000. Don't touch KERNELBASE.

> 6.  It appears that after kludging up to identify machine we tend to die.

You need to add your own machine type, by using an existing one as
example. As your board is probably weird, I'd suggest basing your port
on something else weird, like the APUS.

> 7.  Enabling the caching seems to throw us for a loop as well.

Remember that you can't do memory mapped IO between the point where
caches are enabled and when Linux enables memory translation. This is
actually a very long time, and a complicated code path.

> 8.  What values does the kernel assume are passed in by a boot loader and how?

Different for each machine type. Define your own, and pass them in.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
