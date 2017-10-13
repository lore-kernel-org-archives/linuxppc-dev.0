Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yDPxk4KmlzDr5x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 11:06:02 +1100 (AEDT)
Date: Sat, 14 Oct 2017 09:47:59 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 7/9] powerpc/64s: do not allocate lppaca if we are not
 virtualized
Message-ID: <20171013224759.GA26120@fergus.ozlabs.ibm.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
 <20170813013346.14002-7-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170813013346.14002-7-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 13, 2017 at 11:33:44AM +1000, Nicholas Piggin wrote:
> The "lppaca" is a structure registered with the hypervisor. This
> is unnecessary when running on non-virtualised platforms. One field
> from the lppaca (pmcregs_in_use) is also used by the host, so move
> the host part out into the paca (lppaca field is still updated in
> guest mode).

There is an error in the patch, see below...

> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index c52184a8efdf..b838348e3a2b 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -99,8 +99,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>  	mtspr	SPRN_SPRG_VDSO_WRITE,r3
>  
>  	/* Reload the host's PMU registers */
> -	ld	r3, PACALPPACAPTR(r13)	/* is the host using the PMU? */
> -	lbz	r4, LPPACA_PMCINUSE(r3)
> +	lbz	r4, PACA_PMCINUSE(r13) /* is the host using the PMU? */
>  	cmpwi	r4, 0
>  	beq	23f			/* skip if not */
>  BEGIN_FTR_SECTION
> @@ -1671,7 +1670,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	mtspr	SPRN_MMCRA, r7
>  	isync
>  	beq	21f			/* if no VPA, save PMU stuff anyway */
> -	lbz	r7, LPPACA_PMCINUSE(r8)
> +	lbz	r7, PACA_PMCINUSE(r13)

We really do need to check the guest's flag not the host's here, since
we're deciding whether to save the PMU state to the vcpu struct.

Paul.
