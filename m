Subject: Re: multiple separate pci bridges ...
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040118222053.GA11651@iliana>
References: <20040118144412.GA6897@iliana>
	 <1074443601.9704.164.camel@thor.asgaard.local>
	 <20040118172838.GA8785@iliana>
	 <1074450283.9700.200.camel@thor.asgaard.local>
	 <20040118222053.GA11651@iliana>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1074468804.9700.219.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 00:33:24 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-01-18 at 23:20, Sven Luther wrote:
> On Sun, Jan 18, 2004 at 07:24:44PM +0100, Michel Dänzer wrote:
> > On Sun, 2004-01-18 at 18:28, Sven Luther wrote:
> > > On Sun, Jan 18, 2004 at 05:33:21PM +0100, Michel Dänzer wrote:
> > > > On Sun, 2004-01-18 at 15:44, Sven Luther wrote:
> > > > >
> > > > > The freeze happens when i first launch glxinfo, or when i first start
> > > > > moving a window around (using a debian/unstable default gnome desktop).
> > > > > I don't remember well, but i think it would also freeze when let running
> > > > > for a time, but i am not sure.
> >
> > It would be quite interesting to know, see below.
>
> But then, maybe it has something to do with the GL screensaver or
> something such.

Don't run them, then? *shrug*


> Altough this problem doesn't occur for the Radeon 7500 on the same board.

I suspect that's more luck than anything else at this point...

> I believe it may be triggered by some problem which is present in
> the R200 code path, and which is present in the R100 software T&L (since
> i think the 7000 and 7200 lack a T&L engine).

The 7200 has one, and the 2D acceleration code (which moves windows
around) doesn't have any core specific paths because the 2D engines are
mostly identical.

> > It might also occur when the ring wraps around; whether or not it also
> > happens when the server is idling would give a hint about this, or even
> > better instrumenting the wraparound handling code in the DRM.
>
> Ok, i will look into this and do some experiments. What is the size of
> the ring anyway ? 4K or something such ?

daenzer@thor|0:29:29> grep 'ring buffer' /var/log/XFree86.0.log
(II) RADEON(0): Using 1 MB for the ring buffer


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
