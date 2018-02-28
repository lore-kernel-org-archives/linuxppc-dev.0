Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrgWS63fbzF1Wq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 14:08:52 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id z10so449649pfh.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 19:08:52 -0800 (PST)
Date: Wed, 28 Feb 2018 14:08:39 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Alistair Popple <alistair@popple.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Mark Hairgrove <mhairgrove@nvidia.com>,
 mpe@ellerman.id.au
Subject: Re: [PATCH v2] powerpc/npu-dma.c: Fix deadlock in mmio_invalidate
Message-ID: <20180228140839.58cd98c6@balbir.ozlabs.ibm.com>
In-Reply-To: <20180228003814.32124-1-alistair@popple.id.au>
References: <20180228003814.32124-1-alistair@popple.id.au>
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

On Wed, 28 Feb 2018 11:38:14 +1100
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
> 
> ---
> 
> v2: Added memory barriers around ->npdev[] and ATSD register aquisition/release
> 
>  arch/powerpc/platforms/powernv/npu-dma.c | 203 +++++++++++++++++--------------
>  1 file changed, 113 insertions(+), 90 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index 0a253b64ac5f..2fed4b116e19 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -410,6 +410,11 @@ struct npu_context {
>  	void *priv;
>  };
>  
> +struct mmio_atsd_reg {
> +	struct npu *npu;
> +	int reg;
> +};
> +
>  /*
>   * Find a free MMIO ATSD register and mark it in use. Return -ENOSPC
>   * if none are available.
> @@ -419,7 +424,7 @@ static int get_mmio_atsd_reg(struct npu *npu)
>  	int i;
>  
>  	for (i = 0; i < npu->mmio_atsd_count; i++) {
> -		if (!test_and_set_bit(i, &npu->mmio_atsd_usage))
> +		if (!test_and_set_bit_lock(i, &npu->mmio_atsd_usage))
>  			return i;
>  	}
>  
> @@ -428,86 +433,90 @@ static int get_mmio_atsd_reg(struct npu *npu)
>  
>  static void put_mmio_atsd_reg(struct npu *npu, int reg)
>  {
> -	clear_bit(reg, &npu->mmio_atsd_usage);
> +	clear_bit_unlock(reg, &npu->mmio_atsd_usage);
>  }


I think we need to document in the code that we have a hard reliance on
the order of locks being incremental sequential and that any optimizations
otherwise will result in probable deadlocks. 

>  
>  /* MMIO ATSD register offsets */
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
> +
> +		/* IS set to invalidate matching PID */
> +		launch = PPC_BIT(12);
>  
> -	/* PRS set to process-scoped */
> -	launch |= PPC_BIT(13);
> +		/* PRS set to process-scoped */
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
> -	/* Invalidating the entire process doesn't use a va */
> -	return mmio_launch_invalidate(npu, launch, 0);
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
> @@ -522,16 +531,46 @@ static void mmio_invalidate_wait(
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
> +			npdev = READ_ONCE(npu_context->npdev[i][j]);
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

I guess a softlockup will occur if we don't get the atsd resource in time
and that might aid debugging.

Looks good to me otherwise
Acked-by: Balbir Singh <bsingharora@gmail.com>
