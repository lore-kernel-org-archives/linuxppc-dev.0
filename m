Date: Thu, 15 Mar 2001 09:30:45 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?S=E9bastien=20C=F4t=E9?= <scote1@matrox.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: why XOR ext2_set_bit?
In-Reply-To: <3AAFF094.6137F71A@matrox.com>
Message-ID: <Pine.LNX.4.05.10103150922090.23611-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 14 Mar 2001, Sébastien Côté wrote:
>
> I just had a problem writing to a file on a ext2 filesystem with my port
> of kernel 2.4 on powerpc (G4) running in little-endian.  When the
> function ext2_set_bit was called by ext2_new_block, it returned
> something so I got the warning :
>
> "ext2_new_block bit already set for block 161"
>
> and I was stuck in an infinite loop.  I found the definition for the
> function in include/asm-ppc/bitops.h as follow:
>
> #define ext2_set_bit(nr, addr)		test_and_set_bit((nr) ^ 0x18, addr)
>
> Now my question:  Why is "nr" XORed with 0x18 ???  I tried to do this
> function on paper and with this XOR, they were always trying to change
> the wrong bit.  Now, since nobody's been reporting this problem before,
> I guess this XOR is ok but I'd really like to understand it's utility to
> correct things on my side (for now, I just removed it and everything
> appears to be fine).
>
> Could someone give me an explanation?

Ext2 metadata is little endian. The XOR converts from big endian to little
endian bit numbering inside a 32-bit word in native format.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
