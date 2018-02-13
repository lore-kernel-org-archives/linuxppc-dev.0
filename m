Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgX9X3QlZzF0mb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 17:06:40 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id g2so9176081pgn.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 22:06:39 -0800 (PST)
Date: Tue, 13 Feb 2018 17:06:20 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Alistair Popple <alistair@popple.id.au>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, Mark Hairgrove
 <mhairgrove@nvidia.com>, Javier Cabezas <jcabezas@nvidia.com>
Subject: Re: [PATCH] powerpc/npu-dma.c: Fix deadlock in mmio_invalidate
Message-ID: <20180213170620.409daf29@balbir.ozlabs.ibm.com>
In-Reply-To: <20180213031734.19831-1-alistair@popple.id.au>
References: <20180213031734.19831-1-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Feb 2018 14:17:34 +1100
Alistair Popple <alistair@popple.id.au> wrote:

> When sending TLB invalidates to the NPU we need to send extra flushes due
> to a hardware issue. The original implementation would lock the all the
> ATSD MMIO registers sequentially before unlocking and relocking each of
> them sequentially to do the extra flush.
> 
> This introduced a deadlock as it is possible for one thread to hold one
> ATSD register whilst waiting for another register to be freed while the
> other thread is holding that register waiting for the one in the first
> thread to be freed.
> 
> For example if there are two threads and two ATSD registers:
> 
> Thread A	Thread B
> Acquire 1
> Acquire 2
> Release 1	Acquire 1
> Wait 1		Wait 2
> 
> Both threads will be stuck waiting to acquire a register resulting in an
> RCU stall warning or soft lockup.
> 
> This patch solves the deadlock by refactoring the code to ensure registers
> are not released between flushes and to ensure all registers are either
> acquired or released together and in order.
> 
> Fixes: bbd5ff50afff ("powerpc/powernv/npu-dma: Add explicit flush when sending an ATSD")
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> ---
> 
> Michael,
> 
> This should probalby go to stable as well, although it's bigger than the 100
> line limit mentioned in the stable kernel rules.
> 
> - Alistair
> 
>  arch/powerpc/platforms/powernv/npu-dma.c | 195 +++++++++++++++++--------------
>  1 file changed, 109 insertions(+), 86 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index fb0a6dee9bce..5746b456dfa4 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -408,6 +408,11 @@ struct npu_context {
>  	void *priv;
>  };
>  
> +struct mmio_atsd_reg {
> +	struct npu *npu;
> +	int reg;
> +};
> +

Is it just easier to move reg to inside of struct npu?

>  /*
>   * Find a free MMIO ATSD register and mark it in use. Return -ENOSPC
>   * if none are available.
> @@ -433,79 +438,83 @@ static void put_mmio_atsd_reg(struct npu *npu, int reg)
>  #define XTS_ATSD_AVA  1
>  #define XTS_ATSD_STAT 2
>  
> -static int mmio_launch_invalidate(struct npu *npu, unsigned long launch,
> -				unsigned long va)
> +static void mmio_launch_invalidate(struct mmio_atsd_reg *mmio_atsd_reg,
> +				unsigned long launch, unsigned long va)
>  {
> -	int mmio_atsd_reg;
> -
> -	do {
> -		mmio_atsd_reg = get_mmio_atsd_reg(npu);
> -		cpu_relax();
> -	} while (mmio_atsd_reg < 0);
> +	struct npu *npu = mmio_atsd_reg->npu;
> +	int reg = mmio_atsd_reg->reg;
>  
>  	__raw_writeq(cpu_to_be64(va),
> -		npu->mmio_atsd_regs[mmio_atsd_reg] + XTS_ATSD_AVA);
> +		npu->mmio_atsd_regs[reg] + XTS_ATSD_AVA);
>  	eieio();
> -	__raw_writeq(cpu_to_be64(launch), npu->mmio_atsd_regs[mmio_atsd_reg]);
> -
> -	return mmio_atsd_reg;
> +	__raw_writeq(cpu_to_be64(launch), npu->mmio_atsd_regs[reg]);
>  }
>  
> -static int mmio_invalidate_pid(struct npu *npu, unsigned long pid, bool flush)
> +static void mmio_invalidate_pid(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
> +				unsigned long pid, bool flush)
>  {
> +	int i;
>  	unsigned long launch;
>  
> -	/* IS set to invalidate matching PID */
> -	launch = PPC_BIT(12);
> +	for (i = 0; i <= max_npu2_index; i++) {
> +		if (mmio_atsd_reg[i].reg < 0)
> +			continue;
>  
> -	/* PRS set to process-scoped */
> -	launch |= PPC_BIT(13);
> +		/* IS set to invalidate matching PID */
> +		launch = PPC_BIT(12);
>  
> -	/* AP */
> -	launch |= (u64) mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
> +		/* PRS set to process-scoped */
> +		launch |= PPC_BIT(13);
>  
> -	/* PID */
> -	launch |= pid << PPC_BITLSHIFT(38);
> +		/* AP */
> +		launch |= (u64)
> +			mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
>  
> -	/* No flush */
> -	launch |= !flush << PPC_BITLSHIFT(39);
> +		/* PID */
> +		launch |= pid << PPC_BITLSHIFT(38);
>  
> -	/* Invalidating the entire process doesn't use a va */
> -	return mmio_launch_invalidate(npu, launch, 0);
> +		/* No flush */
> +		launch |= !flush << PPC_BITLSHIFT(39);
> +
> +		/* Invalidating the entire process doesn't use a va */
> +		mmio_launch_invalidate(&mmio_atsd_reg[i], launch, 0);
> +	}
>  }
>  
> -static int mmio_invalidate_va(struct npu *npu, unsigned long va,
> -			unsigned long pid, bool flush)
> +static void mmio_invalidate_va(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
> +			unsigned long va, unsigned long pid, bool flush)
>  {
> +	int i;
>  	unsigned long launch;
>  
> -	/* IS set to invalidate target VA */
> -	launch = 0;
> +	for (i = 0; i <= max_npu2_index; i++) {
> +		if (mmio_atsd_reg[i].reg < 0)
> +			continue;
> +
> +		/* IS set to invalidate target VA */
> +		launch = 0;
>  
> -	/* PRS set to process scoped */
> -	launch |= PPC_BIT(13);
> +		/* PRS set to process scoped */
> +		launch |= PPC_BIT(13);
>  
> -	/* AP */
> -	launch |= (u64) mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
> +		/* AP */
> +		launch |= (u64)
> +			mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
>  
> -	/* PID */
> -	launch |= pid << PPC_BITLSHIFT(38);
> +		/* PID */
> +		launch |= pid << PPC_BITLSHIFT(38);
>  
> -	/* No flush */
> -	launch |= !flush << PPC_BITLSHIFT(39);
> +		/* No flush */
> +		launch |= !flush << PPC_BITLSHIFT(39);
>  
> -	return mmio_launch_invalidate(npu, launch, va);
> +		mmio_launch_invalidate(&mmio_atsd_reg[i], launch, va);
> +	}
>  }
>  
>  #define mn_to_npu_context(x) container_of(x, struct npu_context, mn)
>  
> -struct mmio_atsd_reg {
> -	struct npu *npu;
> -	int reg;
> -};
> -
>  static void mmio_invalidate_wait(
> -	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS], bool flush)
> +	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS])
>  {
>  	struct npu *npu;
>  	int i, reg;
> @@ -520,16 +529,46 @@ static void mmio_invalidate_wait(
>  		reg = mmio_atsd_reg[i].reg;
>  		while (__raw_readq(npu->mmio_atsd_regs[reg] + XTS_ATSD_STAT))
>  			cpu_relax();
> +	}
> +}
>  
> -		put_mmio_atsd_reg(npu, reg);
> +static void acquire_atsd_reg(struct npu_context *npu_context,
> +			struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS])
> +{
> +	int i, j;
> +	struct npu *npu;
> +	struct pci_dev *npdev;
> +	struct pnv_phb *nphb;
>  
> -		/*
> -		 * The GPU requires two flush ATSDs to ensure all entries have
> -		 * been flushed. We use PID 0 as it will never be used for a
> -		 * process on the GPU.
> -		 */
> -		if (flush)
> -			mmio_invalidate_pid(npu, 0, true);
> +	for (i = 0; i <= max_npu2_index; i++) {
> +		mmio_atsd_reg[i].reg = -1;
> +		for (j = 0; j < NV_MAX_LINKS; j++) {

Is it safe to assume that npu_context->npdev will not change in this
loop? I guess it would need to be stronger than just this loop.

> +			npdev = npu_context->npdev[i][j];
> +			if (!npdev)
> +				continue;
> +
> +			nphb = pci_bus_to_host(npdev->bus)->private_data;
> +			npu = &nphb->npu;
> +			mmio_atsd_reg[i].npu = npu;
> +			mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
> +			while (mmio_atsd_reg[i].reg < 0) {
> +				mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
> +				cpu_relax();

A cond_resched() as well if we have too many tries?

Balbir
