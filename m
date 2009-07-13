Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9894FB7069
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jul 2009 14:21:54 +1000 (EST)
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D644DDDEE
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2009 14:21:53 +1000 (EST)
Date: Mon, 13 Jul 2009 13:20:26 +0900
To: Ian.Campbell@citrix.com
Subject: Re: [00/15] swiotlb cleanup
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1247234520.4002.418.camel@zakaz.uk.xensource.com>
References: <20090710051236.GA22218@elte.hu>
	<20090710143408A.fujita.tomonori@lab.ntt.co.jp>
	<1247234520.4002.418.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20090713131859N.fujita.tomonori@lab.ntt.co.jp>
Cc: jeremy@goop.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org,
	joerg.roedel@amd.com, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 10 Jul 2009 15:02:00 +0100
Ian Campbell <Ian.Campbell@citrix.com> wrote:

> On Fri, 2009-07-10 at 14:35 +0900, FUJITA Tomonori wrote:
> > I don't think that we need to take account of dom0 support; we don't
> > have a clear idea about an acceptable dom0 design (it needs to use
> > swiotlb code? I don't know yet), we don't even know we will have dom0
> > support in mainline. That's why I didn't CC this patchset to Xen
> > camp.
> 
> The core domain 0 patches which were the subject of the discussions a
> few week back are completely orthogonal to the swiotlb side of things

? If we don't merge dom0 patch, we don't need dom0 changes to
swiotlb. We don't know we would have dom0 support in mainline. Or I
overlooked something?


> and whatever form they eventually take I do not think it will have any
> impact on the shape of the solution which we arrive at for swiotlb. I
> don't think that assuming that domain 0 can never be done in a way which
> everyone finds acceptable and therefore discounting all consideration of
> it is a useful way to make progress with these issues.
> 
> The DMA use case is much more tightly tied to the paravirtualized MMU
> (which is already in the kernel for domU purposes) than it is to "the
> domain 0" patches anyway. Although domain 0 is probably the main use
> case, at least today, swiotlb support is also used in a Xen domU as part
> of the support for direct assignment of PCI devices to paravirtualised
> guests (pci passthrough).
> 
> The pci frontend driver depends on some bits of the domain 0 physical
> interrupt patches as well as swiotlb which is why I/we haven't tried to
> upstream that particular series yet.

As far as I know, you have not posted anything about changes to
swiotlb for domU. I can't discuss it. If you want, please send
patches.
