Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 84D54B6F8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Aug 2011 04:04:37 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Alex Williamson <alex.williamson@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Date: Fri, 26 Aug 2011 12:04:22 -0600
In-Reply-To: <20110825180557.GD8978@8bytes.org>
References: <1314118861.2859.51.camel@bling.home>
	<CA79326A.FB97%aafabbri@cisco.com> <20110824091035.GD2079@amd.com>
	<1314220434.2859.203.camel@bling.home> <20110825105402.GB1923@amd.com>
	<1314292832.2492.31.camel@x201.home> <20110825180557.GD8978@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314381863.2859.312.camel@bling.home>
Mime-Version: 1.0
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

On Thu, 2011-08-25 at 20:05 +0200, Joerg Roedel wrote:
> On Thu, Aug 25, 2011 at 11:20:30AM -0600, Alex Williamson wrote:
> > On Thu, 2011-08-25 at 12:54 +0200, Roedel, Joerg wrote:
> 
> > > We need to solve this differently. ARM is starting to use the iommu-api
> > > too and this definitly does not work there. One possible solution might
> > > be to make the iommu-ops per-bus.
> > 
> > That sounds good.  Is anyone working on it?  It seems like it doesn't
> > hurt to use this in the interim, we may just be watching the wrong bus
> > and never add any sysfs group info.
> 
> I'll cook something up for RFC over the weekend.
> 
> > > Also the return type should not be long but something that fits into
> > > 32bit on all platforms. Since you use -ENODEV, probably s32 is a good
> > > choice.
> > 
> > The convenience of using seg|bus|dev|fn was too much to resist, too bad
> > it requires a full 32bits.  Maybe I'll change it to:
> >         int iommu_device_group(struct device *dev, unsigned int *group)
> 
> If we really expect segment numbers that need the full 16 bit then this
> would be the way to go. Otherwise I would prefer returning the group-id
> directly and partition the group-id space for the error values (s32 with
> negative numbers being errors).

It's unlikely to have segments using the top bit, but it would be broken
for an iommu driver to define it's group numbers using pci s:b:d.f if we
don't have that bit available.  Ben/David, do PEs have an identifier of
a convenient size?  I'd guess any hardware based identifier is going to
use a full unsigned bit width.  Thanks,

Alex
