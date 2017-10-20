Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJNR73w0fzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 22:11:47 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9KBAfSt095554
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 07:11:44 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dqg1m8248-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 07:11:44 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Fri, 20 Oct 2017 12:11:42 +0100
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9KBBcvX23330954
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 11:11:39 GMT
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9KBBb1q002863
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 22:11:37 +1100
Date: Fri, 20 Oct 2017 16:41:33 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/64s: idle skip POWER9 DD1 and DD2.0 specific
 workarounds on DD2.1
Reply-To: svaidy@linux.vnet.ibm.com
References: <20171020045444.4539-1-npiggin@gmail.com>
 <20171020045444.4539-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171020045444.4539-3-npiggin@gmail.com>
Message-Id: <20171020111133.GA5688@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Nicholas Piggin <npiggin@gmail.com> [2017-10-20 14:54:44]:

> DD2.1 does not have to flush the ERAT after a state-loss idle. It also
> does not have to save and restore MMCR0.
> 
> Performance testing was done on a DD2.1 using only the stop0 idle state
> (the shallowest state which supports state loss), using context_switch
> selftest configured to ping-poing between two threads on the same core
                                ^pong
> and two different cores.
> 
> Performance improvement for same core is 7.0%, different cores is 14.8%.

Good improvement as we remove unnecessary code and workarounds. 
 
> Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>


> ---
>  arch/powerpc/kernel/idle_book3s.S | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 1125c9be9e06..3531a3e727d2 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -112,12 +112,14 @@ power9_save_additional_sprs:
>  	std	r4, STOP_HFSCR(r13)
> 
>  	mfspr	r3, SPRN_MMCRA
> -	mfspr	r4, SPRN_MMCR1
> +	mfspr	r4, SPRN_MMCR0
>  	std	r3, STOP_MMCRA(r13)
> -	std	r4, STOP_MMCR1(r13)
> +	std	r4, _MMCR0(r1)
> 
> -	mfspr	r3, SPRN_MMCR2
> -	std	r3, STOP_MMCR2(r13)
> +	mfspr	r3, SPRN_MMCR1
> +	mfspr	r4, SPRN_MMCR2
> +	std	r3, STOP_MMCR1(r13)
> +	std	r4, STOP_MMCR2(r13)
>  	blr
> 
>  power9_restore_additional_sprs:
> @@ -135,11 +137,14 @@ power9_restore_additional_sprs:
>  	ld	r4, STOP_MMCRA(r13)
>  	mtspr	SPRN_HFSCR, r3
>  	mtspr	SPRN_MMCRA, r4
> -	/* We have already restored PACA_MMCR0 */
> -	ld	r3, STOP_MMCR1(r13)
> -	ld	r4, STOP_MMCR2(r13)
> -	mtspr	SPRN_MMCR1, r3
> -	mtspr	SPRN_MMCR2, r4
> +
> +	ld	r3, _MMCR0(r1)
> +	ld	r4, STOP_MMCR1(r13)
> +	mtspr	SPRN_MMCR0, r3
> +	mtspr	SPRN_MMCR1, r4
> +
> +	ld	r3, STOP_MMCR2(r13)
> +	mtspr	SPRN_MMCR2, r3
>  	blr
> 
>  /*
> @@ -357,6 +362,7 @@ power_enter_stop:
>  	b 	pnv_wakeup_noloss
> 
>  .Lhandle_esl_ec_set:
> +BEGIN_FTR_SECTION
>  	/*
>  	 * POWER9 DD2 can incorrectly set PMAO when waking up after a
>  	 * state-loss idle. Saving and restoring MMCR0 over idle is a
> @@ -364,6 +370,10 @@ power_enter_stop:
>  	 */
>  	mfspr	r4,SPRN_MMCR0
>  	std	r4,_MMCR0(r1)
> +FTR_SECTION_ELSE
> +	nop
> +	nop
> +ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POWER9_DD1 | CPU_FTR_POWER9_DD20)
> 
>  /*
>   * Check if the requested state is a deep idle state.
> @@ -555,15 +565,22 @@ pnv_restore_hyp_resource_arch300:
>  	 * then clear bit 60 in MMCRA to ensure the PMU starts running.
>  	 */
>  	blt	cr3,1f
> +BEGIN_FTR_SECTION
> +	nop
> +	nop
> +	nop
> +	nop
> +FTR_SECTION_ELSE
>  	PPC_INVALIDATE_ERAT
>  	ld	r1,PACAR1(r13)
> +	ld	r4,_MMCR0(r1)
> +	mtspr	SPRN_MMCR0,r4
> +ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POWER9_DD1 | CPU_FTR_POWER9_DD20)
>  	mfspr	r4,SPRN_MMCRA
>  	ori	r4,r4,(1 << (63-60))
>  	mtspr	SPRN_MMCRA,r4
>  	xori	r4,r4,(1 << (63-60))
>  	mtspr	SPRN_MMCRA,r4
> -	ld	r4,_MMCR0(r1)
> -	mtspr	SPRN_MMCR0,r4
>  1:
>  	/*
>  	 * POWER ISA 3. Use PSSCR to determine if we
> -- 
> 2.13.3
> 
