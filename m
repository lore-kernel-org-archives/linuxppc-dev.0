Date: Thu, 30 Mar 2000 14:49:57 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michel Dänzer <michdaen@iiic.ethz.ch>
cc: "William H. Schultz" <whschult@uncc.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Xinerama Support?
In-Reply-To: <38E326E2.49A7AD62@iiic.ethz.ch>
Message-ID: <Pine.LNX.4.21.0003301409540.19872-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 30 Mar 2000, Michel Dänzer wrote:

>
> > I haven't swapped over from sawmill, but the significant difference in speed
> > between the two is pretty important to me (since I'm not running a new
> > machine with accelerated X support--just an old 8500 with a Voodoo3).
>
> I also like Sawmill very much, but the tdfx driver for Voodoo3 should be very
> well accelerated - have you tried Kostas' patches to make it work?
>

  The tdfx driver won't work without PIO support for now, for my machine
i mmap the right iobase but obviously this isn't going to work in other
machines so its not on much of use for other people.

I am working in fbdev support in the tdfx driver but its not ready yet
and fbdev doesn't make this easy at all, for example if tdfxfb uses
a hw cursor the fb memory you mmap starts at an offset and you have no
way to know what this offset is, the xdriver *has* to know this to
program the command fifo :(


> > I set up two different monitors, two different "device" sections, and two
> > different "screen" sections.
>
> Sounds good to me, but then I haven't tried Xinerama yet.
>

You also need to tell the xserver which screens to use, here is what i use

Section "ServerLayout"
  Identifier "Main Layout"
  Screen "myScreen1"
  Screen "myScreen2" RightOf "myScreen1"

  InputDevice "Mouse1" "CorePointer"
  InputDevice "Keyboard1" "CoreKeyboard"
EndSection

>
> > However, I read on here that fbdev has to have a bus ID to work, and there
> > is none (that I'm aware of) on my internal video.
>
> Nothing about a video adapter in /proc/pci (or the output of lspci)?
>

  If the internal video doesn't isn't in /proc/pci then you have no
problem, the xserver won't detect the card so you can go away without the
BusID line.


  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
