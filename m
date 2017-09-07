Return-Path: <santosh@fossix.org>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnwyM3TvVzDrWK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 20:03:39 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id y68so4303695pfd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 03:03:39 -0700 (PDT)
Date: Thu, 7 Sep 2017 15:33:33 +0530
From: Santosh Sivaraj <santosh@fossix.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, anton@ozlabs.org
Subject: Re: [PATCH resend] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
Message-ID: <20170907100333.y6srewaeoxb2gy24@santosiv.in.ibm.com>
References: <20170828074440.18766-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170828074440.18766-1-santosh@fossix.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Any comments on the below patch?

Thanks,
Santosh
* Santosh Sivaraj <santosh@fossix.org> wrote (on 2017-08-28 13:14:40 +0530):

> Current vDSO64 implementation does not have support for coarse clocks
> (CLOCK_MONOTONIC_COARSE, CLOCK_REALTIME_COARSE), for which it falls back
> to system call, increasing the response time, vDSO implementation reduces
> the cycle time. Below is a benchmark of the difference in execution time
> with and without vDSO support.
> 
> (Non-coarse clocks are also included just for completion)
> 
> Without vDSO support:
> --------------------
> clock-gettime-realtime: syscall: 172 nsec/call
> clock-gettime-realtime:    libc: 26 nsec/call
> clock-gettime-realtime:    vdso: 21 nsec/call
> clock-gettime-monotonic: syscall: 170 nsec/call
> clock-gettime-monotonic:    libc: 30 nsec/call
> clock-gettime-monotonic:    vdso: 24 nsec/call
> clock-gettime-realtime-coarse: syscall: 153 nsec/call
> clock-gettime-realtime-coarse:    libc: 15 nsec/call
> clock-gettime-realtime-coarse:    vdso: 9 nsec/call
> clock-gettime-monotonic-coarse: syscall: 167 nsec/call
> clock-gettime-monotonic-coarse:    libc: 15 nsec/call
> clock-gettime-monotonic-coarse:    vdso: 11 nsec/call
> 
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  arch/powerpc/kernel/asm-offsets.c         |  2 +
>  arch/powerpc/kernel/vdso64/gettimeofday.S | 70 ++++++++++++++++++++++++++++---
>  2 files changed, 66 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 6e95c2c19a7e..c6acaa5edd16 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -396,6 +396,8 @@ int main(void)
>  	/* Other bits used by the vdso */
>  	DEFINE(CLOCK_REALTIME, CLOCK_REALTIME);
>  	DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
> +	DEFINE(CLOCK_REALTIME_COARSE, CLOCK_REALTIME_COARSE);
> +	DEFINE(CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC_COARSE);
>  	DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
>  	DEFINE(CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
>  
> diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
> index 382021324883..bae197a81add 100644
> --- a/arch/powerpc/kernel/vdso64/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
> @@ -60,18 +60,25 @@ V_FUNCTION_END(__kernel_gettimeofday)
>   */
>  V_FUNCTION_BEGIN(__kernel_clock_gettime)
>    .cfi_startproc
> +	mr	r11,r4			/* r11 saves tp */
> +	mflr	r12			/* r12 saves lr */
> +	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
> +	ori	r7,r7,NSEC_PER_SEC@l
> +
>  	/* Check for supported clock IDs */
>  	cmpwi	cr0,r3,CLOCK_REALTIME
>  	cmpwi	cr1,r3,CLOCK_MONOTONIC
>  	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
> -	bne	cr0,99f
> +	beq	cr0,49f
>  
> -	mflr	r12			/* r12 saves lr */
> +	cmpwi	cr0,r3,CLOCK_REALTIME_COARSE
> +	cmpwi	cr1,r3,CLOCK_MONOTONIC_COARSE
> +	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
> +	beq	cr0,65f
> +
> +	b	99f		/* Fallback to syscall */
>    .cfi_register lr,r12
> -	mr	r11,r4			/* r11 saves tp */
> -	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
> -	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
> -	ori	r7,r7,NSEC_PER_SEC@l
> +49:	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
>  50:	bl	V_LOCAL_FUNC(__do_get_tspec)	/* get time from tb & kernel */
>  	bne	cr1,80f			/* if not monotonic, all done */
>  
> @@ -110,6 +117,57 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
>  1:	bge	cr1,80f
>  	addi	r4,r4,-1
>  	add	r5,r5,r7
> +	b	80f
> +
> +	/*
> +	 * For coarse clocks we get data directly from the vdso data page, so
> +	 * we don't need to call __do_get_tspec, but we still need to do the
> +	 * counter trick.
> +	 */
> +65:	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
> +70:	ld	r8,CFG_TB_UPDATE_COUNT(r3)
> +	andi.	r0,r8,1			/* pending update ? loop */
> +	bne-	70b
> +	xor	r0,r8,r8		/* create dependency */
> +	add	r3,r3,r0
> +
> +	/*
> +	 * CLOCK_REALTIME_COARSE, below values are needed for MONOTONIC_COARSE
> +	 * too
> +	 */
> +	ld	r4,STAMP_XTIME+TSPC64_TV_SEC(r3)
> +	ld	r5,STAMP_XTIME+TSPC64_TV_NSEC(r3)
> +	bne	cr1,78f
> +
> +	/* CLOCK_MONOTONIC_COARSE */
> +	lwa	r6,WTOM_CLOCK_SEC(r3)
> +	lwa	r9,WTOM_CLOCK_NSEC(r3)
> +
> +	/* check if counter has updated */
> +78:	or	r0,r6,r9
> +	xor	r0,r0,r0
> +	add	r3,r3,r0
> +	ld	r0,CFG_TB_UPDATE_COUNT(r3)
> +	cmpld	cr0,r0,r8		/* check if updated */
> +	bne-	70b
> +
> +	/* Counter has not updated, so continue calculating proper values for
> +	 * sec and nsec if monotonic coarse, or just return with the proper
> +	 * values for realtime.
> +	 */
> +	bne	cr1,80f
> +
> +	/* Add wall->monotonic offset and check for overflow or underflow */
> +	add	r4,r4,r6
> +	add	r5,r5,r9
> +	cmpd	cr0,r5,r7
> +	cmpdi	cr1,r5,0
> +	blt	79f
> +	subf	r5,r7,r5
> +	addi	r4,r4,1
> +79:	bge	cr1,80f
> +	addi	r4,r4,-1
> +	add	r5,r5,r7
>  
>  80:	std	r4,TSPC64_TV_SEC(r11)
>  	std	r5,TSPC64_TV_NSEC(r11)

-- 
