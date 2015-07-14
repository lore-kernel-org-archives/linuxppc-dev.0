Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA6D31A00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 04:02:13 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Wed, 15 Jul 2015 04:02:12 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CC02A2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 04:02:09 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6EI1wmP60817612
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 04:02:06 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6EI1bgu019490
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 04:01:37 +1000
Message-ID: <55A54E6E.8080808@linux.vnet.ibm.com>
Date: Tue, 14 Jul 2015 23:31:18 +0530
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
CC: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc/pseries: Limit EPOW reset event warnings
References: <1436886564-3373-1-git-send-email-kamalesh@linux.vnet.ibm.com>
In-Reply-To: <1436886564-3373-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Patch looks good. Though it seems that we can improve upon
commit log description to better describe the problem and solution.
Few suggestions as below:

Avoid multiple EPOW reset ..........
is better suited as one line description of this problem.

On 07/14/2015 08:39 PM, Kamalesh Babulal wrote:
> We print the respective warning after parsing EPOW interrupts,

Kernel prints respective warnings about various EPOW events for
user information/action after parsing EPOW interrupts.

> prompting user to take action depending upon the severity of the
> event.

Please merge below line with above one.

>
> Some times EPOW rest event warning, such as below could flood
        ^                ^                                  ^^
     At times EPOW reset  event warning is found to be flooding..
> kernel log, over a period of time.

Paste the multiple warnings log here.

> Limit these warnings by use of

This patch avoids these multiple EPOW reset warnings by using a boolean 
flag.

> epow_state flag, which is initialized to false and when any event

This flag is initialized to false and is set to true upon arrival of 
EPOW event.

> gets reported, the flag set to true once an event gets acknowledged
> by a reset.
>
> The reset action is guarded by bool flag (set only if there was event

This same flag is checked and reset during EPOW_RESET scenario to
filter out valid EPOW reset events and avoid multiple warning logs.

> reported previously) and ignore multiple resets, without real EPOW
> event.
> Also, merge adjacent pr_err/pr_emerg into single one to reduce
               ^
          merged
> the number of lines printed per warning.
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
>
> Suggested-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Cc: Anton Blanchard <anton@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> ---
> v3 Changes:
>    - Limit warning printed by EPOW RESET event, by guarding it with bool flag.
>      Instead of rate limiting all the EPOW events.
>
> v2 Changes:
>    - Merged multiple adjacent pr_err/pr_emerg into single line to reduce multi-line
>      warnings, based on Michael's comments.
>
>   arch/powerpc/platforms/pseries/ras.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index 02e4a17..b30396a 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -40,6 +40,9 @@ static int ras_check_exception_token;
>   #define EPOW_SENSOR_TOKEN	9
>   #define EPOW_SENSOR_INDEX	0
>
> +/* Flag to limit EPOW RESET warning. */
> +static bool epow_state;
> +
>   static irqreturn_t ras_epow_interrupt(int irq, void *dev_id);
>   static irqreturn_t ras_error_interrupt(int irq, void *dev_id);
>
> @@ -145,21 +148,27 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
>
>   	switch (action_code) {
>   	case EPOW_RESET:
> -		pr_err("Non critical power or cooling issue cleared");
> +		if (epow_state) {
> +			pr_err("Non critical power or cooling issue cleared");
> +			epow_state = false;
> +		}
>   		break;
>
>   	case EPOW_WARN_COOLING:
> -		pr_err("Non critical cooling issue reported by firmware");
> -		pr_err("Check RTAS error log for details");
> +		pr_err("Non critical cooling issue reported by firmware, "
> +		       "Check RTAS error log for details");
> +		epow_state = true;
>   		break;
>
>   	case EPOW_WARN_POWER:
> -		pr_err("Non critical power issue reported by firmware");
> -		pr_err("Check RTAS error log for details");
> +		pr_err("Non critical power issue reported by firmware, "
> +		       "Check RTAS error log for details");
> +		epow_state = true;
>   		break;
>
>   	case EPOW_SYSTEM_SHUTDOWN:
>   		handle_system_shutdown(epow_log->event_modifier);
> +		epow_state = true;
>   		break;
>
>   	case EPOW_SYSTEM_HALT:
> @@ -169,9 +178,8 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
>
>   	case EPOW_MAIN_ENCLOSURE:
>   	case EPOW_POWER_OFF:
> -		pr_emerg("Critical power/cooling issue reported by firmware");
> -		pr_emerg("Check RTAS error log for details");
> -		pr_emerg("Immediate power off");
> +		pr_emerg("Critical power/cooling issue reported by firmware, "
> +			 "Check RTAS error log for details. Immediate power off.");
>   		emergency_sync();
>   		kernel_power_off();
>   		break;
> @@ -179,6 +187,7 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
>   	default:
>   		pr_err("Unknown power/cooling event (action code %d)",
>   			action_code);
> +		epow_state = true;
>   	}
>   }
>
