Date: Fri, 18 Jun 1999 23:27:57 -0500 (CDT)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: weird glibc bug?? (#0  0x153b94c in strlen () at soinit.c:59)
Message-ID: <Pine.LNX.4.04.9906182316090.23583-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am completely and totally stumped.

I have been seeing various programs (everthing from the installer to scp
to apache) that have seemingly inexplicable segfaults since at least the
first glibc-2.1 was out (6 months ago?)

At first I thought this had been caused by a bug in 'strip', since a new
binutils fixed the problem.

this problem seems to have resurfaced again in recent glibc's.

in it's current incarnation, scp is segfaulting, and when I use gdb, I get
the following backtrace:

Program received signal SIGSEGV, Segmentation fault.
0x153b94c in strlen () at soinit.c:59
soinit.c:59: No such file or directory.
(gdb) bt
#0  0x153b94c in strlen () at soinit.c:59
#1  0x151fda4 in _IO_vfprintf () at vfprintf.c:1554
#2  0x1523304 in buffered_vfprintf (s=0x15fd118, format=0x18047e0 "%s:
%s",
    args=0x7ffff1f0) at vfprintf.c:1747
#3  0x151e2f4 in _IO_vfprintf () at vfprintf.c:1554
#4  0x1803d4c in _SDA2_BASE_ ()
#5  0x18039dc in _SDA2_BASE_ ()
#6  0x18022ac in _SDA2_BASE_ ()
#7  0x1801ac4 in _SDA2_BASE_ ()
#8  0x14fd7d4 in __libc_start_main () at ../sysdeps/powerpc/elf/libc-sta

So, my first thought was that strip was buggy again, so I built scp and
didn't strip it.

It still segfaults when run from the command line. But it gets more
interesting: When run from gdb, the unstripped binary *doesn't* segfault!!

It seems as though depending on where things are aligned in memory either
triggers or masks the problem. I have heard a report that apache works
fine when built with '-g', and segfaults with a screwed up stack when not.
(this normally isn't noticeable with apache, since it occurs when
returning a 'page not found' error)

Someone please tell me I haven't gone of the deep end on this :-/

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
