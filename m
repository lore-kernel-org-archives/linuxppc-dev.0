Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tL1Ck1x4MzDqV5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 01:51:30 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tL1Cj5vRLz9t0J
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2016 01:51:29 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAIEoStG020169
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2016 09:51:28 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26t2ud2y08-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2016 09:51:28 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 18 Nov 2016 09:51:26 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 07/13] KVM: PPC: Book3S HV: Adjust host/guest context
 switch for POWER9
In-Reply-To: <1479454122-26994-8-git-send-email-paulus@ozlabs.org>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-8-git-send-email-paulus@ozlabs.org>
Date: Fri, 18 Nov 2016 20:05:47 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8737ioony4.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> Some special-purpose registers that were present and accessible
> by guests on POWER8 no longer exist on POWER9, so this adds
> feature sections to ensure that we don't try to context-switch
> them when going into or out of a guest on POWER9.  These are
> all relatively obscure, rarely-used registers, but we had to
> context-switch them on POWER8 to avoid creating a covert channel.
> They are: SPMC1, SPMC2, MMCRS, CSIGR, TACR, TCSCR, and ACOP.

We don't need to context-switch them even when running a power8 compat
guest ?

>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 50 ++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index dc25467..d422014 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -752,14 +752,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_PMAO_BUG)
>  BEGIN_FTR_SECTION
>  	ld	r5, VCPU_MMCR + 24(r4)
>  	ld	r6, VCPU_SIER(r4)
> +	mtspr	SPRN_MMCR2, r5
> +	mtspr	SPRN_SIER, r6
> +BEGIN_FTR_SECTION_NESTED(96)
>  	lwz	r7, VCPU_PMC + 24(r4)
>  	lwz	r8, VCPU_PMC + 28(r4)
>  	ld	r9, VCPU_MMCR + 32(r4)
> -	mtspr	SPRN_MMCR2, r5
> -	mtspr	SPRN_SIER, r6
>  	mtspr	SPRN_SPMC1, r7
>  	mtspr	SPRN_SPMC2, r8
>  	mtspr	SPRN_MMCRS, r9
> +END_FTR_SECTION_NESTED(CPU_FTR_ARCH_300, 0, 96)
>  END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	mtspr	SPRN_MMCR0, r3
>  	isync
> @@ -815,20 +817,22 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>  	mtspr	SPRN_EBBHR, r8
>  	ld	r5, VCPU_EBBRR(r4)
>  	ld	r6, VCPU_BESCR(r4)
> -	ld	r7, VCPU_CSIGR(r4)
> -	ld	r8, VCPU_TACR(r4)
> +	lwz	r7, VCPU_GUEST_PID(r4)
> +	ld	r8, VCPU_WORT(r4)
>  	mtspr	SPRN_EBBRR, r5
>  	mtspr	SPRN_BESCR, r6
> -	mtspr	SPRN_CSIGR, r7
> -	mtspr	SPRN_TACR, r8
> +	mtspr	SPRN_PID, r7
> +	mtspr	SPRN_WORT, r8
> +BEGIN_FTR_SECTION
>  	ld	r5, VCPU_TCSCR(r4)
>  	ld	r6, VCPU_ACOP(r4)
> -	lwz	r7, VCPU_GUEST_PID(r4)
> -	ld	r8, VCPU_WORT(r4)
> +	ld	r7, VCPU_CSIGR(r4)
> +	ld	r8, VCPU_TACR(r4)
>  	mtspr	SPRN_TCSCR, r5
>  	mtspr	SPRN_ACOP, r6
> -	mtspr	SPRN_PID, r7
> -	mtspr	SPRN_WORT, r8
> +	mtspr	SPRN_CSIGR, r7
> +	mtspr	SPRN_TACR, r8
> +END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>  8:
>  
>  	/*
> @@ -1343,20 +1347,22 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>  	std	r8, VCPU_EBBHR(r9)
>  	mfspr	r5, SPRN_EBBRR
>  	mfspr	r6, SPRN_BESCR
> -	mfspr	r7, SPRN_CSIGR
> -	mfspr	r8, SPRN_TACR
> +	mfspr	r7, SPRN_PID
> +	mfspr	r8, SPRN_WORT
>  	std	r5, VCPU_EBBRR(r9)
>  	std	r6, VCPU_BESCR(r9)
> -	std	r7, VCPU_CSIGR(r9)
> -	std	r8, VCPU_TACR(r9)
> +	stw	r7, VCPU_GUEST_PID(r9)
> +	std	r8, VCPU_WORT(r9)
> +BEGIN_FTR_SECTION
>  	mfspr	r5, SPRN_TCSCR
>  	mfspr	r6, SPRN_ACOP
> -	mfspr	r7, SPRN_PID
> -	mfspr	r8, SPRN_WORT
> +	mfspr	r7, SPRN_CSIGR
> +	mfspr	r8, SPRN_TACR
>  	std	r5, VCPU_TCSCR(r9)
>  	std	r6, VCPU_ACOP(r9)
> -	stw	r7, VCPU_GUEST_PID(r9)
> -	std	r8, VCPU_WORT(r9)
> +	std	r7, VCPU_CSIGR(r9)
> +	std	r8, VCPU_TACR(r9)
> +END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>  	/*
>  	 * Restore various registers to 0, where non-zero values
>  	 * set by the guest could disrupt the host.
> @@ -1365,12 +1371,14 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>  	mtspr	SPRN_IAMR, r0
>  	mtspr	SPRN_CIABR, r0
>  	mtspr	SPRN_DAWRX, r0
> -	mtspr	SPRN_TCSCR, r0
>  	mtspr	SPRN_WORT, r0
> +BEGIN_FTR_SECTION
> +	mtspr	SPRN_TCSCR, r0
>  	/* Set MMCRS to 1<<31 to freeze and disable the SPMC counters */
>  	li	r0, 1
>  	sldi	r0, r0, 31
>  	mtspr	SPRN_MMCRS, r0
> +END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>  8:
>  
>  	/* Save and reset AMR and UAMOR before turning on the MMU */
> @@ -1504,15 +1512,17 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	stw	r8, VCPU_PMC + 20(r9)
>  BEGIN_FTR_SECTION
>  	mfspr	r5, SPRN_SIER
> +	std	r5, VCPU_SIER(r9)
> +BEGIN_FTR_SECTION_NESTED(96)
>  	mfspr	r6, SPRN_SPMC1
>  	mfspr	r7, SPRN_SPMC2
>  	mfspr	r8, SPRN_MMCRS
> -	std	r5, VCPU_SIER(r9)
>  	stw	r6, VCPU_PMC + 24(r9)
>  	stw	r7, VCPU_PMC + 28(r9)
>  	std	r8, VCPU_MMCR + 32(r9)
>  	lis	r4, 0x8000
>  	mtspr	SPRN_MMCRS, r4
> +END_FTR_SECTION_NESTED(CPU_FTR_ARCH_300, 0, 96)
>  END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  22:
>  	/* Clear out SLB */
> -- 
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
