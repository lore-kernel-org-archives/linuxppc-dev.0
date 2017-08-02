Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMgGc1w6CzDrj3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 14:30:32 +1000 (AEST)
Date: Wed, 2 Aug 2017 14:30:26 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <masriniv@in.ibm.com>, Michael Neuling
 <mikey@neuling.org>, Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH] POWER9 PMU stops after idle workaround
Message-ID: <20170802143026.34bbadde@kryten>
In-Reply-To: <20170720015322.24307-1-npiggin@gmail.com>
References: <20170720015322.24307-1-npiggin@gmail.com>
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

Hi Nick,

> POWER9 DD2 PMU can stop after a state-loss idle in some conditions.
> 
> A solution is to set then clear MMCRA[60] after wake from state-loss
> idle.

Looks good.

Acked-by: Anton Blanchard <anton@samba.org>

Anton

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/idle_book3s.S | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S
> b/arch/powerpc/kernel/idle_book3s.S index 516ebef905c0..e6252c5a57a4
> 100644 --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -460,11 +460,17 @@ pnv_restore_hyp_resource_arch300:
>  	/*
>  	 * Workaround for POWER9, if we lost resources, the ERAT
>  	 * might have been mixed up and needs flushing. We also need
> -	 * to reload MMCR0 (see comment above).
> +	 * to reload MMCR0 (see comment above). We also need to set
> +	 * then clear bit 60 in MMCRA to ensure the PMU starts
> running. */
>  	blt	cr3,1f
>  	PPC_INVALIDATE_ERAT
>  	ld	r1,PACAR1(r13)
> +	mfspr	r4,SPRN_MMCRA
> +	ori	r4,r4,(1 << (63-60))
> +	mtspr	SPRN_MMCRA,r4
> +	xori	r4,r4,(1 << (63-60))
> +	mtspr	SPRN_MMCRA,r4
>  	ld	r4,_MMCR0(r1)
>  	mtspr	SPRN_MMCR0,r4
>  1:
