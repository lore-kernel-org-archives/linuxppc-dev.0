Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQfYr5X38zDqs7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 18:09:36 +1100 (AEDT)
Date: Tue, 23 Jan 2018 16:42:09 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 02/26] KVM: PPC: Book3S PR: add new parameter (guest MSR)
 for kvmppc_save_tm()/kvmppc_restore_tm()
Message-ID: <20180123054208.GB3924@fergus.ozlabs.ibm.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <1515665499-31710-3-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515665499-31710-3-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2018 at 06:11:15PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> HV KVM and PR KVM need different MSR source to indicate whether
> treclaim. or trecheckpoint. is necessary.
> 
> This patch add new parameter (guest MSR) for these kvmppc_save_tm/
> kvmppc_restore_tm() APIs:
> - For HV KVM, it is VCPU_MSR
> - For PR KVM, it is current host MSR or VCPU_SHADOW_SRR1
> 
> This enhancement enables these 2 APIs to be reused by PR KVM later.
> And the patch keeps HV KVM logic unchanged.
> 
> This patch also reworks kvmppc_save_tm()/kvmppc_restore_tm() to
> have a clean ABI: r3 for vcpu and r4 for guest_msr.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Question: why do you switch from using HSTATE_HOST_R1 to HSTATE_SCRATCH2

> @@ -42,11 +45,11 @@ _GLOBAL(kvmppc_save_tm)
>  	rldimi	r8, r0, MSR_TM_LG, 63-MSR_TM_LG
>  	mtmsrd	r8
>  
> -	ld	r5, VCPU_MSR(r9)
> -	rldicl. r5, r5, 64 - MSR_TS_S_LG, 62
> +	rldicl. r4, r4, 64 - MSR_TS_S_LG, 62
>  	beq	1f	/* TM not active in guest. */
>  
> -	std	r1, HSTATE_HOST_R1(r13)
> +	std	r1, HSTATE_SCRATCH2(r13)

... here?

> @@ -166,17 +173,17 @@ _GLOBAL(kvmppc_restore_tm)
>  	 * The user may change these outside of a transaction, so they must
>  	 * always be context switched.
>  	 */
> -	ld	r5, VCPU_TFHAR(r4)
> -	ld	r6, VCPU_TFIAR(r4)
> -	ld	r7, VCPU_TEXASR(r4)
> +	ld	r5, VCPU_TFHAR(r3)
> +	ld	r6, VCPU_TFIAR(r3)
> +	ld	r7, VCPU_TEXASR(r3)
>  	mtspr	SPRN_TFHAR, r5
>  	mtspr	SPRN_TFIAR, r6
>  	mtspr	SPRN_TEXASR, r7
>  
> -	ld	r5, VCPU_MSR(r4)
> +	mr	r5, r4
>  	rldicl. r5, r5, 64 - MSR_TS_S_LG, 62
>  	beqlr		/* TM not active in guest */
> -	std	r1, HSTATE_HOST_R1(r13)
> +	std	r1, HSTATE_SCRATCH2(r13)

and here?

Please add a paragraph to the patch description explaining why you are
making that change.

Paul.
