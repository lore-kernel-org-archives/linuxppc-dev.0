Message-ID: <39A23ADB.25E233F@relog.ch>
Date: Tue, 22 Aug 2000 10:33:31 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org, dmj+@andrew.cmu.edu
Subject: Re: Control fb problem on 8500
References: <Pine.LNX.4.10.10008211844210.371-100000@cassiopeia.home>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> On Mon, 21 Aug 2000, Michel [iso-8859-1] Dänzer wrote:
> > Geert Uytterhoeven wrote:
> > > On Mon, 21 Aug 2000, Michel [iso-8859-1] Dänzer wrote:
> > > > That's not even needed, the fbdev driver is just broken. Line 430:
> > > >
> > > >       pScrn->displayWidth = pScrn->virtualX; /* FIXME: might be wrong
> > > > */
> > > >
> > > > is indeed wrong. virtualX is obvious, but displayWidth should be the
> > > > memory pitch of a scanline.
> > > >
> > > > Now you just have to find out where to get the correct value for
> > > > displayWidth.
> > >
> > > I suppose
> > >
> > >     if (fix.line_length)
> > >         pScrn->displayWidth = fix.line_length*8/var.bits_per_pixel;
> > >     else
> > >         pScrn->displayWidth = var.xres_virtual;
> > >
> > > should work fine, except on hardware were
> > > fix.line_length*8/var.bits_per_pixel might not be integer (e.g. if
> > > 1280x1024x24 mode requires a line_length of 4096).
> >
> > I've thought of this as well. The problem is that the mode hasn't been
> > initialized when displayWidth is set and used.
>
> So the X server initializes the internal screen structures before it even
> knows that it can use them later?

Yes. This really seems to be a rather serious design flaw - the driver is
assumed to know at any time whether it can cope with what the user wants and
how.

Anyway, what do you think about the patch I posted? Michel, can you please try
it? I don't think having to use ShadowFB with the fbdev driver is too bad
because it should generally enhance performance :) If the patch is okay, I'll
submit it to XFree86.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and the DRI project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
