Date: Sat, 25 Mar 2000 16:39:37 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: linuxppc-dev@lists.linuxppc.org
cc: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <38DCCCF4.2868082E@iiic.ethz.ch>
Message-ID: <Pine.LNX.4.10.10003251615560.26717-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Nah, I take this to mean we better fix our PCI resource conflicts in the
> > kernel if at all possible. But as I see everybody juggle with PCI resource
> > and hot swap options only available in 2.3 the XFree people should plaster
> > a big fat warning 'will not work with 2.2 kernels on some PPC hardware' on
> > their release notes.
>
> You are thinking Linux centric IMHO. XFree86 runs on a variety of OSs. AFAIK
> the X PCI code we're talking about is OS independent.

It is OS independent. And I concede my point of view is Linux centric
(which may be excused as I haven't seen XFree on anything beside Linux
yet). The problem is with the PCI setup by OF or MacOS, and can probably
be fixed in the kernel, that's what I'll try next.

Anyway, as things are now, XFree 4.0 not working on Lombard Powerbooks
seems a safe bet, and XFree 4.0 not working on other Powermac models with
the same Mach64 chipset seems likely.

> > fine. Suddenly the kernel isn't to be trusted to correctly set up things
> > anymore, and we're back to square one in terms of X stability. How did
> > that happen?
>
> The _big_ difference is that _the FBDev_ server was responsible for fbdev only
> (I imagine it didn't have to care about PCI stuff at all), while there is only
> one server for all drivers now, and it has to deal with several drivers
> working on the same machine.

I've seen a device option "UseFBDev" in XF86Config. I take that to mean
XFree knows a particular device (even with it's BusID specified) is going
to be handled by a framebuffer driver. Assuming the framebuffer driver
makes sure no PCI access conflicts with _other_ hardware happen, I see no
problem with XFree managing all the other drivers but considering the
framebuffer driven devices off limits in terms of PCI fixup.

> > I'd be glad if the X PCI code would recognize the same facts as reported
> > via the kernel /proc/bus/pci interface, and 1) leave disabled regions
> > alone and not bitch about them, 2) tolerate one region being fully
> > contained inside another if it's on the same card. But it sure is easier
> > to work around X.
>
> It sure is easy to complain about something and not try to enhance it.

I've been banging my head over the X PCI code more hours already than I
would like. Not counting debugging where exactly X crashes the
kernel. I just don't get it. Color me clueless on X server workings, or
PCI in general. Enhancing the X PCI code sure is beyond me. Thanks for
listening anyways.

> > between X and kernel is fine, but why not leave things as they were for
> > framebuffer drivers? This is all that the framebuffer concept was about,
> > why throw it out?
>
> Because X can currently only determine what is controlled by an fbdev via
> heuristics regarding the memory regions themselves. (With 32 bit busses on 64
> bit machines it may even be impossible). Jeff Garzik has proposed a solution
> for this with a new ioctl.

I though X could take a hint from the Device section in the config file?

Section "Device"
    Identifier  "ATY Mach64"
    Driver      "fbdev"
    Option	"no accel"
    Option	"UseFBDev"
    BusID	"PCI:0:17:0"

... seems to say enough. That's not an autoprobed config though;
autoprobing won't be possible to guess a device will use a framebuffer
driver anyway, or will it?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
