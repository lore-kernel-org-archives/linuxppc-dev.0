Date: Sun, 31 Oct 1999 21:25:33 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Riley <happyoscar42@usa.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: More framebuffer stuff...
In-Reply-To: <381BA8A0.8F99D428@usa.net>
Message-ID: <Pine.LNX.4.05.9910312123140.2480-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 30 Oct 1999, David Riley wrote:
> Well, I found a good site for framebuffer initing (though I should have
> thought of mmap() before).  However, now whenever I write to the
> framebuffer, it seems to be using a color map instead of direct color
> (unless I run my program under XF86).  I made sure that it is in 32 or
> 16 bit color, and fb_*_screeninfo even reports a packed pixel display
> using direct color.  So why the colormap effect?  And why not under XF86?

You are confusing directcolor with truecolor.

Directcolor means that the r, g, and b components of a pixel are still passed
through a color map, like

    red = rmap[r];
    green = gmap[g];
    blue = bmap[b];

To make text drawing simpler, the [rgb]maps are loaded with the console
paletter. You should load a linear palette (rmap[i] = gmap[i] = bmap[i] = i)
to emulate a truecolor display.

XF{68,86}_FBDev loads a linear color palette first, that's why it works there.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
