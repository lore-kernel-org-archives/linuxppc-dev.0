Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C33A1A0F97
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 05:18:29 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 00:48:27 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 28DAB1258062
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 00:51:02 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5OJILoW58261728
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 00:48:22 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5OIEYdS010863
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 23:44:34 +0530
Message-ID: <558B027C.1060304@linux.vnet.ibm.com>
Date: Thu, 25 Jun 2015 00:48:20 +0530
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
CC: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/pseries: Ratelimit EPOW event warnings
References: <1433222291-26461-1-git-send-email-kamalesh@linux.vnet.ibm.com>
In-Reply-To: <1433222291-26461-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 06/02/2015 10:48 AM, Kamalesh Babulal wrote:
> We print the respective warning after parsing EPOW interrupts,
> prompting user to take action depending upon the severity of the
> event.
>
> Some times same EPOW event warning, such as below could flood kernel
> log, over a period of time. So Limit the warnings by using ratelimit
> variant of pr_err. Also, merge adjacent pr_err/pr_emerg into single
> one to reduce the number of lines printed per warning.
>
> May 25 03:46:34 alp kernel: Non critical power or cooling issue cleared
> May 25 03:46:52 alp kernel: Non critical power or cooling issue cleared
> May 25 03:53:48 alp kernel: Non critical power or cooling issue cleared
> May 25 03:55:46 alp kernel: Non critical power or cooling issue cleared
> May 25 03:56:34 alp kernel: Non critical power or cooling issue cleared
> May 25 03:59:04 alp kernel: Non critical power or cooling issue cleared
> May 25 04:02:01 alp kernel: Non critical power or cooling issue cleared
> May 25 04:04:24 alp kernel: Non critical power or cooling issue cleared
> May 25 04:07:18 alp kernel: Non critical power or cooling issue cleared
> May 25 04:13:04 alp kernel: Non critical power or cooling issue cleared
> May 25 04:22:04 alp kernel: Non critical power or cooling issue cleared
> May 25 04:22:26 alp kernel: Non critical power or cooling issue cleared
> May 25 04:22:36 alp kernel: Non critical power or cooling issue cleared

These messages are minutes apart and thus rate limiting won't help.
One solution could be to use a flag based approach. Set a flag once a
EPOW condition is detected and check that flag upon receiving EPOW_RESET.
EPOW condition clear message should be logged only if a EPOW was previously
detected i.e. flag found set.

>
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Cc: Anton Blanchard <anton@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
> v2 Changes:
>   - Merged multiple adjacent pr_err/pr_emerg into single line to reduce multi-line
>     warnings, based on Michael's comments.
>
>   arch/powerpc/platforms/pseries/ras.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index 02e4a17..3620935 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -145,17 +145,17 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
>   
>   	switch (action_code) {
>   	case EPOW_RESET:
> -		pr_err("Non critical power or cooling issue cleared");
> +		pr_err_ratelimited("Non critical power or cooling issue cleared");
>   		break;
>   
>   	case EPOW_WARN_COOLING:
> -		pr_err("Non critical cooling issue reported by firmware");
> -		pr_err("Check RTAS error log for details");
> +		pr_err_ratelimited("Non critical cooling issue reported by firmware,"
> +				   " Check RTAS error log for details");
>   		break;
>   
>   	case EPOW_WARN_POWER:
> -		pr_err("Non critical power issue reported by firmware");
> -		pr_err("Check RTAS error log for details");
> +		pr_err_ratelimited("Non critical power issue reported by firmware,"
> +				   " Check RTAS error log for details");
>   		break;
>   
>   	case EPOW_SYSTEM_SHUTDOWN:
> @@ -169,15 +169,14 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
>   
>   	case EPOW_MAIN_ENCLOSURE:
>   	case EPOW_POWER_OFF:
> -		pr_emerg("Critical power/cooling issue reported by firmware");
> -		pr_emerg("Check RTAS error log for details");
> -		pr_emerg("Immediate power off");
> +		pr_emerg("Critical power/cooling issue reported by firmware,"
> +			 " Check RTAS error log for details. Immediate power off");
>   		emergency_sync();
>   		kernel_power_off();
>   		break;
>   
>   	default:
> -		pr_err("Unknown power/cooling event (action code %d)",
> +		pr_err_ratelimited("Unknown power/cooling event (action code %d)",
>   			action_code);
>   	}
>   }
