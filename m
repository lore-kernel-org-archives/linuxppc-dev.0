Date: Mon, 10 Feb 2003 10:35:22 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Cc: Magnus Damm <damm@opensource.se>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: aty128fb and EDID
In-Reply-To: <200302091940.10202.kevin.hendricks@sympatico.ca>
Message-ID: <Pine.GSO.4.21.0302101034180.25020-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 9 Feb 2003, Kevin B. Hendricks wrote:
> Steal the code from the radeon dirver in the kernel.  It finds and parses
> the EDID block in OF for ppc linux systems for LCD.

I guess you actually meant:

| Move the code out of the radeon driver and make it sufficiently generic so it
| can be used by the aty128 and other drivers?

> It works fine with my 17 in lcd display.
>
> Kevin
>
> On February 9, 2003 06:26, Magnus Damm wrote:
> > Hi,
> >
> > I recently bought a Cube G4 and got a 17" Apple Studio Display (CRT,
> > ADC) with it. However, that combination seems hard to use out of the box
> > if you want to use something else than the open firmware framebuffer.
> >
> > The thing is that the monitor only supports two modes:
> > 1600x1200 64Hz
> > 1280x1024 75Hz
> >
> > This gives me no picture at all when I try to use the aty128 driver.
> >
> > However, when I hardcode this video mode as default things work out ok:
> > /* default modedb mode */
> > /* 1600x1200, 64Hz, Non-Interlaced */
> > static struct fb_videomode defaultmode __initdata = {
> >         refresh:        64,
> >         xres:           1600,
> >         yres:           1200,
> >         pixclock:       5952,
> >         left_margin:    304,
> >         right_margin:   24,
> >         upper_margin:   38,
> >         lower_margin:   1,
> >         hsync_len:      184,
> >         vsync_len:      3,
> >         sync:           3,
> >         vmode:          FB_VMODE_NONINTERLACED
> > };
> >
> > The information above was built from my EDID file.
> >
> > To create some kind of generic solution I need to add EDID support to
> > the aty128 driver, or even better - a generic framebuffer layer.
> >
> > My question to you is:
> > All probing that is done by checking if "machine_is_compatible()", could
> > that all be replaced by EDID code?
> >
> > If you could send me your EDID files with together with information
> > about your machine and monitor I would be really happy. Then I could
> > parse them and see if they contain enough information. If you don't find
> > any EDID file then I would be glad to know that too.
> >
> > These machines are extra interesting:
> > * PowerMac2,1 first r128 iMacs
> > * PowerMac2,2 summer 2000 iMacs
> > * PowerMac4,1 january 2001 iMacs "flower power"
> > * iBook SE
> > * PowerBook Firewire (Pismo), iBook Dual USB
> > * PowerBook Titanium
> >
> > I find my EDID file in /proc/device-tree/pci/ATY,Rage128Pd@10/EDID

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
