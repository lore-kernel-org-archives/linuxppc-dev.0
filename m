Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZ74t5PynzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 11:57:02 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rZ74t0x80z9t0J
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2016 11:57:01 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5M1rq5b129866
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 21:57:00 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23q6r3v7d4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2016 21:57:00 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Jun 2016 21:56:59 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kda@linux-powerpc.org
Subject: Re: [PATCH] powerpc: Fix faults caused by radix patching of SLB miss
 handler
In-Reply-To: <1466505379-15597-1-git-send-email-mpe@ellerman.id.au>
References: <1466505379-15597-1-git-send-email-mpe@ellerman.id.au>
Date: Wed, 22 Jun 2016 07:26:54 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <871t3qyoih.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> As part of the Radix MMU support we added some feature sections in the
> SLB miss handler. These are intended to catch the case that we
> incorrectly take an SLB miss when Radix is enabled, and instead of
> crashing weirdly they bail out to a well defined exit path and trigger
> an oops.
>
> However the way they were written meant the bailout case was enabled by
> default until we did CPU feature patching.
>
> On powermacs the early debug prints in setup_system() can cause an SLB
> miss, which happens before code patching, and so the SLB miss handler
> would incorrectly bailout and crash during boot.
>
> Fix it by inverting the sense of the feature section, so that the code
> which is in place at boot is correct for the hash case. Once we
> determine we are using Radix - which will never happen on a powermac -
> only then do we patch in the bailout case which unconditionally jumps.
>
> Fixes: caca285e5ab4 ("powerpc/mm/radix: Use STD_MMU_64 to properly isolate hash related code")
> Reported-by: Denis Kirjanov <kda@linux-powerpc.org>
> Tested-by: Denis Kirjanov <kda@linux-powerpc.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>


Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/exceptions-64s.S | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 4c9440629128..8bcc1b457115 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1399,11 +1399,12 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
>  	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
>
>  	mtlr	r10
> -BEGIN_MMU_FTR_SECTION
> -	b	2f
> -END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
>  	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
> +BEGIN_MMU_FTR_SECTION
>  	beq-	2f
> +FTR_SECTION_ELSE
> +	b	2f
> +ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
>
>  .machine	push
>  .machine	"power4"
> -- 
> 2.5.0
