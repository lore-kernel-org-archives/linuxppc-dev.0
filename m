Message-ID: <38964A23.3CAFFD88@zeta.org.au>
Date: Tue, 01 Feb 2000 13:51:15 +1100
From: Peter Allworth <linsol@zeta.org.au>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
CC: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Low memory problems in 8xx Linux
References: <kfy3drel1xy.fsf@kieraypc07.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Marcus Sundberg wrote:
>
> Hi,
>
> is anybody else experiencing severe problems when free memory gets low
> in Linux? And I'm not talking about _out of memory_, just simply low
> on RAM...

Marcus,

The answer is yes. I first noticed this problem on a proprietary
MPC860T board I've designed (and assumed the fault lay there) but
since then have been able to reproduce it on a Motorola TFADS.
(I've been working with Dan Malek's cllf-2.2.13.)

The good news is I'm pretty sure I have a fix. You've caught me in
the process of learning how to make an official contribution to the
Linux kernel.

Enough of that, on with the problem...

> Even with 96 MB swap on ATA flash, and 26MB of memory in the cache
> (ie not really in use), as soon as free pages hit the minimum limit
> the system will lock solid. This happens before any swap is starting
> to get used, and afterwards the system wont even answer to ping.
>
> At some occasions all processes (including init) will simply crash
> with an illegal instruction or segfault, and the kernel seems to
> live on.

Basically, there are a couple of bugs in the MMU code of the 8xx port.

First, the code assumes that the "write-protected" and "dirty"
attributes of a page can be folded into a single flag. Unfortunately,
when a process forks, the data pages are set up for copy-on-write in
both the parent and child processes so that they can be shared.
This is done by marking those pages "write-protected" which, in the
code as it stands, results in any "dirty" pages being set back to "clean".
Later, when the kernel is trying to free up memory, it wrongly assumes
these pages are unmodified and discards them!

My solution to this problem is as follows. In include/asm-ppc/pgtable.h,
rename 0x0100 (the page changed bit) as _PAGE_HWWRITE and 0x0020 (currently
the write-through cache bit) as _PAGE_DIRTY.
Unfortunately this means the write-through function is lost since there
are no more bits left so, for now, redefine _PAGE_WRITETHRU to be the
same as _PAGE_NO_CACHE. (This is a bit inefficient so the fix is only
temporary.)

The second thing I noticed which doesn't appear to be causing a problem
for now but that probably should be corrected anyway is that the
SET_PAGE_DIR macro should only update the M_TWB register when the destination
task (tsk) is the current one. The i386 implementation includes this check
since, I believe, not having it could result in the current task ending
up with the page directory of another task that is under construction.

I'll send you a patch for the file as soon as I've checked that there
aren't any other files that you need. (I've played around with a few
changes to the TLBMiss code but this is still experimental and doesn't
affect whether the kernel works or not.)

> This happens with kernels 2.2.5, 2.2.10, 2.2.12, 2.2.13, 2.2.14 and
> 2.2.15pre5 + Rik's boobytrap2 patch, on MBX, ADS, FADS, RPX Lite and
> custom boards. (2.2.12 and earlier based on Dan Malek's 2.2.5, 2.2.13
> and later based on his 2.2.13).

You've been busy. I can tell!

Patch file to follow (once I've built it).

Cheers,

PeterA.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
