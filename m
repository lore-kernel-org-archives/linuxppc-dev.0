Date: Wed, 21 Jun 2000 08:19:29 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: "Timothy A. Seufert" <tas@mindspring.com>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [linux-fbdev] Re: 3D accel on PPC
In-Reply-To: <Pine.LNX.4.21.0006201748210.25040-100000@idd-01.imbc.gr>
Message-ID: <Pine.GSO.4.10.10006210818010.2905-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 20 Jun 2000, Kostas Gewrgiou wrote:
> On Tue, 20 Jun 2000, Geert Uytterhoeven wrote:
> > On Mon, 19 Jun 2000, Kostas Gewrgiou wrote:
> > > What is holding back ppc voodoo3 in xfree right now
> > > is PIO support, i tried to use tdfxfb to get away from
> > > this but there a problems there as well (the xserver
> > > needs a 2*vramsize mapping in the framebuffer but fbdev
> > > can't do this unless i patch tdfxfb to think that its
> > > vram is 2*realsize, Geert any ideas how we can get away
> > > from this ?)
> >
> > Why do they want 2*vramsize? Is the extra space where no RAM is used for
> > something different? Can they map something there?
>
>  In voodoo you can setup one part of the framebuffer as tiled memory,
> access to this tiled memory needs more address space thats why a
> mapping of 2*ram is needed.

IC.

Is this tiled memory needed for a specific video mode, or is it independent of
the video mode? In the former case, set smem_len to 2*ram when switching to
that specific video mode; in the latter case, add an ioctl() to switch between
normal and tiled video mode, taking care of smem_len as well.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
