Date: Mon, 16 Jun 2003 08:05:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] 2.4.21 fixes
Message-ID: <20030616150503.GB25221@ip68-0-152-218.tc.ph.cox.net>
References: <Pine.GSO.4.21.0306141056270.14234-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0306141056270.14234-100000@vervain.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jun 14, 2003 at 11:38:01AM +0200, Geert Uytterhoeven wrote:

>   - arch/ppc/kernel/checks.c: Kill warning about undeclared printf() by
>     including <stdio.h> _after_ all other includes (including it first doesn't
>     work)

This should probably just die since it hasn't been useful in a long
time.

>   - arch/ppc/kernel/open_pic.c: Kill warning about unused openpic_reset(). An
>     alternative is to add an #ifdef, but since it's never used before its
>     definition, just removing the forward declaration looks better to me

That reference can go, but the actual call needs an ifdef, see _devel.

>   - arch/ppc/kernel/ppc_ksyms.c, arch/ppc/kernel/setup.c: Define and export
>     screen_info unconditionally, so vga16fb can be built as a module. An
>     alternative is to make the definition dependent on CONFIG_FB_VGA16 ||
>     CONFIG_FB_VGA16_MODULE, and the export on CONFIG_FB_VGA16_MODULE, but this
>     is ugly.
>
>     Another reason is that screen_info is referenced in
>     arch/ppc/platforms/prep_setup.c on the following (complex) condition:
>
>     #if defined(CONFIG_PREP_RESIDUAL) && \
>         (defined(CONFIG_FB_VGA16) || defined(CONFIG_FB_VGA_16_MODULE) || \
> 	         defined(CONFIG_FB_VESA))
>
>     which causes a link failure with the current code, too. The alternative
>     #ifdef solution would clutter this even more...

Eh?  What set of conditionals doesn't work, in _devel ?  In fact, I bet
what happened is that when Paul updated the prep stuff he forgot to grab
the screen_info stuff.  IIRC, there was a "good" reason for not doing it
unconditionally, possibly wasted space.

>   - include/asm-ppc/posix_types.h: Kill warning about incorrect printf()-style
>     format in the ext2 code by making __kernel_ino_t unsigned long, like on
>     most other architectures.

Should be fine.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
