Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 418CFB6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 03:01:12 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 23 Aug 2011 11:01:00 -0600
In-Reply-To: <1314082483.30478.43.camel@pasglop>
References: <CA7847D2.FB3A%aafabbri@cisco.com>
	<1314082483.30478.43.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314118861.2859.51.camel@bling.home>
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

On Tue, 2011-08-23 at 16:54 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2011-08-22 at 17:52 -0700, aafabbri wrote:
> 
> > I'm not following you.
> > 
> > You have to enforce group/iommu domain assignment whether you have the
> > existing uiommu API, or if you change it to your proposed
> > ioctl(inherit_iommu) API.
> > 
> > The only change needed to VFIO here should be to make uiommu fd assignment
> > happen on the groups instead of on device fds.  That operation fails or
> > succeeds according to the group semantics (all-or-none assignment/same
> > uiommu).
> 
> Ok, so I missed that part where you change uiommu to operate on group
> fd's rather than device fd's, my apologies if you actually wrote that
> down :-) It might be obvious ... bare with me I just flew back from the
> US and I am badly jet lagged ...

I missed it too, the model I'm proposing entirely removes the uiommu
concept.

> So I see what you mean, however...
> 
> > I think the question is: do we force 1:1 iommu/group mapping, or do we allow
> > arbitrary mapping (satisfying group constraints) as we do today.
> > 
> > I'm saying I'm an existing user who wants the arbitrary iommu/group mapping
> > ability and definitely think the uiommu approach is cleaner than the
> > ioctl(inherit_iommu) approach.  We considered that approach before but it
> > seemed less clean so we went with the explicit uiommu context.
> 
> Possibly, the question that interest me the most is what interface will
> KVM end up using. I'm also not terribly fan with the (perceived)
> discrepancy between using uiommu to create groups but using the group fd
> to actually do the mappings, at least if that is still the plan.

Current code: uiommu creates the domain, we bind a vfio device to that
domain via a SET_UIOMMU_DOMAIN ioctl on the vfio device, then do
mappings via MAP_DMA on the vfio device (affecting all the vfio devices
bound to the domain)

My current proposal: "groups" are predefined.  groups ~= iommu domain.
The iommu domain would probably be allocated when the first device is
bound to vfio.  As each device is bound, it gets attached to the group.
DMAs are done via an ioctl on the group.

I think group + uiommu leads to effectively reliving most of the
problems with the current code.  The only benefit is the group
assignment to enforce hardware restrictions.  We still have the problem
that uiommu open() = iommu_domain_alloc(), whose properties are
meaningless without attached devices (groups).  Which I think leads to
the same awkward model of attaching groups to define the domain, then we
end up doing mappings via the group to enforce ordering.

> If the separate uiommu interface is kept, then anything that wants to be
> able to benefit from the ability to put multiple devices (or existing
> groups) into such a "meta group" would need to be explicitly modified to
> deal with the uiommu APIs.
> 
> I tend to prefer such "meta groups" as being something you create
> statically using a configuration interface, either via sysfs, netlink or
> ioctl's to a "control" vfio device driven by a simple command line tool
> (which can have the configuration stored in /etc and re-apply it at
> boot).

I cringe anytime there's a mention of "static".  IMHO, we have to
support hotplug.  That means "meta groups" change dynamically.  Maybe
this supports the idea that we should be able to retrieve a new fd from
the group to do mappings.  Any groups bound together will return the
same fd and the fd will persist so long as any member of the group is
open.

> That way, any program capable of exploiting VFIO "groups" will
> automatically be able to exploit those "meta groups" (or groups of
> groups) as well as long as they are supported on the system.
> 
> If we ever have system specific constraints as to how such groups can be
> created, then it can all be handled at the level of that configuration
> tool without impact on whatever programs know how to exploit them via
> the VFIO interfaces.

I'd prefer to have the constraints be represented in the ioctl to bind
groups.  It works or not and the platform gets to define what it
considers compatible.  Thanks,

Alex
