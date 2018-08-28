Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420R136r6RzF0QC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 10:13:27 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7SN4CYn093106
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 19:08:38 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m5f7w10cx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 19:08:38 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Tue, 28 Aug 2018 19:08:38 -0400
Subject: Re: [PATCH] selftests/powerpc: Do not fail on TM_CAUSE_RESCHED
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
References: <1534877787-24359-1-git-send-email-leitao@debian.org>
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Date: Tue, 28 Aug 2018 20:08:33 -0300
MIME-Version: 1.0
In-Reply-To: <1534877787-24359-1-git-send-email-leitao@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3404db1f-cd5a-5ca1-0559-26d2ad08f410@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Breno,

On 08/21/2018 03:56 PM, Breno Leitao wrote:
> There are cases where the test is not expecting to have the transaction
> aborted, but, the test process might have been rescheduled, either in the OS
> level or by KVM (if it is running on a KVM guest machine). The process
> reschedule will cause a treclaim/recheckpoint which will cause the transaction
> to doom, failing as soon as the process is rescheduled back to the CPU. This
> might cause the test to fail, but this is not a failure in essence.
> 
> If that is the case, TEXASR[FC] is indicated with either
> TM_CAUSE_RESCHEDULE or TM_CAUSE_KVM_RESCHEDULE for KVM interruptions.
> 
> In this scenario, ignore these two failures and avoid the whole test to return
> failure.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thanks for improving the code.

I understand that filtering out the aborts caused by the re-schedules is correct.

Only a nit:

> @@ -244,9 +245,12 @@ void *tm_una_ping(void *input)
> 
>   	/*
>   	 * Check if TM failed due to the cause we were expecting. 0xda is a
> -	 * TM_CAUSE_FAC_UNAV cause, otherwise it's an unexpected cause.
> +	 * TM_CAUSE_FAC_UNAV cause, otherwise it's an unexpected cause, unless
> +	 * it was caused by a reschedule.
>   	 */
> -	if (is_failure(cr_) && !failure_is_unavailable()) {
> +
> +	if (is_failure(cr_) && !failure_is_unavailable()
> +	    & !failure_is_reschedule()) {

             ^---

It should read a short-circuit operator here instead of a bitwise operator.

Otherwise it LGTM.

Reviewed-by: Gustavo Romero <gromero@linux.ibm.com>


Best regards,
Gustavo
