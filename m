Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 4B6D0B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 14:25:29 +1000 (EST)
Subject: Re: VFIO v2 design plan
From: Alex Williamson <alex.williamson@redhat.com>
To: David Gibson <dwg@au1.ibm.com>
Date: Mon, 29 Aug 2011 22:24:43 -0600
In-Reply-To: <20110830030439.GF4254@yookeroo.fritz.box>
References: <1314378325.2859.307.camel@bling.home>
	<20110830030439.GF4254@yookeroo.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314678286.2859.430.camel@bling.home>
Mime-Version: 1.0
Cc: aafabbri <aafabbri@cisco.com>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>, "Roedel,
	Joerg" <Joerg.Roedel@amd.com>, agraf@suse.de,
	qemu-devel <qemu-devel@nongnu.org>, chrisw <chrisw@sous-sol.org>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, benve@cisco.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-08-30 at 13:04 +1000, David Gibson wrote:
> On Fri, Aug 26, 2011 at 11:05:23AM -0600, Alex Williamson wrote:
> > 
> > I don't think too much has changed since the previous email went out,
> > but it seems like a good idea to post a summary in case there were
> > suggestions or objections that I missed.
> > 
> > VFIO v2 will rely on the platform iommu driver reporting grouping
> > information.  Again, a group is a set of devices for which the iommu
> > cannot differentiate transactions.  An example would be a set of devices
> > behind a PCI-to-PCI bridge.  All transactions appear to be from the
> > bridge itself rather than devices behind the bridge.  Platforms are free
> > to have whatever constraints they need to for what constitutes a group.
> > 
> > I posted a rough draft of patch to implement that for the base iommu
> > driver and VT-d, adding an iommu_device_group callback on iommu ops.
> > The iommu base driver also populates an iommu_group sysfs file for each
> > device that's part of a group.  Members of the same group return the
> > same value via either the sysfs or iommu_device_group.  The value
> > returned is arbitrary, should not be assumed to be persistent across
> > boots, and is left to the iommu driver to generate.  There are some
> > implementation details around how to do this without favoring one bus
> > over another, but the interface should be bus/device type agnostic in
> > the end.
> > 
> > When the vfio module is loaded, character devices will be created for
> > each group in /dev/vfio/$GROUP.  Setting file permissions on these files
> > should be sufficient for providing a user with complete access to the
> > group.  Opening this device file provides what we'll call the "group
> > fd".  The group fd is restricted to only work with a single mm context.
> > Concurrent opens will be denied if the opening process mm does not
> > match.  The group fd will provide interfaces for enumerating the devices
> > in the group, returning a file descriptor for each device in the group
> > (the "device fd"), binding groups together, and returning a file
> > descriptor for iommu operations (the "iommu fd").
> > 
> > A group is "viable" when all member devices of the group are bound to
> > the vfio driver.  Until that point, the group fd only allows enumeration
> > interfaces (ie. listing of group devices).  I'm currently thinking
> > enumeration will be done by a simple read() on the device file returning
> > a list of dev_name()s.
> 
> Ok.  Are you envisaging this interface as a virtual file, or as a
> stream?  That is, can you seek around the list of devices like a
> regular file - in which case, what are the precise semantics when the
> list is changed by a bind - or is there no meaningful notion of file
> pointer and read() just gives you the next device - in which case how
> to you rewind to enumerate the group again.

I was implementing it as a virtual file that gets generated on read()
(see example in note[2] below).  It is a bit clunky as reading it a byte
at a time could experience races w/ device add/remove.  If it's read all
at once, it's an accurate snapshot.  Suggestions welcome, this just
seemed easier than trying to stuff it into a struct for an ioctl.  For a
while I thought I could do a VFIO_GROUP_GET_NUM_DEVICES +
VFIO_GROUP_GET_DEVICE_INDEX, but that assumes device stability, which I
don't think we can guarantee.

> >  Once the group is viable, the user may bind the
> > group to another group, retrieve the iommu fd, or retrieve device fds.
> > Internally, each of these operations will result in an iommu domain
> > being allocated and all of the devices attached to the domain.
> > 
> > The purpose of binding groups is to share the iommu domain.  Groups
> > making use of incompatible iommu domains will fail to bind.  Groups
> > making use of different mm's will fail to bind.  The vfio driver may
> > reject some binding based on domain capabilities, but final veto power
> > is left to the iommu driver[1].  If a user makes use of a group
> > independently and later wishes to bind it to another group, all the
> > device fds and the iommu fd must first be closed.  This prevents using a
> > stale iommu fd or accessing devices while the iommu is being switched.
> > Operations on any group fds of a merged group are performed globally on
> > the group (ie. enumerating the devices lists all devices in the merged
> > group, retrieving the iommu fd from any group fd results in the same fd,
> > device fds from any group can be retrieved from any group fd[2]).
> > Groups can be merged and unmerged dynamically.  Unmerging a group
> > requires the device fds for the outgoing group are closed.  The iommu fd
> > will remain persistent for the remaining merged group.
> 
> As I've said I prefer a persistent group model, rather than this
> transient group model, but it's not a dealbreaker by itself.  How are
> unmerges specified?

VFIO_GROUP_UNMERGE ioctl taking a group fd parameter.

>  I'm also assuming that in this model closing a
> (bound) group fd will unmerge everything down to atomic groups again.

Yes, it will unmerge the closed group down to the atomic group.

> > If a device within a group is unbound from the vfio driver while it's in
> > use (iommu fd refcnt > 0 || device fd recnt > 0), vfio will block the
> > release and send netlink remove requests for every opened device in the
> > group (or merged group).
> 
> Hrm, I do dislike netlink being yet another aspect of an already
> complex interface.  Would it be possible to do kernel->user
> notifications with a poll()/read() interface on one of the existing
> fds instead?

I think it'd have to be a new eventfd, but yes, it would be possible.
Then we'd have to figure out if we filter all requests through that
(remove, PCI AER, suspend/resume, etc..) or do we use a new fd for each
and how we return info for each of those.  As much as everyone hates
netlink, it still feels like the right interface for these.

Beyond unbind, we also need to think about hotplug.  If a system had
multiple hotplug slots below a P2P bridge and a device was added while
the group is in use, what do we do?  Maybe we can somehow disable it or
mark it for vfio in our bus notifier routines(?).

> >  If the device fds are not released and
> > subsequently the iommu fd released as well, vfio will kill the user
> > process after some delay.
> 
> Ouch, this seems to me a problematic semantic.  Whether the user
> process survives depends on whether it processes the remove requests
> fast enough - and a user process could be slowed down by system load
> or other factors not entirely in its control.

I was assuming "ample" time to process a hot remove, but yes, it's an
area of concern.  I'm not sure how much of a problem it is in practice
though.  Yes you can shoot your VM accidentally as root... don't do
that.

> I'd be more comfortable with a model where there was a distinction
> between a "soft" and "hard" remove.  The soft would either simply
> fail, if the device is in use by vfio, or block indefinitely.  The
> hard would kill the user process without delay.  This effectively
> allows your semantics to be implemented in userspace (soft remove,
> wait, hard remove) - where it's easier to tweak the policy of how long
> to wait.

Your first example is essentially what current vfio does now, request
remove, wait indefinitely and qemu triggers an abort if the guest
doesn't respond.  The trouble with moving this policy to userspace is
that we're not protecting the host.  You won't like this, but we can
also use whether the vfio user registers with netlink as a signal of
when to do notify-wait-kill, or just kill (yeah, we could do the same
with a notification eventfd too).  Thanks,

Alex

> >  At some point in the future we may be able to
> > adapt this to perform a hard removal and revoke all device access
> > without killing the user.
> > 
> > The iommu fd supports dma mapping and unmapping ioctls as well as some,
> > yet to be defined and possibly architecture specific, iommu description
> > interfaces.  At some point we may also make use of read/write/mmap on
> > the iommu fd as means to setup dma.  
> 
> Ok.
> 
> > The device fds will largely support the existing vfio interface, with
> > generalizations to make it non-pci specific.  We'll access mmio/pio/pci
> > config using segmented offset into the device fd.  Interrupts will use
> > the existing mechanisms (eventfds/irqfd).  We'll need to add ioctls to
> > describe the type of device, number, size, and type of each resource and
> > available interrupts.
> > 
> > We still have outstanding questions with how devices are exposed in
> > qemu, but I think that's largely a qemu-vfio problem and the vfio kernel
> > interface described here supports all the interesting ways that devices
> > can be exposed as individuals or sets.  I'm currently working on code
> > changes to support the above and will post as I complete useful chunks.
> > Thanks,
> > 
> > Alex
> > 
> > [1] Implementation note: the current iommu ops makes some of this
> > awkward.  We'll need to temporarily setup a domain for incoming devices
> > to validate the capabilities of that domain, then tear it down and try
> > to attach devices to the existing domain.  In particular I'm thinking of
> > the cache coherence capability and whether we remap existing dma
> > mappings to allow this to change or just reject as incompatible (I'm
> > leaning to the latter).
> > 
> > [2] Implementation note: I think a container object makes sense here
> > where reads/ioctls are passed from the group to the container, which
> > performs them across all groups making use of that container (there are
> > no performance critical paths through the group fd).  This also implies
> > the enumeration interface should report groups so we can easily see
> > which groups are merged.  The group fd could simply read as:
> >         group: 1234
> >         device: 0000:00:19.0
> >         group: 5678
> >         device: 0000:01:00.0
> >         device: 0000:01:00.1
> > Some might say this is screaming for xml.  Do we need to go there?  We
> > could also do this via the netlink interface.  Suggestions welcome.
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > 
> 
