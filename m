Date: Wed, 11 Feb 2004 20:31:47 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Hank <compdata@alltel.net>
Cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: compiiler failure 2/11/04 on Macintosh Quadra 840AV: linux-m68k
 -r 2.4.24
In-Reply-To: <402A7B08.9090904@alltel.net>
Message-ID: <Pine.GSO.4.58.0402112028570.28274@waterleaf.sonytel.be>
References: <402A7B08.9090904@alltel.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 11 Feb 2004, Hank wrote:
> Changed the options in config to compile for the input hid.
>
> mac_hid.c: In function `mac_hid_sysctl_keycodes':
> mac_hid.c:298: `ppc_md' undeclared (first use in this function)
> mac_hid.c:298: (Each undeclared identifier is reported only once
> mac_hid.c:298: for each function it appears in.)
> mac_hid.c: In function `mac_hid_init_hw':
> mac_hid.c:484: `ppc_md' undeclared (first use in this function)
> make[3]: *** [mac_hid.o] Error 1
> make[2]: *** [first_rule] Error 2
> make[1]: *** [_subdir_macintosh] Error 2
> make: *** [_dir_drivers] Error 2

Hmm, someone stuck too many PPC-isms in that file ;-)

Try replacing `ppc_md.ppc_kbd_sysrq_xlate' by `mach_kbd_translate' and see
whether that works.

BTW, apparently much of the initialization is duplicated in
arch/m68k/mac/config.c and drivers/macintosh/mac_hid.c and thus needs some
clean ups.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
