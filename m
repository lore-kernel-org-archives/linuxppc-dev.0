Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA93A1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 20:09:12 +1100 (AEDT)
Message-ID: <1446541751.23081.1.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: sparse: add __iomem annotations in vphb.c
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
Cc: imunsie@au1.ibm.com, dja@axtens.net
Date: Tue, 03 Nov 2015 20:09:11 +1100
In-Reply-To: <1446002979-29728-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1446002979-29728-1-git-send-email-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-10-28 at 14:29 +1100, Andrew Donnellan wrote:

> sparse identifies the following issues:
> 
>   drivers/misc/cxl/vphb.c:131:17: warning: incorrect type in assignment
>     (different address spaces)
>   drivers/misc/cxl/vphb.c:131:17:    expected void volatile [noderef]
>     <asn:2>*<noident>
>   drivers/misc/cxl/vphb.c:131:17:    got void *<noident>
>   drivers/misc/cxl/vphb.c:252:23: warning: incorrect type in assignment
>     (different address spaces)
>   drivers/misc/cxl/vphb.c:252:23:    expected void [noderef]
>     <asn:2>*cfg_data
>   drivers/misc/cxl/vphb.c:252:23:    got void *<noident>
> 
> Add __iomem annotations and remove unnecessary casts to clear up these
> warnings.
> 
> Reported-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> 
> ---
> 
> This patch is a respin of https://patchwork.ozlabs.org/patch/504976/,
> incorporating comments from mpe.
> 
> As with the old patch, this patch doesn't make any changes to the return
> type of cxl_pcie_cfg_addr() and casts to an __iomem type when we use it in
> cxl_pcie_config_info(). cxl_pcie_cfg_addr() returns an unsigned long,
> rather than a pointer type, as we use its return value in bitwise
> operations. If there's a better way to handle this I'd like to know.

There's always a better way, but can we agree on what it is :)

Part of your problem is you're storing afu->crs_len which is not __iomem in
cfg_data which is, and so that's leading to some of your casts.

I don't really see why you're using cfg_data like that, you have the afu in
phb->private_data. But maybe cfg_data needs to hold that value for some other
code I'm not seeing.

Regardless, in cxl_pcie_config_info() you have the afu pointer, so you can just
look at afu->crs_len directly can't you?

That means you can drop one cast of cfg_data to unsigned long in there.

Then I see that cxl_pcie_cfg_addr() is only used in cxl_pcie_config_info(), and
doesn't abstract much. So I'd drop it and inline the logic. That leads to the
realisation that we're calling cxl_pcie_cfg_record() twice, so we can save the
value and only call it once.

You're then left with:

	addr = phb->cfg_addr + (afu->crs_len * record) + offset;
	*ioaddr = (void *)(addr & ~0x3ULL);
	*shift = ((addr & 0x3) * 8);

Ideally we'd be able to say that cfg_addr is always aligned, and so it doesn't
need to be part of the calculation. I suspect that is true but you'll have to
check. If it is you can then leave cfg_addr out of the logic and you have:

	addr = (afu->crs_len * record) + offset;

	*ioaddr = phb->cfg_addr + (addr & ~0x3ull);
	*shift = (addr & 0x3) * 8;

Which hopefully still gives you the right result! :)

cheers
