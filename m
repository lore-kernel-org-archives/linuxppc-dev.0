From: "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>
To: "dhiltgen@toocool.calpoly.edu" <dhiltgen@toocool.itslab.calpoly.edu>,
        O.Waller@ee.qub.ac.uk
Date: Mon, 1 Feb 1999 10:34:08 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: matroxfb, anybody? (More details...)
CC: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Message-ID: <1EB9B063356@vcnet.vc.cvut.cz>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Owen, hello D?, hello anybody,
> What are the odds that I could get a hold of that, and that it would
> compile and possibly run under PPC?  Slim to none I bet, but
> it would be nice...
  it should work as long as XFree does not do byteswapping because of
Matrox is switched into big endian mode with matroxfb. Unfortunately,
I did not test it yet because of my PowerStack refuses to boot with
Gabriel's PrepLoader, so I have something important to work out. Sorry.
> And the second, I have managed to get X working on both displays at once,
> but the first X server freezes until I exit the second.  I used "X :1"
> for the second.  Is there some other trick to keep the first one alive?
> ...Mouse stops, and I tried firing up "xterm -display :0.0 &" and they
> didn't appear until after I exited the :0.1 X server, at which point all
> of the xterms I had started popped up on the :0.0 server and the mouse
> woke back up.
Strange. I tried two fbdev servers (on i386) and they both works. There is
only one problem I know of: only one, foreground, server updates screen.
I think that fbdev server thinks that he is not visible when it gets
console switch signal... SVGA server even switches into textmode... But
they work in paralell. Also, maybe that you should run X on fb1 using
con2fb /dev/fb1 /dev/tty#X
<switch to tty#X>
FRAMEBUFFER=/dev/fb1 X vt#X
(I'm doing it this way)
> I've used both 2.2 pre 7 and I'm now playing with 2.2.1.
> /dev/fb0 = control  -- on bootup, this is the console
> /dev/fb1 = x86 Matrox Mil. I -- on bootup, displays garbage from last session.
OK.
> So, if I "fbset -i" back on console, then I get the controlfb information
> as expected, but if I "fbset -i -fb /dev/fb1" the console immediately
> switches to /dev/fb1, but the fonts are all messed up (I'm guessing the
Cannot comment on this because of my kernel (with my patches) says

# fbset -i -fb /dev/fb1
ioctl_FBIOGET_VSCREENINFO: Invalid cross-device link

That means that fbset tried to work with console belonging to /dev/fb0
through /dev/fb1 device. And it is bug in kernel that it is allowed
and it ends up with calling matroxfb_set_var() with console owned by /dev/fb0
without calling FBIOPUT_CON2FBMAP. What happens is unknown, undefined and
I think that you are lucky that it did not died :-( (patch to do this
is available at ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/fbaddon.gz,
but it is for something like 2.2.0-pre1 and will be never included into
Linus kernel as is.)
> timing values for fb0 are somehow getting used)  I can't see what I type,
> but the output is definitely trying to go to the matrox.  The funny part
Yes, it could happen.
> is the "scroll" is controlled by the kernel, which still correctly scrolls
> /dev/fb0 (control) so whenever I type enough to get a scroll to occur,
> matrox doesn't, but control does (even though no new text has appeared
> on control.)
Yes. You should switch current (or some tty) to /dev/fb1 and then
invoke fbset -fb /dev/fb1 from that tty. con2fb is on Geert's home page.
> I then ran "fbset -i -fb /dev/fb1" and console switched back to matrox
> with messed up fonts.  At some point I did a setenv FRAMEBUFFER /dev/fb1
> and ran "startx" and it came up on the matrox.  The only problem is that
You should not do it with fbset -i -fb /dev/fb1. You should use con2fb,
fbset -i -fb /dev/fb1 from tty device on fb0 corrupts internal kernel
structures.
> > > the kernel slightly, in that it assumes if you have a Mac, well then you
> > > must have a Mac matrox card, and OF should take care of initialization.
> > > Nope, I've got a x86 card, and it has to be initialized by the kernel.
> > > Simple one line hack in the init function for matroxfb.
If you have Matrox which cannot be initialized by OF, you should not
enable CONFIG_FB_OF. If you have both devices, you can try to persuade
OF to have two devices or edit sources. Sorry.
> in drivers/video/matroxfb.c:
>
> #ifndef MODULE
> __initfunc(void matroxfb_init(void))
> {
>         DBG("matroxfb_init")
> #if defined(CONFIG_FB_OF)
> /* Nothing to do, must be called from offb */
> #else
>         matrox_init();
> #endif
> }
>
> matrox_init never gets called on my system, so the card never inits.
> I just commented out the #ifdef stuff so that matrox_init always gets
> called and the card magically appears.
Yes, you must add "MTRX,...." somewhere into your OF configuration
(my PReP does not have OF and I never saw it...) If you uncommented #define
above, be sure that you commented out complement part from
drivers/video/offb.c - otherwise matroxfb can be initialized twice, thus
you'll get two fb's per one hardware :-(
> The current mode that I'm using, that "sort of works" for matroxfb is:
> (I'd _really_ like to be able to change this, but without timing values
> I can't get it to work, and as I said in the previous e-mail appending
> to the kernel video=matrox:vesa:<hex-code> results in a immediate panic
> (no error message, it just freezes) Any ideas short of getting the values
> from someone with a Mac version of the card who can use vmode or whatever
> to set the mode properly?)
Could you try put console to serial port and send me panic message, if
any comes out through serial port?
> I'm honestly less concerned with the console jumping back and forth.
> I just want to be able to fire up X on both monitors at the maximum
> res/depth for each card.
con2fb is your friend...
                                    Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz

P.S.: I'm not on the linuxppc-dev list, so CC me if you think that
I'm interested in that message.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
