Message-ID: <19990202023740.A479@toocool.calpoly.edu>
Date: Tue, 2 Feb 1999 02:37:40 -0800
From: "dhiltgen@toocool.calpoly.edu" <dhiltgen@toocool.itslab.calpoly.edu>
To: Owen Waller <O.Waller@ee.qub.ac.uk>,
        "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>
Cc: mlan@cpu.lu, Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
References: <1EB9B063356@vcnet.vc.cvut.cz> <Pine.SGI.4.02A.9902011106470.11398-100000@myst.ee.qub.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SGI.4.02A.9902011106470.11398-100000@myst.ee.qub.ac.uk>; from Owen Waller on Mon, Feb 01, 1999 at 11:35:16AM -0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK, I've made a bit more progress...

Using con2fb makes the console switching much happier...  I associated
tty2 to matrox and left the rest on control.  The tty2 console didn't
move immediately; I had to run fbset -i -fb /dev/fb1 on tty2 (still
visually on control) at which point it popped over to matrox.  From then
on I could switch back and forth and everything worked as expected.

The cursor tends to get messed up on matrox... a second "large"
multi-color funky cursor square (about 4x larger) exists after an fbset.
As soon as I switch consoles back to control, the cursor cleared back up.
(This was consistent every time I ran fbset.)

Scrolling is still messed up.  When the matrox scrolls off the end,
control gets the scroll action.  Again, if I switch consoles things get
reset as they should be. ^L will also clean it up temporarily.

I can get two X servers started, and I tried to use "X :0 tty1" for one
of them and "X :1 tty2" for the other, but I can't get them to co-exist
happily.  The first one always takes tty7.  I even tried "-keeptty" as
it sounded like it might force the X server to stick to the initial tty
instead of 7.  Bottom line:  I can switch from either one to console,
but I can only get back to the first one that I started through
tty7. (Either matrox or control but never both)

Also, only the active X server is "alive."  The second one just freezes
as if it thinks it lost the console to a VC switch.... not the desired
result.  So is this an X server issue, (Should ignore the VC switch) or a
kernel issue?  Sounds like a kernel issue, as the kernel should realize
that the X server still has the framebuffer, and therefore should still
"think" that it is active.  If no-one speaks up I might go hacking next
week and see if I can cludge something to get it to the point where both
X servers get console data...  Geert, any thoughts?

So, two questions.    

1) How can I get the two X servers to use different VCs so that I can 
switch between them.  Alternatively...

2) Is there any way to get the mouse to "fall off" one side and end
up on the other X server (Like Sun's with multiple heads.)  XFree86 4.0
maybe?  Is it even close to usable yet if I signed up to be a developer,
or is it really messy right now?

Oh, and I've downloaded 3.3.3 and applied the SVGA patch and it didn't
build out of the box (unrelated to the patch, looks like ppc issues with
other parts of the build.)  I haven't started tweaking yet but as soon
as I get some more free time I'll see if I can get it to build.



Note:  All of this was without passing any kernel parameters.  I'm now
running with "video=matrox:vesa:0x11a,nopan,fv:80" and only using the
matrox buffer and it works great as /dev/fb0.  Now all I have to do is
get that darn accelerated X server working. ;)   Of course if I try to do
stuff with control (/dev/fb1 now) things start getting screwy again.

Thanks.

-- 
Daniel Kerry Hiltgen     Computer Science     Cal Poly, San Luis Obispo, CA  
dhiltgen@www.itslab.calpoly.edu    http://www.itslab.calpoly.edu/~dhiltgen/

"In a world without fences who needs Gates?"  1997 JavaOne Conference

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
