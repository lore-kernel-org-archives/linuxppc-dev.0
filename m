Return-Path: <aafabbri@cisco.com>
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "rcdn-iport-7.cisco.com", Issuer "Cisco SSCA2" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E179CB6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 03:33:35 +1000 (EST)
Date: Tue, 23 Aug 2011 10:33:14 -0700
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Aaron Fabbri <aafabbri@cisco.com>
To: Alex Williamson <alex.williamson@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <CA79326A.FB97%aafabbri@cisco.com>
In-Reply-To: <1314118861.2859.51.camel@bling.home>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>, chrisw <chrisw@sous-sol.org>,
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




On 8/23/11 10:01 AM, "Alex Williamson" <alex.williamson@redhat.com> wrote:

> On Tue, 2011-08-23 at 16:54 +1000, Benjamin Herrenschmidt wrote:
>> On Mon, 2011-08-22 at 17:52 -0700, aafabbri wrote:
>> 
>>> I'm not following you.
>>> 
>>> You have to enforce group/iommu domain assignment whether you have the
>>> existing uiommu API, or if you change it to your proposed
>>> ioctl(inherit_iommu) API.
>>> 
>>> The only change needed to VFIO here should be to make uiommu fd assignment
>>> happen on the groups instead of on device fds.  That operation fails or
>>> succeeds according to the group semantics (all-or-none assignment/same
>>> uiommu).
>> 
>> Ok, so I missed that part where you change uiommu to operate on group
>> fd's rather than device fd's, my apologies if you actually wrote that
>> down :-) It might be obvious ... bare with me I just flew back from the
>> US and I am badly jet lagged ...
> 
> I missed it too, the model I'm proposing entirely removes the uiommu
> concept.
> 
>> So I see what you mean, however...
>> 
>>> I think the question is: do we force 1:1 iommu/group mapping, or do we allow
>>> arbitrary mapping (satisfying group constraints) as we do today.
>>> 
>>> I'm saying I'm an existing user who wants the arbitrary iommu/group mapping
>>> ability and definitely think the uiommu approach is cleaner than the
>>> ioctl(inherit_iommu) approach.  We considered that approach before but it
>>> seemed less clean so we went with the explicit uiommu context.
>> 
>> Possibly, the question that interest me the most is what interface will
>> KVM end up using. I'm also not terribly fan with the (perceived)
>> discrepancy between using uiommu to create groups but using the group fd
>> to actually do the mappings, at least if that is still the plan.
> 
> Current code: uiommu creates the domain, we bind a vfio device to that
> domain via a SET_UIOMMU_DOMAIN ioctl on the vfio device, then do
> mappings via MAP_DMA on the vfio device (affecting all the vfio devices
> bound to the domain)
> 
> My current proposal: "groups" are predefined.  groups ~= iommu domain.

This is my main objection.  I'd rather not lose the ability to have multiple
devices (which are all predefined as singleton groups on x86 w/o PCI
bridges) share IOMMU resources.  Otherwise, 20 devices sharing buffers would
require 20x the IOMMU/ioTLB resources.  KVM doesn't care about this case?

> The iommu domain would probably be allocated when the first device is
> bound to vfio.  As each device is bound, it gets attached to the group.
> DMAs are done via an ioctl on the group.
> 
> I think group + uiommu leads to effectively reliving most of the
> problems with the current code.  The only benefit is the group
> assignment to enforce hardware restrictions.  We still have the problem
> that uiommu open() = iommu_domain_alloc(), whose properties are
> meaningless without attached devices (groups).  Which I think leads to
> the same awkward model of attaching groups to define the domain, then we
> end up doing mappings via the group to enforce ordering.

Is there a better way to allow groups to share an IOMMU domain?

Maybe, instead of having an ioctl to allow a group A to inherit the same
iommu domain as group B, we could have an ioctl to fully merge two groups
(could be what Ben was thinking):

A.ioctl(MERGE_TO_GROUP, B)

The group A now goes away and its devices join group B.  If A ever had an
iommu domain assigned (and buffers mapped?) we fail.

Groups cannot get smaller (they are defined as minimum granularity of an
IOMMU, initially).  They can get bigger if you want to share IOMMU
resources, though.

Any downsides to this approach?

-AF

> 
>> If the separate uiommu interface is kept, then anything that wants to be
>> able to benefit from the ability to put multiple devices (or existing
>> groups) into such a "meta group" would need to be explicitly modified to
>> deal with the uiommu APIs.
>> 
>> I tend to prefer such "meta groups" as being something you create
>> statically using a configuration interface, either via sysfs, netlink or
>> ioctl's to a "control" vfio device driven by a simple command line tool
>> (which can have the configuration stored in /etc and re-apply it at
>> boot).
> 
> I cringe anytime there's a mention of "static".  IMHO, we have to
> support hotplug.  That means "meta groups" change dynamically.  Maybe
> this supports the idea that we should be able to retrieve a new fd from
> the group to do mappings.  Any groups bound together will return the
> same fd and the fd will persist so long as any member of the group is
> open.
> 
>> That way, any program capable of exploiting VFIO "groups" will
>> automatically be able to exploit those "meta groups" (or groups of
>> groups) as well as long as they are supported on the system.
>> 
>> If we ever have system specific constraints as to how such groups can be
>> created, then it can all be handled at the level of that configuration
>> tool without impact on whatever programs know how to exploit them via
>> the VFIO interfaces.
> 
> I'd prefer to have the constraints be represented in the ioctl to bind
> groups.  It works or not and the platform gets to define what it
> considers compatible.  Thanks,
> 
> Alex
> 
