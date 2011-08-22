Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8FBFBB6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 06:49:55 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: aafabbri <aafabbri@cisco.com>
In-Reply-To: <CA780A2A.FB0B%aafabbri@cisco.com>
References: <CA780A2A.FB0B%aafabbri@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Aug 2011 06:49:31 +1000
Message-ID: <1314046171.7662.27.camel@pasglop>
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

On Mon, 2011-08-22 at 13:29 -0700, aafabbri wrote:

> > Each device fd would then support a
> > similar set of ioctls and mapping (mmio/pio/config) interface as current
> > vfio, except for the obvious domain and dma ioctls superseded by the
> > group fd.
> > 
> > Another valid model might be that /dev/vfio/$GROUP is created for all
> > groups when the vfio module is loaded.  The group fd would allow open()
> > and some set of iommu querying and device enumeration ioctls, but would
> > error on dma mapping and retrieving device fds until all of the group
> > devices are bound to the vfio driver.
> > 
> > In either case, the uiommu interface is removed entirely since dma
> > mapping is done via the group fd.
> 
> The loss in generality is unfortunate. I'd like to be able to support
> arbitrary iommu domain <-> device assignment.  One way to do this would be
> to keep uiommu, but to return an error if someone tries to assign more than
> one uiommu context to devices in the same group.

I wouldn't use uiommu for that. If the HW or underlying kernel drivers
support it, what I'd suggest is that you have an (optional) ioctl to
bind two groups (you have to have both opened already) or for one group
to "capture" another one.

The binding means under the hood the iommus get shared, with the
lifetime being that of the "owning" group.

Another option is to make that static configuration APIs via special
ioctls (or even netlink if you really like it), to change the grouping
on architectures that allow it.

Cheers.
Ben.

> 
> -Aaron
> 
> > As necessary in the future, we can
> > define a more high performance dma mapping interface for streaming dma
> > via the group fd.  I expect we'll also include architecture specific
> > group ioctls to describe features and capabilities of the iommu.  The
> > group fd will need to prevent concurrent open()s to maintain a 1:1 group
> > to userspace process ownership model.
> > 
> > Also on the table is supporting non-PCI devices with vfio.  To do this,
> > we need to generalize the read/write/mmap and irq eventfd interfaces.
> > We could keep the same model of segmenting the device fd address space,
> > perhaps adding ioctls to define the segment offset bit position or we
> > could split each region into it's own fd (VFIO_GET_PCI_BAR_FD(0),
> > VFIO_GET_PCI_CONFIG_FD(), VFIO_GET_MMIO_FD(3)), though we're already
> > suffering some degree of fd bloat (group fd, device fd(s), interrupt
> > event fd(s), per resource fd, etc).  For interrupts we can overload
> > VFIO_SET_IRQ_EVENTFD to be either PCI INTx or non-PCI irq (do non-PCI
> > devices support MSI?).
> > 
> > For qemu, these changes imply we'd only support a model where we have a
> > 1:1 group to iommu domain.  The current vfio driver could probably
> > become vfio-pci as we might end up with more target specific vfio
> > drivers for non-pci.  PCI should be able to maintain a simple -device
> > vfio-pci,host=bb:dd.f to enable hotplug of individual devices.  We'll
> > need to come up with extra options when we need to expose groups to
> > guest for pvdma.
> > 
> > Hope that captures it, feel free to jump in with corrections and
> > suggestions.  Thanks,
> > 
> > Alex
> > 
