Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCvQ15ynGzDvLg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 03:09:13 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tCvQ11NbJz9t17
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2016 03:09:12 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA8G8tN4107713
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Nov 2016 11:09:11 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26kh42tyr6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Nov 2016 11:09:11 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 Nov 2016 11:09:10 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/3] Detect instruction fetch denied and report
In-Reply-To: <1478007500-23624-3-git-send-email-bsingharora@gmail.com>
References: <1478007500-23624-1-git-send-email-bsingharora@gmail.com>
 <1478007500-23624-3-git-send-email-bsingharora@gmail.com>
Date: Tue, 08 Nov 2016 21:39:04 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877f8e2btr.fsf@linux.vnet.ibm.com>
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
>  arch/powerpc/mm/fault.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index d0b137d..835fd03 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -404,6 +404,10 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
>  		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
>  			goto bad_area;
> +
> +		if (radix_enabled() && (regs->msr & SRR1_ISI_N_OR_G))
> +			goto bad_area;

Why is this within radix_enabled() ? Hash can also generate an
interrupt with that SRR1 value right ?


> +
>  #ifdef CONFIG_PPC_STD_MMU
>  		/*
>  		 * protfault should only happen due to us


-aneesh
