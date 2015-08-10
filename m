Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 129F81A03BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 17:51:34 +1000 (AEST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 598431401AF
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 17:51:33 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 10 Aug 2015 13:21:31 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C3984E005C
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 13:25:43 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7A7pLgO48169042
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 13:21:22 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7A7pLgS016917
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 13:21:21 +0530
Message-ID: <55C857F8.6090502@linux.vnet.ibm.com>
Date: Mon, 10 Aug 2015 13:21:20 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, rjw@rjwysocki.net
CC: linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, joel@jms.id.au
Subject: Re: [PATCH v5 3/6] cpufreq: powernv: Register for OCC related
 opal_message notification
References: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1437033863-15864-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <m3y4hjex8q.fsf@oc8180480414.ibm.com>
In-Reply-To: <m3y4hjex8q.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/10/2015 07:11 AM, Stewart Smith wrote:
> Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index d0c18c9..a634199 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -33,6 +33,7 @@
>>  #include <asm/firmware.h>
>>  #include <asm/reg.h>
>>  #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
>> +#include <asm/opal.h>
>>  
>>  #define POWERNV_MAX_PSTATES	256
>>  #define PMSR_PSAFE_ENABLE	(1UL << 30)
>> @@ -41,7 +42,7 @@
>>  #define PMSR_LP(x)		((x >> 48) & 0xFF)
>>  
>>  static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
>> -static bool rebooting, throttled;
>> +static bool rebooting, throttled, occ_reset;
>>  
>>  static struct chip {
>>  	unsigned int id;
>> @@ -414,6 +415,74 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>>  	.notifier_call = powernv_cpufreq_reboot_notifier,
>>  };
>>  
>> +static char throttle_reason[][30] = {
>> +					"No throttling",
>> +					"Power Cap",
>> +					"Processor Over Temperature",
>> +					"Power Supply Failure",
>> +					"Over Current",
>> +					"OCC Reset"
>> +				     };
>> +
>> +static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>> +				   unsigned long msg_type, void *_msg)
>> +{
>> +	struct opal_msg *msg = _msg;
>> +	struct opal_occ_msg omsg;
>> +
>> +	if (msg_type != OPAL_MSG_OCC)
>> +		return 0;
>> +
>> +	omsg.type = be64_to_cpu(msg->params[0]);
>> +
>> +	switch (omsg.type) {
>> +	case OCC_RESET:
>> +		occ_reset = true;
>> +		/*
>> +		 * powernv_cpufreq_throttle_check() is called in
>> +		 * target() callback which can detect the throttle state
>> +		 * for governors like ondemand.
>> +		 * But static governors will not call target() often thus
>> +		 * report throttling here.
>> +		 */
>> +		if (!throttled) {
>> +			throttled = true;
>> +			pr_crit("CPU Frequency is throttled\n");
>> +		}
>> +		pr_info("OCC: Reset\n");
>> +		break;
>> +	case OCC_LOAD:
>> +		pr_info("OCC: Loaded\n");
>> +		break;
> 
> I wonder if we could have the log messages be a bit clearer here, odds
> are, unless you're one of the people reading this code, you have no idea
> what an OCC is or what on earth "OCC: Loaded" means and why this
> *doesn't* mean that your CPUs are no longer throttled so that your
> computer doesn't catch fire/break/add 1+1 and get 4.
> 
> Also, do we export this information via sysfs somewhere? It would seem
> to want to go along with other cpufreq/cpu info there.

No we don't export the throttling status of the cpu via sysfs. Since the
throttling state is common across the chip, the per_cpu export will be
redundant. Did you mean something like one of the below:

1)/sys/devices/system/cpu/cpufreq/chipN_throttle

2)/sys/devices/system/cpu/cpuN/cpufreq/throttle

> 
> It feels like we could do much better at informing users as to what is
> going on.... maybe something like:
> 
> "OCC (On Chip Controller - enforces hard thermal/power limits) Resetting: CPU frequency throttled for duration"
> "OCC Loading, CPU frequency throttled until OCC started"
> "OCC Active, CPU frequency no longer throttled"
> 

Okay will change the messages.

Thanks and Regards,
Shilpa
