Date: Sun, 18 Jan 2004 18:28:38 +0100
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040118172838.GA8785@iliana>
References: <20040118144412.GA6897@iliana> <1074443601.9704.164.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074443601.9704.164.camel@thor.asgaard.local>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 18, 2004 at 05:33:21PM +0100, Michel Dänzer wrote:
> On Sun, 2004-01-18 at 15:44, Sven Luther wrote:
> > >
> > > > Finally, X works, altough DRI freezes after a second or two with my
> > > > radeon 9200SE, while it works for a Radeon 7500, but this is probably a
> > > > DRI issue.
>
> [...]
>
> > As for the DRI version, i use the drm module from the linuxppc-2.4 tree,
> > using the v2.4.24 TAG to checkout, and the rest of the XFree86 stuff,
> > including the mesa libraries, from the 4.3.0-0pre1v5 experimental
> > package, rebuild with the Radeon 9200SE patch from Michel Daenzer.
>
> You may want to try my dri-trunk-sid packages.

Ok, will give them a try.

> > The freeze happens when i first launch glxinfo, or when i first start
> > moving a window around (using a debian/unstable default gnome desktop).
> > I don't remember well, but i think it would also freeze when let running
> > for a time, but i am not sure. The box is still available trough ssh,
> > but killing the X server doesn't restore the fbdev console, and freeze
> > the box.
>
> Sounds like a typical chip lockup, possibly caused by the chip not
> reading from the CP ring what we're writing to it.

Well, not sure. Compared to the pegasos 1 situation, where nothing
showed up on the screen, except the hardware cursor, Things seem to work
out fine at first, and only certain operation make it happen. The gdm
prompt comes up, you can log in, then once logged in, you can open a
gnome-terminal, and even do some stuff. Once you try moving the window
though, it starts moving, but then quickly freezes. I believe there is
maybe more a problem with the CPU and the graphic chip being in disacord
over the size of the CP ring.

Come to think of it, i have three negative tries (Radeon 7000, 7200 and
9200SE) and one positive (Radeon 7500), or at least claimed such, the
glxgears numbers obtained with the Radeon 7500 where not all that high
(maybe 300 or so), but still higher than the software only numbers i
obtain on my box with Radeon 9200 SE.

Also, the Radeon 9200 SE has only 64bit memory interface. I don't know
about 7000 and 7200, but maybe this is also the case for them, while the
7500 could have 128bit memory interface ? Not sure, will investigate.

> Do you also have a server log with the DRI enabled?

Wait a minute, i can send them to you. I also had logs of the of the
7500 and 7000, but had them in /tmp and rebooted my box yesterday :/.

Anyway, here are the three DRI enabled logs :

http://people.debian.org/~luther/XFree86.DRI.log
	this one is while it is loading.
http://people.debian.org/~luther/XFree86.DRI2.log
	this one is ones loged in gnome, opened a terminal, and started
	typing in it (ls only).
http://people.debian.org/~luther/XFree86.DRI3.log
	this one is after having moved the gnome-terminal and locking up
	X. Hardware cursor still works. i first moved the gnome-terminal
	a bit, and it worked, but i insisted and it locked up.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
