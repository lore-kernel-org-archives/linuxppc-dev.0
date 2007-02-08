Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83E0DDDEE8
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 08:26:12 +1100 (EST)
Subject: Re: Discussion about iopa()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
In-Reply-To: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 08:26:05 +1100
Message-Id: <1170969965.2620.345.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Tabi Timur-B04825 <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Do you think we should remove iopa?

I'm really not fan of it. We might keep it for now to not break
everything that uses it, but I'd rather avoid new things using it
directly.

> The information is often not so obvious.  The most case of using iopa is
> that we allocate memory from MURAM using rheap, and then get the
> physical address of it.

Then provide specific MURAM functions that return a dma_addr_t in
addition to the virtual address and have your driver keep track of that.
It's more efficient than walking the page tables all the time anyway.

Remember that if you have CONFIG_HIGHMEM, you can potentially have to
create TLB entries for accessing the PTEs used by iopa to resolve the
address. It's really not efficient.

>   We can calculate phy_addr by using:  virt_addr
> - virt_muram_base + phy_muram_base, but it is not as straightforward as
> just using the page table, let alone we need to keep track of
> virt_muram_base and phy_muram_base.

Using the page table is much less efficient. As I said, I'd rather see
you having a set of alloc/free functions for your MURAM that return the
dma_addr_t as well as the virtual address (like dma_alloc_coherent does)
and have your drivers using these keep track of the dma_addr_t.

Ben.
