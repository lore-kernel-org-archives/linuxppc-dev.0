Return-Path: <Joerg.Roedel@amd.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 059B3B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 19:24:54 +1000 (EST)
Date: Fri, 26 Aug 2011 11:24:40 +0200
From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
To: Alexander Graf <agraf@suse.de>, Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Mackerras
	<pmac@au1.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, iommu
	<iommu@lists.linux-foundation.org>, chrisw <chrisw@sous-sol.org>, Alex
	Williamson <alex.williamson@redhat.com>, Avi Kivity <avi@redhat.com>,
	Anthony Liguori <anthony@codemonkey.ws>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"benve@cisco.com" <benve@cisco.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110826092440.GO1923@amd.com>
References: <1313859105.6866.192.camel@x201.home>
	<20110822172508.GJ2079@amd.com>
	<1314040622.6866.268.camel@x201.home>
	<20110823131441.GN2079@amd.com>
	<1314119311.2859.59.camel@bling.home>
	<20110824085213.GB2079@amd.com>
	<1314198467.2859.192.camel@bling.home>
	<20110825123146.GD1923@amd.com>
	<EC0C2298-1EC9-42A0-9A71-3671E21BCA56@suse.de>
	<20110826042423.GF2308@yookeroo.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110826042423.GF2308@yookeroo.fritz.box>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 26, 2011 at 12:24:23AM -0400, David Gibson wrote:
> On Thu, Aug 25, 2011 at 08:25:45AM -0500, Alexander Graf wrote:
> > On 25.08.2011, at 07:31, Roedel, Joerg wrote:

> > > For mmio we could stop the guest and replace the mmio region with a
> > > region that is filled with 0xff, no?
> > 
> > Sure, but that happens in user space. The question is how does
> > kernel space enforce an MMIO region to not be mapped after the
> > hotplug event occured? Keep in mind that user space is pretty much
> > untrusted here - it doesn't have to be QEMU. It could just as well
> > be a generic user space driver. And that can just ignore hotplug
> > events.
> 
> We're saying you hard yank the mapping from the userspace process.
> That is, you invalidate all its PTEs mapping the MMIO space, and don't
> let it fault them back in.
> 
> As I see it there are two options: (a) make subsequent accesses from
> userspace or the guest result in either a SIGBUS that userspace must
> either deal with or die, or (b) replace the mapping with a dummy RO
> mapping containing 0xff, with any trapped writes emulated as nops.

The biggest problem with this approach is that it has to happen in the
context of the given process. Linux can't really modify an mm which
which belong to another context in a safe way.

The more I think about this, I come to the conclusion that it would be
the best to just kill the process accessing the device if it is manually
de-assigned from vfio. It should be a non-standard path anyway so it
doesn't make a lot of sense to implement complicated handling semantics
for it, no?

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
