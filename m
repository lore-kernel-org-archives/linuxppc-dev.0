Date: Sat, 29 Jul 2000 20:12:30 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tony Mantler <nicoya@apia.dhs.org>
cc: Tom Rini <trini@kernel.crashing.org>, Dan Malek <dan@netx4.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
In-Reply-To: <v04003a00b5a8c0b923e3@[24.66.67.194]>
Message-ID: <Pine.LNX.4.10.10007292003430.3886-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 29 Jul 2000, Tony Mantler wrote:
> At 11:38 AM -0500 7/29/2000, Tom Rini wrote:
> >On Fri, Jul 28, 2000 at 07:57:11PM -0400, Dan Malek wrote:
> >
> >> So, the 2.4.0 PowerPC tree is now Mac workstation only?  Please,
> >> we can't make the assumption that CONFIG_PPC is a Macintosh.  It
> >> breaks all PowerPC embedded systems (or anything that isn't a recent
> >> Mac with USB).  There is a CONFIG_MAC, isn't that enough to do the same
> >> thing?
> >
> >Well, where are the specific breakages?  (CONFIG_MAC is used for 68k only
> >right now, IIRC.)
>
> Add a CONFIG_PMAC maybe? I don't really object to sharing CONFIG_MAC with
> PPC, except that it would be easy to assume that CONFIG_MAC == CONFIG_MAC
> && __powerpc__, and vice versa CONFIG_MAC == CONFIG_MAC && __m68k__.
>
> On the other hand, using a CONFIG option all over the place is probably the
> wrong answer for this. I'd rather see something along the lines of:
>
> #ifdef CONFIG_PMAC
> #define MACH_IS_PMAC (machtype == MACH_PMAC)
> #else
> #define MACH_IS_PMAC 0
> #endif
>
> ...
>
> if (MACH_IS_PMAC) {
> 	/* do powermac stuff here */
> }
>
> which may already exist, I haven't ever bothered to look. Anyways, it would

Ah, the 1996 m68k scheme :-) [cfr. include/asm-m68k/setup.h]

> let you either strip out powermac code, or build a kernel that works both
> on powermacs and non-powermacs alike, depending on which you want.

The Master PPC Penguin decided to no longer allow to build machine specific
kernels, but treat PowerMac/PReP/MTX/CHRP as one big machine type
(`CONFIG_ALL_PPC').

Given the flexibility I was used to on m68k[*], I find this a pity as well...

Gr{oetje,eeting}s,

						Geert

[*] Mix-'n-match any of:

    bool 'Amiga support' CONFIG_AMIGA
    bool 'Atari support' CONFIG_ATARI
    bool 'Macintosh support' CONFIG_MAC
    bool 'Apollo support' CONFIG_APOLLO
    bool 'VME (Motorola and BVM) support' CONFIG_VME
    bool 'HP9000/300 support' CONFIG_HP300
    bool 'Sun3x support' CONFIG_SUN3X
    bool 'Q40/Q60 support' CONFIG_Q40

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
