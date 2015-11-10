Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E2CC1A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 15:29:45 +1100 (AEDT)
Message-ID: <1447129784.13889.25.camel@ellerman.id.au>
Subject: Re: [PATCH v2] of: Check for overlap in reserved memory regions
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mitchel Humpherys <mitchelh@codeaurora.org>, Rob Herring
 <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely
 <grant.likely@linaro.org>, devicetree@vger.kernel.org, Marek Szyprowski
 <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 10 Nov 2015 15:29:44 +1100
In-Reply-To: <1442367036-15205-1-git-send-email-mitchelh@codeaurora.org>
References: <1442367036-15205-1-git-send-email-mitchelh@codeaurora.org>
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

On Tue, 2015-09-15 at 18:30 -0700, Mitchel Humpherys wrote:

> Any overlap in the reserved memory regions (those specified in the
> reserved-memory DT node) is a bug.  These bugs might go undetected as
> long as the contested region isn't used simultaneously by multiple
> software agents, which makes such bugs hard to debug.  Fix this by
> printing a scary warning during boot if overlap is detected.
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 726ebe792813..62f467b8ccae 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -197,12 +198,52 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
>  	return -ENOENT;
>  }
>  
> +static int __init __rmem_cmp(const void *a, const void *b)
> +{
> +	const struct reserved_mem *ra = a, *rb = b;
> +
> +	return ra->base - rb->base;
> +}
> +
> +static void __init __rmem_check_for_overlap(void)
> +{
> +	int i;
> +
> +	if (reserved_mem_count < 2)
> +		return;
> +
> +	sort(reserved_mem, reserved_mem_count, sizeof(reserved_mem[0]),
> +	     __rmem_cmp, NULL);
> +	for (i = 0; i < reserved_mem_count - 1; i++) {
> +		struct reserved_mem *this, *next;
> +
> +		this = &reserved_mem[i];
> +		next = &reserved_mem[i + 1];
> +		if (!(this->base && next->base))
> +			continue;
> +		if (this->base + this->size > next->base) {
> +			phys_addr_t this_end, next_end;
> +
> +			this_end = this->base + this->size;
> +			next_end = next->base + next->size;
> +			WARN(1,
> +			     "Reserved memory: OVERLAP DETECTED!\n%s (%pa--%pa) overlaps with %s (%pa--%pa)\n",
> +			     this->name, &this->base, &this_end,
> +			     next->name, &next->base, &next_end);

This is blowing up on some powerpc machines.

It's too early in boot to call WARN() on these systems.

Can we turn it into a pr_err() for now?

I'll send a patch?

cheers
