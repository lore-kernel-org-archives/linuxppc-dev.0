Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 52B96B71C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Aug 2011 20:30:47 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id p72APYJP018365
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2011 20:25:34 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p72AUgsx405726
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2011 20:30:42 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p72AUfSW021464
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2011 20:30:42 +1000
Date: Tue, 2 Aug 2011 18:28:48 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110802082848.GD29719@yookeroo.fritz.box>
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312050011.2265.185.camel@x201.home>
Cc: aafabbri <aafabbri@cisco.com>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	qemu-devel <qemu-devel@nongnu.org>, chrisw <chrisw@sous-sol.org>,
	iommu <iommu@lists.linux-foundation.org>,
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

On Sat, Jul 30, 2011 at 12:20:08PM -0600, Alex Williamson wrote:
> On Sat, 2011-07-30 at 09:58 +1000, Benjamin Herrenschmidt wrote:
[snip]
> On x86, the USB controllers don't typically live behind a PCIe-to-PCI
> bridge, so don't suffer the source identifier problem, but they do often
> share an interrupt.  But even then, we can count on most modern devices
> supporting PCI2.3, and thus the DisINTx feature, which allows us to
> share interrupts.  In any case, yes, it's more rare but we need to know
> how to handle devices behind PCI bridges.  However I disagree that we
> need to assign all the devices behind such a bridge to the guest.
> There's a difference between removing the device from the host and
> exposing the device to the guest.

I think you're arguing only over details of what words to use for
what, rather than anything of substance here.  The point is that an
entire partitionable group must be assigned to "host" (in which case
kernel drivers may bind to it) or to a particular guest partition (or
at least to a single UID on the host).  Which of the assigned devices
the partition actually uses is another matter of course, as is at
exactly which level they become "de-exposed" if you don't want to use
all of then.

[snip]
> > Maybe something like /sys/devgroups ? This probably warrants involving
> > more kernel people into the discussion.
> 
> I don't yet buy into passing groups to qemu since I don't buy into the
> idea of always exposing all of those devices to qemu.  Would it be
> sufficient to expose iommu nodes in sysfs that link to the devices
> behind them and describe properties and capabilities of the iommu
> itself?  More on this at the end.

Again, I don't think you're making a distinction of any substance.
Ben is saying the group as a whole must be set to allow partition
access, whether or not you call that "assigning".  There's no reason
that passing a sysfs descriptor to qemu couldn't be the qemu
developer's quick-and-dirty method of putting the devices in, while
also allowing full assignment of the devices within the groups by
libvirt.

[snip]
> > Now some of this can be fixed with tweaks, and we've started doing it
> > (we have a working pass-through using VFIO, forgot to mention that, it's
> > just that we don't like what we had to do to get there).
> 
> This is a result of wanting to support *unmodified* x86 guests.  We
> don't have the luxury of having a predefined pvDMA spec that all x86
> OSes adhere to.  The 32bit problem is unfortunate, but the priority use
> case for assigning devices to guests is high performance I/O, which
> usually entails modern, 64bit hardware.  I'd like to see us get to the
> point of having emulated IOMMU hardware on x86, which could then be
> backed by VFIO, but for now guest pinning is the most practical and
> useful.

No-one's suggesting that this isn't a valid mode of operation.  It's
just that right now conditionally disabling it for us is fairly ugly
because of the way the qemu code is structured.

[snip]
> > The above means we need arch specific APIs. So arch specific vfio
> > ioctl's, either that or kvm ones going to vfio or something ... the
> > current structure of vfio/kvm interaction doesn't make it easy.
> 
> FYI, we also have large page support for x86 VT-d, but it seems to only
> be opportunistic right now.  I'll try to come back to the rest of this
> below.

Incidentally there seems to be a hugepage leak bug in the current
kernel code (which I haven't had a chance to track down yet).  Our
qemu code currently has bugs (working on it..) which means it has
unbalanced maps and unmaps of the pages.  But when qemu quits they
should all be released but somehow they're not.

[snip]
> >  - I don't like too much the fact that VFIO provides yet another
> > different API to do what we already have at least 2 kernel APIs for, ie,
> > BAR mapping and config space access. At least it should be better at
> > using the backend infrastructure of the 2 others (sysfs & procfs). I
> > understand it wants to filter in some case (config space) and -maybe-
> > yet another API is the right way to go but allow me to have my doubts.
> 
> The use of PCI sysfs is actually one of my complaints about current
> device assignment.  To do assignment with an unprivileged guest we need
> to open the PCI sysfs config file for it, then change ownership on a
> handful of other PCI sysfs files, then there's this other pci-stub thing
> to maintain ownership, but the kvm ioctls don't actually require it and
> can grab onto any free device...  We are duplicating some of that in
> VFIO, but we also put the ownership of the device behind a single device
> file.  We do have the uiommu problem that we can't give an unprivileged
> user ownership of that, but your usage model may actually make that
> easier.  More below...

Hrm.  I was assuming that a sysfs groups interface would provide a
single place to set the ownership of the whole group.  Whether that's
a echoing a uid to a magic file or doing or chown on the directory or
whatever is a matter of details.

[snip]
> I spent a lot of time looking for an architecture neutral solution here,
> but I don't think it exists.  Please prove me wrong.  The problem is
> that we have to disable INTx on an assigned device after it fires (VFIO
> does this automatically).  If we don't do this, a non-responsive or
> malicious guest could sit on the interrupt, causing it to fire
> repeatedly as a DoS on the host.  The only indication that we can rely
> on to re-enable INTx is when the guest CPU writes an EOI to the APIC.
> We can't just wait for device accesses because a) the device CSRs are
> (hopefully) direct mapped and we'd have to slow map them or attempt to
> do some kind of dirty logging to detect when they're accesses b) what
> constitutes an interrupt service is device specific.
> 
> That means we need to figure out how PCI interrupt 'A' (or B...)
> translates to a GSI (Global System Interrupt - ACPI definition, but
> hopefully a generic concept).  That GSI identifies a pin on an IOAPIC,
> which will also see the APIC EOI.  And just to spice things up, the
> guest can change the PCI to GSI mappings via ACPI.  I think the set of
> callbacks I've added are generic (maybe I left ioapic in the name), but
> yes they do need to be implemented for other architectures.  Patches
> appreciated from those with knowledge of the systems and/or access to
> device specs.  This is the only reason that I make QEMU VFIO only build
> for x86.

There will certainly need to be some arch hooks here, but it can be
made less intrusively x86 specific without too much difficulty.
e.g. Create an EOF notifier chain in qemu - the master PICs (APIC for
x86, XICS for pSeries) for all vfio capable machines need to kick it,
and vfio subscribes.

[snip]
> Rather than your "groups" idea, I've been mulling over whether we can
> just expose the dependencies, configuration, and capabilities in sysfs
> and build qemu commandlines to describe it.  For instance, if we simply
> start with creating iommu nodes in sysfs, we could create links under
> each iommu directory to the devices behind them.  Some kind of
> capability file could define properties like whether it's page table
> based or fixed iova window or the granularity of mapping the devices
> behind it.  Once we have that, we could probably make uiommu attach to
> each of those nodes.

Well, that would address our chief concern that inherently tying the
lifetime of a domain to an fd is problematic.  In fact, I don't really
see how this differs from the groups proposal except in the details of
how you inform qemu of the group^H^H^H^H^Hiommu domain.

[snip]
> Today we do DMA mapping via the VFIO device because the capabilities of
> the IOMMU domains change depending on which devices are connected (for
> VT-d, the least common denominator of the IOMMUs in play).  Forcing the
> DMA mappings through VFIO naturally forces the call order.  If we moved
> to something like above, we could switch the DMA mapping to the uiommu
> device, since the IOMMU would have fixed capabilities.

Ah, that's why you have the map and unmap on the vfio fd,
necessitating the ugly "pick the first vfio fd from the list" thing.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
