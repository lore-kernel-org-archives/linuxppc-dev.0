Message-ID: <19990203214943.A493@toocool.calpoly.edu>
Date: Wed, 3 Feb 1999 21:49:43 -0800
From: "dhiltgen@toocool.calpoly.edu" <dhiltgen@toocool.itslab.calpoly.edu>
To: "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>
Cc: O.Waller@ee.qub.ac.uk, mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org,
        Geert.Uytterhoeven@cs.kuleluven.ac.be
Subject: Re: matroxfb, anybody? (More details...)
References: <205EF7C55EE@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <205EF7C55EE@vcnet.vc.cvut.cz>; from Petr Vandrovec Ing. VTEI on Tue, Feb 02, 1999 at 12:53:20PM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 02, 1999 at 12:53:20PM +0000, Petr Vandrovec Ing. VTEI wrote:
> On  2 Feb 99 at 2:37, dhiltgen@toocool.calpoly.edu wrote:
> > Using con2fb makes the console switching much happier...  I associated
> > tty2 to matrox and left the rest on control.  The tty2 console didn't
> > move immediately; I had to run fbset -i -fb /dev/fb1 on tty2 (still
> You have some problem somewhere. If I do (atyfb + matroxfb or vga16fb +

It gets weirder... ;)

> matroxfb):
> <switch to tty2>
> con2fb /dev/fb1 /dev/tty2
> then immediately at this point contents of screen on atyfb/vga16fb is
> frozen and output on matroxfb is activated. Without any intervening
> fbset, of course. I hope, that resolution on controlfb is compatible

Now that I'm running matrox as my primary display (/dev/fb0) , I tried
to fire up control this evening using the same technique (con2fb and fbset)
and I managed to panic my machine numerous times, yet I never got a
valid console on control (/dev/fb1).  I was going to try to play around
with getting two X servers running again, but I just couldn't get
it to be happy.  

> with matroxfb capabilities (i.e. 8-32 bpp, 4bpp only on Millennium I/II).

The real problem now is that whenever I do an fbset, the mode gets set 
for _both_ framebuffers, and the timings are not the same between the two.
I tried to pass the parameters to control at bootup hoping that 
would circumvent the problem by using:

append="video=matrox:vesa:0x11a,nopan,fv:80 video=control:vmode:6,cmode:32"

but either my syntax is wrong, or matrox overrides controls settings,
as I don't get a 640x480x32 mode on control.   It gets set to the same
mode as matrox, which can be confirmed with a fbset -i.

When I was running control as /dev/fb0, then I could get X to work
correctly only on /dev/fb0.  On fb1 it had a messed up color pallet,
and if I tried to change the mode/timings things just got all messed up.

Now that I have matrox as /dev/fb0, I can only get X to work properly
on that.  Control wont work properly.   Bummer. :(


> > The cursor tends to get messed up on matrox... a second "large"
> > multi-color funky cursor square (about 4x larger) exists after an fbset.
> Could it be forgotten fbcon software cursor (flashing box 1x1 character)?
> It could be also 32x32 pixels uninitialized hardware cursor, but I do not
> know why driver should forget to initialize it.

I'm voting for the uninitialized hardware cursor.  It definitely looks
like "random" bits of color.  With Matrox as /dev/fb0 this is no longer
present, and the scrolling anomaly isn't either.  Now if I could get a
darn console terminal on control then I could tell you what would happen
then, but I imagine things would get screwy again.

> > I can get two X servers started, and I tried to use "X :0 tty1" for one
> > of them and "X :1 tty2" for the other, but I can't get them to co-exist.
> > happily.  The first one always takes tty7.  I even tried "-keeptty" as
> > it sounded like it might force the X server to stick to the initial tty
> > instead of 7.  Bottom line:  I can switch from either one to console,
> > but I can only get back to the first one that I started through
> > tty7. (Either matrox or control but never both)
> It could be on tty8. And I think that you want to run `X vt2 :1'
> (I hope that it is not fbdev specific option).

I'll try this again soon, but I was unable to get anywhere today
with control.  After a few attempts X popped up on control, but using
matrox's mode settings and as a result was all messed up... two copies
side-by-side that each looked like half of an interlaced frame.  When
I tried to set a mode that was valid for control, I got a kernel panic.
Definitely some bugs in the kernel right now. :(

> > 2) Is there any way to get the mouse to "fall off" one side and end
> > up on the other X server (Like Sun's with multiple heads.)  XFree86 4.0
> > maybe?  Is it even close to usable yet if I signed up to be a developer,
> > or is it really messy right now?
> I do not think that it is possible at this moment.

Is this feature planned?  Anyone know?  I'd sure love to see it...

> > Note:  All of this was without passing any kernel parameters.  I'm now
> > running with "video=matrox:vesa:0x11a,nopan,fv:80" and only using the
> Why nopan? It must be slow as hell...

I don't like the panning window in X.  I want exactly the same virtual
window size as physical size.  ...and no, it's just fine.  Performance is
no different than if I run without nopan.   Sometimes if I change the
vyres using fbset the performance does become hideously slow, but as
long as I use nopan at bootup time then it works fine.


So, given that it looks like it's kernel bugs at this point...
Is there anything I can do to help squash them?   Geert, is there
anything that I can do to help you find where the problems might be?
I'd be more than happy to beta-test patches for you, or if you point me
in a general direction I can start throwing printk's in to track down
what's going wrong.

Thanks everyone. :)

-- 
Daniel Kerry Hiltgen     Computer Science     Cal Poly, San Luis Obispo, CA  
dhiltgen@www.itslab.calpoly.edu    http://www.itslab.calpoly.edu/~dhiltgen/

"In a world without fences who needs Gates?"  1997 JavaOne Conference

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
