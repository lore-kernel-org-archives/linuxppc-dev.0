Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id CA8A7B6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Aug 2011 01:07:57 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Alex Williamson <alex.williamson@redhat.com>
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Date: Wed, 24 Aug 2011 09:07:46 -0600
In-Reply-To: <20110824085213.GB2079@amd.com>
References: <1312310121.2653.470.camel@bling.home>
	<20110803020422.GF29719@yookeroo.fritz.box>
	<4E3F9E33.5000706@redhat.com> <1312932258.4524.55.camel@bling.home>
	<1312944513.29273.28.camel@pasglop>
	<1313859105.6866.192.camel@x201.home> <20110822172508.GJ2079@amd.com>
	<1314040622.6866.268.camel@x201.home> <20110823131441.GN2079@amd.com>
	<1314119311.2859.59.camel@bling.home> <20110824085213.GB2079@amd.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314198467.2859.192.camel@bling.home>
Mime-Version: 1.0
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

On Wed, 2011-08-24 at 10:52 +0200, Roedel, Joerg wrote:
> On Tue, Aug 23, 2011 at 01:08:29PM -0400, Alex Williamson wrote:
> > On Tue, 2011-08-23 at 15:14 +0200, Roedel, Joerg wrote:
> 
> > > Handling it through fds is a good idea. This makes sure that everything
> > > belongs to one process. I am not really sure yet if we go the way to
> > > just bind plain groups together or if we create meta-groups. The
> > > meta-groups thing seems somewhat cleaner, though.
> > 
> > I'm leaning towards binding because we need to make it dynamic, but I
> > don't really have a good picture of the lifecycle of a meta-group.
> 
> In my view the life-cycle of the meta-group is a subrange of the
> qemu-instance's life-cycle.

I guess I mean the lifecycle of a super-group that's actually exposed as
a new group in sysfs.  Who creates it?  How?  How are groups dynamically
added and removed from the super-group?  The group merging makes sense
to me because it's largely just an optimization that qemu will try to
merge groups.  If it works, great.  If not, it manages them separately.
When all the devices from a group are unplugged, unmerge the group if
necessary.

> > > Putting the process to sleep (which would be uninterruptible) seems bad.
> > > The process would sleep until the guest releases the device-group, which
> > > can take days or months.
> > > The best thing (and the most intrusive :-) ) is to change PCI core to
> > > allow unbindings to fail, I think. But this probably further complicates
> > > the way to upstream VFIO...
> > 
> > Yes, it's not ideal but I think it's sufficient for now and if we later
> > get support for returning an error from release, we can set a timeout
> > after notifying the user to make use of that.  Thanks,
> 
> Ben had the idea of just forcing to hard-unplug this device from the
> guest. Thats probably the best way to deal with that, I think. VFIO
> sends a notification to qemu that the device is gone and qemu informs
> the guest in some way about it.

We need to try the polite method of attempting to hot unplug the device
from qemu first, which the current vfio code already implements.  We can
then escalate if it doesn't respond.  The current code calls abort in
qemu if the guest doesn't respond, but I agree we should also be
enforcing this at the kernel interface.  I think the problem with the
hard-unplug is that we don't have a good revoke mechanism for the mmio
mmaps.  Thanks,

Alex
