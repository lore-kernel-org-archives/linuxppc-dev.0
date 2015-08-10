Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70A651A1D48
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 11:41:18 +1000 (AEST)
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B53781401CD
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 11:41:17 +1000 (AEST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Sun, 9 Aug 2015 19:41:15 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 4B3CC3E4003F
 for <linuxppc-dev@ozlabs.org>; Sun,  9 Aug 2015 19:41:12 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7A1cSDA44171496
 for <linuxppc-dev@ozlabs.org>; Sun, 9 Aug 2015 18:38:28 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7A1fBld031367
 for <linuxppc-dev@ozlabs.org>; Sun, 9 Aug 2015 19:41:12 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, joel@jms.id.au,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 3/6] cpufreq: powernv: Register for OCC related
 opal_message notification
In-Reply-To: <1437033863-15864-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1437033863-15864-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date: Mon, 10 Aug 2015 11:41:09 +1000
Message-ID: <m3y4hjex8q.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index d0c18c9..a634199 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -33,6 +33,7 @@
>  #include <asm/firmware.h>
>  #include <asm/reg.h>
>  #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
> +#include <asm/opal.h>
>  
>  #define POWERNV_MAX_PSTATES	256
>  #define PMSR_PSAFE_ENABLE	(1UL << 30)
> @@ -41,7 +42,7 @@
>  #define PMSR_LP(x)		((x >> 48) & 0xFF)
>  
>  static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
> -static bool rebooting, throttled;
> +static bool rebooting, throttled, occ_reset;
>  
>  static struct chip {
>  	unsigned int id;
> @@ -414,6 +415,74 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>  	.notifier_call = powernv_cpufreq_reboot_notifier,
>  };
>  
> +static char throttle_reason[][30] = {
> +					"No throttling",
> +					"Power Cap",
> +					"Processor Over Temperature",
> +					"Power Supply Failure",
> +					"Over Current",
> +					"OCC Reset"
> +				     };
> +
> +static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
> +				   unsigned long msg_type, void *_msg)
> +{
> +	struct opal_msg *msg = _msg;
> +	struct opal_occ_msg omsg;
> +
> +	if (msg_type != OPAL_MSG_OCC)
> +		return 0;
> +
> +	omsg.type = be64_to_cpu(msg->params[0]);
> +
> +	switch (omsg.type) {
> +	case OCC_RESET:
> +		occ_reset = true;
> +		/*
> +		 * powernv_cpufreq_throttle_check() is called in
> +		 * target() callback which can detect the throttle state
> +		 * for governors like ondemand.
> +		 * But static governors will not call target() often thus
> +		 * report throttling here.
> +		 */
> +		if (!throttled) {
> +			throttled = true;
> +			pr_crit("CPU Frequency is throttled\n");
> +		}
> +		pr_info("OCC: Reset\n");
> +		break;
> +	case OCC_LOAD:
> +		pr_info("OCC: Loaded\n");
> +		break;

I wonder if we could have the log messages be a bit clearer here, odds
are, unless you're one of the people reading this code, you have no idea
what an OCC is or what on earth "OCC: Loaded" means and why this
*doesn't* mean that your CPUs are no longer throttled so that your
computer doesn't catch fire/break/add 1+1 and get 4.

Also, do we export this information via sysfs somewhere? It would seem
to want to go along with other cpufreq/cpu info there.

It feels like we could do much better at informing users as to what is
going on.... maybe something like:

"OCC (On Chip Controller - enforces hard thermal/power limits) Resetting: CPU frequency throttled for duration"
"OCC Loading, CPU frequency throttled until OCC started"
"OCC Active, CPU frequency no longer throttled"
