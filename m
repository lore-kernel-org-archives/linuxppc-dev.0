Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 25 Jul 2003 10:51:19 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IO, ANSI vs GCC structs
In-Reply-To: <20030725113026.E29161@borg.org>
Message-ID: <Pine.LNX.4.44.0307251038370.22864-100000@spider.ancor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 25 Jul 2003, Kent Borg wrote:
> The PPC arch likes to access physical devices with C structures that
> correspond to a memory map of device registers.  But a colleague says
> that structure layout is not guaranteed.  In fact, he cited two
> instances when he got burned by assuming he could predict structure
> layout.  But neither of those examples were with GCC.
>
> Does GCC make guarantees beyond what ANSI requires?  Is there some
> subtle detail that forces struct layout ("volatile" in the definition
> perhaps)?

There is nothing that guarentees this, in ANSI or GCC.

There are several things you can do which will work on all compilers I've
ever used (works in practice) and allow you to detect if the assumptions
are ever violated.

You can't use bit-fields. Don't even try.

You should always use fixed-width named types. I think you can use stdint
on most systems, when I started doing this there wasn't a common include
I could use everywhere so I ended up making my own.

What you basically want is the integer types uint8_t, uint16_t, uint32_t.
Make sure that the structure stays properly aligned, no 16-bit or 32-bit
quantities starting on an odd address or 32-bit quantities starting on
an address that isn't 4-byte aligned. Define your structures using
only these types. Make sure you put in filler for address space that doesn't
have registers in them. In your code, do a check on the sizeof() the
structure, make sure that it matches what you expect.

Example:

typedef struct mm_foobolizer {
   uint8_t bar1;
   uint8_t bar2;
   uint16_t filler002;	/* I use the offeset address in naming fillers */
   uint32_t sna;
   uint16_t fu;
   uint16_t filler00a;
   uint8_t  buffer[0xa1];
   uint8_t  filler0ad;
   uint16_t filler0ae;
   uint32_t word_buf[0x100];
} my_reg_def_t;

#define	EXPECTED_REG_SIZE	0x500

In your code, do the equivilent of:
    assert(EXPECTED_REG_SIZE == sizeof(my_reg_def_t));

That should get you past the worst of the problems.

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
