Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB1051A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 14:05:52 +1000 (AEST)
In-Reply-To: <1436934126-9273-1-git-send-email-kamalesh@linux.vnet.ibm.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: vipin@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RESEND,v3] powerpc/pseries: Limit EPOW reset event warnings
Message-Id: <20150716040552.BBCEC1402C2@ozlabs.org>
Date: Thu, 16 Jul 2015 14:05:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-15-07 at 04:22:06 UTC, Kamalesh Babulal wrote:
> Kernel prints respective warnings about various EPOW events for
> user information/action after parsing EPOW interrupts.Prompting
> user to take action depending upon the severity of the event.
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

Why are we even getting these reset events when nothing has happened?

> Also, merged adjacent pr_err/pr_emerg into single one to reduce
> the number of lines printed per warning.
> 
> Suggested-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> [Vipin: edited the changelog]
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
>  arch/powerpc/platforms/pseries/ras.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index 02e4a17..b30396a 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -40,6 +40,9 @@ static int ras_check_exception_token;
>  #define EPOW_SENSOR_TOKEN	9
>  #define EPOW_SENSOR_INDEX	0
>  
> +/* Flag to limit EPOW RESET warning. */
> +static bool epow_state;

This name is terrible, it doesn't give me any hint to what it means.

But really it should be a counter, not a boolean.

We could have multiple EPOW events come in and then later get the reset events
for them, couldn't we?


So what about:

static unsigned epow_event_depth;

And then below:

> @@ -145,21 +148,27 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
>  

	epow_event_depth++;

  	switch (action_code) {
  	case EPOW_RESET:
		if (epow_event_depth)
			epow_event_depth--;

		if (epow_event_depth)
> +			pr_err("Non critical power or cooling issue cleared");

>  		break;


And that's all you need.


>  	case EPOW_WARN_COOLING:
> -		pr_err("Non critical cooling issue reported by firmware");
> -		pr_err("Check RTAS error log for details");
> +		pr_err("Non critical cooling issue reported by firmware, "
> +		       "Check RTAS error log for details");

This should be:

		pr_err("Non-critical cooling issue reported by firmware, check RTAS error log for details.\n");

But that's too long, so how about:

		pr_err("Non-critical cooling issue reported, check RTAS error log for details.\n");

And if it's non-critical it shouldn't be pr_err(), it should be pr_info().

Similarly for all the other messages.


cheers
