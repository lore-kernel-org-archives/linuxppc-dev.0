From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200201122139.g0CLdK5376343@saturn.cs.uml.edu>
Subject: Re: No cache control on ppc??
To: langausd@fachschaft.informatik.uni-stuttgart.de (Siggi Langauf)
Date: Sat, 12 Jan 2002 16:39:20 -0500 (EST)
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.21.0201121753510.11140-100000@darkwing.informatik.uni-stuttgart.de> from "Siggi Langauf" at Jan 12, 2002 06:10:42 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On i586 (or newer) machines with AGP, the X server can set some MTRR
> ranges. AFAIUI, these tell the (CPU-internal) cache controller not to
> cache video memory (which wouln't make any sense, as that is used
> write-only).

It would make sense. You could fill up cache lines in the CPU,
then force a write-out all at once. You could then free the
cache line for future use.

> I haven't found anything similar in powerpc kernels, so I assume
> there is nothing like this. Is that correct? If so, is that a
> hardware restriction? Does the hardware do this automagically?

Oh come on... You get:

1. 4 cache-control bits per page table entry
2. instructions to manipulate cache lines
3. prefetch instructions (on "G4" chips: MPC7400, MPC7410...)
4. some TLB control that might be useful
5. 8 data BAT registers, allowing 4 super-size (256 MB) pages
6. 64-bit FPU (and 128-bit AltiVec) registers for memory copy

BTW, some of the above is good for RAID, IP checksums...

The serious problem is Apple's crappy 100 MHz bus. You'll have a
hard time moving much beyond 700 MiB/s I think. Supercomputer? Not.
I'm getting 351 in plus 351 out with 16 doubles on a Mac Cube.

Another problem is lack of OS support. You can't set mmap()
flags to indicate: cached, coherency not enforced, unguarded,
and no writeback. This is what you need. It would be nice to
get the BAT registers too, since user space does a lot more
memory access than the kernel does.

I don't know very much about MPEG, but something like this
would be a reasonable plan I guess:

Get some nice memory to use. Maybe 32 MiB, BAT mapped, with
all the attributes mentioned above. Flush all the cache lines
out -- you MUST if you have non-coherent memory, and it's a
nice idea anyway. Repeat before every use of the memory.

Get your video data, using raw IO. You'd really be asking
for several frames ahead of course.

Bite off a small chunk of the image. Pulling a number out of
my ass, I'll say 128x128 pixels and 4 frames deep. This fits
nicely into my 1 MB L2 cache. Go with 64x64 for the MPC7410.

Prefetch your data. If you have AltiVec, use AltiVec prefetch.

Do the decryption on that little chunk. Do the various motion
compensation things and inter-frame stuff on that little chunk.
You can process this tile in multiple frames to get better
cache usage. That is, you are doing work for future frames.

Now you may either

a. write back your cache, then start video DMA + color transform
b. do color transform interleaved with writing to video memory

Scaling goes there too, if you must. You might limit scaling
to small integer ratios, and pad/crop as needed to reach the
exact size desired.

Assuming you don't use DMA: make sure the video memory has the
same attributes as everything else, and use explicit cache
write-back instructions to push out the data.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
