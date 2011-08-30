Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 199D8B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 00:52:28 +1000 (EST)
Subject: Re: VFIO v2 design plan
From: Alex Williamson <alex.williamson@redhat.com>
To: David Gibson <dwg@au1.ibm.com>
Date: Tue, 30 Aug 2011 08:51:38 -0600
In-Reply-To: <20110830074855.GA11906@yookeroo.fritz.box>
References: <1314378325.2859.307.camel@bling.home>
	<20110830030439.GF4254@yookeroo.fritz.box>
	<1314678286.2859.430.camel@bling.home>
	<20110830074855.GA11906@yookeroo.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314715900.2859.480.camel@bling.home>
Mime-Version: 1.0
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>, "Roedel,
	Joerg" <Joerg.Roedel@amd.com>, agraf@suse.de,
	qemu-devel <qemu-devel@nongnu.org>, aafabbri <aafabbri@cisco.com>,
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

On Tue, 2011-08-30 at 17:48 +1000, David Gibson wrote:
> On Mon, Aug 29, 2011 at 10:24:43PM -0600, Alex Williamson wrote:
> > On Tue, 2011-08-30 at 13:04 +1000, David Gibson wrote:
> > > On Fri, Aug 26, 2011 at 11:05:23AM -0600, Alex Williamson wrote:
> > > > 
> > > > I don't think too much has changed since the previous email went out,
> > > > but it seems like a good idea to post a summary in case there were
> > > > suggestions or objections that I missed.
> > > > 
> > > > VFIO v2 will rely on the platform iommu driver reporting grouping
> > > > information.  Again, a group is a set of devices for which the iommu
> > > > cannot differentiate transactions.  An example would be a set of devices
> > > > behind a PCI-to-PCI bridge.  All transactions appear to be from the
> > > > bridge itself rather than devices behind the bridge.  Platforms are free
> > > > to have whatever constraints they need to for what constitutes a group.
> > > > 
> > > > I posted a rough draft of patch to implement that for the base iommu
> > > > driver and VT-d, adding an iommu_device_group callback on iommu ops.
> > > > The iommu base driver also populates an iommu_group sysfs file for each
> > > > device that's part of a group.  Members of the same group return the
> > > > same value via either the sysfs or iommu_device_group.  The value
> > > > returned is arbitrary, should not be assumed to be persistent across
> > > > boots, and is left to the iommu driver to generate.  There are some
> > > > implementation details around how to do this without favoring one bus
> > > > over another, but the interface should be bus/device type agnostic in
> > > > the end.
> > > > 
> > > > When the vfio module is loaded, character devices will be created for
> > > > each group in /dev/vfio/$GROUP.  Setting file permissions on these files
> > > > should be sufficient for providing a user with complete access to the
> > > > group.  Opening this device file provides what we'll call the "group
> > > > fd".  The group fd is restricted to only work with a single mm context.
> > > > Concurrent opens will be denied if the opening process mm does not
> > > > match.  The group fd will provide interfaces for enumerating the devices
> > > > in the group, returning a file descriptor for each device in the group
> > > > (the "device fd"), binding groups together, and returning a file
> > > > descriptor for iommu operations (the "iommu fd").
> > > > 
> > > > A group is "viable" when all member devices of the group are bound to
> > > > the vfio driver.  Until that point, the group fd only allows enumeration
> > > > interfaces (ie. listing of group devices).  I'm currently thinking
> > > > enumeration will be done by a simple read() on the device file returning
> > > > a list of dev_name()s.
> > > 
> > > Ok.  Are you envisaging this interface as a virtual file, or as a
> > > stream?  That is, can you seek around the list of devices like a
> > > regular file - in which case, what are the precise semantics when the
> > > list is changed by a bind - or is there no meaningful notion of file
> > > pointer and read() just gives you the next device - in which case how
> > > to you rewind to enumerate the group again.
> > 
> > I was implementing it as a virtual file that gets generated on read()
> > (see example in note[2] below).  It is a bit clunky as reading it a byte
> > at a time could experience races w/ device add/remove.  If it's read all
> > at once, it's an accurate snapshot.  Suggestions welcome, this just
> > seemed easier than trying to stuff it into a struct for an ioctl.  For a
> > while I thought I could do a VFIO_GROUP_GET_NUM_DEVICES +
> > VFIO_GROUP_GET_DEVICE_INDEX, but that assumes device stability, which I
> > don't think we can guarantee.
> 
> Yeah, that sounds reasonable.
> 
> > > >  Once the group is viable, the user may bind the
> > > > group to another group, retrieve the iommu fd, or retrieve device fds.
> > > > Internally, each of these operations will result in an iommu domain
> > > > being allocated and all of the devices attached to the domain.
> > > > 
> > > > The purpose of binding groups is to share the iommu domain.  Groups
> > > > making use of incompatible iommu domains will fail to bind.  Groups
> > > > making use of different mm's will fail to bind.  The vfio driver may
> > > > reject some binding based on domain capabilities, but final veto power
> > > > is left to the iommu driver[1].  If a user makes use of a group
> > > > independently and later wishes to bind it to another group, all the
> > > > device fds and the iommu fd must first be closed.  This prevents using a
> > > > stale iommu fd or accessing devices while the iommu is being switched.
> > > > Operations on any group fds of a merged group are performed globally on
> > > > the group (ie. enumerating the devices lists all devices in the merged
> > > > group, retrieving the iommu fd from any group fd results in the same fd,
> > > > device fds from any group can be retrieved from any group fd[2]).
> > > > Groups can be merged and unmerged dynamically.  Unmerging a group
> > > > requires the device fds for the outgoing group are closed.  The iommu fd
> > > > will remain persistent for the remaining merged group.
> > > 
> > > As I've said I prefer a persistent group model, rather than this
> > > transient group model, but it's not a dealbreaker by itself.  How are
> > > unmerges specified?
> > 
> > VFIO_GROUP_UNMERGE ioctl taking a group fd parameter.
> > 
> > >  I'm also assuming that in this model closing a
> > > (bound) group fd will unmerge everything down to atomic groups again.
> > 
> > Yes, it will unmerge the closed group down to the atomic group.
> 
> Hrm, not thrilled with the merging semantics, but I can probably live
> with them.  Still some clarifications, though..
> 
> If you open a group, merge in a bunch of other groups, then re-open
> /dev/vfio/NNN for one of the groups mergeed, presumably the new fd
> must also see the merged group?  So presumably you must only unmerge
> everything when all the fds are closed.

The device fds for the group to be unmerged must be closed before an
unmerge.  The iommu fd is tricky.  The iommu fd is really the iommu for
the merged group, not the individual groups, so it's context stays with
the remaining group.  Therefore I don't enforce a refcnt on the iommu
fd.  The usage model I expect is that if a merge works, the user will
probably use a single iommu fd for the whole merged group.  Maybe that
should be enforced?

> If you open groups a and b, then merge a (disjoint) bunch of things
> into each, then merge b into a, what are the semantics?  Wheat about
> if you then unmerge b from a - does it just remove the atomic group b,
> or everything you merged into b earlier?  Or, what happens if you open
> group a, merge in some things, then attempt to unmerge a from the
> merged group?

Simple, don't allow merging and unmerging of merged groups.  Merge and
unmerge only work on singleton groups.  The last case we must support.
In that case you just use:

ioctl(a.fd, VFIO_GROUP_MERGE, b.fd)
ioctl(b.fd, VFIO_GROUP_UNMERGE, a.fd)

The groups are peers when merged, so b can remove a as easily as a can
remove b.  Group b is left with any iommu context setup while merged.

> > > > If a device within a group is unbound from the vfio driver while it's in
> > > > use (iommu fd refcnt > 0 || device fd recnt > 0), vfio will block the
> > > > release and send netlink remove requests for every opened device in the
> > > > group (or merged group).
> > > 
> > > Hrm, I do dislike netlink being yet another aspect of an already
> > > complex interface.  Would it be possible to do kernel->user
> > > notifications with a poll()/read() interface on one of the existing
> > > fds instead?
> > 
> > I think it'd have to be a new eventfd, but yes, it would be possible.
> > Then we'd have to figure out if we filter all requests through that
> > (remove, PCI AER, suspend/resume, etc..) or do we use a new fd for each
> > and how we return info for each of those.
> 
> Well, I wasn't thinking an eventfd(), precisely so that you can return
> a custom packet of information with this stuff on read().
> 
> >  As much as everyone hates
> > netlink, it still feels like the right interface for these.
> 
> Well, maybe.
> 
> > Beyond unbind, we also need to think about hotplug.  If a system had
> > multiple hotplug slots below a P2P bridge and a device was added while
> > the group is in use, what do we do?  Maybe we can somehow disable it or
> > mark it for vfio in our bus notifier routines(?).
> 
> That is a very good point.  It actually brings into focus a niggling
> concern I had about this model where the group becomes vfio usable
> once all the devices in it are bound to vfio.  Because of the
> possibility of hotplug, I think its conceptually more correct to not
> treat vfio as just another kernel driver which can bind devices, but a
> special state that the whole group goes into atomically.  So the
> sequence would be:
> 	- Admin asks that a group go into vfio state
> 	- kernel (attempts to) unbind kernel drivers from every device
> in the group
> 	- group is marked in vfio/limbo state
> 
> At this point no kernel drivers may bind to anything in the group,
> including things that are hotplugged into the group after this initial
> sequence.

It seems like this is a mode that could only be accessible if the group
is opened w/ admin capabilities, I don't think we'd want to let the vfio
group chrdev owner be able to do that automatically.  I don't know of
any other drivers that behave like this, being able to unbind running
drivers and pull devices into itself.

> > > >  If the device fds are not released and
> > > > subsequently the iommu fd released as well, vfio will kill the user
> > > > process after some delay.
> > > 
> > > Ouch, this seems to me a problematic semantic.  Whether the user
> > > process survives depends on whether it processes the remove requests
> > > fast enough - and a user process could be slowed down by system load
> > > or other factors not entirely in its control.
> > 
> > I was assuming "ample" time to process a hot remove, but yes, it's an
> > area of concern.  I'm not sure how much of a problem it is in practice
> > though.  Yes you can shoot your VM accidentally as root... don't do
> > that.
> 
> They can, but with this semantic they can't know in advance whether
> the command is going to kill the VM or not.  I can just see a
> situation where the admin issues a command to remove the device from
> the guest, and usually that goes through the hot guest unplug
> mechanisms, the guest keeps running and everything is happy.  Then one
> time they issue *exactly the same command* and the VM dies, because
> the system is running really slow for some reason (huge load, or maybe
> someone switched the VM into full emulation for debugging).

Not sure how to handle this other than leave a trail of bread crumbs.

> > > I'd be more comfortable with a model where there was a distinction
> > > between a "soft" and "hard" remove.  The soft would either simply
> > > fail, if the device is in use by vfio, or block indefinitely.  The
> > > hard would kill the user process without delay.  This effectively
> > > allows your semantics to be implemented in userspace (soft remove,
> > > wait, hard remove) - where it's easier to tweak the policy of how long
> > > to wait.
> > 
> > Your first example is essentially what current vfio does now, request
> > remove, wait indefinitely and qemu triggers an abort if the guest
> > doesn't respond.  The trouble with moving this policy to userspace is
> > that we're not protecting the host.
> 
> How is the host not protected?  Bear in mind that when I say
> "userspace" I'm not thinking qemu, I'm thinking the admin equipped
> with whatever tools he uses for moving devices between guests.  So
> they go:
> 	- Please remove this group from the guest
> 	- Waits for an amount of time of their choice
> 	- Decide, crap, the guest is broken
> 	- Hard remove the group from the guest, killing the guest
> 
> It's basic in perfect analogy to the old:
> 	- kill -15
> 	- *drum fingers*
> 	- Damn, it's stuck
> 	- kill -9

And what if the remove is initiated by a hardware admin that walks over
to the system, and presses the PCI device hot unplug doorbell?  It just
looks like a driver hang.  Thanks,

Alex
