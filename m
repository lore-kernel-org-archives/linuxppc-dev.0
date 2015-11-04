Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69CA51A022F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 17:18:47 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E1772140291
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2015 17:18:46 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 4 Nov 2015 16:18:45 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 39F032BB003F
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2015 17:18:41 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA46IRoZ30736404
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2015 17:18:35 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA46I88R019952
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2015 17:18:09 +1100
Message-ID: <5639A307.7060503@au1.ibm.com>
Date: Wed, 04 Nov 2015 17:17:43 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
CC: imunsie@au1.ibm.com, dja@axtens.net, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] cxl: sparse: add __iomem annotations in vphb.c
References: <1446002979-29728-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1446541751.23081.1.camel@ellerman.id.au>
In-Reply-To: <1446541751.23081.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/11/15 20:09, Michael Ellerman wrote:
> Part of your problem is you're storing afu->crs_len which is not __iomem in
> cfg_data which is, and so that's leading to some of your casts.
>
> I don't really see why you're using cfg_data like that, you have the afu in
> phb->private_data. But maybe cfg_data needs to hold that value for some other
> code I'm not seeing.

I can't see any obvious reason why we need to use cfg_data either.

> Regardless, in cxl_pcie_config_info() you have the afu pointer, so you can just
> look at afu->crs_len directly can't you?
>
> That means you can drop one cast of cfg_data to unsigned long in there.
>
> Then I see that cxl_pcie_cfg_addr() is only used in cxl_pcie_config_info(), and
> doesn't abstract much. So I'd drop it and inline the logic. That leads to the
> realisation that we're calling cxl_pcie_cfg_record() twice, so we can save the
> value and only call it once.
> You're then left with:
>
> 	addr = phb->cfg_addr + (afu->crs_len * record) + offset;
> 	*ioaddr = (void *)(addr & ~0x3ULL);
> 	*shift = ((addr & 0x3) * 8);

Will do, that's nicer.

> Ideally we'd be able to say that cfg_addr is always aligned, and so it doesn't
> need to be part of the calculation. I suspect that is true but you'll have to
> check. If it is you can then leave cfg_addr out of the logic and you have:
>
> 	addr = (afu->crs_len * record) + offset;
>
> 	*ioaddr = phb->cfg_addr + (addr & ~0x3ull);
> 	*shift = (addr & 0x3) * 8;
>
> Which hopefully still gives you the right result! :)

Will check.


Andrew

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
