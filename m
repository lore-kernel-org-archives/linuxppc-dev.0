Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 82F121A369E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 17:04:11 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Wed, 15 Jul 2015 12:34:07 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 52E30E006A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 12:37:38 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6F73IrO8061082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 12:33:19 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6F731v2000690
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 12:33:01 +0530
Message-ID: <55A60556.6080402@linux.vnet.ibm.com>
Date: Wed, 15 Jul 2015 12:31:42 +0530
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
CC: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RESEND PATCH v3] powerpc/pseries: Limit EPOW reset event warnings
References: <55A54E6E.8080808@linux.vnet.ibm.com>
 <1436934126-9273-1-git-send-email-kamalesh@linux.vnet.ibm.com>
In-Reply-To: <1436934126-9273-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 07/15/2015 09:52 AM, Kamalesh Babulal wrote:
> Kernel prints respective warnings about various EPOW events for
> user information/action after parsing EPOW interrupts. Prompting
> user to take action depending upon the severity of the event.

Second line probably isn't needed.  Also below line can be merged with 
first one
as both are in same context to describe problem.

>
> At times EPOW reset event warning, such as below could flood
> kernel log, over a period of time.
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
> This patch avoids these multiple EPOW reset warnings by using a boolean
> flag. This flag is initialized to false and is set to true upon arrival
> of EPOW event. This same flag is checked and reset during EPOW_RESET
> scenario to filter out valid EPOW reset events and avoid multiple warning
> logs.
>
> Also, merged adjacent pr_err/pr_emerg into single one to reduce
> the number of lines printed per warning.
>
> Suggested-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> [Vipin: edited the changelog]

This probably should go to change summary below.

> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Cc: Anton Blanchard <anton@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> ---
> v3 Changes:
>     - Limit warning printed by EPOW RESET event, by guarding it with bool flag.
>       Instead of rate limiting all the EPOW events.
>
> v2 Changes:
>     - Merged multiple adjacent pr_err/pr_emerg into single line to reduce multi-line
>       warnings, based on Michael's comments.
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
