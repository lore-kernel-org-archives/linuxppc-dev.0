Return-Path: <Joerg.Roedel@amd.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A944CB6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Aug 2011 22:32:15 +1000 (EST)
Date: Thu, 25 Aug 2011 14:31:46 +0200
From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110825123146.GD1923@amd.com>
References: <4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home>
	<20110822172508.GJ2079@amd.com>
	<1314040622.6866.268.camel@x201.home>
	<20110823131441.GN2079@amd.com>
	<1314119311.2859.59.camel@bling.home>
	<20110824085213.GB2079@amd.com>
	<1314198467.2859.192.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1314198467.2859.192.camel@bling.home>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>,
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

On Wed, Aug 24, 2011 at 11:07:46AM -0400, Alex Williamson wrote:
> On Wed, 2011-08-24 at 10:52 +0200, Roedel, Joerg wrote:
> > On Tue, Aug 23, 2011 at 01:08:29PM -0400, Alex Williamson wrote:
> > > On Tue, 2011-08-23 at 15:14 +0200, Roedel, Joerg wrote:
> > 
> > > > Handling it through fds is a good idea. This makes sure that everything
> > > > belongs to one process. I am not really sure yet if we go the way to
> > > > just bind plain groups together or if we create meta-groups. The
> > > > meta-groups thing seems somewhat cleaner, though.
> > > 
> > > I'm leaning towards binding because we need to make it dynamic, but I
> > > don't really have a good picture of the lifecycle of a meta-group.
> > 
> > In my view the life-cycle of the meta-group is a subrange of the
> > qemu-instance's life-cycle.
> 
> I guess I mean the lifecycle of a super-group that's actually exposed as
> a new group in sysfs.  Who creates it?  How?  How are groups dynamically
> added and removed from the super-group?  The group merging makes sense
> to me because it's largely just an optimization that qemu will try to
> merge groups.  If it works, great.  If not, it manages them separately.
> When all the devices from a group are unplugged, unmerge the group if
> necessary.

Right. The super-group thing is an optimization.

> We need to try the polite method of attempting to hot unplug the device
> from qemu first, which the current vfio code already implements.  We can
> then escalate if it doesn't respond.  The current code calls abort in
> qemu if the guest doesn't respond, but I agree we should also be
> enforcing this at the kernel interface.  I think the problem with the
> hard-unplug is that we don't have a good revoke mechanism for the mmio
> mmaps.

For mmio we could stop the guest and replace the mmio region with a
region that is filled with 0xff, no?

Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
