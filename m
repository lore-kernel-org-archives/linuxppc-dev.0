Message-ID: <40B35085.7090006@fh-landshut.de>
Date: Tue, 25 May 2004 15:56:21 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Fwd: Memory layout question]
References: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com>
In-Reply-To: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

It's not done and over with virt_to_bus() etc.

What we basically got here is a PCI configuration and portability issue.

On the MVME2100, e.g., the PCI host bridge grabs I/O resource 0x80000000
- 0xFFFFFFFF.

On the VMIC driver it requests an I/O memory ressource, and a region on
the I/O memory is awarded.

In order to request a region being mapped by the PCI host bridge, one
would have to request a region of the PCI host bridge resource, not the
I/O resource.

As far as I can deduce from looking at kernel/resource.c
allocate_resource(), find_resource() and __request_resource() have no
recursion, so one cannot request an appropriate region from the
iomem_resource.

I guess to do it portably PCI functions may be needed, though I'm still
looking at it.

 From my current knowledge, the driver may have 3 issues:
1) How to request a "safe" range of PCI addresses.
2) How to map those PCI addresses safely to virtual (kernel) and bus
(PCI device) addresses.
3) Using the safer readb/readw ... etc. calls, or stuff like memcpy_io
to portably access the VME bus, perhaps in read() and write()
implementations, perhaps deprecating the not-so-portable dereferencing
of a pointer.

1) and 2) are non-issues on the x86, because of the PCI and memory
layout. So all these 3 issues are about portability.

I'm looking into this, starting with 2) currently.

Maybe the driver would be easier to port and maintain, if the universe
gets treated like a "proper" PCI device right from the start. I'm not
experienced enough to say something about that right now.

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
