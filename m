Date: Mon, 16 Oct 2000 17:22:58 -0700 (PDT)
From: James Simmons <jsimmons@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Takashi Oe <toe@unlserve.unl.edu>, Benjamin Herrenschmidt <bh40@calva.net>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Samuel Rydh <samuel@ibrium.se>
Subject: Re: [linux-fbdev] Re: Video driver bug
In-Reply-To: <Pine.LNX.4.10.10010141839280.570-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.21.0010161712090.6261-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > Well, my understanding is that MOL needs to be able to "probe" for all
> > > supported mode. Doing so on a visible console would definitely be hell.
> > > It does that in order to setup the MacOS-side driver mode list.
> >
> > According to Samuel's last post, MOL needs both var and fix for probing.
> > If there is something like:
> >
> > struct fb_probe_info {
> > 	struct fb_var_screeninfo var;
> > 	struct fb_fix_screeninfo fix;
> > };
>
> Why does it need fix? Relying on data from fix for a mode that is not yet
> really set is not wise: there's no guarantee that fix will be the same when the
> mode is really set later.
>
> Example: dual-head cards, where the resolution on one head is changed so the
> card's memory management is changed.

Yes this is really bad. The way most drivers are written is that testing
var does not change fix. If you grab fix after testing the video mode it
will be for the current set resolution. Not the one you are testing
for. For most drivers you need to physically set the mode to change
fix. Sometimes the information in fix can only be obtained from the
hardware and this requires a video mode change.
   I do agree their are problems with fix and var being grabbed by
seperate ioctl calls. This can cause really problems (think fork). But
the solution is much more complex than just combining both fix and var
into one ioctl. Consider the situation with several apps having /dev/fbX
open and one app changes the video mode. Since changing the video mode
will change var and fix not only for the app that changed the video mode
but also for the other apps depending on the values it obtains for var and
fix. Now they will have the wrong values. Their are other issues as well.
As you can see it is more complex than what you think.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
