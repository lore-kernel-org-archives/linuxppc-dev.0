Date: Mon, 17 Jul 2000 15:03:11 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andreas Tobler <toa@pop.agri.ch>
cc: Martin Costabel <costabel@wanadoo.fr>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: cards initialized from offb (was: Re: [linux-fbdev] Re: [patch]VRAM
  detection in controlfb)
In-Reply-To: <3971A48E.64668BE9@pop.agri.ch>
Message-ID: <Pine.LNX.4.10.10007171410530.449-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 16 Jul 2000, Andreas Tobler wrote:
> Geert Uytterhoeven wrote:
> > This patch moves the initialization of some frame buffer devices from offb.c
> > to fbmem.c. It also reorders the initialization calls in fbmem.c.
> >
> > The patch mainly affects the users of the following frame buffer devices on
> > PowerMac and CHRP:
>
> >   - platinumfb
>
> ^^^^^^^^^^^^^^^^^
> pm7200
>
> > Except for a simple compile test (except for the new ofonly logic), it is
> > untested. Please test it!! Many many thanks!
>
> I applied it with some massive handwork to a 2.4.0-test4 from
> hq.fsmlabs.com. So far I can't see some oddities.
> Afterstep runs....
>
> Do yu have some special testcases?

If it works as before, everything is fine. Please also verify that offb is
used instead of platinumfb if the option `video=ofonly' is passed to the
kernel (or `no video driver' is checked in BootX).

In /proc/iomem you should see which memory regions are in used by the frame
buffer device driver you are using (platinumfb or offb, in your case).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
