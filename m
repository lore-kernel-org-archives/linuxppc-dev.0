Message-ID: <19990130153420.A970@toocool.calpoly.edu>
Date: Sat, 30 Jan 1999 15:34:20 -0800
From: "dhiltgen@toocool.calpoly.edu" <dhiltgen@toocool.itslab.calpoly.edu>
To: Owen Waller <O.Waller@ee.qub.ac.uk>,
        "dhiltgen@toocool.calpoly.edu" <dhiltgen@toocool.itslab.calpoly.edu>
Cc: mlan@cpu.lu, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
References: <19990130020006.A580@toocool.calpoly.edu> <Pine.SGI.4.02A.9901301411250.9620-100000@myst.ee.qub.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SGI.4.02A.9901301411250.9620-100000@myst.ee.qub.ac.uk>; from Owen Waller on Sat, Jan 30, 1999 at 02:32:32PM -0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I apologize for the length, but I don't want to leave anything
out that might be critical....

Let me open with two quick questions.  A while back on linux-kernel
someone said that they had ported X_SVGA with Matrox acceleration
to FB, and Geert asked the guy for a copy of the patch.

What are the odds that I could get a hold of that, and that it would
compile and possibly run under PPC?  Slim to none I bet, but 
it would be nice...

And the second, I have managed to get X working on both displays at once,
but the first X server freezes until I exit the second.  I used "X :1"
for the second.  Is there some other trick to keep the first one alive?
...Mouse stops, and I tried firing up "xterm -display :0.0 &" and they
didn't appear until after I exited the :0.1 X server, at which point all
of the xterms I had started popped up on the :0.0 server and the mouse
woke back up. 

...ok, on to the nitty gritty details...

On Sat, Jan 30, 1999 at 02:32:32PM -0100, Owen Waller wrote:
> 
> Hi,
> 
> > I'm running an x86 Matrox card in my 8600, and it "sort of" works
> > right now on 2.2.0.  It appears that there are definitely some kernel
> 
> To be honest I haven't tried this. I've been snowed under with work since
> October :-(. The last thing I tried was building a 2.2pre6 kernel which
> worked o.k. bar breaking my PPP connection. I didn't build the kernel
> with matroxfb support though as I thought the less I experiment with the
> better.

I've used both 2.2 pre 7 and I'm now playing with 2.2.1.

> > bugs as far as mode switching, as sometimes control and matrox end up
> > duplicating each other resulting in very funky displays.  I had to hack
> 
> This doesn't sound good. What exactly are you doing to achieve this?

Initially I was "moving" /dev/fb[01] back and forth so that I could try
to get X working.  Now I'm using ${FRAMEBUFFER} so that I don't have to
do that.  ...the symptoms described below appear for both.

OK, scenario goes like this.

/dev/fb0 = control  -- on bootup, this is the console
/dev/fb1 = x86 Matrox Mil. I -- on bootup, displays garbage from last session.
           does not turn on until kernel probes (aka, OF doesn't turn it on)
           I have turned on the #define in matroxfb.c for debugging.

	uname -a
Linux hysteria.insanity.org 2.2.1 #3 Sat Jan 30 12:20:05 PST 1999 ppc unknown

	ls -l /dev/fb* 
crw-r--r--   1 root     root      29,   0 Jan  4 05:53 /dev/fb0
crw-r--r--   1 root     root      29,  32 Jan 21 07:42 /dev/fb1


If I setenv FRAMEBUFFER /dev/fb0 (not really needed, but to be explicit)
and "startx" I get an X session on controlfb, as expected.  Everything
looks fine and dandy.  

So, if I "fbset -i" back on console, then I get the controlfb information
as expected, but if I "fbset -i -fb /dev/fb1" the console immediately
switches to /dev/fb1, but the fonts are all messed up (I'm guessing the
timing values for fb0 are somehow getting used)  I can't see what I type,
but the output is definitely trying to go to the matrox.  The funny part
is the "scroll" is controlled by the kernel, which still correctly scrolls
/dev/fb0 (control) so whenever I type enough to get a scroll to occur,
matrox doesn't, but control does (even though no new text has appeared
on control.)

At this point I had a vyres set to something huge, so I did an
"fbset -vyres 768" and poof, console went back to control.

I then ran "fbset -i -fb /dev/fb1" and console switched back to matrox
with messed up fonts.  At some point I did a setenv FRAMEBUFFER /dev/fb1
and ran "startx" and it came up on the matrox.  The only problem is that
the color pallet is all jacked up.  Again, I'm guessing that somehow
it's using controlfb information incorrectly for the matroxfb.

It appears that the issue is that somehow the kernel is using fb0
sometimes, and others it's using FRAMEBUFFER, or the "-fb" argument.
When I try to change settings using fbset it's like both frame buffers
get set at once, and one of them gets confused since the timings are only
valid for one of the cards.  ...or, the FB code in the kernel _really_
isn't very clean when it comes to multiple heads right now, and some
code just assumes /dev/fb0 is console and uses it without checking for
the proper state information.  I guess the whole thing is complicated 
by the fact that sometimes it's user space stuff, other times it's kernel 
space stuff messing with the fb.

> > the kernel slightly, in that it assumes if you have a Mac, well then you
> > must have a Mac matrox card, and OF should take care of initialization.
> > Nope, I've got a x86 card, and it has to be initialized by the kernel.
> > Simple one line hack in the init function for matroxfb.  
> 
> o.k. as far as I know Petr set things up so that under a Mac the card was
> always initialised by OF - even for x86 cards (like my mystique and your
> mil. I). The change is listed in Petr's readme/changes file. Petr can you
> comment on this?

I don't think so.

in drivers/video/matroxfb.c:

#ifndef MODULE
__initfunc(void matroxfb_init(void))
{
        DBG("matroxfb_init")
#if defined(CONFIG_FB_OF)
/* Nothing to do, must be called from offb */
#else
        matrox_init();
#endif
}

matrox_init never gets called on my system, so the card never inits.
I just commented out the #ifdef stuff so that matrox_init always gets
called and the card magically appears.


> What I'll do is bring my kernel sources up to 2.2.0-final and try setting
> up my Mystique again. Then let you know what happens.

I'm definitely interested....  Unfortunately I doubt I can use any of
your timing information, but who knows...

> On a realted note though, has anybody got a matrox card running under
> pre-R5 with the XFree86, framebuffer stuff running? I'm still running R4
> but once R5 is out I'll move over to XFree from XPmac.

Well, I'm running R4, but I have XF68_FBDev-ppc-19980910 from Geert's page, 
and when I run it on the matrox card I get:

XFree86 Version 3.3.2 / X Window System
(protocol Version 11, revision 0, vendor release 6300)
Release Date: March 2 1998
        If the server is older than 6-12 months, or if your card is newer
        than the above date, look for a newer version before reporting
        problems.  (see http://www.XFree86.Org/FAQ)
Operating System: Linux 2.1.120 ppc [ELF] 
Configured drivers:
   FBDev: Server for frame buffer device
   (Patchlevel 9): mfb, afb, cfb8, cfb16, cfb24, cfb32
(using VT number 7)

XF86Config: /etc/XF86Config
(**) stands for supplied, (--) stands for probed/default values
(**) XKB: disabled
(**) Mouse: type: busmouse, device: /dev/adbmouse, buttons: 3
(**) FBDev: Graphics device ID: "Linux Frame Buffer Device"
(**) FBDev: Monitor ID: "Generic"
(**) FontPath set to "/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/Ty
pe1/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6
/lib/X11/fonts/100dpi/"
(**) FBDev: Using default frame buffer video mode
(--) FBDev: Frame buffer device: MATROX
(--) FBDev: Video memory: 4096K @ 0x81000000
(--) FBDev: MMIO regs: 16K @ 0x80804000
(--) FBDev: Type 0 type_aux 0 bits_per_pixel 8
(--) FBDev: Unknown hardware accelerator type 16
(--) FBDev: No hardware acceleration used
(--) FBDev: Enabled virtual desktop
(--) FBDev: Using cfb8 driver


The current mode that I'm using, that "sort of works" for matroxfb is:
(I'd _really_ like to be able to change this, but without timing values
I can't get it to work, and as I said in the previous e-mail appending
to the kernel video=matrox:vesa:<hex-code> results in a immediate panic
(no error message, it just freezes) Any ideas short of getting the values
from someone with a Mac version of the card who can use vmode or whatever
to set the mode properly?)

fbset -i -fb /dev/fb1

mode "name"
    # D: 79.554 MHz, H: 59.905 kHz, V: 74.509 Hz
    geometry 1024 768 1024 768 8
    timings 12570 164 44 30 3 96 3
    hsync high
    vsync high
endmode

Frame buffer device information:
    Name        : `MATROX'
    Address     : 0x81000000
    Size        : 4194304
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 8
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 1024
    MMIO Address: 0x80804000
    MMIO Size   : 16384
    Accelerator : Matrox MGA2064W (Millennium)


Thanks for any and all input!   I'll be more than happy to help get this 
working via kernel hacking... just tell me where to start.  :)

I'm honestly less concerned with the console jumping back and forth.
I just want to be able to fire up X on both monitors at the maximum
res/depth for each card.

-- 
Daniel Kerry Hiltgen     Computer Science     Cal Poly, San Luis Obispo, CA  
dhiltgen@www.itslab.calpoly.edu    http://www.itslab.calpoly.edu/~dhiltgen/

"In a world without fences who needs Gates?"  1997 JavaOne Conference

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
