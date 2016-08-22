Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHjjm4N52zDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 16:05:48 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7M64B1M010490
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 02:05:46 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24y4s62wwm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 02:05:45 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Aug 2016 00:05:45 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH 2/2] Detect instruction fetch denied and report
In-Reply-To: <1471831017-18167-2-git-send-email-bsingharora@gmail.com>
References: <1471831017-18167-1-git-send-email-bsingharora@gmail.com>
 <1471831017-18167-2-git-send-email-bsingharora@gmail.com>
Date: Mon, 22 Aug 2016 11:35:36 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87vaytibin.fsf@linux.vnet.ibm.com>
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

But what does the error mean ? A buggy application ? IIUC, it indicate a
buggy kernel isn't it ?. So should we kill the application or panic() ?


> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/mm/fault.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index a4db22f..f162e77 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -404,6 +404,10 @@ good_area:
>  		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
>  		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
>  			goto bad_area;
> +#ifdef CONFIG_PPC_RADIX_MMU
> +		if (radix_enabled() && regs->msr & PPC_BIT(35))
> +			goto bad_area;
> +#endif
>  #ifdef CONFIG_PPC_STD_MMU
>  		/*
>  		 * protfault should only happen due to us

-aneesh
