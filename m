Return-Path: <markn@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8E3F8DDF0F
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 18:06:46 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id m4N87OXe021572
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 18:07:24 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4N86VLB3788826
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 18:06:31 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4N86j4U009720
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 18:06:45 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] POWERPC: Merge 32 and 64-bit dma code
Date: Fri, 23 May 2008 18:06:50 +1000
References: <Pine.LNX.4.64.0804301815020.12768@monty.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0804301815020.12768@monty.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805231806.50551.markn@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 1 May 2008 09:36:43 am Becky Bruce wrote:
> 
> I essentially adopt the 64-bit dma code, with some changes to support
> 32-bit systems, including HIGHMEM.  dma functions on 32-bit are now
> invoked via accessor functions which call the correct op for a device based
> on archdata dma_ops.  Currently, this defaults to dma_direct_ops, but this
> structure will make it easier to do iommu/swiotlb on 32-bit going
> forward.
> 
> In addition, the dma_map/unmap_page functions are added to dma_ops on
> HIGHMEM-enabled configs because we can't just fall back on map/unmap_single
> when HIGHMEM is enabled.  Adding these to dma_ops makes it cleaner to
> substitute different functionality once we have iommu/swiotlb support.
> 
> This code conflicts with the dma_attrs code that Mark Nelson just pushed.
> At this point, I'm just looking for some review, and suggestions on how 
> this code might be improved.  I'll uprev it to work with Mark's code once
> that goes in.

The last patch of my series may be in question so it could end up that this
patch makes it in first. It shouldn't be too hard to respin my patches after
your merge so no worries there though.

> 
> There will be other patches that precede this one - I plan to duplicate 
> dma_mapping.h into include/asm-ppc to avoid breakage there.  There will 
> also be a patch to rename dma_64.c to dma.c, and a series of patches to 
> modify drivers that pass NULL dev pointers.
> 
> Dma experts, please review this when you can - I was a dma newbie 
> until very recently, and the odds that I'm missing some subtlety 
> in this merge are fairly high.
> 

I'm far from a DMA expert but this all looks sane to me - I can't really
comment on the 32bit side of things but I don't think it's going to break
anything on 64bit (it compiles fine on cell and pseries).

I'll try and test boot it on Monday.

We should get BenH to look at it but he's travelling at the moment...

Mark.

> Cheers,
> Becky
> 
>  ---
>  arch/powerpc/kernel/Makefile      |    4 +-
>  arch/powerpc/kernel/dma_64.c      |   80 ++++++++++++++++++-
>  arch/powerpc/kernel/pci-common.c  |   53 +++++++++++++
>  arch/powerpc/kernel/pci_32.c      |    7 ++
>  arch/powerpc/kernel/pci_64.c      |   49 ------------
>  include/asm-powerpc/dma-mapping.h |  156 +++++++++----------------------------
>  include/asm-powerpc/machdep.h     |    5 +-
>  include/asm-powerpc/pci.h         |   14 ++--
>  8 files changed, 186 insertions(+), 182 deletions(-)
<snip>
