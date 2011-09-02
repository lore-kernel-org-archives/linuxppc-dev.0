Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7040FB6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Sep 2011 15:08:05 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p8257tHR013441
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Sep 2011 15:07:55 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8256RUT979046
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Sep 2011 15:06:27 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8257sYU029196
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Sep 2011 15:07:54 +1000
Date: Fri, 2 Sep 2011 15:07:48 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: VFIO v2 design plan
Message-ID: <20110902050748.GZ11906@yookeroo.fritz.box>
References: <1314378325.2859.307.camel@bling.home>
	<20110830030439.GF4254@yookeroo.fritz.box>
	<1314678286.2859.430.camel@bling.home>
	<20110830074855.GA11906@yookeroo.fritz.box>
	<1314715900.2859.480.camel@bling.home>
	<20110901041035.GJ11906@yookeroo.fritz.box>
	<1314908821.2859.531.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314908821.2859.531.camel@bling.home>
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

On Thu, Sep 01, 2011 at 02:27:00PM -0600, Alex Williamson wrote:
> On Thu, 2011-09-01 at 14:10 +1000, David Gibson wrote:
> > On Tue, Aug 30, 2011 at 08:51:38AM -0600, Alex Williamson wrote:
[snip]
> > > > If you open a group, merge in a bunch of other groups, then re-open
> > > > /dev/vfio/NNN for one of the groups mergeed, presumably the new fd
> > > > must also see the merged group?  So presumably you must only unmerge
> > > > everything when all the fds are closed.
> > > 
> > > The device fds for the group to be unmerged must be closed before an
> > > unmerge.  The iommu fd is tricky.  The iommu fd is really the iommu for
> > > the merged group, not the individual groups, so it's context stays with
> > > the remaining group.  Therefore I don't enforce a refcnt on the iommu
> > > fd.  The usage model I expect is that if a merge works, the user will
> > > probably use a single iommu fd for the whole merged group.  Maybe that
> > > should be enforced?
> > 
> > I thought I recalled you saying earlier that the iommu fd could not be
> > open when merging new groups in.  I would expect that also to be true
> > when unmerging in that case.
> 
> We have to support hotplug.  The group-to-be-merged can't be in use (no
> open device or iommu fds).  To unmerge a group, we only require that no
> device fds are in use as the merged-group-iommu may still be in use by
> the remaining members.

I'm not entirely clear how this relates to hotplug.  But I guess the
crucial point is that the group-to-be-merged may not have open device
or iommu fds, but the group-to-be-merged-into can?

But couldn't either a merge or an unmerge cause a change in the
effective capabilities of the IOMMU?

> > > > If you open groups a and b, then merge a (disjoint) bunch of things
> > > > into each, then merge b into a, what are the semantics?  Wheat about
> > > > if you then unmerge b from a - does it just remove the atomic group b,
> > > > or everything you merged into b earlier?  Or, what happens if you open
> > > > group a, merge in some things, then attempt to unmerge a from the
> > > > merged group?
> > > 
> > > Simple, don't allow merging and unmerging of merged groups.  Merge and
> > > unmerge only work on singleton groups.
> > 
> > Ok, in that case I think we should call it "add" and "remove" rather
> > than merge and unmerge.
> > 
> > >  The last case we must support.
> > > In that case you just use:
> > > 
> > > ioctl(a.fd, VFIO_GROUP_MERGE, b.fd)
> > > ioctl(b.fd, VFIO_GROUP_UNMERGE, a.fd)
> > > 
> > > The groups are peers when merged, so b can remove a as easily as a can
> > > remove b.  Group b is left with any iommu context setup while
> > > merged.
> > 
> > Um *goes cross-eyed*.  So, if you open (atomic) groups a and b, then
> > add group b to a, are the two open fds now functionally identical?
> 
> Yes.
> 
> > And likewise if you then open either a or b again straight from from
> > /dev/vfio?
> 
> Yes.
> 
> > Except, that the b fd must then retain the fact that it was originally
> > for atomic group (b), so that it can be used as a handle for an
> > unmerge/remove.
> 
> Right.

Ugh.  Having the file handle represent the meta-group for most
purposes, but also represent (invisibly) an atomic group is just
horrible.  Especially when - using one of the examples mentioned
above, it's actually possible to remove the atomic group represented
by an fd from the meta-group it's also representing.

> > The more I dig into the details of these semantics the more I dislike
> > them.
> 
> Suggest something better.  I spent half a day thinking about what vfio
> would look like in configfs, it has some very appealing aspects, but
> since it doesn't support ioctls we'd still have a chardev interface and
> it gets ugly again.

Well, again, I prefer a persistent group interface, where the
meta-group is not bound to the lifetime of a file handle.  Instead you
use a different interface to create a meta-group (which has an ID
disjoint from the atomic groups), then you can open
/dev/vfio/<metagroup-id>.  The constituent atomic group devices are
still visible, and their enumeration interface works, but are otherwise
unusable (like a group which still has kernel drivers bound to some
constituent devices).


Hrm.  In the interests of making forward progress here, can I suggest
we implement the other APIs without group-binding/metagrouping for
now.  It doesn't look as if any of the suggested approaches for this
so far are fundamentally incompatible with the rest of the interface.

[snip]
> > > > > > I'd be more comfortable with a model where there was a distinction
> > > > > > between a "soft" and "hard" remove.  The soft would either simply
> > > > > > fail, if the device is in use by vfio, or block indefinitely.  The
> > > > > > hard would kill the user process without delay.  This effectively
> > > > > > allows your semantics to be implemented in userspace (soft remove,
> > > > > > wait, hard remove) - where it's easier to tweak the policy of how long
> > > > > > to wait.
> > > > > 
> > > > > Your first example is essentially what current vfio does now, request
> > > > > remove, wait indefinitely and qemu triggers an abort if the guest
> > > > > doesn't respond.  The trouble with moving this policy to userspace is
> > > > > that we're not protecting the host.
> > > > 
> > > > How is the host not protected?  Bear in mind that when I say
> > > > "userspace" I'm not thinking qemu, I'm thinking the admin equipped
> > > > with whatever tools he uses for moving devices between guests.  So
> > > > they go:
> > > > 	- Please remove this group from the guest
> > > > 	- Waits for an amount of time of their choice
> > > > 	- Decide, crap, the guest is broken
> > > > 	- Hard remove the group from the guest, killing the guest
> > > > 
> > > > It's basic in perfect analogy to the old:
> > > > 	- kill -15
> > > > 	- *drum fingers*
> > > > 	- Damn, it's stuck
> > > > 	- kill -9
> > > 
> > > And what if the remove is initiated by a hardware admin that walks over
> > > to the system, and presses the PCI device hot unplug doorbell?  It just
> > > looks like a driver hang.  Thanks,
> > 
> > Hm, true.  How is this case handled on the host side?
> 
> Same as if you attempt to unbind the device from the driver, release
> callback, iirc.  Thanks,

Roght, I guess my point is whether there's some kind of userspace
notification or not.  If there is, then it's reasonable to do a soft
unbind, and the userspace callback can do a hard kill after a delay.
If not, then it does need to be a hard unbind / kill.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
