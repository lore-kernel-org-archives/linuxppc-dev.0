Date: Sun, 18 Jan 2004 23:20:53 +0100
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040118222053.GA11651@iliana>
References: <20040118144412.GA6897@iliana> <1074443601.9704.164.camel@thor.asgaard.local> <20040118172838.GA8785@iliana> <1074450283.9700.200.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074450283.9700.200.camel@thor.asgaard.local>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 18, 2004 at 07:24:44PM +0100, Michel Dänzer wrote:
> On Sun, 2004-01-18 at 18:28, Sven Luther wrote:
> > On Sun, Jan 18, 2004 at 05:33:21PM +0100, Michel Dänzer wrote:
> > > On Sun, 2004-01-18 at 15:44, Sven Luther wrote:
> > > > >
> > > > The freeze happens when i first launch glxinfo, or when i first start
> > > > moving a window around (using a debian/unstable default gnome desktop).
> > > > I don't remember well, but i think it would also freeze when let running
> > > > for a time, but i am not sure.
>
> It would be quite interesting to know, see below.

But then, maybe it has something to do with the GL screensaver or
something such. The problem is that i have this box on the analog entry
of my dual entry monitor, and mostly work on the box connected to the
DVI connector, so it usually died while i was not looking.

> > > > The box is still available trough ssh, but killing the X server
> > > > doesn't restore the fbdev console, and freeze the box.
> > >
> > > Sounds like a typical chip lockup, possibly caused by the chip not
> > > reading from the CP ring what we're writing to it.
> >
> > Well, not sure. Compared to the pegasos 1 situation, where nothing
> > showed up on the screen, except the hardware cursor, Things seem to work
> > out fine at first, and only certain operation make it happen. The gdm
> > prompt comes up, you can log in, then once logged in, you can open a
> > gnome-terminal, and even do some stuff. Once you try moving the window
> > though, it starts moving, but then quickly freezes.
>
> Because the RENDER extension isn't accelerated, that might be the first
> time the ring is heavily used.

Yep. Altough this problem doesn't occur for the Radeon 7500 on the same
board. I believe it may be triggered by some problem which is present in
the R200 code path, and which is present in the R100 software T&L (since
i think the 7000 and 7200 lack a T&L engine).

> It might also occur when the ring wraps around; whether or not it also
> happens when the server is idling would give a hint about this, or even
> better instrumenting the wraparound handling code in the DRM.

Ok, i will look into this and do some experiments. What is the size of
the ring anyway ? 4K or something such ?

> > I believe there is maybe more a problem with the CPU and the graphic
> > chip being in disacord over the size of the CP ring.
>
> I'd expect problems everywhere if that code wasn't correct.

Mmm.

> > Come to think of it, i have three negative tries (Radeon 7000, 7200 and
> > 9200SE) and one positive (Radeon 7500), or at least claimed such, the
> > glxgears numbers obtained with the Radeon 7500 where not all that high
> > (maybe 300 or so), but still higher than the software only numbers i
> > obtain on my box with Radeon 9200 SE.
>
> PCI GART isn't very fast in general, it's even mysteriously slow on some
> systems, see the dri-devel list archives.

Ok. There is no other chance anyway, since there is no true AGP bus on
these boxes. The nortbridge used is a communication controller after
all.

> > Also, the Radeon 9200 SE has only 64bit memory interface. I don't know
> > about 7000 and 7200, but maybe this is also the case for them, while the
> > 7500 could have 128bit memory interface ? Not sure, will investigate.
>
> I doubt that matters.

I doubt it too. But then, if the chip measures data in multiples of the
memory words or something such, it may have an influence.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
