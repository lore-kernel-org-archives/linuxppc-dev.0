Date: Wed, 2 Aug 2000 22:25:12 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: daenzerm@student.ethz.ch
cc: Jack Howarth <howarth@bromo.med.uc.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: color maps issues
In-Reply-To: <39884F64.75928F2B@relog.ch>
Message-ID: <Pine.LNX.4.10.10008022223240.833-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2 Aug 2000, Michel [iso-8859-1] Dänzer wrote:
> Jack Howarth wrote:
> > Who is wrong?  Should xfree shrink the vxres and vyres to match xres and
> > yres before calling set_var or should aty128fb.c var_to_crtc routine be
> > fixed to use vxres >> 3 instead of just xres >> 3?
>
> IMO aty128fb is definitely wrong. v{x,y}res never change in the X server - in
> fact, the size of the X root window can't be changed legally, and these values
> correspond to its size.

Right.

> > So my feeling is that both are wrong.  We should shrink the virtual
> > resolution to match the physical resolution in xfree when mode switching and
> > put the patch in place in aty128fb.c
> > I submitted the following patch to BenH for use in his test kernels...
> >
> > --- drivers/video/aty128fb.c.prev       Sun Jul 30 22:04:24 2000
> > +++ drivers/video/aty128fb.c    Sun Jul 30 22:05:01 2000
> > @@ -842,7 +842,7 @@
> >      crtc->v_sync_strt_wid = v_sync_strt | (v_sync_wid << 16) |
> >                  (v_sync_pol << 23);
> >
> > -    crtc->pitch = xres >> 3;
> > +    crtc->pitch = vxres >> 3;
> >
> >      crtc->offset = 0;
> >      crtc->offset_cntl = 0;

The patch looks OK to me.

> > that Kevin sent me last week. However after finding Kevin's original
> > message I think he final suggestion in it is right and we should have
> > a patch placed in aty128fb.c which shrinks the virtual resolution down
> > to match the physical resolution in xfree when mode switching.
>
> I don't think that's possible without destroying the framebuffer contents.

Indeed. Besides, shrinking vxres is not allowed per the frame buffer device
API rules.

As the 'to do' list in aty128fb.c states, panning still has to be implemented.
Anyone with a patch?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
