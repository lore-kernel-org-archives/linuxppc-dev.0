Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7kFK3h6PzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 20:03:17 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v968wrjU083204
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 05:03:14 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2de6q40etw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Oct 2017 05:03:14 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 10:03:12 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v96938jB22282438
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 09:03:09 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v96937Tw001874
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 20:03:08 +1100
Date: Fri, 6 Oct 2017 14:33:02 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Santosh Sivaraj <santosh@fossix.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/vdso64: Coarse timer support preparatory patch
References: <20170918092336.21912-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170918092336.21912-1-santosh@fossix.org>
Message-Id: <20171006090302.q4oquzdyytjkawuf@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Santosh,

On 2017/09/18 09:23AM, Santosh Sivaraj wrote:
> Reorganize code to make it easy to introduce CLOCK_REALTIME_COARSE and
> CLOCK_MONOTONIC_COARSE timer support.
> 
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  arch/powerpc/kernel/vdso64/gettimeofday.S | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
> index 382021324883..a0b4943811db 100644
> --- a/arch/powerpc/kernel/vdso64/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
> @@ -60,18 +60,20 @@ V_FUNCTION_END(__kernel_gettimeofday)
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
> +	b	99f		/* Fallback to syscall */

'beq', followed by a 'b' looks weird without considering the next patch.  
I think this can be organized better to not have to update r7/r11/r12 if 
using the system call. See next patch for my comments.

>    .cfi_register lr,r12

If you move the mflr, you should move the above line along with it.

- Naveen

> -	mr	r11,r4			/* r11 saves tp */
> -	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
> -	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
> -	ori	r7,r7,NSEC_PER_SEC@l
> +49:	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
>  50:	bl	V_LOCAL_FUNC(__do_get_tspec)	/* get time from tb & kernel */
>  	bne	cr1,80f			/* if not monotonic, all done */
> 
> -- 
> 2.13.5
> 
