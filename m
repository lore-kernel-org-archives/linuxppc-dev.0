Date: Tue, 17 Oct 2000 13:37:58 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Samuel Rydh <samuel@ibrium.se>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>, bh40@calva.net,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: Video driver bug
In-Reply-To: <20001017002037.A26630@ibrium.se>
Message-ID: <Pine.LNX.4.10.10010171332540.394-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 17 Oct 2000, Samuel Rydh wrote:
> On Mon, Oct 16, 2000 at 05:22:58PM -0700, James Simmons wrote:
> > > > > Well, my understanding is that MOL needs to be able to "probe" for all
> > > > > supported mode. Doing so on a visible console would definitely be hell.
> > > > > It does that in order to setup the MacOS-side driver mode list.
> > > >
> > > > According to Samuel's last post, MOL needs both var and fix for probing.
> >
> > Yes this is really bad. The way most drivers are written is that testing
> > var does not change fix. If you grab fix after testing the video mode it
> > will be for the current set resolution. Not the one you are testing
> > for. For most drivers you need to physically set the mode to change
> > fix. Sometimes the information in fix can only be obtained from the
> > hardware and this requires a video mode change.
>
> What MOL needs from the fix structure is the bytes_per_line field and
> the page_offset of framebuffer. This information is necessary in order
> to make it possible to switch seamlessly (by using the MMU) from a
> RAM based framebuffer to the physical one.

OK.

> What I'd like to see is good way to obtain these parameters without
> actually setting the video mode. And, of course, it would be nice

Currently that's possible, but it will no longer be in the future. But I guess
it's only a few modes (640x400, 800x600, 1024x768, 1280x1024), so it won't
cause too much annoyance?

Alternatively you can get the info once and store it in a config file in the
user's homedir. If it later turns out to be invalid (e.g. due to dual-head
issues, or because you changed your video card), you can offer to reprobe when
restarting MOL the next time.

> if they were guaranteed to be constant for a given video mode.

That depends on the hardware. When you're running on the second head of e.g. a
Matrox G400, it cannot be guaranteed.

So MOL should test whether those values are still valid when switching from X
to the console, and return to X when they are no longer valid.

Is this acceptable?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
