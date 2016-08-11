Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8z6Y5ZzKzDqJ4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:45:25 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s8z6Y26y2z9sRB
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2016 16:45:25 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7B6hhwu074014
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2016 02:45:23 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9ugkxj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2016 02:45:23 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 16:45:20 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CD9493578056
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2016 16:45:16 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7B6jGKB26804332
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2016 16:45:16 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7B6jGxd000361
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2016 16:45:16 +1000
Subject: Re: [PATCH 1/2] powerpc/pseries: PACA save area fix for general
 exception vs MCE
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@ozlabs.org
References: <1470826005-14520-1-git-send-email-npiggin@gmail.com>
 <1470826123-14699-2-git-send-email-npiggin@gmail.com>
Cc: "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 11 Aug 2016 12:15:14 +0530
MIME-Version: 1.0
In-Reply-To: <1470826123-14699-2-git-send-email-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <f484fc37-6407-8a22-92a9-5714e2fdce31@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2016 04:18 PM, Nicholas Piggin wrote:
> MCE must not use PACA_EXGEN. When a general exception enables MSR_RI,
> that means SPRN_SRR[01] and SPRN_SPRG are no longer used. However the
> PACA save area is still in use.
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 694def6..4174c4e 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -984,14 +984,14 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
>  machine_check_common:
> 
>  	mfspr	r10,SPRN_DAR
> -	std	r10,PACA_EXGEN+EX_DAR(r13)
> +	std	r10,PACA_EXMC+EX_DAR(r13)
>  	mfspr	r10,SPRN_DSISR
> -	stw	r10,PACA_EXGEN+EX_DSISR(r13)
> +	stw	r10,PACA_EXMC+EX_DSISR(r13)
>  	EXCEPTION_PROLOG_COMMON(0x200, PACA_EXMC)
>  	FINISH_NAP
>  	RECONCILE_IRQ_STATE(r10, r11)
> -	ld	r3,PACA_EXGEN+EX_DAR(r13)
> -	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
> +	ld	r3,PACA_EXMC+EX_DAR(r13)
> +	lwz	r4,PACA_EXMC+EX_DSISR(r13)
>  	std	r3,_DAR(r1)
>  	std	r4,_DSISR(r1)
>  	bl	save_nvgprs
> 

Yup agree. Looks like copy-paste was the culprit.

Acked-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
