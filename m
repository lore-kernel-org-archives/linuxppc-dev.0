Date: Mon, 30 Oct 2000 13:50:17 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Heiko Jakob <buffalo@the7lg.de>
cc: Neil Russell <caret@c-side.com>, David Riley <oscar@the-rileys.net>,
        linuxppc-dev@lists.linuxppc.org,
        "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: PPC byte ordering
In-Reply-To: <003101bff189$9ac1f800$084da8c0@uranus>
Message-ID: <Pine.HPX.4.10.10010301329500.15431-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 19 Jul 2000, Heiko Jakob wrote:

> How do the linux-mips people handle with big- and  little-endian code ?
> Maybe they know a good solution, which allows both big- and little-endian
> code to execute.

They compiler the kernel and the apps for different endianness AFAICT.

> The PPC is big-endian by nature, and what for we do need little-endian code
> to be executed on a PPC ?

We don't need, especially since PPC endian switching is painful enough
that you don't want to switch endianness on the fly:

- the 601 uses a completely different, and much more complex method

- switching the processor is not sufficient if you want to access I/O due
to the "address munging" system used to give the impression of
little-endianness. The bridge also has to be reprogrammed, which is slow
and causes some problems with SMP when the two processors are runninng
with different byte orderings. Even a simple memory copy between two areas
use by different endianness process would have to mung/unmung the data,
even for simple text (or processes communicating through pipes...).

I have written an x86 emulator for ROM BIOSes, it is much easier to run it
in big endian and do byte swaps on every memory access (even the registers
are byte swapped in a memory image actually). Older processors will trap
on a 16 bit access at an odd address in LE mode, but lhbrx/sthbrx on an
odd address will work perfectly in BE mode. The BIOS does a lot of 16 bit
unaligned accesses due to its 8-bit 8088 origins, the emulator just does
not care, to the point that there is not a single alignment check in the
code (download it from ftp://vlab1.iram.es/pub/ if you are curious).

In short, the mixed endian capability of PPC is not good enough to be
effectively used. It would be a nightmare to try to use it. Make your life
simpler: forget about it.

If you absolutely want to do it, add minimal support to the kernel (wont't
be easy to support 601 though) and handle the rest as a userspace problem.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
