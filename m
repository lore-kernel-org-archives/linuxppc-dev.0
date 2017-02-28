Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXSXh3bxrzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 16:57:40 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1S5t4FV030815
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 00:57:37 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28w28kb1tr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 00:57:37 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 28 Feb 2017 11:27:34 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 964B4E005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 11:29:14 +0530 (IST)
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1S5vUCc14680130
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 11:27:30 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1S5vUNU002824
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 11:27:30 +0530
Subject: Re: [PATCH 1/3] powerpc/64s: fix handling of non-synchronous machine
 checks
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170228020048.8862-1-npiggin@gmail.com>
 <20170228020048.8862-2-npiggin@gmail.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 28 Feb 2017 11:27:29 +0530
MIME-Version: 1.0
In-Reply-To: <20170228020048.8862-2-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <15d128c9-f574-0104-d47e-37e2dced8d8f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/28/2017 07:30 AM, Nicholas Piggin wrote:
> A synchronous machine check is an exception raised by the attempt to
> execute the current instruction. If the error can't be corrected, it
> can make sense to SIGBUS the currently running process.
> 
> In other cases, the error condition is not related to the current
> instruction, so killing the current process is not the right thing to
> do.
> 
> Today, all machine checks are MCE_SEV_ERROR_SYNC, so this has no
> practical change. It will be used to handle POWER9 asynchronous
> machine checks.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/platforms/powernv/opal.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 86d9fde93c17..e0f856bfbfe8 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -395,7 +395,6 @@ static int opal_recover_mce(struct pt_regs *regs,
>  					struct machine_check_event *evt)
>  {
>  	int recovered = 0;
> -	uint64_t ea = get_mce_fault_addr(evt);
> 
>  	if (!(regs->msr & MSR_RI)) {
>  		/* If MSR_RI isn't set, we cannot recover */
> @@ -404,26 +403,18 @@ static int opal_recover_mce(struct pt_regs *regs,
>  	} else if (evt->disposition == MCE_DISPOSITION_RECOVERED) {
>  		/* Platform corrected itself */
>  		recovered = 1;
> -	} else if (ea && !is_kernel_addr(ea)) {
> +	} else if (evt->severity == MCE_SEV_FATAL) {
> +		/* Fatal machine check */
> +		pr_err("Machine check interrupt is fatal\n");
> +		recovered = 0;

Setting recovered = 0 would trigger kernel panic. Should we panic the
kernel for asynchronous errors ?

> +	} else if ((evt->severity == MCE_SEV_ERROR_SYNC) &&
> +			(user_mode(regs) && !is_global_init(current))) {
>  		/*
> -		 * Faulting address is not in kernel text. We should be fine.
> -		 * We need to find which process uses this address.
>  		 * For now, kill the task if we have received exception when
>  		 * in userspace.
>  		 *
>  		 * TODO: Queue up this address for hwpoisioning later.
>  		 */
> -		if (user_mode(regs) && !is_global_init(current)) {
> -			_exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
> -			recovered = 1;
> -		} else
> -			recovered = 0;
> -	} else if (user_mode(regs) && !is_global_init(current) &&
> -		evt->severity == MCE_SEV_ERROR_SYNC) {
> -		/*
> -		 * If we have received a synchronous error when in userspace
> -		 * kill the task.
> -		 */
>  		_exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
>  		recovered = 1;
>  	}
> 
