Date: Tue, 28 Aug 2001 07:19:43 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
To: Paul Mackerras <paulus@samba.org>
Cc: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>,
	<debian-powerpc@lists.debian.org>
Subject: Re: Call for help: altivec-enabled vlc
In-Reply-To: <15243.36729.335303.936811@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0108280718010.217-100000@desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 28 Aug 2001, Paul Mackerras wrote:

> Michel Lanners writes:
>
> > However, there's something wrong with the IDCT code; the output is
> > essentially garbage. Makes for some interesting visual effects, but
> > that's about it....
>
> Here is my altivec-enabled IDCT, in assembler.  It does everything
> internally in floating point so there is no need for scaling.  It
> exports two procedures:
>
> void idct_block_copy_altivec(int16_t *dct_block, uint8_t *dest, int stride);
> void idct_block_add_altivec(int16_t *dct_block, uint8_t *dest, int stride);
>
> stride is the offset between successive rows of dest.  It does an IDCT
> of the 8x8 block of 16-bit integers at *dct_block, and either puts the
> result in an 8x8 block at *dest or adds it to the block at *dest.
> dct_block has to be 16-byte aligned.  And no, it hasn't been
> _deliberately_ obfuscated. :)
>
> I use this in mpeg2dec (actually a hacked version that I use to play
> videos off my tivo) and Anton Blanchard hacked this into xine.  I also
> have altivec-enabled motion compensation routines for libmpeg2.
>
> Hope this is useful...

Wow Paul, thanks!  I adapted Apple's AltiVec IDCT from their tech library,
but anything I write using the C extensions is going to suck since
Motorola's GCC/binutils hack is useless.  I never could get it to work (or
even compile).  I'll try your version straight away!

-jwb


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
