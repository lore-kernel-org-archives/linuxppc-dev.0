Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE427B6F84
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 07:02:02 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
In-Reply-To: <1314027950.6866.242.camel@x201.home>
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
	<20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
	<20110822055509.GI30097@yookeroo.fritz.box>
	<1314027950.6866.242.camel@x201.home>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Aug 2011 07:01:44 +1000
Message-ID: <1314046904.7662.37.camel@pasglop>
Mime-Version: 1.0
Cc: aafabbri <aafabbri@cisco.com>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	David Gibson <dwg@au1.ibm.com>, chrisw <chrisw@sous-sol.org>,
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

On Mon, 2011-08-22 at 09:45 -0600, Alex Williamson wrote:

> Yes, that's the idea.  An open question I have towards the configuration
> side is whether we might add iommu driver specific options to the
> groups.  For instance on x86 where we typically have B:D.F granularity,
> should we have an option not to trust multi-function devices and use a
> B:D granularity for grouping?

Or even B or range of busses... if you want to enforce strict isolation
you really can't trust anything below a bus level :-)

> Right, we can also combine models.  Binding a device to vfio
> creates /dev/vfio$GROUP, which only allows a subset of ioctls and no
> device access until all the group devices are also bound.  I think
> the /dev/vfio/$GROUP might help provide an enumeration interface as well
> though, which could be useful.

Could be tho in what form ? returning sysfs pathes ?

> 1:1 group<->process is probably too strong.  Not allowing concurrent
> open()s on the group file enforces a single userspace entity is
> responsible for that group.  Device fds can be passed to other
> processes, but only retrieved via the group fd.  I suppose we could even
> branch off the dma interface into a different fd, but it seems like we
> would logically want to serialize dma mappings at each iommu group
> anyway.  I'm open to alternatives, this just seemed an easy way to do
> it.  Restricting on UID implies that we require isolated qemu instances
> to run as different UIDs.  I know that's a goal, but I don't know if we
> want to make it an assumption in the group security model.

1:1 process has the advantage of linking to an -mm which makes the whole
mmu notifier business doable. How do you want to track down mappings and
do the second level translation in the case of explicit map/unmap (like
on power) if you are not tied to an mm_struct ?

> Yes.  I'm not sure there's a good ROI to prioritize that model.  We have
> to assume >1 device per guest is a typical model and that the iotlb is
> large enough that we might improve thrashing to see both a resource and
> performance benefit from it.  I'm open to suggestions for how we could
> include it though.

Sharing may or may not be possible depending on setups so yes, it's a
bit tricky.

My preference is to have a static interface (and that's actually where
your pet netlink might make some sense :-) to create "synthetic" groups
made of other groups if the arch allows it. But that might not be the
best approach. In another email I also proposed an option for a group to
"capture" another one...

> > If that's
> > not what you're saying, how would the domains - now made up of a
> > user's selection of groups, rather than individual devices - be
> > configured?
> > 
> > > Hope that captures it, feel free to jump in with corrections and
> > > suggestions.  Thanks,
> > 

Another aspect I don't see discussed is how we represent these things to
the guest.

On Power for example, I have a requirement that a given iommu domain is
represented by a single dma window property in the device-tree. What
that means is that that property needs to be either in the node of the
device itself if there's only one device in the group or in a parent
node (ie a bridge or host bridge) if there are multiple devices.

Now I do -not- want to go down the path of simulating P2P bridges,
besides we'll quickly run out of bus numbers if we go there.

For us the most simple and logical approach (which is also what pHyp
uses and what Linux handles well) is really to expose a given PCI host
bridge per group to the guest. Believe it or not, it makes things
easier :-)

Cheers,
Ben.
