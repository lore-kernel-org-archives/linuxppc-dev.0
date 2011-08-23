Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7FCE2B6F85
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 16:55:10 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: aafabbri <aafabbri@cisco.com>
In-Reply-To: <CA7847D2.FB3A%aafabbri@cisco.com>
References: <CA7847D2.FB3A%aafabbri@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Aug 2011 16:54:43 +1000
Message-ID: <1314082483.30478.43.camel@pasglop>
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

On Mon, 2011-08-22 at 17:52 -0700, aafabbri wrote:

> I'm not following you.
> 
> You have to enforce group/iommu domain assignment whether you have the
> existing uiommu API, or if you change it to your proposed
> ioctl(inherit_iommu) API.
> 
> The only change needed to VFIO here should be to make uiommu fd assignment
> happen on the groups instead of on device fds.  That operation fails or
> succeeds according to the group semantics (all-or-none assignment/same
> uiommu).

Ok, so I missed that part where you change uiommu to operate on group
fd's rather than device fd's, my apologies if you actually wrote that
down :-) It might be obvious ... bare with me I just flew back from the
US and I am badly jet lagged ...

So I see what you mean, however...

> I think the question is: do we force 1:1 iommu/group mapping, or do we allow
> arbitrary mapping (satisfying group constraints) as we do today.
> 
> I'm saying I'm an existing user who wants the arbitrary iommu/group mapping
> ability and definitely think the uiommu approach is cleaner than the
> ioctl(inherit_iommu) approach.  We considered that approach before but it
> seemed less clean so we went with the explicit uiommu context.

Possibly, the question that interest me the most is what interface will
KVM end up using. I'm also not terribly fan with the (perceived)
discrepancy between using uiommu to create groups but using the group fd
to actually do the mappings, at least if that is still the plan.

If the separate uiommu interface is kept, then anything that wants to be
able to benefit from the ability to put multiple devices (or existing
groups) into such a "meta group" would need to be explicitly modified to
deal with the uiommu APIs.

I tend to prefer such "meta groups" as being something you create
statically using a configuration interface, either via sysfs, netlink or
ioctl's to a "control" vfio device driven by a simple command line tool
(which can have the configuration stored in /etc and re-apply it at
boot).

That way, any program capable of exploiting VFIO "groups" will
automatically be able to exploit those "meta groups" (or groups of
groups) as well as long as they are supported on the system.

If we ever have system specific constraints as to how such groups can be
created, then it can all be handled at the level of that configuration
tool without impact on whatever programs know how to exploit them via
the VFIO interfaces.

> >  .../...
> > 
> >> If we in singleton-group land were building our own "groups" which were sets
> >> of devices sharing the IOMMU domains we wanted, I suppose we could do away
> >> with uiommu fds, but it sounds like the current proposal would create 20
> >> singleton groups (x86 iommu w/o PCI bridges => all devices are partitionable
> >> endpoints).  Asking me to ioctl(inherit) them together into a blob sounds
> >> worse than the current explicit uiommu API.
> > 
> > I'd rather have an API to create super-groups (groups of groups)
> > statically and then you can use such groups as normal groups using the
> > same interface. That create/management process could be done via a
> > simple command line utility or via sysfs banging, whatever...

Cheers,
Ben.
