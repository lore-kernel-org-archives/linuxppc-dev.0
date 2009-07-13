Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EEC93B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jul 2009 19:20:00 +1000 (EST)
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94D0CDDDE1
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2009 19:19:59 +1000 (EST)
Date: Mon, 13 Jul 2009 18:16:30 +0900
To: mingo@elte.hu
Subject: Re: [00/15] swiotlb cleanup
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20090713131157V.fujita.tomonori@lab.ntt.co.jp>
References: <1247234512.4002.417.camel@zakaz.uk.xensource.com>
	<20090710141248.GE26264@elte.hu>
	<20090713131157V.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20090713181558B.fujita.tomonori@lab.ntt.co.jp>
Cc: jeremy@goop.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Ian.Campbell@eu.citrix.com, linuxppc-dev@ozlabs.org, joerg.roedel@amd.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 13 Jul 2009 13:20:22 +0900
FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:

> On Fri, 10 Jul 2009 16:12:48 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > functionality and reimplemented the surrounding infrastructure in 
> > > terms of that (and incorporating our additional requirements). I 
> > > prototyped this (it is currently unworking, in fact it seems to 
> > > have developed rather a taste for filesystems :-() but the 
> > > diffstat of my WIP patch is:
> > >
> > >          arch/x86/kernel/pci-swiotlb.c |    6 
> > >          arch/x86/xen/pci-swiotlb.c    |    2 
> > >          drivers/pci/xen-iommu.c       |  385 ++++++++++++++++++++++++++++++++++++++++--
> > >          include/linux/swiotlb.h       |   12 +
> > >          lib/swiotlb.c                 |   10 -
> > >          5 files changed, 385 insertions(+), 30 deletions(-)
> > >
> > > where a fair number of the lines in xen-iommu.c are copies of 
> > > functions from swiotlb.c with minor modifications. As I say it 
> > > doesn't work yet but I think it's roughly indicative of what such 
> > > an approach would look like. I don't like it much but am happy to 
> > > run with it if it looks to be the most acceptable approach. [...]
> > 
> > +400 lines of code to avoid much fewer lines of generic code impact 
> > on the lib/swiotlb.c side sounds like a bad technical choice to me. 
> 
> The amount of code is not the point. The way to impact on the
> lib/swiotlb.c is totally wrong from the perspective of the kernel
> design; it uses architecture code in the very original (xen) way.

btw, '+400 lines of code to avoid much fewer lines of generic code
impact on the lib/swiotlb.c' doesn't sound true to me.

Here is a patch in the way that Xen people want to do:

http://patchwork.kernel.org/patch/26343/

---
 arch/x86/Kconfig                 |    4 +
 arch/x86/include/asm/io.h        |    2 +
 arch/x86/include/asm/pci_x86.h   |    1 +
 arch/x86/include/asm/xen/iommu.h |   12 ++
 arch/x86/kernel/pci-dma.c        |    3 +
 arch/x86/pci/Makefile            |    1 +
 arch/x86/pci/init.c              |    6 +
 arch/x86/pci/xen.c               |   51 +++++++
 drivers/pci/Makefile             |    2 +
 drivers/pci/xen-iommu.c          |  271 ++++++++++++++++++++++++++++++++++++++


Even with the way that Xen people want to do, drivers/pci/xen-iommu.c
is about 300 lines. And my patchset removes the nice amount of lines
for dom0 support. I don't see much difference wrt lines.
