Date: Tue, 8 Dec 1998 09:47:27 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: Tom Rini <tmrini@ntplx.net>
cc: Martin Costabel <costabel@lie.univ-rennes1.fr>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: pre-R5&miscs
In-Reply-To: <Pine.LNX.4.05.9812071636130.1031-100000@pc.wackyland.com>
Message-ID: <Pine.BSI.3.96.981208093553.13521A-100000@usr09.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Dec 1998, Tom Rini wrote:

> > I tried to run the Xpmac from R4, fixed by fix961212, but it dies saying it 
> > cannot define the default font path and doesn't find the font 'fixed'. But
> > this is exactly the same font path that Xpmac from pre-R5 finds without
> > problems. Weird. 
> 
> Nope, expected.  There's some oddity with X servers and X11R6<->XFree86 it
> seems.  I -think-.  Might just be problems trying to read the fonts of
> course..
> 

I think the X11R6 servers can't decompress the gzipped (.gz) fonts, but they
can decompress compressed (.Z) fonts.  I remember having this problem some
time about with X11R6 and the XFree fonts.

On a side note, I've rebuilt the Xbh server in the XFree86 Servers heirarchy
and it seems to be running ok (though I added the power management function
from XFree and haven't tested it yet).  This runs with the XFree86 3.3.3
distribution (glibc1.99 only -- I don't have the hard drive space to upgrade
as of yet).  In addition, I changed it to open /dev/tty0 instead of
/dev/console so it works with the later 2.1.X kernels, _and_ it has some
tweaks for 32-bit color to work (but there's a lot of flicker when text
scrolls so I don't know if I have the timing values right -- no bitblt at
that depth).

I haven't talked to Chris Nadig (hope I have the name right -- going from
memory) recently -- he did most of the Xbh stuff originally -- so most of
these tweaks are probably only in my code.  I'll make the server available
if people want it, though I don't know a place to put it yet.

In addition, I've been playing with the Xfree86 mono server just to learn
Xfee86 stuff, and as a break (as if I've been playing with it enough to need
a break) from the clgen framebuffer code.  With my luck I'll have the mono
server working first.  Anyway -- about clgen, I have it so I can boot with
that framebuffer enabled, but I can't open a virtual terminal with it (but
remotely logging in I can change the screenmode with fbmode (or whatever
that program was called).  haven't looked into it recently, but I hope to
have more time now.  When trying to install the framebuffer as a module, I
get kernel panics, but I'm wondering if its because I'm trying to send debug
output (printk) to a non-initialized console.

Any comments on the above appreciated.

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

..Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
