Return-Path: <alistair@popple.id.au>
Received: from ipmail03.adl2.internode.on.net (ipmail03.adl2.internode.on.net
 [150.101.137.141])
 by lists.ozlabs.org (Postfix) with ESMTP id 41hZ1j5WC0zF12N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 14:34:01 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Reza Arbab <arbab@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Fix concurrency issue with
 npu->mmio_atsd_usage
Date: Fri, 03 Aug 2018 14:29:48 +1000
Message-ID: <1905109.BUrIJKBoqf@new-mexico>
In-Reply-To: <1533269016-16238-1-git-send-email-arbab@linux.ibm.com>
References: <1533269016-16238-1-git-send-email-arbab@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> There may be a long-term way to fix this at a larger scale, but for now
> resolve the immediate problem by gating our call to
> test_and_set_bit_lock() with one to test_bit(), which is obviously
> implemented without using a store.

I am less sure of this now but am continuing to investigate. However this patch
looks good.

Acked-by: Alistair Popple <alistair@popple.id.au>

> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/npu-dma.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index 8cdf91f..c773465 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -437,8 +437,9 @@ static int get_mmio_atsd_reg(struct npu *npu)
>  	int i;
>  
>  	for (i = 0; i < npu->mmio_atsd_count; i++) {
> -		if (!test_and_set_bit_lock(i, &npu->mmio_atsd_usage))
> -			return i;
> +		if (!test_bit(i, &npu->mmio_atsd_usage))
> +			if (!test_and_set_bit_lock(i, &npu->mmio_atsd_usage))
> +				return i;
>  	}
>  
>  	return -ENOSPC;
> 
