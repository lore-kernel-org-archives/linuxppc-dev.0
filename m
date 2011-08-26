Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 94CFBB6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Aug 2011 03:42:28 +1000 (EST)
Subject: VFIO v2 design plan
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 26 Aug 2011 11:05:23 -0600
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314378325.2859.307.camel@bling.home>
Mime-Version: 1.0
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	agraf@suse.de, qemu-devel <qemu-devel@nongnu.org>,
	David Gibson <dwg@au1.ibm.com>, aafabbri <aafabbri@cisco.com>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>, "Roedel,
	Joerg" <Joerg.Roedel@amd.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, benve@cisco.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I don't think too much has changed since the previous email went out,
but it seems like a good idea to post a summary in case there were
suggestions or objections that I missed.

VFIO v2 will rely on the platform iommu driver reporting grouping
information.  Again, a group is a set of devices for which the iommu
cannot differentiate transactions.  An example would be a set of devices
behind a PCI-to-PCI bridge.  All transactions appear to be from the
bridge itself rather than devices behind the bridge.  Platforms are free
to have whatever constraints they need to for what constitutes a group.

I posted a rough draft of patch to implement that for the base iommu
driver and VT-d, adding an iommu_device_group callback on iommu ops.
The iommu base driver also populates an iommu_group sysfs file for each
device that's part of a group.  Members of the same group return the
same value via either the sysfs or iommu_device_group.  The value
returned is arbitrary, should not be assumed to be persistent across
boots, and is left to the iommu driver to generate.  There are some
implementation details around how to do this without favoring one bus
over another, but the interface should be bus/device type agnostic in
the end.

When the vfio module is loaded, character devices will be created for
each group in /dev/vfio/$GROUP.  Setting file permissions on these files
should be sufficient for providing a user with complete access to the
group.  Opening this device file provides what we'll call the "group
fd".  The group fd is restricted to only work with a single mm context.
Concurrent opens will be denied if the opening process mm does not
match.  The group fd will provide interfaces for enumerating the devices
in the group, returning a file descriptor for each device in the group
(the "device fd"), binding groups together, and returning a file
descriptor for iommu operations (the "iommu fd").

A group is "viable" when all member devices of the group are bound to
the vfio driver.  Until that point, the group fd only allows enumeration
interfaces (ie. listing of group devices).  I'm currently thinking
enumeration will be done by a simple read() on the device file returning
a list of dev_name()s.  Once the group is viable, the user may bind the
group to another group, retrieve the iommu fd, or retrieve device fds.
Internally, each of these operations will result in an iommu domain
being allocated and all of the devices attached to the domain.

The purpose of binding groups is to share the iommu domain.  Groups
making use of incompatible iommu domains will fail to bind.  Groups
making use of different mm's will fail to bind.  The vfio driver may
reject some binding based on domain capabilities, but final veto power
is left to the iommu driver[1].  If a user makes use of a group
independently and later wishes to bind it to another group, all the
device fds and the iommu fd must first be closed.  This prevents using a
stale iommu fd or accessing devices while the iommu is being switched.
Operations on any group fds of a merged group are performed globally on
the group (ie. enumerating the devices lists all devices in the merged
group, retrieving the iommu fd from any group fd results in the same fd,
device fds from any group can be retrieved from any group fd[2]).
Groups can be merged and unmerged dynamically.  Unmerging a group
requires the device fds for the outgoing group are closed.  The iommu fd
will remain persistent for the remaining merged group.

If a device within a group is unbound from the vfio driver while it's in
use (iommu fd refcnt > 0 || device fd recnt > 0), vfio will block the
release and send netlink remove requests for every opened device in the
group (or merged group).  If the device fds are not released and
subsequently the iommu fd released as well, vfio will kill the user
process after some delay.  At some point in the future we may be able to
adapt this to perform a hard removal and revoke all device access
without killing the user.

The iommu fd supports dma mapping and unmapping ioctls as well as some,
yet to be defined and possibly architecture specific, iommu description
interfaces.  At some point we may also make use of read/write/mmap on
the iommu fd as means to setup dma.  

The device fds will largely support the existing vfio interface, with
generalizations to make it non-pci specific.  We'll access mmio/pio/pci
config using segmented offset into the device fd.  Interrupts will use
the existing mechanisms (eventfds/irqfd).  We'll need to add ioctls to
describe the type of device, number, size, and type of each resource and
available interrupts.

We still have outstanding questions with how devices are exposed in
qemu, but I think that's largely a qemu-vfio problem and the vfio kernel
interface described here supports all the interesting ways that devices
can be exposed as individuals or sets.  I'm currently working on code
changes to support the above and will post as I complete useful chunks.
Thanks,

Alex

[1] Implementation note: the current iommu ops makes some of this
awkward.  We'll need to temporarily setup a domain for incoming devices
to validate the capabilities of that domain, then tear it down and try
to attach devices to the existing domain.  In particular I'm thinking of
the cache coherence capability and whether we remap existing dma
mappings to allow this to change or just reject as incompatible (I'm
leaning to the latter).

[2] Implementation note: I think a container object makes sense here
where reads/ioctls are passed from the group to the container, which
performs them across all groups making use of that container (there are
no performance critical paths through the group fd).  This also implies
the enumeration interface should report groups so we can easily see
which groups are merged.  The group fd could simply read as:
        group: 1234
        device: 0000:00:19.0
        group: 5678
        device: 0000:01:00.0
        device: 0000:01:00.1
Some might say this is screaming for xml.  Do we need to go there?  We
could also do this via the netlink interface.  Suggestions welcome.
