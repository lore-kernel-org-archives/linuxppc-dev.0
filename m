Message-Id: <200004111350.JAA25971@hoover.gilbarco.com>
From: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Cc: "Royal, Bill" <bill_royal@gilbarco.com>
Subject: Low Memory / Software Emulation Exception / Performance
Date: Tue, 11 Apr 2000 09:50:45 -0400
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just a few more questions.  After applying the head.S patch our software
emulation exceptions have gone away, although, I intend to go back and trip
the exception with a logic analyzer attached to verify everything with our
hardware engineer.  However, this patch seems to induce ultra-slow
performance in areas where we map physical memory down to the user-level
with /dev/mem, my guess is that it has something to do with this:

>From: Peter Allworth <linsol@zeta.org.au <mailto:linsol@zeta.org.au>>
>Basically, there are a couple of bugs in the MMU code of the 8xx port.
First, the code assumes that the "write-protected" and "dirty" >attributes
of a page can be folded into a single flag. Unfortunately, when a process
forks, the data pages are set up for copy-on-write in >both the parent and
child processes so that they can be shared. This is done by marking those
pages "write-protected" which, in the >code as it stands, results in any
"dirty" pages being set back to "clean". Later, when the kernel is trying to
free up memory, it wrongly >assumes these pages are unmodified and discards
them! My solution to this problem is as follows. In
include/asm-ppc/pgtable.h, >rename 0x0100 (the page changed bit) as
_PAGE_HWWRITE and 0x0020 (currently the write-through cache bit) as
_PAGE_DIRTY. >Unfortunately this means the write-through function is lost
since there are no more bits left so, for now, redefine _PAGE_WRITETHRU >to
be the same as _PAGE_NO_CACHE. (This is a bit inefficient so the fix is only
temporary.)
Specifically, the part regarding _PAGE_WRITETHRU being redefined to
_PAGE_NO_CACHE, is this a correct assumption?  Is anyone else running into
performance related issues with this patch applied?
Thanks,
Jason


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
