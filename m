Date: Fri, 16 Jun 2000 13:14:07 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Cox <apc@agelectronics.co.uk>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: copy_from_user in drivers/video/fbmem.c
In-Reply-To: <3949F3E3.996DDC77@agelectronics.co.uk>
Message-ID: <Pine.LNX.4.05.10006161312290.5039-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 16 Jun 2000, Adrian Cox wrote:
> I've just ported the chips driver in 2.2 to the 69030 (now Asiliant, was
> Intel, was C&T). I've found that writing to the frame buffer device
> fails, because the underlying method in fbmem.c uses copy_from_user(),
> and on PowerPC copy_from_user() cannot copy into uncached space.
>
> Which do people think is wrong:
> Is copy_from_user() on PPC wrong, because it can't write to uncached
> space.
> Is fbmem.c wrong, because it tries to use copy_from_user() to memory
> mapped IO?

Congratulations! You found a bug in fbmem.c! Fbmem.c should not use direct
memory accesses to access the frame buffer, but must use fb_writel() and
friends instead.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
