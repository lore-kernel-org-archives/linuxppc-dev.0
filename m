Date: Mon, 9 Aug 2004 16:23:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: "'linuxppc-dev@lists.linuxppc.org' Development" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PReP bootloader VGA console
Message-ID: <20040809232327.GC22109@smtp.west.cox.net>
References: <3461F858-E7F6-11D8-B7C4-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3461F858-E7F6-11D8-B7C4-000A95A0560C@us.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 06, 2004 at 05:16:03PM -0500, Hollis Blanchard wrote:

>
> This is the minimal patch needed to get the bootloader prompt on VGA
> for PReP.
>
> --- 1.1/arch/ppc/boot/simple/misc-prep.c        Mon Mar  1 17:34:28 2004
> +++ edited/arch/ppc/boot/simple/misc-prep.c     Fri Aug  6 17:21:00 2004
> @@ -89,6 +89,7 @@
>         }
>
>  #if defined(CONFIG_VGA_CONSOLE)
> +       serial_fixups();
>         vga_init((unsigned char *)0xC0000000);
>  #endif /* CONFIG_VGA_CONSOLE */
>
> Of course that looks funny doesn't it? "serial_fixups()" just sets
> ISA_io, so should probably be called something else.

Curse you folks with a video display! :)

> Also it's written in assembly in legacy.S (with matching chrpmap.S),
> which could easily become prepmap.c and chrpmap.c.

OK.  So when I wrote all of this initially, there was, I could have
sworn, a good reason for doing 'serial_fixups' as an asm routine, and
not just a define or C func.  But, I can't recall why now.

So if you'd be so kind as to whip up, and test, a patch which switches
us to defines, or a C func, whichever ends up being easier, I'd
appreciate it.  Thanks.

> Even better ISA_io could have a #define that's used in misc.c and
> misc-prep.c...

and ns16550.c

> But all of this would require more digging through makefiles and weak
> aliases than it's probably worth.

'cmon, you know you want to. :)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
