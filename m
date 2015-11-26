Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0606A1A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 20:20:21 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 26 Nov 2015 14:50:17 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4941B125805B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 14:50:28 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAQ9KAih2294100
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 14:50:11 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAQ9KAcE029219
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 14:50:10 +0530
Message-ID: <5656CEC9.4070000@linux.vnet.ibm.com>
Date: Thu, 26 Nov 2015 14:50:09 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
CC: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v5] powerpc/pseries: Limit EPOW reset event warnings
References: <1447836157-19599-1-git-send-email-vipin@linux.vnet.ibm.com>
In-Reply-To: <1447836157-19599-1-git-send-email-vipin@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/18/2015 02:12 PM, Vipin K Parashar wrote:
> Kernel prints respective warnings about various EPOW events for
> user information/action after parsing EPOW interrupts. At times
> below EPOW reset event warning is seen to be flooding kernel log
> over a period of time.
> 
> May 25 03:46:34 alp kernel: Non critical power or cooling issue cleared
> May 25 03:46:52 alp kernel: Non critical power or cooling issue cleared
> May 25 03:53:48 alp kernel: Non critical power or cooling issue cleared
> May 25 03:55:46 alp kernel: Non critical power or cooling issue cleared
> May 25 03:56:34 alp kernel: Non critical power or cooling issue cleared
> May 25 03:59:04 alp kernel: Non critical power or cooling issue cleared
> May 25 04:02:01 alp kernel: Non critical power or cooling issue cleared
> 

@Michael,
 I think above log is raising some concern. We have been asked by multiple
people on this. Hence I think we should avoid these duplicate messages.


> These EPOW reset events are spurious in nature and are triggered by
> firmware witout an actual EPOW event being reset. This patch avoids these

s/witout/without/

> multiple EPOW reset warnings by using a counter variable. This variable
> is incremented every time an EPOW event is reported. Upon receiving a EPOW
> reset event the same variable is checked to filer out spurious events and
> decremented accordingly.
> 
> This patch also improves log messages to better describe EPOW event being
> reported. Merged adjacent log messages into single one to reduce number of
> lines printed per event.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> ---
> v5 changes:
>    - Used num_epow_events counter variable to count number of epow_events
>    - Improved log messages to better describe epow event.
>    - Merged adjacent warnings into single lines.
> 
> v4 changes:
>    - Changed the approach to depth counter to match the EPOW events and
>      EPOW reset.
>    - Converted pr_err() ot pr_info() for non-critical errors.
>    - Merged adjacent warnings into single line across the file.
>    - Fixed grammar in the warnings to make is short.
> 
> v3 changes:
>    - Limit warning printed by EPOW RESET event, by guarding it with bool flag.
>      Instead of rate limiting all the EPOW events.
> 
> v2 changes:
>    - Merged multiple adjacent pr_err/pr_emerg into single line to reduce multi-line
>      warnings, based on Michael's comments.
> 
>  arch/powerpc/platforms/pseries/ras.c | 54 ++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index 3b6647e..bbe2856 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -40,6 +40,8 @@ static int ras_check_exception_token;
>  #define EPOW_SENSOR_TOKEN	9
>  #define EPOW_SENSOR_INDEX	0
>  
> +static int num_epow_events;
> +
>  static irqreturn_t ras_epow_interrupt(int irq, void *dev_id);
>  static irqreturn_t ras_error_interrupt(int irq, void *dev_id);
>  
> @@ -82,32 +84,30 @@ static void handle_system_shutdown(char event_modifier)
>  {
>  	switch (event_modifier) {
>  	case EPOW_SHUTDOWN_NORMAL:
> -		pr_emerg("Firmware initiated power off");
> +		pr_emerg("Power off requested\n");

Why are you changing this  message? These are FW initiated Power off and helps
us to identify who initiated shutdown request.

>  		orderly_poweroff(true);
>  		break;
>  
>  	case EPOW_SHUTDOWN_ON_UPS:
> -		pr_emerg("Loss of power reported by firmware, system is "
> -			"running on UPS/battery");
> -		pr_emerg("Check RTAS error log for details");
> +		pr_emerg("Loss of system power detected. System is running on"
> +			 " UPS/battery. Check RTAS error log for details\n");
>  		orderly_poweroff(true);
>  		break;
>  
>  	case EPOW_SHUTDOWN_LOSS_OF_CRITICAL_FUNCTIONS:
> -		pr_emerg("Loss of system critical functions reported by "
> -			"firmware");
> -		pr_emerg("Check RTAS error log for details");
> +		pr_emerg("Loss of system critical functions detected. Check"
> +			 " RTAS error log for details\n");
>  		orderly_poweroff(true);
>  		break;
>  
>  	case EPOW_SHUTDOWN_AMBIENT_TEMPERATURE_TOO_HIGH:
> -		pr_emerg("Ambient temperature too high reported by firmware");
> -		pr_emerg("Check RTAS error log for details");
> +		pr_emerg("High ambient temperature detected. Check RTAS"
> +			 " error log for details\n");
>  		orderly_poweroff(true);
>  		break;
>  
>  	default:
> -		pr_err("Unknown power/cooling shutdown event (modifier %d)",
> +		pr_err("Unknown power/cooling shutdown event (modifier = %d)\n",
>  			event_modifier);
>  	}
>  }
> @@ -145,40 +145,47 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
>  
>  	switch (action_code) {
>  	case EPOW_RESET:
> -		pr_err("Non critical power or cooling issue cleared");
> +		if (num_epow_events) {
> +			pr_info("Non critical power/cooling issue cleared\n");
> +			num_epow_events--;
> +		}
>  		break;
>  
>  	case EPOW_WARN_COOLING:
> -		pr_err("Non critical cooling issue reported by firmware");
> -		pr_err("Check RTAS error log for details");
> +		pr_info("Non-critical cooling issue detected. Check RTAS error"
> +			" log for details\n");
> +		num_epow_events++;

So every switch-case you are modifying this variable. Not sure this is the best way.
How about adding if condition after switch to modify this variable ?

-Vasant
