Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0L232PHrzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 00:26:19 +1000 (AEST)
Received: from localhost
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 4 May 2016 15:26:15 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id DE9972190063
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 15:25:48 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u44EQCWc5636374
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 14:26:12 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u44EQATb001811
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 08:26:11 -0600
Subject: Re: [PATCH] cxl: Ensure PSL interrupt is configured for contexts with
 no AFU IRQs
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>
References: <1462337578-15883-1-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <572A0681.4080703@linux.vnet.ibm.com>
Date: Wed, 4 May 2016 16:26:09 +0200
MIME-Version: 1.0
In-Reply-To: <1462337578-15883-1-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ian,


> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
> index c0cdf3c..04f6dff 100644
> --- a/drivers/misc/cxl/guest.c
> +++ b/drivers/misc/cxl/guest.c
> @@ -552,6 +552,17 @@ static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
>
>   	elem->common.sstp0  = cpu_to_be64(ctx->sstp0);
>   	elem->common.sstp1  = cpu_to_be64(ctx->sstp1);
> +
> +	/*
> +	 * Ensure we have at least one interrupt allocated to take faults for
> +	 * kernel contexts that may not have allocated any AFU IRQs at all:
> +	 */
> +	if (ctx->irqs.range[0] == 0) {
> +		rc = afu_register_irqs(ctx, 0);
> +		if (rc)
> +			goto out_free;
> +	}
> +

I believe there's a potential problem there for powerVM guest.
In afu_allocate_irqs(), the allocation of the bitmap for the AFU 
interrupts should return NULL (since count = 0). Therefore we'll skip 
the allocation for the irq names. Yet we need one for the PSL interrupt. 
I'm not too sure of what the effect of calling cxl_map_irq with a NULL 
name is (later, in afu_register_hwirqs), but it's likely not very good.
That is admittedly a latent pb introduced by the powerVM patch, only 
revealed here.
Of course, this is highly theoretical. pHyp only supports cxlflash, so 
count is not supposed to be null. Still...

Other than that, the patch looks good to me.

   Fred
