Mime-Version: 1.0
Message-Id: <p05100304b7d00bd21d35@[10.0.0.42]>
In-Reply-To: <3BAA4F46.1020002@mc.com>
References: <20010920171002.37DCA2B54A@marcus.pants.nu>
 <3BAA363B.5010400@mc.com> <8xlmj9psnw.fsf@s62.informatik.uni-bremen.de>
 <3BAA4F46.1020002@mc.com>
Date: Thu, 20 Sep 2001 18:46:37 -0700
To: Mark Salisbury <mbs@mc.com>,
	Holger Bettag <hobold@Informatik.Uni-Bremen.DE>,
	linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: ppc LE questions (seeking help hand info pointers)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 4:19 PM -0400 9/20/01, Mark Salisbury wrote:
>Holger Bettag wrote:
>
>>  You are aware that a PPC in little endian mode is merely tricking with the
>>  low order address bits, but does not actually lay out its data in a little
>>  endian fashion in physical memory?
>
>not according to section 3.1 of the motorola ppc "green book"
>
>according to that it is a sort of munged le representation,

Nope.  Read section 3.1 very carefully.  Data in memory is still
organized in BE order.  Another reference: 9.3.2 in the MPC7400
manual.

The "munging" plays with low order address bits in an attempt to make
porting LE software easier.  When software tries to access a
multibyte data item with a granularity other than that native to the
data (e.g. a library routine for printing FP numbers which accesses
floats & doubles a byte at a time), it assumes either LE or BE
offsets within the larger data item.  Munging makes it possible to
run software that assumes LE internal offsets even though the
processor and memory layout are BE.

>which thanks to a "one trick pony" PCI bridge looks like standard LE to
>the PCI based  x86 host.

As a hardware guy, I recommend that (if you have not done so already)
you get with your hardware guys and make Really, Really Sure that the
PCI bridge actually can translate PPC pseudo-LE address munging to
real LE.  It will have to demunge/munge addresses that travel through
the bridge *and* swap bytes.

IMO, munging is likely to make your life (and that of all who use
your platform with munging turned on) harder rather than easier.

Actually, even just swapping in the bridge is likely to do that too,
unless you have enough control over when the bridge swaps to restrict
it to very specific things.  (e.g. if you can tell it "swap
everything in this address region with a granularity of 32 bits",
that's useful, but "swap everything" is likely to be a pain.)

>understand please that what I am proposing is a config option. as a
>sub-architecture port.  it would not affect any code that it didn't
>absolutely need to, and would only be compiled if sombody selected that
>particular config.

I don't think anybody had assumed otherwise, but the thing is that
given the way it works, PPC LE would require large changes in the
kernel tree regardless.  Linux has the infrastructure needed to
support LE and BE architectures, but has none for anything like PPC
LE mode.  I submit that the changes necessary are unlikely to be
accepted into standard trees, because it will uglify huge swaths of
code in order to support a CPU mode that can best be described as a
bizarre hack.

(Specifically: in order to support PPC-LE, all the hardware drivers
needed for your platform will need to be rewritten to be aware of
munging.  The alternative is to make the kernel run in regular BE
mode while some or all of userspace runs in the hack mode, but *that*
requires an astounding ugliness: a translation layer sitting between
the kernel and userland.)

I'm pretty certain PPC-LE would require modifications to the toolchain too.



Finally, Book E has been mentioned.  I read through the relevant
stuff and it looks to me like Book E PowerPC does offer a useful
feature: a TLB entry bit (bit 'E' for endian) which marks a page as
little endian.  The semantics are that a regular load/store whose
effective address lies inside a page with bit E set operates like a
byteswapping form of the same load/store instruction, and vice versa.
Advantage compared to simply using the byteswapping forms of the
instructions: you get the full range of load/store instructions
rather than just the subset that have explicit byteswapping variants,
and no use of assembly or funky compiler tricks is required when
writing code to access such a memory region.

Unfortunately, Book E does not guarantee that the 'E' TLB entry bit
is really supported in hardware: the CPU may have to take exceptions
to emulate it.  Even when hardware support is there, they still allow
for implementations that must take an exception to perform a static
mode switch whenever a page differing in endianness from the last
memory access is touched.

But so far as I can tell, the 750, 7400, 7450, etc. are not Book E
PowerPC, so the only thing they have is the MSR[LE] mode bit (address
munging).

Too bad this part of Book E wasn't in the architecture from the start...
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
