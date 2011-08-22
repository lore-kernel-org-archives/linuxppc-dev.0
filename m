Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13DCFB6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 07:50:07 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: aafabbri <aafabbri@cisco.com>
In-Reply-To: <CA781A61.FB15%aafabbri@cisco.com>
References: <CA781A61.FB15%aafabbri@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Aug 2011 07:49:45 +1000
Message-ID: <1314049785.7662.44.camel@pasglop>
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	iommu <iommu@lists.linux-foundation.org>, chrisw <chrisw@sous-sol.org>,
	Alex Williamson <alex.williamson@redhat.com>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, benve@cisco.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > I wouldn't use uiommu for that.
> 
> Any particular reason besides saving a file descriptor?
> 
> We use it today, and it seems like a cleaner API than what you propose
> changing it to.

Well for one, we are back to square one vs. grouping constraints.

 .../...

> If we in singleton-group land were building our own "groups" which were sets
> of devices sharing the IOMMU domains we wanted, I suppose we could do away
> with uiommu fds, but it sounds like the current proposal would create 20
> singleton groups (x86 iommu w/o PCI bridges => all devices are partitionable
> endpoints).  Asking me to ioctl(inherit) them together into a blob sounds
> worse than the current explicit uiommu API.

I'd rather have an API to create super-groups (groups of groups)
statically and then you can use such groups as normal groups using the
same interface. That create/management process could be done via a
simple command line utility or via sysfs banging, whatever...

Cheers,
Ben.

> Thanks,
> Aaron
> 
> > 
> > Another option is to make that static configuration APIs via special
> > ioctls (or even netlink if you really like it), to change the grouping
> > on architectures that allow it.
> > 
> > Cheers.
> > Ben.
> > 
> >> 
> >> -Aaron
> >> 
> >>> As necessary in the future, we can
> >>> define a more high performance dma mapping interface for streaming dma
> >>> via the group fd.  I expect we'll also include architecture specific
> >>> group ioctls to describe features and capabilities of the iommu.  The
> >>> group fd will need to prevent concurrent open()s to maintain a 1:1 group
> >>> to userspace process ownership model.
> >>> 
> >>> Also on the table is supporting non-PCI devices with vfio.  To do this,
> >>> we need to generalize the read/write/mmap and irq eventfd interfaces.
> >>> We could keep the same model of segmenting the device fd address space,
> >>> perhaps adding ioctls to define the segment offset bit position or we
> >>> could split each region into it's own fd (VFIO_GET_PCI_BAR_FD(0),
> >>> VFIO_GET_PCI_CONFIG_FD(), VFIO_GET_MMIO_FD(3)), though we're already
> >>> suffering some degree of fd bloat (group fd, device fd(s), interrupt
> >>> event fd(s), per resource fd, etc).  For interrupts we can overload
> >>> VFIO_SET_IRQ_EVENTFD to be either PCI INTx or non-PCI irq (do non-PCI
> >>> devices support MSI?).
> >>> 
> >>> For qemu, these changes imply we'd only support a model where we have a
> >>> 1:1 group to iommu domain.  The current vfio driver could probably
> >>> become vfio-pci as we might end up with more target specific vfio
> >>> drivers for non-pci.  PCI should be able to maintain a simple -device
> >>> vfio-pci,host=bb:dd.f to enable hotplug of individual devices.  We'll
> >>> need to come up with extra options when we need to expose groups to
> >>> guest for pvdma.
> >>> 
> >>> Hope that captures it, feel free to jump in with corrections and
> >>> suggestions.  Thanks,
> >>> 
> >>> Alex
> >>> 
> > 
> > 
