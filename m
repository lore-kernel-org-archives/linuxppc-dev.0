Message-ID: <39884F64.75928F2B@relog.ch>
Date: Wed, 02 Aug 2000 18:42:12 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Jack Howarth <howarth@bromo.med.uc.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: color maps issues
References: <200008021245.FAA13221@bromo.med.uc.edu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jack Howarth wrote:
>
>     I think we should revisit the issue Kevin Hendricks brought up in
> March since it still was a problem up until a week ago in the linuxppc
> stable kernel anyway....Here was his old message...

But Steffen Haeuser stated on the Xpert ML someone told him the problem was
fixed?


> Okay so I found the bug.  It seems all through the r128 driver, crtc.pitch
> values are set to the virtual x resolution  (vxres) / 8.  But in aty128fb.c
> in the var_to_crtc routine the crtc.pitch is set to be just the xres / 8.
>
> This is not a problem if xres == vxres.  Which is what happens when the
> aty128fb.c starts up.  So for any one mode it defaults to being okay.
>
> However, when doing mode switching via the Cntl-Alt-Keypad+- keys, xfree
> sets vxres and vyres to be the same as the resolution of the largest mode
> on that line (so 1152x870 becomes my vxres, and vyres when 1152x870,
> 832x624, 1024x768 are all specified on the same line.
>
> This results in a call to aty128fb_set-var which calls decode_var which
> calls var_to_crtc. which gets the crtc.pitch wrong.
>
> So my questions is as follows?
>
> Who is wrong?  Should xfree shrink the vxres and vyres to match xres and
> yres before calling set_var or should aty128fb.c var_to_crtc routine be
> fixed to use vxres >> 3 instead of just xres >> 3?

IMO aty128fb is definitely wrong. v{x,y}res never change in the X server - in
fact, the size of the X root window can't be changed legally, and these values
correspond to its size.


> What use is it to get a nice 832x624 hole into a display that is virtually
> 1152x870?!?  I can't get to any of the kde controls, panels, etc since they
> are off the screen!  And it would be a pain to have to pan around looking
> for them (especially since the ioctl for panning is on the "to do" list!).

That's not the X server's problem.

It's still better to get a correct display where you can't reach certain parts
of the display instead of an incorrect display, isn't it? And then as soon as
panning is implemented, everything works fine.

And in the special case of games using full-screen modes, panning isn't even
needed...


> So my feeling is that both are wrong.  We should shrink the virtual
> resolution to match the physical resolution in xfree when mode switching and
> put the patch in place in aty128fb.c
> I submitted the following patch to BenH for use in his test kernels...
>
> --- drivers/video/aty128fb.c.prev       Sun Jul 30 22:04:24 2000
> +++ drivers/video/aty128fb.c    Sun Jul 30 22:05:01 2000
> @@ -842,7 +842,7 @@
>      crtc->v_sync_strt_wid = v_sync_strt | (v_sync_wid << 16) |
>                  (v_sync_pol << 23);
>
> -    crtc->pitch = xres >> 3;
> +    crtc->pitch = vxres >> 3;
>
>      crtc->offset = 0;
>      crtc->offset_cntl = 0;
>
> that Kevin sent me last week. However after finding Kevin's original
> message I think he final suggestion in it is right and we should have
> a patch placed in aty128fb.c which shrinks the virtual resolution down
> to match the physical resolution in xfree when mode switching.

I don't think that's possible without destroying the framebuffer contents.


Michel


--
It is easier to fix Unix than to live with NT.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
