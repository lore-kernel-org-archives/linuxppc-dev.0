Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFC4C004D2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 07:27:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C212089A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 07:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C212089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PW2J1GfkzF3G8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 17:27:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=popple.id.au
 (client-ip=150.101.137.141; helo=ipmail03.adl2.internode.on.net;
 envelope-from=alistair@popple.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from ipmail03.adl2.internode.on.net (ipmail03.adl2.internode.on.net
 [150.101.137.141])
 by lists.ozlabs.org (Postfix) with ESMTP id 42PVxy5kX1zF3G1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 17:23:50 +1000 (AEST)
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AqAwBZHLNb/xwSUcpbHAEBAQQBAQcEA?=
 =?us-ascii?q?QGDX4FTEiiYI4INeJV4gWY2AYRAAoQYITgUAQMBAQIBAQJtKIU5AQUnEz8QCw0?=
 =?us-ascii?q?BCgkVEA8BRwYThSKmKDMaAooCiwEXggCBEoJdBy6EZoVwAohQlGwJggyOQwkCT?=
 =?us-ascii?q?4hHA4Y2lxkhgVUfFBoIFxmDJ4IlFxGOGS0weQGMawEB?=
Received: from unknown (HELO new-mexico.localnet) ([202.81.18.28])
 by ipmail03.adl2.internode.on.net with ESMTP; 02 Oct 2018 16:53:49 +0930
From: Alistair Popple <alistair@popple.id.au>
To: Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [PATCH 1/3] powerpc/powernv/npu: Reduce eieio usage when issuing
 ATSD invalidates
Date: Tue, 02 Oct 2018 17:23:47 +1000
Message-ID: <1590969.EuJDlkCUV7@new-mexico>
User-Agent: KMail/5.2.3 (Linux/4.17.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <1538090591-28519-2-git-send-email-mhairgrove@nvidia.com>
References: <1538090591-28519-1-git-send-email-mhairgrove@nvidia.com>
 <1538090591-28519-2-git-send-email-mhairgrove@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, Reza Arbab <arbab@us.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thanks, this looks good to me.

Reviewed-by: Alistair Popple <alistair@popple.id.au>

On Thursday, 27 September 2018 4:23:09 PM AEST Mark Hairgrove wrote:
> There are two types of ATSDs issued to the NPU: invalidates targeting a
> specific virtual address and invalidates targeting the whole address
> space. In both cases prior to this change, the sequence was:
> 
>     for each NPU
>         - Write the target address to the XTS_ATSD_AVA register
>         - EIEIO
>         - Write the launch value to issue the ATSD
> 
> First, a target address is not required when invalidating the whole
> address space, so that write and the EIEIO have been removed. The AP
> (size) field in the launch is not needed either.
> 
> Second, for per-address invalidates the above sequence is inefficient in
> the common case of multiple NPUs because an EIEIO is issued per NPU. This
> unnecessarily forces the launches of later ATSDs to be ordered with the
> launches of earlier ones. The new sequence only issues a single EIEIO:
> 
>     for each NPU
>         - Write the target address to the XTS_ATSD_AVA register
>     EIEIO
>     for each NPU
>         - Write the launch value to issue the ATSD
> 
> Performance results were gathered using a microbenchmark which creates a
> 1G allocation then uses mprotect with PROT_NONE to trigger invalidates in
> strides across the allocation.
> 
> With only a single NPU active (one GPU) the difference is in the noise for
> both types of invalidates (+/-1%).
> 
> With two NPUs active (on a 6-GPU system) the effect is more noticeable:
> 
>          mprotect rate (GB/s)
> Stride   Before      After      Speedup
> 64K         5.9        6.5          10%
> 1M         31.2       33.4           7%
> 2M         36.3       38.7           7%
> 4M        322.6      356.7          11%
> 
> Signed-off-by: Mark Hairgrove <mhairgrove@nvidia.com>
> ---
>  arch/powerpc/platforms/powernv/npu-dma.c |   99 ++++++++++++++---------------
>  1 files changed, 48 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index 8006c54..c8f438a 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -454,79 +454,76 @@ static void put_mmio_atsd_reg(struct npu *npu, int reg)
>  }
>  
>  /* MMIO ATSD register offsets */
> -#define XTS_ATSD_AVA  1
> -#define XTS_ATSD_STAT 2
> +#define XTS_ATSD_LAUNCH 0
> +#define XTS_ATSD_AVA    1
> +#define XTS_ATSD_STAT   2
>  
> -static void mmio_launch_invalidate(struct mmio_atsd_reg *mmio_atsd_reg,
> -				unsigned long launch, unsigned long va)
> +static unsigned long get_atsd_launch_val(unsigned long pid, unsigned long psize,
> +					bool flush)
>  {
> -	struct npu *npu = mmio_atsd_reg->npu;
> -	int reg = mmio_atsd_reg->reg;
> +	unsigned long launch = 0;
>  
> -	__raw_writeq_be(va, npu->mmio_atsd_regs[reg] + XTS_ATSD_AVA);
> -	eieio();
> -	__raw_writeq_be(launch, npu->mmio_atsd_regs[reg]);
> +	if (psize == MMU_PAGE_COUNT) {
> +		/* IS set to invalidate entire matching PID */
> +		launch |= PPC_BIT(12);
> +	} else {
> +		/* AP set to invalidate region of psize */
> +		launch |= (u64)mmu_get_ap(psize) << PPC_BITLSHIFT(17);
> +	}
> +
> +	/* PRS set to process-scoped */
> +	launch |= PPC_BIT(13);
> +
> +	/* PID */
> +	launch |= pid << PPC_BITLSHIFT(38);
> +
> +	/* No flush */
> +	launch |= !flush << PPC_BITLSHIFT(39);
> +
> +	return launch;
>  }
>  
> -static void mmio_invalidate_pid(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
> -				unsigned long pid, bool flush)
> +static void mmio_atsd_regs_write(struct mmio_atsd_reg
> +			mmio_atsd_reg[NV_MAX_NPUS], unsigned long offset,
> +			unsigned long val)
>  {
> -	int i;
> -	unsigned long launch;
> +	struct npu *npu;
> +	int i, reg;
>  
>  	for (i = 0; i <= max_npu2_index; i++) {
> -		if (mmio_atsd_reg[i].reg < 0)
> +		reg = mmio_atsd_reg[i].reg;
> +		if (reg < 0)
>  			continue;
>  
> -		/* IS set to invalidate matching PID */
> -		launch = PPC_BIT(12);
> -
> -		/* PRS set to process-scoped */
> -		launch |= PPC_BIT(13);
> -
> -		/* AP */
> -		launch |= (u64)
> -			mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
> -
> -		/* PID */
> -		launch |= pid << PPC_BITLSHIFT(38);
> +		npu = mmio_atsd_reg[i].npu;
> +		__raw_writeq_be(val, npu->mmio_atsd_regs[reg] + offset);
> +	}
> +}
>  
> -		/* No flush */
> -		launch |= !flush << PPC_BITLSHIFT(39);
> +static void mmio_invalidate_pid(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
> +				unsigned long pid, bool flush)
> +{
> +	unsigned long launch = get_atsd_launch_val(pid, MMU_PAGE_COUNT, flush);
>  
> -		/* Invalidating the entire process doesn't use a va */
> -		mmio_launch_invalidate(&mmio_atsd_reg[i], launch, 0);
> -	}
> +	/* Invalidating the entire process doesn't use a va */
> +	mmio_atsd_regs_write(mmio_atsd_reg, XTS_ATSD_LAUNCH, launch);
>  }
>  
>  static void mmio_invalidate_va(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
>  			unsigned long va, unsigned long pid, bool flush)
>  {
> -	int i;
>  	unsigned long launch;
>  
> -	for (i = 0; i <= max_npu2_index; i++) {
> -		if (mmio_atsd_reg[i].reg < 0)
> -			continue;
> -
> -		/* IS set to invalidate target VA */
> -		launch = 0;
> +	launch = get_atsd_launch_val(pid, mmu_virtual_psize, flush);
>  
> -		/* PRS set to process scoped */
> -		launch |= PPC_BIT(13);
> +	/* Write all VAs first */
> +	mmio_atsd_regs_write(mmio_atsd_reg, XTS_ATSD_AVA, va);
>  
> -		/* AP */
> -		launch |= (u64)
> -			mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
> -
> -		/* PID */
> -		launch |= pid << PPC_BITLSHIFT(38);
> -
> -		/* No flush */
> -		launch |= !flush << PPC_BITLSHIFT(39);
> +	/* Issue one barrier for all address writes */
> +	eieio();
>  
> -		mmio_launch_invalidate(&mmio_atsd_reg[i], launch, va);
> -	}
> +	/* Launch */
> +	mmio_atsd_regs_write(mmio_atsd_reg, XTS_ATSD_LAUNCH, launch);
>  }
>  
>  #define mn_to_npu_context(x) container_of(x, struct npu_context, mn)
> 


