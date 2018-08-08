Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41m4cy4BXlzDqxs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 07:43:14 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w78Lceq8060042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Aug 2018 17:43:11 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kr6xkm4r9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Aug 2018 17:43:11 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 8 Aug 2018 15:43:10 -0600
Subject: Re: [PATCH] powerpc: fix size calculation using resource_size()
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jia Hongtao <B38951@freescale.com>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Rob Herring <robh@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
References: <20180808115724.gh5mbbi6twzqbqao@kili.mountain>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Wed, 8 Aug 2018 14:43:02 -0700
MIME-Version: 1.0
In-Reply-To: <20180808115724.gh5mbbi6twzqbqao@kili.mountain>
Content-Type: text/plain; charset=utf-8
Message-Id: <a5411d3a-8c2c-0a4f-7e3f-baa473c34e92@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/08/2018 04:57 AM, Dan Carpenter wrote:
> The problem is the the calculation should be "end - start + 1" but the
> plus one is missing in this calculation.
> 
> Fixes: 8626816e905e ("powerpc: add support for MPIC message register API")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Static analysis.  Not tested.

Looks sane to me.

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

> 
> diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
> index eb69a5186243..280e964e1aa8 100644
> --- a/arch/powerpc/sysdev/mpic_msgr.c
> +++ b/arch/powerpc/sysdev/mpic_msgr.c
> @@ -196,7 +196,7 @@ static int mpic_msgr_probe(struct platform_device *dev)
> 
>  	/* IO map the message register block. */
>  	of_address_to_resource(np, 0, &rsrc);
> -	msgr_block_addr = ioremap(rsrc.start, rsrc.end - rsrc.start);
> +	msgr_block_addr = ioremap(rsrc.start, resource_size(&rsrc));
>  	if (!msgr_block_addr) {
>  		dev_err(&dev->dev, "Failed to iomap MPIC message registers");
>  		return -EFAULT;
> 
