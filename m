Subject: Re: multiple separate pci bridges ...
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040118172838.GA8785@iliana>
References: <20040118144412.GA6897@iliana>
	 <1074443601.9704.164.camel@thor.asgaard.local>
	 <20040118172838.GA8785@iliana>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1074450283.9700.200.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Sun, 18 Jan 2004 19:24:44 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-01-18 at 18:28, Sven Luther wrote:
> On Sun, Jan 18, 2004 at 05:33:21PM +0100, Michel Dänzer wrote:
> > On Sun, 2004-01-18 at 15:44, Sven Luther wrote:
> > > >
> > > The freeze happens when i first launch glxinfo, or when i first start
> > > moving a window around (using a debian/unstable default gnome desktop).
> > > I don't remember well, but i think it would also freeze when let running
> > > for a time, but i am not sure.

It would be quite interesting to know, see below.

> > > The box is still available trough ssh, but killing the X server
> > > doesn't restore the fbdev console, and freeze the box.
> >
> > Sounds like a typical chip lockup, possibly caused by the chip not
> > reading from the CP ring what we're writing to it.
>
> Well, not sure. Compared to the pegasos 1 situation, where nothing
> showed up on the screen, except the hardware cursor, Things seem to work
> out fine at first, and only certain operation make it happen. The gdm
> prompt comes up, you can log in, then once logged in, you can open a
> gnome-terminal, and even do some stuff. Once you try moving the window
> though, it starts moving, but then quickly freezes.

Because the RENDER extension isn't accelerated, that might be the first
time the ring is heavily used.

It might also occur when the ring wraps around; whether or not it also
happens when the server is idling would give a hint about this, or even
better instrumenting the wraparound handling code in the DRM.

> I believe there is maybe more a problem with the CPU and the graphic
> chip being in disacord over the size of the CP ring.

I'd expect problems everywhere if that code wasn't correct.


> Come to think of it, i have three negative tries (Radeon 7000, 7200 and
> 9200SE) and one positive (Radeon 7500), or at least claimed such, the
> glxgears numbers obtained with the Radeon 7500 where not all that high
> (maybe 300 or so), but still higher than the software only numbers i
> obtain on my box with Radeon 9200 SE.

PCI GART isn't very fast in general, it's even mysteriously slow on some
systems, see the dri-devel list archives.


> Also, the Radeon 9200 SE has only 64bit memory interface. I don't know
> about 7000 and 7200, but maybe this is also the case for them, while the
> 7500 could have 128bit memory interface ? Not sure, will investigate.

I doubt that matters.


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
