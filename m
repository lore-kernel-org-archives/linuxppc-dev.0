Message-ID: <3AE02654.4D389C90@iiic.ethz.ch>
Date: Fri, 20 Apr 2001 14:06:44 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Iain Sandoe <iain@sandoe.co.uk>,
	Ani Joshi <ajoshi@shell.unixbox.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [measurement] (was Re: XF4 (mach64) help please)
References: <Pine.LNX.4.05.10104201324460.2779-100000@callisto.of.borg>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> On Fri, 20 Apr 2001, Iain Sandoe wrote:
> > I wrote:
> > > On  Thu, Apr 19, 2001, Geert Uytterhoeven wrote:
> > >> On Thu, 19 Apr 2001, Iain Sandoe wrote:
> > >>> On Thu, Apr 19, 2001,  Ani Joshi wrote:
> > >>> > On Thu, 19 Apr 2001, William Blew wrote:
> > >>> >> On Thu, 19 Apr 2001, Iain Sandoe wrote:
> > >>> >> > 2/  how difficult would it be to plumb the scroll acceleration
> > >>> >> > back into the console driver?  (would one need access to the NDA
> > >>> >> > stuff?) -- the scrolling
> > >>> >> > of console is a real problem in blocking sound :-/
> > >>> >>
> > >>> >> For mach64 at least, I would start by porting the CopyScreen2Screen
> > >>> >> XXA operation into the kernel and then using it during scrolling.
> > >>> >
> > >>> > This is already done by atyfb in the kernel,
> > >>>
> > >>> then why is the atyfb scroll (and fbdevhw) _so_ much slower than the X
> > >>> 'native' driver ... the same reason as below?
> > >>
> > >> Because xterm uses jump scroll? Try scrolling line by line in X11.
> > >
> > > hmmm.  I was comparing "before" and "after" changing to Ani's new
> > > ati_drv.o (before was using libfbdevhw.a) - in all other respects the
> > > configuration was identical.
> > >
> > > this is mach64 (3DU Pro) on G3/beige - the difference seemed to be
> > > striking enough to comment (but I guess I could wind it back and do an
> > > X11Perf).
> >
> >        with libfbdevhw.a           with new ati_drv.o/atimisc_drv.o
>
> What's this libfbdevhw.a? Is it just the plain fbdev driver from XFree86?

Nope, it's just the fbdevHW layer. But I guess Iain actually means the fbdev
driver?


> > -scroll500    51.8/sec                76.5/sec
> > -shmput500    14.2/sec                25.4/sec
> >
> > doesn't seem that different, I suppose, but this is...
> >
> > cat test.txt  10.382 sec               5.132 sec
> >
> > I guess that's what I've noticed on things like kernel builds.
> >
> > >>> >however the problem lies in
> > >>> > the entire fbcon layer where there is some improper
> > >>> > locking/interrupts
> > >>
> > >> Read: the entire console layer. Fbcon cannot (read: couldn't) use
> > >> interrupts because the upper console layer disables (disabled)
> > >> interrupts.
> > >>
> > >>> > going on there.  This was discussed here and on linux-fbdev a few
> > >>> > months ago and I believe will be addressed in 2.5.
> > >>>
> > >>> and there is a (temporary) fix for it (I believe) involving a patch
> > >>> from Andrew Morton - (which I haven't had time to try on PPC yet).
> > >>> Will that fix the slow console scroll as well?
> > >>
> > >> It's supposed to. Haven't tried it yet, though.
> > >
> > > I will ASAP - AFAICT the various blocking issues are the main problem
> > > with (pmac) sound now.
> >
> > I've fetched AM's latest console patch (2.4.3-pre8) and will try applying
> > it later and re-run the libfbdevhw.a test.
>
> If libfbdevhw.a is from XFree86, it has nothing to do with the console.

That's it.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
