Message-ID: <40B43779.8040107@fh-landshut.de>
Date: Wed, 26 May 2004 08:21:45 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
Reply-To: okorpil@fh-landshut.de
MIME-Version: 1.0
To: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Fwd: Memory layout question]
References: <DB1DE297F535B340AEAE1E51B221C3D007E83FF4@FTWMLVEM02.e2k.ad.ge.com>
In-Reply-To: <DB1DE297F535B340AEAE1E51B221C3D007E83FF4@FTWMLVEM02.e2k.ad.ge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Heater, Daniel (GE Infrastructure) wrote:

>We're setting up a 2700 here to test with, so that will help.
>
>
>
Have you run into similar issues with the VMIVME7050?

>>In order to request a region being mapped by the PCI host bridge, one
>>would have to request a region of the PCI host bridge
>>resource, not the
>>I/O resource.
>>
>>
>
>Can the pci_lo_bound and pci_hi_bound module parameter be used to
>limit the range of memory resources requested to those available to
>the PCI bridge that the Universe chip lives behind.
>
>
>
Actually I tried that out - it's the only way to even load the driver on
a MVME2100 without interfering with the Tulip Ethernet driver. While
both these define sane bounds to allocate I/O memory from, if set
correctly, the allocation request always fails because of the different
layout of the resource tree.

On x86: I/O memory -> Addresses relevant for the Tundra.
on PPC: I/O memory -> PCI host bridge -> Addresses relevant for the Tundra.

Since allocate_resource() does not traverse the tree, but instead tries
to allocate a resource as a child of the resource given (here:
iomem_resource), this will always fail: All the PCI addresses can only
be allocated to children of "PCI host bridge", not to children of I/O
memory.

>>From my current knowledge, the driver may have 3 issues:
>>1) How to request a "safe" range of PCI addresses.
>>
>>
>
>The pci_lo_bound and pci_hi_bound module parameters may help.
>
>
>
See above.

>>3) Using the safer readb/readw ... etc. calls, or stuff like
>>memcpy_io
>>to portably access the VME bus, perhaps in read() and write()
>>implementations, perhaps deprecating the not-so-portable
>>dereferencing
>>of a pointer.
>>
>>
>
>Issue 3 gets confusing, (as endian issues always do). On VMIC hardware,
>there is custom byte swapping hardware to deal with the big-endian VMEbus
>to little-endian PCI bus. The Universe chip also has some internal byte
>swapping hardware. I not sure that the read[bwl]/write[bwl] calls
>would do the correct thing considering the existing byte swapping hardware.
>(I'm not sure it would do the wrong thing either :-/)
>
>
>
Well, I'm not to sure either: They'd at least byte-swap between CPU and
PCI bus, because they are of different endianness on the PPC. Generally
spoken, since we can have both Intel and PowerPC boards on the VME, I
guess this will always be an issue. Either you configure the hardware on
the VME, or you have to work some magic in software. But dereferencing a
pointer into I/O memory is simply not safe on every architecture or
platform. Maybe, all in all, read() and write() with memcpy_io() may be
more portable and robust, and the pointer stuff can be used for x86 only.

>>Maybe the driver would be easier to port and maintain, if the
>>universe
>>gets treated like a "proper" PCI device right from the start. I'm not
>>experienced enough to say something about that right now.
>>
>>
>
>Unfortunately, that's the design of the Tundra Universe chip.
>I don't thing there is any way for us to correct that.
>
>
I see. But I meant not the memory window mechanism, but the data
structures of the driver. If we're only trying to handle PCI stuff, why
not flesh it out as a PCI driver. The data structures of PCI drivers
like pci_dev can be used instead of our own generic handle. It may be
that we need the PCI functions to do everything portably, so adaption of
interface to that of other PCI devices may become necessary to satisfy
interfaces of PCI-related calls. I'm still looking into this.

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
