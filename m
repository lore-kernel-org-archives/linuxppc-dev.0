Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F121BB6F7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Sep 2011 14:29:18 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p814T7h8002591
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2011 14:29:07 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p814T7Fe1532006
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2011 14:29:07 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p814T6Fe028036
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2011 14:29:06 +1000
Date: Thu, 1 Sep 2011 14:10:35 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: VFIO v2 design plan
Message-ID: <20110901041035.GJ11906@yookeroo.fritz.box>
References: <1314378325.2859.307.camel@bling.home>
	<20110830030439.GF4254@yookeroo.fritz.box>
	<1314678286.2859.430.camel@bling.home>
	<20110830074855.GA11906@yookeroo.fritz.box>
	<1314715900.2859.480.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314715900.2859.480.camel@bling.home>
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

On Tue, Aug 30, 2011 at 08:51:38AM -0600, Alex Williamson wrote:
> On Tue, 2011-08-30 at 17:48 +1000, David Gibson wrote:
> > On Mon, Aug 29, 2011 at 10:24:43PM -0600, Alex Williamson wrote:
> > > On Tue, 2011-08-30 at 13:04 +1000, David Gibson wrote:
> > > > On Fri, Aug 26, 2011 at 11:05:23AM -0600, Alex Williamson wrote:
[snip]
> > > > >  Once the group is viable, the user may bind the
> > > > > group to another group, retrieve the iommu fd, or retrieve device fds.
> > > > > Internally, each of these operations will result in an iommu domain
> > > > > being allocated and all of the devices attached to the domain.
> > > > > 
> > > > > The purpose of binding groups is to share the iommu domain.  Groups
> > > > > making use of incompatible iommu domains will fail to bind.  Groups
> > > > > making use of different mm's will fail to bind.  The vfio driver may
> > > > > reject some binding based on domain capabilities, but final veto power
> > > > > is left to the iommu driver[1].  If a user makes use of a group
> > > > > independently and later wishes to bind it to another group, all the
> > > > > device fds and the iommu fd must first be closed.  This prevents using a
> > > > > stale iommu fd or accessing devices while the iommu is being switched.
> > > > > Operations on any group fds of a merged group are performed globally on
> > > > > the group (ie. enumerating the devices lists all devices in the merged
> > > > > group, retrieving the iommu fd from any group fd results in the same fd,
> > > > > device fds from any group can be retrieved from any group fd[2]).
> > > > > Groups can be merged and unmerged dynamically.  Unmerging a group
> > > > > requires the device fds for the outgoing group are closed.  The iommu fd
> > > > > will remain persistent for the remaining merged group.
> > > > 
> > > > As I've said I prefer a persistent group model, rather than this
> > > > transient group model, but it's not a dealbreaker by itself.  How are
> > > > unmerges specified?
> > > 
> > > VFIO_GROUP_UNMERGE ioctl taking a group fd parameter.
> > > 
> > > >  I'm also assuming that in this model closing a
> > > > (bound) group fd will unmerge everything down to atomic groups again.
> > > 
> > > Yes, it will unmerge the closed group down to the atomic group.
> > 
> > Hrm, not thrilled with the merging semantics, but I can probably live
> > with them.  Still some clarifications, though..
> > 
> > If you open a group, merge in a bunch of other groups, then re-open
> > /dev/vfio/NNN for one of the groups mergeed, presumably the new fd
> > must also see the merged group?  So presumably you must only unmerge
> > everything when all the fds are closed.
> 
> The device fds for the group to be unmerged must be closed before an
> unmerge.  The iommu fd is tricky.  The iommu fd is really the iommu for
> the merged group, not the individual groups, so it's context stays with
> the remaining group.  Therefore I don't enforce a refcnt on the iommu
> fd.  The usage model I expect is that if a merge works, the user will
> probably use a single iommu fd for the whole merged group.  Maybe that
> should be enforced?

I thought I recalled you saying earlier that the iommu fd could not be
open when merging new groups in.  I would expect that also to be true
when unmerging in that case.

> > If you open groups a and b, then merge a (disjoint) bunch of things
> > into each, then merge b into a, what are the semantics?  Wheat about
> > if you then unmerge b from a - does it just remove the atomic group b,
> > or everything you merged into b earlier?  Or, what happens if you open
> > group a, merge in some things, then attempt to unmerge a from the
> > merged group?
> 
> Simple, don't allow merging and unmerging of merged groups.  Merge and
> unmerge only work on singleton groups.

Ok, in that case I think we should call it "add" and "remove" rather
than merge and unmerge.

>  The last case we must support.
> In that case you just use:
> 
> ioctl(a.fd, VFIO_GROUP_MERGE, b.fd)
> ioctl(b.fd, VFIO_GROUP_UNMERGE, a.fd)
> 
> The groups are peers when merged, so b can remove a as easily as a can
> remove b.  Group b is left with any iommu context setup while
> merged.

Um *goes cross-eyed*.  So, if you open (atomic) groups a and b, then
add group b to a, are the two open fds now functionally identical?
And likewise if you then open either a or b again straight from from
/dev/vfio?

Except, that the b fd must then retain the fact that it was originally
for atomic group (b), so that it can be used as a handle for an
unmerge/remove.

The more I dig into the details of these semantics the more I dislike
them.

[snip]
> > > Beyond unbind, we also need to think about hotplug.  If a system had
> > > multiple hotplug slots below a P2P bridge and a device was added while
> > > the group is in use, what do we do?  Maybe we can somehow disable it or
> > > mark it for vfio in our bus notifier routines(?).
> > 
> > That is a very good point.  It actually brings into focus a niggling
> > concern I had about this model where the group becomes vfio usable
> > once all the devices in it are bound to vfio.  Because of the
> > possibility of hotplug, I think its conceptually more correct to not
> > treat vfio as just another kernel driver which can bind devices, but a
> > special state that the whole group goes into atomically.  So the
> > sequence would be:
> > 	- Admin asks that a group go into vfio state
> > 	- kernel (attempts to) unbind kernel drivers from every device
> > in the group
> > 	- group is marked in vfio/limbo state
> > 
> > At this point no kernel drivers may bind to anything in the group,
> > including things that are hotplugged into the group after this initial
> > sequence.
> 
> It seems like this is a mode that could only be accessible if the group
> is opened w/ admin capabilities, I don't think we'd want to let the vfio
> group chrdev owner be able to do that automatically.

They have to do something that's just as restrictive automatically.
If new devices enter an atomic group that's in use by a guest, the
kernel must not bind drivers to them.  I'm just trying to make the
semantics clearer, than proxying the restrictions by binding a dummy
driver to everything.

>  I don't know of
> any other drivers that behave like this, being able to unbind running
> drivers and pull devices into itself.

Well, it's not a driver behaving like this, it's an explicit admin
operation to unbind all drivers from the whole group and put it in a
state that's suitable for vfio assignment.

> > > > >  If the device fds are not released and
> > > > > subsequently the iommu fd released as well, vfio will kill the user
> > > > > process after some delay.
> > > > 
> > > > Ouch, this seems to me a problematic semantic.  Whether the user
> > > > process survives depends on whether it processes the remove requests
> > > > fast enough - and a user process could be slowed down by system load
> > > > or other factors not entirely in its control.
> > > 
> > > I was assuming "ample" time to process a hot remove, but yes, it's an
> > > area of concern.  I'm not sure how much of a problem it is in practice
> > > though.  Yes you can shoot your VM accidentally as root... don't do
> > > that.
> > 
> > They can, but with this semantic they can't know in advance whether
> > the command is going to kill the VM or not.  I can just see a
> > situation where the admin issues a command to remove the device from
> > the guest, and usually that goes through the hot guest unplug
> > mechanisms, the guest keeps running and everything is happy.  Then one
> > time they issue *exactly the same command* and the VM dies, because
> > the system is running really slow for some reason (huge load, or maybe
> > someone switched the VM into full emulation for debugging).
> 
> Not sure how to handle this other than leave a trail of bread crumbs.

I have no idea what you mean by that.

> > > > I'd be more comfortable with a model where there was a distinction
> > > > between a "soft" and "hard" remove.  The soft would either simply
> > > > fail, if the device is in use by vfio, or block indefinitely.  The
> > > > hard would kill the user process without delay.  This effectively
> > > > allows your semantics to be implemented in userspace (soft remove,
> > > > wait, hard remove) - where it's easier to tweak the policy of how long
> > > > to wait.
> > > 
> > > Your first example is essentially what current vfio does now, request
> > > remove, wait indefinitely and qemu triggers an abort if the guest
> > > doesn't respond.  The trouble with moving this policy to userspace is
> > > that we're not protecting the host.
> > 
> > How is the host not protected?  Bear in mind that when I say
> > "userspace" I'm not thinking qemu, I'm thinking the admin equipped
> > with whatever tools he uses for moving devices between guests.  So
> > they go:
> > 	- Please remove this group from the guest
> > 	- Waits for an amount of time of their choice
> > 	- Decide, crap, the guest is broken
> > 	- Hard remove the group from the guest, killing the guest
> > 
> > It's basic in perfect analogy to the old:
> > 	- kill -15
> > 	- *drum fingers*
> > 	- Damn, it's stuck
> > 	- kill -9
> 
> And what if the remove is initiated by a hardware admin that walks over
> to the system, and presses the PCI device hot unplug doorbell?  It just
> looks like a driver hang.  Thanks,

Hm, true.  How is this case handled on the host side?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
