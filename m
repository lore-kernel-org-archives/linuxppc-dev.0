Return-Path: <Joerg.Roedel@amd.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C1723B6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 19:11:11 +1000 (EST)
Date: Wed, 24 Aug 2011 11:10:35 +0200
From: Joerg Roedel <joerg.roedel@amd.com>
To: Aaron Fabbri <aafabbri@cisco.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110824091035.GD2079@amd.com>
References: <1314118861.2859.51.camel@bling.home>
	<CA79326A.FB97%aafabbri@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CA79326A.FB97%aafabbri@cisco.com>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	iommu <iommu@lists.linux-foundation.org>, chrisw <chrisw@sous-sol.org>,
	Alex Williamson <alex.williamson@redhat.com>, Avi Kivity <avi@redhat.com>,
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

On Tue, Aug 23, 2011 at 01:33:14PM -0400, Aaron Fabbri wrote:
> On 8/23/11 10:01 AM, "Alex Williamson" <alex.williamson@redhat.com> wrote:
> > The iommu domain would probably be allocated when the first device is
> > bound to vfio.  As each device is bound, it gets attached to the group.
> > DMAs are done via an ioctl on the group.
> > 
> > I think group + uiommu leads to effectively reliving most of the
> > problems with the current code.  The only benefit is the group
> > assignment to enforce hardware restrictions.  We still have the problem
> > that uiommu open() = iommu_domain_alloc(), whose properties are
> > meaningless without attached devices (groups).  Which I think leads to
> > the same awkward model of attaching groups to define the domain, then we
> > end up doing mappings via the group to enforce ordering.
> 
> Is there a better way to allow groups to share an IOMMU domain?
> 
> Maybe, instead of having an ioctl to allow a group A to inherit the same
> iommu domain as group B, we could have an ioctl to fully merge two groups
> (could be what Ben was thinking):
> 
> A.ioctl(MERGE_TO_GROUP, B)
> 
> The group A now goes away and its devices join group B.  If A ever had an
> iommu domain assigned (and buffers mapped?) we fail.
> 
> Groups cannot get smaller (they are defined as minimum granularity of an
> IOMMU, initially).  They can get bigger if you want to share IOMMU
> resources, though.
> 
> Any downsides to this approach?

As long as this is a 2-way road its fine. There must be a way to split
the groups again after the guest exits. But then we are again at the
super-groups (aka meta-groups, aka uiommu) point.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
