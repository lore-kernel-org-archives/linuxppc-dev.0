Message-ID: <38DDD12E.43809311@iiic.ethz.ch>
Date: Sun, 26 Mar 2000 10:58:22 +0200
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: linuxppc-dev@lists.linuxppc.org, Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LongTrail PCI resource assignment
References: <Pine.LNX.4.10.10003251615560.26717-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> Anyway, as things are now, XFree 4.0 not working on Lombard Powerbooks
> seems a safe bet, and XFree 4.0 not working on other Powermac models with
> the same Mach64 chipset seems likely.

Due to buggy OF and/or Linux kernels.


> > > fine. Suddenly the kernel isn't to be trusted to correctly set up things
> > > anymore, and we're back to square one in terms of X stability. How did
> > > that happen?
> >
> > The _big_ difference is that _the FBDev_ server was responsible for fbdev > > only (I imagine it didn't have to care about PCI stuff at all), while
> > there is only one server for all drivers now, and it has to deal with
> > several drivers working on the same machine.
>
> I've seen a device option "UseFBDev" in XF86Config. I take that to mean
> XFree knows a particular device (even with it's BusID specified) is going
> to be handled by a framebuffer driver.

No. The option is in the Device Section and thus driver-dependant. It just
tells the driver to use fbdev for mode setting/switching etc. instead of
banging the hardware directly. The option can be there but not the fbdev, the
driver should then just fall back to banging.

And only a few drivers (glint, r128, nv, mga, ???) currently support that
option.


> Assuming the framebuffer driver makes sure no PCI access conflicts with
> _other_ hardware happen, I see no problem with XFree managing all the other
> drivers but considering the framebuffer driven devices off limits in terms
> of PCI fixup.

Yes, once X has a safe way of telling what is controlled by an fbdev that
should be no problem.


> > > I'd be glad if the X PCI code would recognize the same facts as reported
> > > via the kernel /proc/bus/pci interface, and 1) leave disabled regions
> > > alone and not bitch about them, 2) tolerate one region being fully
> > > contained inside another if it's on the same card. But it sure is easier
> > > to work around X.
> >
> > It sure is easy to complain about something and not try to enhance it.
>
> I've been banging my head over the X PCI code more hours already than I
> would like. Not counting debugging where exactly X crashes the
> kernel. I just don't get it. Color me clueless on X server workings, or
> PCI in general. Enhancing the X PCI code sure is beyond me. Thanks for
> listening anyways.

If you can't fix/work around it yourself, you could post your ideas to
devel@XFree86.Org (state clearly that you're not on the list as the reply-to
is set to it) and in particular to Egbert Eich
<eich@hilbert.ikp.physik.tu-darmstadt.de>

Nothing will ever happen if you're complaining about X on linuxppc-dev.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
