Date: Sat, 19 Jun 1999 01:40:16 -0500 (CDT)
From: Troy Benjegerdes <hozer@drgw.net>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: weird glibc bug?? (#0  0x153b94c in strlen () at soinit.c:59)
In-Reply-To: <376B356B.8645613@wanadoo.fr>
Message-ID: <Pine.LNX.4.04.9906190138300.26671-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 19 Jun 1999, Martin Costabel wrote:

> Could this be an egcs bug? When i reported a similar bug (lines #0 and
> #1 in the gdb output were the same) where gnuplot was segfaulting, Franz
> Sirl and the others found out that it was related to the varargs bug in
> egcs. Have a look at the linuxppc-dev archives from around April 15.
> There should be a fix for this in egcs-1.1.2-1c.

I doubt it, as I compiled with egcs-1.1.2-12e. It might be possible that a
shared lib the program is linked with was compiled with a bad egcs, but I
doubt it.

> 
> According to the sources at http://gate.crashing.org/, the "official"
> varargs fix is included in egcs-1.1.2-1e which I managed to compile from
> the spec and patch files found at that site. And of course, gcc-2.95 is
> probably fixed, too.
> 
> Hope this helps
> 
> --
> Martin
> 
> Troy Benjegerdes wrote:
> > 
> > I am completely and totally stumped.
> > 
> > I have been seeing various programs (everthing from the installer to scp
> > to apache) that have seemingly inexplicable segfaults since at least the
> > first glibc-2.1 was out (6 months ago?)
> > 
> > At first I thought this had been caused by a bug in 'strip', since a new
> > binutils fixed the problem.
> > 
> > this problem seems to have resurfaced again in recent glibc's.
> > 
> > in it's current incarnation, scp is segfaulting, and when I use gdb, I get
> > the following backtrace:
> > 
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x153b94c in strlen () at soinit.c:59
> > soinit.c:59: No such file or directory.
> > (gdb) bt
> > #0  0x153b94c in strlen () at soinit.c:59
> > #1  0x151fda4 in _IO_vfprintf () at vfprintf.c:1554
> > #2  0x1523304 in buffered_vfprintf (s=0x15fd118, format=0x18047e0 "%s:
> > %s",
> >     args=0x7ffff1f0) at vfprintf.c:1747
> > #3  0x151e2f4 in _IO_vfprintf () at vfprintf.c:1554
> > #4  0x1803d4c in _SDA2_BASE_ ()
> > #5  0x18039dc in _SDA2_BASE_ ()
> > #6  0x18022ac in _SDA2_BASE_ ()
> > #7  0x1801ac4 in _SDA2_BASE_ ()
> > #8  0x14fd7d4 in __libc_start_main () at ../sysdeps/powerpc/elf/libc-sta
> > 
> > So, my first thought was that strip was buggy again, so I built scp and
> > didn't strip it.
> > 
> > It still segfaults when run from the command line. But it gets more
> > interesting: When run from gdb, the unstripped binary *doesn't* segfault!!
> > 
> > It seems as though depending on where things are aligned in memory either
> > triggers or masks the problem. I have heard a report that apache works
> > fine when built with '-g', and segfaults with a screwed up stack when not.
> > (this normally isn't noticeable with apache, since it occurs when
> > returning a 'page not found' error)
> > 
> > Someone please tell me I haven't gone of the deep end on this :-/
> > 
> > --------------------------------------------------------------------------
> > | Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
> > |    Unix is user friendly... You just have to be friendly to it first.  |
> > | This message composed with 100% free software.    http://www.gnu.org   |
> > --------------------------------------------------------------------------
> 
> 

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
