Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 38CF3B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 21 Aug 2011 02:51:56 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 20 Aug 2011 09:51:39 -0700
In-Reply-To: <1312944513.29273.28.camel@pasglop>
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
	<20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1313859105.6866.192.camel@x201.home>
Mime-Version: 1.0
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>, aafabbri <aafabbri@cisco.com>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
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

We had an extremely productive VFIO BoF on Monday.  Here's my attempt to
capture the plan that I think we agreed to:

We need to address both the description and enforcement of device
groups.  Groups are formed any time the iommu does not have resolution
between a set of devices.  On x86, this typically happens when a
PCI-to-PCI bridge exists between the set of devices and the iommu.  For
Power, partitionable endpoints define a group.  Grouping information
needs to be exposed for both userspace and kernel internal usage.  This
will be a sysfs attribute setup by the iommu drivers.  Perhaps:

# cat /sys/devices/pci0000:00/0000:00:19.0/iommu_group
42

(I use a PCI example here, but attribute should not be PCI specific)

>From there we have a few options.  In the BoF we discussed a model where
binding a device to vfio creates a /dev/vfio$GROUP character device
file.  This "group" fd provides provides dma mapping ioctls as well as
ioctls to enumerate and return a "device" fd for each attached member of
the group (similar to KVM_CREATE_VCPU).  We enforce grouping by
returning an error on open() of the group fd if there are members of the
group not bound to the vfio driver.  Each device fd would then support a
similar set of ioctls and mapping (mmio/pio/config) interface as current
vfio, except for the obvious domain and dma ioctls superseded by the
group fd.

Another valid model might be that /dev/vfio/$GROUP is created for all
groups when the vfio module is loaded.  The group fd would allow open()
and some set of iommu querying and device enumeration ioctls, but would
error on dma mapping and retrieving device fds until all of the group
devices are bound to the vfio driver.

In either case, the uiommu interface is removed entirely since dma
mapping is done via the group fd.  As necessary in the future, we can
define a more high performance dma mapping interface for streaming dma
via the group fd.  I expect we'll also include architecture specific
group ioctls to describe features and capabilities of the iommu.  The
group fd will need to prevent concurrent open()s to maintain a 1:1 group
to userspace process ownership model.

Also on the table is supporting non-PCI devices with vfio.  To do this,
we need to generalize the read/write/mmap and irq eventfd interfaces.
We could keep the same model of segmenting the device fd address space,
perhaps adding ioctls to define the segment offset bit position or we
could split each region into it's own fd (VFIO_GET_PCI_BAR_FD(0),
VFIO_GET_PCI_CONFIG_FD(), VFIO_GET_MMIO_FD(3)), though we're already
suffering some degree of fd bloat (group fd, device fd(s), interrupt
event fd(s), per resource fd, etc).  For interrupts we can overload
VFIO_SET_IRQ_EVENTFD to be either PCI INTx or non-PCI irq (do non-PCI
devices support MSI?).

For qemu, these changes imply we'd only support a model where we have a
1:1 group to iommu domain.  The current vfio driver could probably
become vfio-pci as we might end up with more target specific vfio
drivers for non-pci.  PCI should be able to maintain a simple -device
vfio-pci,host=bb:dd.f to enable hotplug of individual devices.  We'll
need to come up with extra options when we need to expose groups to
guest for pvdma.

Hope that captures it, feel free to jump in with corrections and
suggestions.  Thanks,

Alex
