Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5648DB708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 15:09:57 +1000 (EST)
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B403DDDDE1
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 15:09:55 +1000 (EST)
Date: Tue, 14 Jul 2009 14:08:47 +0900
To: beckyb@kernel.crashing.org
Subject: Re: [PATCH 04/15] swiotlb: remove unnecessary swiotlb_bus_to_virt
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <5E909C02-3FA2-4BEB-8C73-F4E4A5A404BF@kernel.crashing.org>
References: <1247187904-31999-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1247187904-31999-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<5E909C02-3FA2-4BEB-8C73-F4E4A5A404BF@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20090714140805G.fujita.tomonori@lab.ntt.co.jp>
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 13 Jul 2009 21:17:21 -0500
Becky Bruce <beckyb@kernel.crashing.org> wrote:

> 
> On Jul 9, 2009, at 8:04 PM, FUJITA Tomonori wrote:
> 
> > swiotlb_bus_to_virt is unncessary; we can use swiotlb_bus_to_phys and
> > phys_to_virt instead.
> 
> phys_to_virt (also, virt_to_phys) is invalid for highmem addresses on  
> ppc.  In most of the uses in this file, it doesn't matter, as the  
> iotlb buffers themselves are alloc'd out of lowmem,

Right,

> but the  
> dma_mark_clean() calls could happen on a highmem addr.  Currently, on  
> powerpc, dma_mark_clean() doesn't do anything, so it isn't a  
> functional problem.

Oops, I overlooked this. However, as you said, this is not a problem
with the current code.


>  I'm fine with the bulk of this patch, because in  
> reality, if I need to do something with a virtual address of a highmem  
> page, I have to get a kmap for the page.  So the existing  
> swiotlb_bus_to_virt isn't really helping.
> 
> What is dma_mark_clean used for?  Could it be made to take a paddr,  
> and let the implementation deal with making sure there's a valid vaddr  
> for the actual "clean" operation?

I think that it's IA64's optimization (it's a NULL function on X86
like POWERPC). It's defined in arch/ia64/mm/init.c. Looks like POWERPC
could use this optimization, I guess.

dma_mark_clean() just modifies the page flag (what it needs is struct
page) so I think that we can make it take a paddr.


> I'd also like to see a comment with swiotlb_virt_to_bus() that notes  
> that it should only be called on addresses in lowmem.

Ok, I'll do.


Thanks,
