Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id EF684B71BF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Aug 2011 01:35:07 +1000 (EST)
Subject: Re: kvm PCI assignment & VFIO ramblings
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 02 Aug 2011 09:34:58 -0600
In-Reply-To: <1312289929.8793.890.camel@pasglop>
References: <1311983933.8793.42.camel@pasglop> <4E356221.6010302@redhat.com>
	<1312248479.8793.827.camel@pasglop>  <4E37BF62.2060809@redhat.com>
	<1312289929.8793.890.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1312299299.2653.429.camel@bling.home>
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
	Paul Mackerras <pmac@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	David Gibson <dwg@au1.ibm.com>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-08-02 at 22:58 +1000, Benjamin Herrenschmidt wrote:
> 
> Don't worry, it took me a while to get my head around the HW :-) SR-IOV
> VFs will generally not have limitations like that no, but on the other
> hand, they -will- still require 1 VF = 1 group, ie, you won't be able to
> take a bunch of VFs and put them in the same 'domain'.
> 
> I think the main deal is that VFIO/qemu sees "domains" as "guests" and
> tries to put all devices for a given guest into a "domain".

Actually, that's only a recent optimization, before that each device got
it's own iommu domain.  It's actually completely configurable on the
qemu command line which devices get their own iommu and which share.
The default optimizes the number of domains (one) and thus the number of
mapping callbacks since we pin the entire guest.

> On POWER, we have a different view of things were domains/groups are
> defined to be the smallest granularity we can (down to a single VF) and
> we give several groups to a guest (ie we avoid sharing the iommu in most
> cases)
> 
> This is driven by the HW design but that design is itself driven by the
> idea that the domains/group are also error isolation groups and we don't
> want to take all of the IOs of a guest down if one adapter in that guest
> is having an error.
> 
> The x86 domains are conceptually different as they are about sharing the
> iommu page tables with the clear long term intent of then sharing those
> page tables with the guest CPU own. We aren't going in that direction
> (at this point at least) on POWER..

Yes and no.  The x86 domains are pretty flexible and used a few
different ways.  On the host we do dynamic DMA with a domain per device,
mapping only the inflight DMA ranges.  In order to achieve the
transparent device assignment model, we have to flip that around and map
the entire guest.  As noted, we can continue to use separate domains for
this, but since each maps the entire guest, it doesn't add a lot of
value and uses more resources and requires more mapping callbacks (and
x86 doesn't have the best error containment anyway).  If we had a well
supported IOMMU model that we could adapt for pvDMA, then it would make
sense to keep each device in it's own domain again.  Thanks,

Alex
