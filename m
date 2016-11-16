Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJcMY1wd5zDvmt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 19:08:25 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAG83tM3064047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 03:08:22 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26qxscc3um-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 03:08:22 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 16 Nov 2016 01:08:21 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [powerpc v6 2/3] Detect instruction fetch denied and report
In-Reply-To: <1479192976-17847-3-git-send-email-bsingharora@gmail.com>
References: <1479192976-17847-1-git-send-email-bsingharora@gmail.com>
 <1479192976-17847-3-git-send-email-bsingharora@gmail.com>
Date: Wed, 16 Nov 2016 13:38:17 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y40jludq.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> ISA 3 allows for prevention of instruction fetch and execution
> of user mode pages. If such an error occurs, SRR1 bit 35
> reports the error. We catch and report the error in do_page_fault()
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/mm/fault.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index d0b137d..d498e40 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -390,6 +390,13 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  #endif /* CONFIG_8xx */
>  
>  	if (is_exec) {
> +
> +		/*
> +		 * An execution fault + no execute ?
> +		 */
> +		if (regs->msr & SRR1_ISI_N_OR_G)
> +			goto bad_area;
> +

Can we get that SRR1 value on cpu with  CPU_FTR_NOEXECUTE cleared ?
The comment below says, we should look at at VM_READ and VM_WRITE.

Also don't we need to look at user_mode(regs) here if we are moving this
above the vma check.

>  		/*
>  		 * Allow execution from readable areas if the MMU does not
>  		 * provide separate controls over reading and executing.
> @@ -404,6 +411,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
>  		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
>  			goto bad_area;
> +
>  #ifdef CONFIG_PPC_STD_MMU
>  		/*
>  		 * protfault should only happen due to us
> -- 
> 2.5.5
