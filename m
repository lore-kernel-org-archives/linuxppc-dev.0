MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [Fwd: Memory layout question]
Date: Tue, 25 May 2004 09:17:45 -0500
Message-ID: <DB1DE297F535B340AEAE1E51B221C3D007E83FF4@FTWMLVEM02.e2k.ad.ge.com>
From: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
To: "Oliver Korpilla" <okorpil@fh-landshut.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We're setting up a 2700 here to test with, so that will help.

> It's not done and over with virt_to_bus() etc.
>
> What we basically got here is a PCI configuration and
> portability issue.
>
> On the MVME2100, e.g., the PCI host bridge grabs I/O resource
> 0x80000000
> - 0xFFFFFFFF.
>
> On the VMIC driver it requests an I/O memory ressource, and a
> region on
> the I/O memory is awarded.
>
> In order to request a region being mapped by the PCI host bridge, one
> would have to request a region of the PCI host bridge
> resource, not the
> I/O resource.

Can the pci_lo_bound and pci_hi_bound module parameter be used to
limit the range of memory resources requested to those available to
the PCI bridge that the Universe chip lives behind.

>
> As far as I can deduce from looking at kernel/resource.c
> allocate_resource(), find_resource() and __request_resource() have no
> recursion, so one cannot request an appropriate region from the
> iomem_resource.
>
> I guess to do it portably PCI functions may be needed, though
> I'm still
> looking at it.
>
>  From my current knowledge, the driver may have 3 issues:
> 1) How to request a "safe" range of PCI addresses.

The pci_lo_bound and pci_hi_bound module parameters may help.

> 2) How to map those PCI addresses safely to virtual (kernel) and bus
> (PCI device) addresses.
> 3) Using the safer readb/readw ... etc. calls, or stuff like
> memcpy_io
> to portably access the VME bus, perhaps in read() and write()
> implementations, perhaps deprecating the not-so-portable
> dereferencing
> of a pointer.

Issue 3 gets confusing, (as endian issues always do). On VMIC hardware,
there is custom byte swapping hardware to deal with the big-endian VMEbus
to little-endian PCI bus. The Universe chip also has some internal byte
swapping hardware. I not sure that the read[bwl]/write[bwl] calls
would do the correct thing considering the existing byte swapping hardware.
(I'm not sure it would do the wrong thing either :-/)

> 1) and 2) are non-issues on the x86, because of the PCI and memory
> layout. So all these 3 issues are about portability.
>
> I'm looking into this, starting with 2) currently.
>
> Maybe the driver would be easier to port and maintain, if the
> universe
> gets treated like a "proper" PCI device right from the start. I'm not
> experienced enough to say something about that right now.

Unfortunately, that's the design of the Tundra Universe chip.
I don't thing there is any way for us to correct that.

Daniel L. Heater
Software Development, Embedded Systems
GE Fanuc Automation Americas, Inc.
VMIC, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
