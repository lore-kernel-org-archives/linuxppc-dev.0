Date: Thu, 24 Jan 2002 09:52:02 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: hollis@austin.ibm.com
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	sdi@remote.org,
	Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: RFC: vesafb
In-Reply-To: <20020123192010.GP510@austin.ibm.com>
Message-ID: <Pine.GSO.4.21.0201240948070.19665-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 23 Jan 2002 hollis@austin.ibm.com wrote:
> The attached patch allows vesafb to work on PPC. vesafb does surprisingly

Nice!

> little with the BIOS (which I thought was the whole point of VESA). With some
> ifdef's I'm able to use it as sort of a VGA offb -- the firmware initializes
> the card, and the driver just uses it and never mucks with it.

Well, vesafb assumes the VESA BIOS initialized the card to some linear graphics
mode _before_ the real kernel code was started. Once the kernel is started, no
VESA calls are made, and the video mode is fixed.

So in theory (and you proved the practical side on PReP) it can be used on any
platform that initializes a more-or-less VGA card to a linear graphics mode.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
