Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E2CD1A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 15:41:06 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0D212140083
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 15:41:06 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 15:41:04 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 220C83578048
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 15:41:02 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3S5esTq14156272
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 15:41:02 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3S5eSsp022859
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 15:40:28 +1000
Message-ID: <553F1D3A.7010505@linux.vnet.ibm.com>
Date: Tue, 28 Apr 2015 11:10:10 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] cpufreq: powernv: Register for OCC related
 opal_message notification
References: <1429722265-2953-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1429722265-2953-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <5538DE7E.1020805@linux.vnet.ibm.com>
In-Reply-To: <5538DE7E.1020805@linux.vnet.ibm.com>
Content-Type: text/plain; charset=iso-8859-6
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Preeti,

On 04/23/2015 05:28 PM, Preeti U Murthy wrote:
> Hi Shilpa,
> 
> On 04/22/2015 10:34 PM, Shilpasri G Bhat wrote:
>> OCC is an On-Chip-Controller which takes care of power and thermal
>> safety of the chip. During runtime due to power failure or
>> overtemperature the OCC may throttle the frequencies of the CPUs to
>> remain within the power budget.
>>
>> We want the cpufreq driver to be aware of such situations to be able
>> to report it to the user. We register to opal_message_notifier to
>> receive OCC messages from opal.
>>
>> powernv_cpufreq_throttle_check() reports any frequency throttling and
>> this patch will report the reason or event that caused throttling. We
>> can be throttled if OCC is reset or OCC limits Pmax due to power or
>> thermal reasons. We are also notified of unthrottling after an OCC
>> reset or if OCC restores Pmax on the chip.
>>
>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> CC: Viresh Kumar <viresh.kumar@linaro.org>
>> CC: linux-pm@vger.kernel.org
>> ---
>>  drivers/cpufreq/powernv-cpufreq.c | 70 ++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 69 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index ebef0d8..5718765 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -32,6 +32,7 @@
>>  #include <asm/firmware.h>
>>  #include <asm/reg.h>
>>  #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
>> +#include <asm/opal.h>
>>
>>  #define POWERNV_MAX_PSTATES	256
>>  #define PMSR_PSAFE_ENABLE	(1UL << 30)
>> @@ -40,7 +41,7 @@
>>  #define PMSR_LP(x)		((x >> 48) & 0xFF)
>>
>>  static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
>> -static bool rebooting, throttled;
>> +static bool rebooting, throttled, occ_reset;
>>
>>  /*
>>   * Note: The set of pstates consists of contiguous integers, the
>> @@ -395,6 +396,72 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>>  	.notifier_call = powernv_cpufreq_reboot_notifier,
>>  };
>>
>> +static char throttle_reason[6][50] = {	"No throttling",
>> +					"Power Cap",
>> +					"Processor Over Temperature",
>> +					"Power Supply Failure",
>> +					"OverCurrent",
>> +					"OCC Reset"
>> +				     };
>> +
>> +static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>> +		unsigned long msg_type, void *msg)
>> +{
>> +	struct opal_msg *occ_msg = msg;
>> +	uint64_t token;
>> +	uint64_t chip_id, reason;
>> +
>> +	if (msg_type != OPAL_MSG_OCC)
>> +		return 0;
>> +	token = be64_to_cpu(occ_msg->params[0]);
>> +	switch (token) {
>> +	case 0:
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
>> +		pr_info("OCC in Reset\n");
>> +		break;
>> +	case 1:
>> +		pr_info("OCC is Loaded\n");
>> +		break;
>> +	case 2:
> 
> You may want to replace the numbers with macros. Like
> OCC_RESET,OCC_LOAD, OCC_THROTTLE for better readability.

Okay will do.

> 
>> +		chip_id = be64_to_cpu(occ_msg->params[1]);
>> +		reason = be64_to_cpu(occ_msg->params[2]);
>> +		if (occ_reset) {
>> +			occ_reset = false;
>> +			throttled = false;
>> +			pr_info("OCC is Active\n");
>> +			/* Sanity check for static governors */
>> +			powernv_cpufreq_throttle_check(smp_processor_id());
>> +		} else if (reason) {
>> +			throttled = true;
>> +			pr_info("Pmax reduced due to %s on chip %x\n",
>> +					throttle_reason[reason], (int)chip_id);
>> +		} else {
>> +			throttled = false;
>> +			pr_info("%s on chip %x\n",
>> +					throttle_reason[reason], (int)chip_id);
> 
> Don't you need a powernv_cpufreq_throttle_check() here?  Or is it ok to
> rely on the OCC notification for unthrottle ?

Yes we need to check. Fixing this in v2.

Thanks and Regards,
Shilpa
