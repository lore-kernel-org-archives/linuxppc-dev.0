From: "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>
To: "dhiltgen@toocool.calpoly.edu" <dhiltgen@toocool.itslab.calpoly.edu>
Date: Tue, 2 Feb 1999 12:53:20 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: matroxfb, anybody? (More details...)
CC: O.Waller@ee.qub.ac.uk, mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org,
        Geert.Uytterhoeven@cs.kuleluven.ac.be
Message-ID: <205EF7C55EE@vcnet.vc.cvut.cz>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  2 Feb 99 at 2:37, dhiltgen@toocool.calpoly.edu wrote:
> Using con2fb makes the console switching much happier...  I associated
> tty2 to matrox and left the rest on control.  The tty2 console didn't
> move immediately; I had to run fbset -i -fb /dev/fb1 on tty2 (still
You have some problem somewhere. If I do (atyfb + matroxfb or vga16fb +
matroxfb):
<switch to tty2>
con2fb /dev/fb1 /dev/tty2
then immediately at this point contents of screen on atyfb/vga16fb is
frozen and output on matroxfb is activated. Without any intervening
fbset, of course. I hope, that resolution on controlfb is compatible
with matroxfb capabilities (i.e. 8-32 bpp, 4bpp only on Millennium I/II).
> The cursor tends to get messed up on matrox... a second "large"
> multi-color funky cursor square (about 4x larger) exists after an fbset.
Could it be forgotten fbcon software cursor (flashing box 1x1 character)?
It could be also 32x32 pixels uninitialized hardware cursor, but I do not
know why driver should forget to initialize it.
> Scrolling is still messed up.  When the matrox scrolls off the end,
> control gets the scroll action.  Again, if I switch consoles things get
> reset as they should be. ^L will also clean it up temporarily.
? Isn't it control problem? vgacon + matroxfb, vga16fb + matroxfb,
atyfb + matroxfb and matroxfb + matroxfb hapilly coexist here...
BTW, updates on non-fg framebuffer are suspended until you switch
to that framebuffer.
> I can get two X servers started, and I tried to use "X :0 tty1" for one
> of them and "X :1 tty2" for the other, but I can't get them to co-exist.
> happily.  The first one always takes tty7.  I even tried "-keeptty" as
> it sounded like it might force the X server to stick to the initial tty
> instead of 7.  Bottom line:  I can switch from either one to console,
> but I can only get back to the first one that I started through
> tty7. (Either matrox or control but never both)
It could be on tty8. And I think that you want to run `X vt2 :1'
(I hope that it is not fbdev specific option).
> Also, only the active X server is "alive."  The second one just freezes
> as if it thinks it lost the console to a VC switch.... not the desired
> result.  So is this an X server issue, (Should ignore the VC switch) or a
> kernel issue?  Sounds like a kernel issue, as the kernel should realize
It is kernel issue. At least, it send signals about getting/loosing fg
terminal on every console switch.
> 1) How can I get the two X servers to use different VCs so that I can
> switch between them.  Alternatively...
I did "XF86_Mach64 & ; XF86_SVGA :1 &" just now and I got
Mach64 server running (on top of vga16fb) on /dev/tty24 and Matrox
running on /dev/tty25... /dev/tty24 is available here as right-alt-ctrl-F12,
/dev/tty25 as left-alt-ctrl-F1 + alt-left_arrow... Both hapilly working.
You can switch between them, but, of course, only one updates screen in
one moment. Because of I have dual-input EIZO, it does not cause problems
to me :-)
> 2) Is there any way to get the mouse to "fall off" one side and end
> up on the other X server (Like Sun's with multiple heads.)  XFree86 4.0
> maybe?  Is it even close to usable yet if I signed up to be a developer,
> or is it really messy right now?
I do not think that it is possible at this moment.
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz

> Note:  All of this was without passing any kernel parameters.  I'm now
> running with "video=matrox:vesa:0x11a,nopan,fv:80" and only using the
Why nopan? It must be slow as hell...

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
