Date: Mon, 1 Feb 1999 11:35:16 -0100
From: Owen Waller <O.Waller@ee.qub.ac.uk>
To: "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>
Cc: "dhiltgen@toocool.calpoly.edu" <dhiltgen@toocool.itslab.calpoly.edu>,
        mlan@cpu.lu, Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
In-Reply-To: <1EB9B063356@vcnet.vc.cvut.cz>
Message-Id: <Pine.SGI.4.02A.9902011106470.11398-100000@myst.ee.qub.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Petr, Daniel and everyone else.

o.k. well after a weekend updating my kernel sources to 2.2.1 here's what
I get...

> > And the second, I have managed to get X working on both displays at
> > but the first X server freezes until I exit the second.  I used "X :1"
> > for the second.  Is there some other trick to keep the first one alive?
> > ...Mouse stops, and I tried firing up "xterm -display :0.0 &" and they
> > didn't appear until after I exited the :0.1 X server, at which point all
> > of the xterms I had started popped up on the :0.0 server and the mouse
> > woke back up.
> Strange. I tried two fbdev servers (on i386) and they both works. There is
> only one problem I know of: only one, foreground, server updates screen.
> I think that fbdev server thinks that he is not visible when it gets
> console switch signal... SVGA server even switches into textmode... But
> they work in paralell. Also, maybe that you should run X on fb1 using
> con2fb /dev/fb1 /dev/tty#X
> <switch to tty#X>
> FRAMEBUFFER=/dev/fb1 X vt#X
> (I'm doing it this way)

Daniel, I haven't tried this yet on my Mystique. If Petr's suggestions
still doesn't work let me know nad I'll try testing this on my machine.
The last time I tried con2fb (a few months ago) it worked fine for moving
the console about, but I didn't try X.

> > So, if I "fbset -i" back on console, then I get the controlfb information
> > as expected, but if I "fbset -i -fb /dev/fb1" the console immediately
> > switches to /dev/fb1, but the fonts are all messed up (I'm guessing the

as far as I can tell fbset -i reports the correct information for fb0 -
matrox and fb1 - control. But I'll double check this when I get back
tonight.

> > > > the kernel slightly, in that it assumes if you have a Mac, well then you
> > > > must have a Mac matrox card, and OF should take care of initialization.
> > > > Nope, I've got a x86 card, and it has to be initialized by the kernel.
> > > > Simple one line hack in the init function for matroxfb.
> If you have Matrox which cannot be initialized by OF, you should not
> enable CONFIG_FB_OF. If you have both devices, you can try to persuade
> OF to have two devices or edit sources. Sorry.
> > in drivers/video/matroxfb.c:
> >
> > #ifndef MODULE
> > __initfunc(void matroxfb_init(void))
> > {
> >         DBG("matroxfb_init")
> > #if defined(CONFIG_FB_OF)
> > /* Nothing to do, must be called from offb */
> > #else
> >         matrox_init();
> > #endif
> > }

Daniel, well after some poking around in the kernel source I'll agree with
you on this ;-). When I first got 2.2.1 compiled it didn't even see the
Mystique. Once I took your hack though things seem to be o.k.

> > matrox_init never gets called on my system, so the card never inits.
> > I just commented out the #ifdef stuff so that matrox_init always gets
> > called and the card magically appears.
> Yes, you must add "MTRX,...." somewhere into your OF configuration
> (my PReP does not have OF and I never saw it...) If you uncommented #define
> above, be sure that you commented out complement part from
> drivers/video/offb.c - otherwise matroxfb can be initialized twice, thus
> you'll get two fb's per one hardware :-(

Is there any way that this could be changed? I don't need my internal
video (control) to work, but I'd rather have it and the matrox compiled
into the one kernel without a hack. Unless Geert you know some way of
"fudging" an non-OF card into the OF device tree? OR Petr could you
possibly work in a #define construct so that Daniel's "hack" became
official? (mind you neither of these are very general solutions).

As for editing drivers/video/offb.c - I don't think this is important. In
my case the card never shows up in the device-tree, cat'ing
/proc/device-tree doesn't show the card. It only appears on the PCI bus,
cat'ing /proc/pci does show the card. So if the card isn't in the device
tree then the matrox clause of offb.c is never called. Correct?

Also does anybody know how this situation changes if you use BootX to boot
(I don't so I can't comment on this). Would BootX map the mystique from
the PCI space into the OF device tree??

> > The current mode that I'm using, that "sort of works" for matroxfb is:
> > (I'd _really_ like to be able to change this, but without timing values
> > I can't get it to work, and as I said in the previous e-mail appending
> > to the kernel video=matrox:vesa:<hex-code> results in a immediate panic

I'm currently running with:

video=matrox:vesa:0x105 (or 0x118), and things have been rock solid.

Daniel how are you booting via, bootX or direct from OF?

> P.S.: I'm not on the linuxppc-dev list, so CC me if you think that
> I'm interested in that message.

consider it done :-)

Cheers


-------------------------------------------------------------------------
Owen Waller                     |   "...sometimes I think I'm a little
PhD. Student in Control Eng.    |    more English than I am French..."
Queens University               |              - Alain Prost 
Belfast                         |
Tele: +44 (0)1232 274085        |    Fax: +44 (0)1232 667023


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
