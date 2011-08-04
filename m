Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C4CDB6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  4 Aug 2011 10:39:22 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p740Wwjt004081
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Aug 2011 10:32:58 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p740dLR21478818
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Aug 2011 10:39:21 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p740dKMu017983
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Aug 2011 10:39:21 +1000
Date: Thu, 4 Aug 2011 10:39:17 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110804003917.GH29719@yookeroo.fritz.box>
References: <1311983933.8793.42.camel@pasglop>
	<1312050011.2265.185.camel@x201.home>
	<20110802082848.GD29719@yookeroo.fritz.box>
	<1312308847.2653.467.camel@bling.home>
	<1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<1312343090.2653.564.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312343090.2653.564.camel@bling.home>
Cc: aafabbri <aafabbri@cisco.com>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	kvm@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>, chrisw <chrisw@sous-sol.org>,
	iommu <iommu@lists.linux-foundation.org>,
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

On Tue, Aug 02, 2011 at 09:44:49PM -0600, Alex Williamson wrote:
> On Wed, 2011-08-03 at 12:04 +1000, David Gibson wrote:
> > On Tue, Aug 02, 2011 at 12:35:19PM -0600, Alex Williamson wrote:
> > > On Tue, 2011-08-02 at 12:14 -0600, Alex Williamson wrote:
> > > > On Tue, 2011-08-02 at 18:28 +1000, David Gibson wrote:
> > > > > On Sat, Jul 30, 2011 at 12:20:08PM -0600, Alex Williamson wrote:
> > > > > > On Sat, 2011-07-30 at 09:58 +1000, Benjamin Herrenschmidt wrote:
> > > > > [snip]
> > > > > > On x86, the USB controllers don't typically live behind a PCIe-to-PCI
> > > > > > bridge, so don't suffer the source identifier problem, but they do often
> > > > > > share an interrupt.  But even then, we can count on most modern devices
> > > > > > supporting PCI2.3, and thus the DisINTx feature, which allows us to
> > > > > > share interrupts.  In any case, yes, it's more rare but we need to know
> > > > > > how to handle devices behind PCI bridges.  However I disagree that we
> > > > > > need to assign all the devices behind such a bridge to the guest.
> > > > > > There's a difference between removing the device from the host and
> > > > > > exposing the device to the guest.
> > > > > 
> > > > > I think you're arguing only over details of what words to use for
> > > > > what, rather than anything of substance here.  The point is that an
> > > > > entire partitionable group must be assigned to "host" (in which case
> > > > > kernel drivers may bind to it) or to a particular guest partition (or
> > > > > at least to a single UID on the host).  Which of the assigned devices
> > > > > the partition actually uses is another matter of course, as is at
> > > > > exactly which level they become "de-exposed" if you don't want to use
> > > > > all of then.
> > > > 
> > > > Well first we need to define what a partitionable group is, whether it's
> > > > based on hardware requirements or user policy.  And while I agree that
> > > > we need unique ownership of a partition, I disagree that qemu is
> > > > necessarily the owner of the entire partition vs individual devices.
> > > 
> > > Sorry, I didn't intend to have such circular logic.  "... I disagree
> > > that qemu is necessarily the owner of the entire partition vs granted
> > > access to devices within the partition".  Thanks,
> > 
> > I still don't understand the distinction you're making.  We're saying
> > the group is "owned" by a given user or guest in the sense that no-one
> > else may use anything in the group (including host drivers).  At that
> > point none, some or all of the devices in the group may actually be
> > used by the guest.
> > 
> > You seem to be making a distinction between "owned by" and "assigned
> > to" and "used by" and I really don't see what it is.
> 
> How does a qemu instance that uses none of the devices in a group still
> own that group?

?? In the same way that you still own a file you don't have open..?

>  Aren't we at that point free to move the group to a
> different qemu instance or return ownership to the host?

Of course.  But until you actually do that, the group is still
notionally owned by the guest.

>  Who does that?

The admin.  Possily by poking sysfs, or possibly by frobbing some
character device, or maybe something else.  Naturally libvirt or
whatever could also do this.

> In my mental model, there's an intermediary that "owns" the group and
> just as kernel drivers bind to devices when the host owns the group,
> qemu is a userspace device driver that binds to sets of devices when the
> intermediary owns it.  Obviously I'm thinking libvirt, but it doesn't
> have to be.  Thanks,

Well sure, but I really don't see how such an intermediary fits into
the kernel's model of ownership.

So, first, take a step back and look at what sort of entities can
"own" a group (or device or whatever).  I notice that when I've said
"owned by the guest" you seem to have read this as "owned by qemu"
which is not necessarily the same thing.

What I had in mind is that each group is either owned by "host", in
which case host kernel drivers can bind to it, or it's in "guest mode"
in which case it has a user, group and mode and can be bound by user
drivers (and therefore guests) with the right permission.  From the
kernel's perspective there is therefore no distinction between "owned
by qemu" and "owned by libvirt".


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
