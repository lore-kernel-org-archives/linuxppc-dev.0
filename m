Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 379EC1A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 18:32:50 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Tue, 14 Jul 2015 14:02:46 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B67B11258053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 14:05:37 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6E8WgMq34210010
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 14:02:43 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6E8WQPt006810
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 14:02:27 +0530
Message-ID: <55A4C916.7050003@linux.vnet.ibm.com>
Date: Tue, 14 Jul 2015 14:02:22 +0530
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/pseries: Ratelimit EPOW event warnings
References: <1433222291-26461-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <558B027C.1060304@linux.vnet.ibm.com>
 <20150714075153.GA32237@linux.vnet.ibm.com>
In-Reply-To: <20150714075153.GA32237@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch looks good to me. A small nit pick below.

On 07/14/2015 01:21 PM, Kamalesh Babulal wrote:
> * Vipin K Parashar <vipin@linux.vnet.ibm.com> [2015-06-25 00:48:20]:
>
>> On 06/02/2015 10:48 AM, Kamalesh Babulal wrote:
>>> We print the respective warning after parsing EPOW interrupts,
>>> prompting user to take action depending upon the severity of the
>>> event.
>>>
>>> Some times same EPOW event warning, such as below could flood kernel
>>> log, over a period of time. So Limit the warnings by using ratelimit
>>> variant of pr_err. Also, merge adjacent pr_err/pr_emerg into single
>>> one to reduce the number of lines printed per warning.
>>>
>>> May 25 03:46:34 alp kernel: Non critical power or cooling issue cleared
>>> May 25 03:46:52 alp kernel: Non critical power or cooling issue cleared
>>> May 25 03:53:48 alp kernel: Non critical power or cooling issue cleared
>>> May 25 03:55:46 alp kernel: Non critical power or cooling issue cleared
>>> May 25 03:56:34 alp kernel: Non critical power or cooling issue cleared
>>> May 25 03:59:04 alp kernel: Non critical power or cooling issue cleared
>>> May 25 04:02:01 alp kernel: Non critical power or cooling issue cleared
>>> May 25 04:04:24 alp kernel: Non critical power or cooling issue cleared
>>> May 25 04:07:18 alp kernel: Non critical power or cooling issue cleared
>>> May 25 04:13:04 alp kernel: Non critical power or cooling issue cleared
>>> May 25 04:22:04 alp kernel: Non critical power or cooling issue cleared
>>> May 25 04:22:26 alp kernel: Non critical power or cooling issue cleared
>>> May 25 04:22:36 alp kernel: Non critical power or cooling issue cleared
>> These messages are minutes apart and thus rate limiting won't help.
>> One solution could be to use a flag based approach. Set a flag once a
>> EPOW condition is detected and check that flag upon receiving EPOW_RESET.
>> EPOW condition clear message should be logged only if a EPOW was previously
>> detected i.e. flag found set.
> Thanks for reviewing it. Sorry for late response.
>
> bool flag epow_state, which is initialized to false and when any event gets
> reported, the flag set to true once the event gets acknowledged by a reset.
> As, seen in the example of flooded messages occurring only with reset event.
> The reset action is guarded with bool flag (set only if there was event
> reported previously) and ignore multiple resets, without real EPOW event.
>
> I have only compile tested the patch. If this approach sounds good.
> I will resend formal patch.
>
>
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index 02e4a17..4819b1d 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -40,6 +40,8 @@ static int ras_check_exception_token;
>   #define EPOW_SENSOR_TOKEN	9
>   #define EPOW_SENSOR_INDEX	0
>
> +static bool epow_state = false;
> +

Explicit declaration isn't needed. default value would be false already.
A one line comment about flag usage would be good.

>   static irqreturn_t ras_epow_interrupt(int irq, void *dev_id);
>   static irqreturn_t ras_error_interrupt(int irq, void *dev_id);
>
> @@ -145,21 +147,27 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
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
> @@ -169,9 +177,8 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
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
> @@ -179,6 +186,7 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
>   	default:
>   		pr_err("Unknown power/cooling event (action code %d)",
>   			action_code);
> +		epow_state = true;
>   	}
>   }
>
