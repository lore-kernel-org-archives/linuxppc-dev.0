Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnR7f4l28zDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 19:39:26 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2L8Y1aJ117435
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 04:39:18 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29awug7xgq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 04:39:18 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 14:09:15 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2L8dBXN15204472
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 14:09:11 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2L8d7NG026891
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 14:09:10 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, bsingharora@gmail.com,
 npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powerpc/mm: move mmap_sem unlock up from do_sigbus
In-Reply-To: <925b1b5f2d28b5015354405af72bf23d21a1c5c4.1487090656.git.ldufour@linux.vnet.ibm.com>
References: <cover.1487090656.git.ldufour@linux.vnet.ibm.com>
 <925b1b5f2d28b5015354405af72bf23d21a1c5c4.1487090656.git.ldufour@linux.vnet.ibm.com>
Date: Tue, 21 Mar 2017 14:09:06 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a88fowgl.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:

> Move mmap_sem releasing in the do_sigbus()'s unique caller : mm_fault_error()
>
> No functional changes.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/fault.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 62a50d6d1053..ee09604bbe12 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -119,8 +119,6 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
>  	siginfo_t info;
>  	unsigned int lsb = 0;
>
> -	up_read(&current->mm->mmap_sem);
> -
>  	if (!user_mode(regs))
>  		return MM_FAULT_ERR(SIGBUS);
>
> @@ -184,8 +182,10 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
>  		return MM_FAULT_RETURN;
>  	}
>
> -	if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE))
> +	if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
> +		up_read(&current->mm->mmap_sem);
>  		return do_sigbus(regs, addr, fault);
> +	}
>
>  	/* We don't understand the fault code, this is fatal */
>  	BUG();
> -- 
> 2.7.4
