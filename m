Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8F1A1B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jul 2009 14:21:54 +1000 (EST)
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29D2ADDDE9
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2009 14:21:53 +1000 (EST)
Date: Mon, 13 Jul 2009 13:20:22 +0900
To: mingo@elte.hu
Subject: Re: [00/15] swiotlb cleanup
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20090710141248.GE26264@elte.hu>
References: <20090710051236.GA22218@elte.hu>
	<1247234512.4002.417.camel@zakaz.uk.xensource.com>
	<20090710141248.GE26264@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20090713131157V.fujita.tomonori@lab.ntt.co.jp>
Cc: fujita.tomonori@lab.ntt.co.jp, jeremy@goop.org, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ian.Campbell@eu.citrix.com,
	linuxppc-dev@ozlabs.org, joerg.roedel@amd.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 10 Jul 2009 16:12:48 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> > functionality and reimplemented the surrounding infrastructure in 
> > terms of that (and incorporating our additional requirements). I 
> > prototyped this (it is currently unworking, in fact it seems to 
> > have developed rather a taste for filesystems :-() but the 
> > diffstat of my WIP patch is:
> >
> >          arch/x86/kernel/pci-swiotlb.c |    6 
> >          arch/x86/xen/pci-swiotlb.c    |    2 
> >          drivers/pci/xen-iommu.c       |  385 ++++++++++++++++++++++++++++++++++++++++--
> >          include/linux/swiotlb.h       |   12 +
> >          lib/swiotlb.c                 |   10 -
> >          5 files changed, 385 insertions(+), 30 deletions(-)
> >
> > where a fair number of the lines in xen-iommu.c are copies of 
> > functions from swiotlb.c with minor modifications. As I say it 
> > doesn't work yet but I think it's roughly indicative of what such 
> > an approach would look like. I don't like it much but am happy to 
> > run with it if it looks to be the most acceptable approach. [...]
> 
> +400 lines of code to avoid much fewer lines of generic code impact 
> on the lib/swiotlb.c side sounds like a bad technical choice to me. 

The amount of code is not the point. The way to impact on the
lib/swiotlb.c is totally wrong from the perspective of the kernel
design; it uses architecture code in the very original (xen) way.


> It makes the swiotlb code less useful and basically forks a random 
> implementation of it in drivers/pci/xen-iommu.c.

I don't think so. We always have the reasonable amount of duplication
rather than integration in a dirty way (at least about IOMMU
code).


> Fujita-san, can you think of a solution that avoids the whole-sale 
> copying of hundreds of lines of code?

Ian didn't give a pointer to his code in a public place so I'm not
sure his claim is valid. But if his code does the right thing and
the duplication is less than 400 lines, it doesn't sound that bad to
me.
