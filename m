Return-Path: <maddy@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtprp4vbdzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 15:44:26 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rtprp18h2z9sC3
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Jul 2016 15:44:25 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6J5hYqa064889
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Jul 2016 01:44:22 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2495r7cy5n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Jul 2016 01:44:22 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 19 Jul 2016 11:14:19 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id F1E78394005E
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Jul 2016 11:14:15 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6J5iF2830867706
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Jul 2016 11:14:15 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6J5iDPE028920
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Jul 2016 11:14:15 +0530
Subject: Re: [PATCH 1/2] powerpc/ftrace: Separate the heuristics for checking
 call sites
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1468903711-5869-1-git-send-email-mpe@ellerman.id.au>
Cc: duwe@lst.de, aneesh.kumar@linux.vnet.ibm.com,
 Anton Blanchard <anton@samba.org>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 19 Jul 2016 11:14:09 +0530
MIME-Version: 1.0
In-Reply-To: <1468903711-5869-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <578DBE29.6010100@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 19 July 2016 10:18 AM, Michael Ellerman wrote:
> In __ftrace_make_nop() (the 64-bit version), we have code to deal with
> two ftrace ABIs. There is the original ABI, which looks mostly like a
> function call, and then the mprofile-kernel ABI which is just a branch.
>
> The code tries to handle both cases, by looking for the presence of a
> load to restore the TOC pointer (PPC_INST_LD_TOC). If we detect the TOC
> load, we assume the call site is for an mcount() call using the old ABI.
> That means we patch the mcount() call with a b +8, to branch over the
> TOC load.
>
> However if the kernel was built with mprofile-kernel, then there will
> never be a call site using the original ftrace ABI. If for some reason
> we do see a TOC load, then it's there for a good reason, and we should
> not jump over it.
>
> So split the code, using the existing CC_USING_MPROFILE_KERNEL. Kernels
> built with mprofile-kernel will only look for, and expect, the new ABI,
> and similarly for the original ABI.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   arch/powerpc/kernel/ftrace.c | 35 ++++++++++++++++++-----------------
>   1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
> index 7af6c4de044b..438442dac44c 100644
> --- a/arch/powerpc/kernel/ftrace.c
> +++ b/arch/powerpc/kernel/ftrace.c
> @@ -144,6 +144,21 @@ __ftrace_make_nop(struct module *mod,
>   		return -EINVAL;
>   	}
>   
> +#ifdef CC_USING_MPROFILE_KERNEL
> +	/* When using -mkernel_profile there is no load to jump over */
> +	pop = PPC_INST_NOP;
> +
> +	if (probe_kernel_read(&op, (void *)(ip - 4), 4)) {
> +		pr_err("Fetching instruction at %lx failed.\n", ip - 4);
> +		return -EFAULT;
> +	}
> +
> +	/* We expect either a mlfr r0, or a std r0, LRSAVE(r1) */

nit..  "mflr" and not "mlfr"
> +	if (op != PPC_INST_MFLR && op != PPC_INST_STD_LR) {
> +		pr_err("Unexpected instruction %08x around bl _mcount\n", op);
> +		return -EINVAL;
> +	}
> +#else
>   	/*
>   	 * Our original call site looks like:
>   	 *
> @@ -170,24 +185,10 @@ __ftrace_make_nop(struct module *mod,
>   	}
>   
>   	if (op != PPC_INST_LD_TOC) {
> -		unsigned int inst;
> -
> -		if (probe_kernel_read(&inst, (void *)(ip - 4), 4)) {
> -			pr_err("Fetching instruction at %lx failed.\n", ip - 4);
> -			return -EFAULT;
> -		}
> -
> -		/* We expect either a mlfr r0, or a std r0, LRSAVE(r1) */
> -		if (inst != PPC_INST_MFLR && inst != PPC_INST_STD_LR) {
> -			pr_err("Unexpected instructions around bl _mcount\n"
> -			       "when enabling dynamic ftrace!\t"
> -			       "(%08x,bl,%08x)\n", inst, op);
> -			return -EINVAL;
> -		}
> -
> -		/* When using -mkernel_profile there is no load to jump over */
> -		pop = PPC_INST_NOP;
> +		pr_err("Expected %08x found %08x\n", PPC_INST_LD_TOC, op);
> +		return -EINVAL;
>   	}
> +#endif /* CC_USING_MPROFILE_KERNEL */
>   
>   	if (patch_instruction((unsigned int *)ip, pop)) {
>   		pr_err("Patching NOP failed.\n");
