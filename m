Mime-Version: 1.0
Message-Id: <v04220800b4ecf4093730@[10.0.0.42]>
In-Reply-To: <Pine.GSO.4.05.10003081359150.17227-100000@ophelia.dogcow.org>
References: <Pine.GSO.4.05.10003081359150.17227-100000@ophelia.dogcow.org>
Date: Thu, 9 Mar 2000 00:53:34 -0800
To: Sean Harding <sharding@dogcow.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: compiler optimization? something else?
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:18 PM -0800 3/8/00, Sean Harding wrote:
>Obviously a 150MHz PPC workstation isn't going to keep
>up with a 12 proc 500MHz alpha server. But I find it hard to believe that
>it should be as far out of line as it is.
>
>(FWIW, another metric...It took 41 minutes to compile a kernel on the
>powermac. It took just over 6 minutes on my PII 350 desktop. The pentium
>was compressing an mp3 at the same time).

Kernel compiles depend on more than just the CPU.  Even if you have
enough RAM to avoid swapping, a fast disk does enhance compilation
times.  I believe it also ends up touching a lot of memory, so RAM
speed is important.

In fact, RAM access is an area where some of Apple's older machines
really look weak.  The original generation of PCI Macs (which almost
all the PCI Mac clones like yours were derived from) has pretty poor
memory performance.

For what it's worth, I just did a clean build of the kernel, and it
took about 8 minutes.  Here's the output of "time make":

real    8m11.447s
user    7m13.080s
sys     0m49.350s

Note the significant system (I/O) time.

This is on a 366 MHz beige G3 with 512K L2 cache, a 5400 RPM IDE
disk, and 192MB RAM.  It wasn't compressing an MP3 at the same time
though.  :)  Assuming the PII's time wouldn't improve enormously if
it were not doing the compression, we're probably within a factor of
2 here.  SPECint95 scores suggest that a G3 should generally be
slightly faster than a PII at the same clock rate, so this could
either be normal variation (SPEC doesn't perfectly predict
everything) or a case where performance isn't as good as it could be.


BTW, one thing which is different about RAM use between the two
platforms is that the PPC tends to use more of it -- PPC binaries are
significantly larger than x86.  This is architectural, not a compiler
problem; the PPC instruction set (like most general purpose 32-bit
RISCs) wasn't designed for high code density.  In fact, it's one of
the least dense (or most bloated, take your pick) architectures.  The
x86 was designed in an era when memory was a lot more precious, so
its binaries are fairly compact.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
