Date: Sat, 3 Jun 2000 02:13:59 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
In-Reply-To: <200006030628.IAA00691@piglet.grunz.lu>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000603015640.22680D-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 3 Jun 2000, Michel Lanners wrote:

> Hi Takashi,
>
> On  31 May, this message from Takashi Oe echoed through cyberspace:
> > [...]
> >> If I hear no opposition, I'll send this off to Alan; it might make it
> >> into 2.4.0-final.
> >
> > Actually, I have sent a similar patch to DanJ a few weeks ago.
>
> Do you mind if I merge yours and my patch to keep your bugfixes and
> enhancements, and my command line code? I think mine is easier in the
> sense that you can _exactly_ specify what is in the box, including
> indicating the bank for 2MB configs.

I don't mind, but can you improve the way to specify the vram config?
Your method is precise but not very intuitive.  Besides, is there anyone
with 2MB vram have the vram detection problem with either 2.2 or 2.{3,4}
controlfb codes?  I have only seen the problem with 4 MB, so being able to
specifiy which bank is in use may be overkill.

>
> For those with multiple display adapters, do you think an option
> controlfb:off might make sense? As there is no way to control which card
> gets assigned which framebuffer device, that might help in certain
> situations...
>
> > The patch
> > attached includes a few bug fixes as well as a feature enhancement in that
> > it is now possible to program all aspects of control frame buffer
> > geometry/timings to your liking; that is, you can use xvidtune to ruin
> > your monitor if you are not careful.
>
> I've had a quick try in XFree 4, but that didn't work. How did you do
> that?

I'm using XF4 server with XFree86-3.3.x xvidtune, and it does what I think
it should do.

> Also, when running Xfree 4, I get a wrapped-around screen in the sense
> that the leftmost ~200 pixels appear on the _right_ side of the monitor.
> Might that be the offset of pixel #1 in the framebuffer? Although,
> that's around 100 bytes IIRC, so wouldn't explain the 200 pixels at 32
> bit/pixel.... FWIW, I'm running Jack Howarth's XF4-12a RPMs.

XF4's fbdev is not working right for me either.  The weird displacement
occurs on both of display cards (control, matrox) I have.  I think the
current XF4 is of no use for fbdev only people.

Try fbset for finding resolution/timings you like for now and use
XF68_FBDev.

By the way, I've heard there is a work-in-progress Xpmac with software
accelerated code by Ryuichi.  I'd think this one would be the best X
server for control or any other Apple un-accelerated display adapters.  If
you ask him now, he might consider adding XF86VidMode extension support.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
