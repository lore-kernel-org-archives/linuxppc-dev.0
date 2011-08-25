Return-Path: <joro@8bytes.org>
Received: from 8bytes.org (8bytes.org [88.198.83.132])
	by ozlabs.org (Postfix) with ESMTP id 66909B6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 04:06:00 +1000 (EST)
Date: Thu, 25 Aug 2011 20:05:57 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110825180557.GD8978@8bytes.org>
References: <1314118861.2859.51.camel@bling.home>
	<CA79326A.FB97%aafabbri@cisco.com> <20110824091035.GD2079@amd.com>
	<1314220434.2859.203.camel@bling.home>
	<20110825105402.GB1923@amd.com>
	<1314292832.2492.31.camel@x201.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314292832.2492.31.camel@x201.home>
Cc: chrisw <chrisw@sous-sol.org>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, "Roedel, Joerg" <Joerg.Roedel@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>, Aaron Fabbri <aafabbri@cisco.com>,
	iommu <iommu@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
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

On Thu, Aug 25, 2011 at 11:20:30AM -0600, Alex Williamson wrote:
> On Thu, 2011-08-25 at 12:54 +0200, Roedel, Joerg wrote:

> > We need to solve this differently. ARM is starting to use the iommu-api
> > too and this definitly does not work there. One possible solution might
> > be to make the iommu-ops per-bus.
> 
> That sounds good.  Is anyone working on it?  It seems like it doesn't
> hurt to use this in the interim, we may just be watching the wrong bus
> and never add any sysfs group info.

I'll cook something up for RFC over the weekend.

> > Also the return type should not be long but something that fits into
> > 32bit on all platforms. Since you use -ENODEV, probably s32 is a good
> > choice.
> 
> The convenience of using seg|bus|dev|fn was too much to resist, too bad
> it requires a full 32bits.  Maybe I'll change it to:
>         int iommu_device_group(struct device *dev, unsigned int *group)

If we really expect segment numbers that need the full 16 bit then this
would be the way to go. Otherwise I would prefer returning the group-id
directly and partition the group-id space for the error values (s32 with
negative numbers being errors).

> > > @@ -438,6 +439,10 @@ static int __init intel_iommu_setup(char *str)
> > >  			printk(KERN_INFO
> > >  				"Intel-IOMMU: disable supported super page\n");
> > >  			intel_iommu_superpage = 0;
> > > +		} else if (!strncmp(str, "no_mf_groups", 12)) {
> > > +			printk(KERN_INFO
> > > +				"Intel-IOMMU: disable separate groups for multifunction devices\n");
> > > +			intel_iommu_no_mf_groups = 1;
> > 
> > This should really be a global iommu option and not be VT-d specific.
> 
> You think?  It's meaningless on benh's power systems.

But it is not meaningless on AMD-Vi systems :) There should be one
option for both.
On the other hand this requires an iommu= parameter on ia64, but thats
probably not that bad.

> > This looks like code duplication in the VT-d driver. It doesn't need to
> > be generalized now, but we should keep in mind to do a more general
> > solution later.
> > Maybe it is beneficial if the IOMMU drivers only setup the number in
> > dev->arch.iommu.groupid and the iommu-api fetches it from there then.
> > But as I said, this is some more work and does not need to be done for
> > this patch(-set).
> 
> The iommu-api reaches into dev->arch.iommu.groupid?  I figured we should
> at least start out with a lightweight, optional interface without the
> overhead of predefining groupids setup by bus notification callbacks in
> each iommu driver.  Thanks,

As I said, this is just an idea for an later optimization. It is fine
for now as it is in this patch.

	Joerg
