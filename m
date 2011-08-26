Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 07D97B6F8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 14:24:32 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p7Q4OUUF013255
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2011 14:24:30 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7Q4NBTX1548444
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2011 14:23:11 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7Q4OSrV010393
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2011 14:24:29 +1000
Date: Fri, 26 Aug 2011 14:24:23 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110826042423.GF2308@yookeroo.fritz.box>
References: <1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
	<20110822172508.GJ2079@amd.com>
	<1314040622.6866.268.camel@x201.home>
	<20110823131441.GN2079@amd.com>
	<1314119311.2859.59.camel@bling.home>
	<20110824085213.GB2079@amd.com>
	<1314198467.2859.192.camel@bling.home>
	<20110825123146.GD1923@amd.com>
	<EC0C2298-1EC9-42A0-9A71-3671E21BCA56@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EC0C2298-1EC9-42A0-9A71-3671E21BCA56@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, "Roedel, Joerg" <joerg.roedel@amd.com>,
	qemu-devel <qemu-devel@nongnu.org>, chrisw <chrisw@sous-sol.org>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"benve@cisco.com" <benve@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 25, 2011 at 08:25:45AM -0500, Alexander Graf wrote:
> 
> On 25.08.2011, at 07:31, Roedel, Joerg wrote:
> 
> > On Wed, Aug 24, 2011 at 11:07:46AM -0400, Alex Williamson wrote:
> >> On Wed, 2011-08-24 at 10:52 +0200, Roedel, Joerg wrote:
> > 
> 
> [...]
> 
> >> We need to try the polite method of attempting to hot unplug the device
> >> from qemu first, which the current vfio code already implements.  We can
> >> then escalate if it doesn't respond.  The current code calls abort in
> >> qemu if the guest doesn't respond, but I agree we should also be
> >> enforcing this at the kernel interface.  I think the problem with the
> >> hard-unplug is that we don't have a good revoke mechanism for the mmio
> >> mmaps.
> > 
> > For mmio we could stop the guest and replace the mmio region with a
> > region that is filled with 0xff, no?
> 
> Sure, but that happens in user space. The question is how does
> kernel space enforce an MMIO region to not be mapped after the
> hotplug event occured? Keep in mind that user space is pretty much
> untrusted here - it doesn't have to be QEMU. It could just as well
> be a generic user space driver. And that can just ignore hotplug
> events.

We're saying you hard yank the mapping from the userspace process.
That is, you invalidate all its PTEs mapping the MMIO space, and don't
let it fault them back in.

As I see it there are two options: (a) make subsequent accesses from
userspace or the guest result in either a SIGBUS that userspace must
either deal with or die, or (b) replace the mapping with a dummy RO
mapping containing 0xff, with any trapped writes emulated as nops.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
