Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9cDz4dVRzDscC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Oct 2017 21:39:31 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v99AdGAF133656
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 06:39:29 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dg7fk8a66-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 06:39:29 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 9 Oct 2017 11:39:26 +0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v99AdLnp20054170
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 10:39:23 GMT
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v99AdOGV005181
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 21:39:25 +1100
Date: Mon, 9 Oct 2017 16:09:18 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Santosh Sivaraj <santosh@fossix.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
References: <20171006112528.zryd4l2yl2k6xk2h@naverao1-tp.localdomain>
 <20171009080949.25913-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171009080949.25913-1-santosh@fossix.org>
Message-Id: <20171009103918.liylptwpf2tsu3qa@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/10/09 08:09AM, Santosh Sivaraj wrote:
> Current vDSO64 implementation does not have support for coarse clocks
> (CLOCK_MONOTONIC_COARSE, CLOCK_REALTIME_COARSE), for which it falls back
> to system call, increasing the response time, vDSO implementation reduces
> the cycle time. Below is a benchmark of the difference in execution times.
> 
> (Non-coarse clocks are also included just for completion)
> 
> clock-gettime-realtime: syscall: 172 nsec/call
> clock-gettime-realtime:    libc: 28 nsec/call
> clock-gettime-realtime:    vdso: 22 nsec/call
> clock-gettime-monotonic: syscall: 171 nsec/call
> clock-gettime-monotonic:    libc: 30 nsec/call
> clock-gettime-monotonic:    vdso: 25 nsec/call
> clock-gettime-realtime-coarse: syscall: 153 nsec/call
> clock-gettime-realtime-coarse:    libc: 16 nsec/call
> clock-gettime-realtime-coarse:    vdso: 10 nsec/call
> clock-gettime-monotonic-coarse: syscall: 167 nsec/call
> clock-gettime-monotonic-coarse:    libc: 17 nsec/call
> clock-gettime-monotonic-coarse:    vdso: 11 nsec/call
> 
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  arch/powerpc/kernel/asm-offsets.c         |  2 +
>  arch/powerpc/kernel/vdso64/gettimeofday.S | 67 ++++++++++++++++++++++++++-----
>  2 files changed, 58 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 8cfb20e38cfe..b55c68c54dc1 100644
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
> index 382021324883..729dded195ce 100644
> --- a/arch/powerpc/kernel/vdso64/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
> @@ -64,6 +64,12 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
>  	cmpwi	cr0,r3,CLOCK_REALTIME
>  	cmpwi	cr1,r3,CLOCK_MONOTONIC
>  	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
> +
> +	cmpwi	cr5,r3,CLOCK_REALTIME_COARSE
> +	cmpwi	cr6,r3,CLOCK_MONOTONIC_COARSE
> +	cror	cr5*4+eq,cr5*4+eq,cr6*4+eq
> +
> +	cror	cr0*4+eq,cr0*4+eq,cr5*4+eq
>  	bne	cr0,99f
> 
>  	mflr	r12			/* r12 saves lr */
> @@ -72,6 +78,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
>  	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
>  	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
>  	ori	r7,r7,NSEC_PER_SEC@l
> +	beq	cr5,70f
>  50:	bl	V_LOCAL_FUNC(__do_get_tspec)	/* get time from tb & kernel */
>  	bne	cr1,80f			/* if not monotonic, all done */
> 
> @@ -97,19 +104,57 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
>  	ld	r0,CFG_TB_UPDATE_COUNT(r3)
>          cmpld   cr0,r0,r8		/* check if updated */
>  	bne-	50b
> +	b	78f
> 
> -	/* Add wall->monotonic offset and check for overflow or underflow.
> +	/*
> +	 * For coarse clocks we get data directly from the vdso data page, so
> +	 * we don't need to call __do_get_tspec, but we still need to do the
> +	 * counter trick.
>  	 */
> -	add	r4,r4,r6
> -	add	r5,r5,r9
> -	cmpd	cr0,r5,r7
> -	cmpdi	cr1,r5,0
> -	blt	1f
> -	subf	r5,r7,r5
> -	addi	r4,r4,1
> -1:	bge	cr1,80f
> -	addi	r4,r4,-1
> -	add	r5,r5,r7
> +70:	ld      r8,CFG_TB_UPDATE_COUNT(r3)
> +	andi.   r0,r8,1                 /* pending update ? loop */
> +	bne-    70b
> +	xor     r0,r8,r8                /* create dependency */
> +	add     r3,r3,r0
> +
> +	/*
> +	 * CLOCK_REALTIME_COARSE, below values are needed for MONOTONIC_COARSE
> +	 * too
> +	 */
> +	ld      r4,STAMP_XTIME+TSPC64_TV_SEC(r3)
> +	ld      r5,STAMP_XTIME+TSPC64_TV_NSEC(r3)
> +	bne     cr6,75f
> +
> +	/* CLOCK_MONOTONIC_COARSE */
> +	lwa     r6,WTOM_CLOCK_SEC(r3)
> +	lwa     r9,WTOM_CLOCK_NSEC(r3)
> +
> +	/* check if counter has updated */
> +75:	or      r0,r6,r9
> +	or	r0,r4,r5
> +	xor     r0,r0,r0

The label '75:' should be on the second instruction since we don't need 
to worry about r6/r9 for REALTIME_COARSE.

Also, the above hunk should actually be:

	or      r0,r6,r9
	or	r0,r0,r4
	or	r0,r0,r5
	xor     r0,r0,r0

Otherwise, the first 'or' will be skipped. I realized this after I 
replied to your previous version, but missed letting you know...

> +	add     r3,r3,r0
> +	ld      r0,CFG_TB_UPDATE_COUNT(r3)
> +	cmpld   cr0,r0,r8               /* check if updated */
> +	bne-    70b

I also notice that the code for dealing with CLOCK_MONOTONIC is similar 
for _COARSE and regular clocks. If possible, we should reuse that as 
well.


- Naveen
