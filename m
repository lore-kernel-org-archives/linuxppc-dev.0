Date: Mon, 2 Dec 2002 18:53:47 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Samuel Rydh <samuel@ibrium.se>
Cc: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: asm inline
In-Reply-To: <20021202170017.GA8469@ibrium.se>
Message-ID: <Pine.LNX.4.33.0212021840350.10165-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2 Dec 2002, Samuel Rydh wrote:

>
> On Mon, Dec 02, 2002 at 04:12:27PM +0100, Franz Sirl wrote:
> > >The compiler does the right thing if -fno-strict-aliasing is used or
> > >if 'int b' is replaced by 'ulong b'.
> >
> > Well, the compiler was right before and as Andreas said, you are wrong. In
> > C *(ulong*)&B and *&B are different unrelated objects and the compiler
> > optimizes accordingly.
>
> Indeed. A quick check of the ISO C99 standard revealed that the compiler is
> allowed to distinguish between int and long even though they share the
> same representation on a particular arch.
>
> > Besides the fact that it's almost always right in low-level inline assembly
> > to use __asm__ __volatile__ (because without the __volatile__ the __asm__
> > maybe hoisted out of loops if the compiler thinks it's a loop invariant),
>
> ...which is desirable in this case. The st_le32 inline is just an efficient
> way to flip the endian and is not supposted to have any undeclared
> side effects (like touching hardware).

Efficient?

That's a store followed by a load from the same location. This implies
stalls in the memory queues, besides that since you can't use any memory
addressing mode, you have to put the address in a register, for a total
of 3 instuctions.

Compare with (src byte order is 1234 from MSB to LSB):
					# dst byte order
	rotlwi	dst,src,8		# 2341
	rlwimi	dst,src,24,0xff000000	# 4341
	rlwimi	dst,src,24,0x0000ff00	# 4321

that's also 3 instructions, 3 clocks because they have the same
destination. But no stack slot, no MMU translation and cache access
delays, straight register to register operations which could easily be
interspersed with other operations.

The only problem is that GCC is unable to reduce a series of equivalent
assignments to this short sequence of instructions, or at least I was
unable to obtain this ideal code from the compiler, even after trying to
add recognizers for rlwimi in the md file. I got better code for many bit
mainpulations except when they happened to fall on byte boundaries,
probably because some earlier pass in GCC tried to perform a 'clever'
transform on the sequence.

	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
