Date: Sat, 29 Jul 2000 19:54:26 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bogus dmasound.o module (was: Re: 2.4.0-test4 success (Re: affs))
In-Reply-To: <20000729164011.A11090@suse.de>
Message-ID: <Pine.LNX.4.10.10007291951200.3886-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 29 Jul 2000, Olaf Hering wrote:
> can someone check if the ./include/linux/soundcard.h is correct?
> This looks bogus to us:
>
> +178
> /*
>  * Some big endian/little endian handling macros
>  */
>
> #if defined(_AIX) || defined(AIX) || defined(sparc) || defined(HPPA) ||
> defined(PPC)
> /* Big endian machines */
> #  define _PATCHKEY(id) (0xfd00|id)
> #  define AFMT_S16_NE AFMT_S16_BE
> #else
> #  define _PATCHKEY(id) ((id<<8)|0xfd)
> #  define AFMT_S16_NE AFMT_S16_LE
> #endif
>
>
> Is PPC really defined? At least (sparc) is wrong and should be
> __sparc__. PPC should proably be __powerpc__.
> It is from current benh tree.

At least drivers/sound/dmasound/ doesn't refer to AFMT_S16_NE or _PATCHKEY.

It may be the cause of many endianness problems, though, if any userspace
application assumes AFMT_S16_NE is always the native format.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
