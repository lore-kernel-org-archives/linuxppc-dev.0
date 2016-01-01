Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AC9D1A0174
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jan 2016 09:41:27 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 38506140B96
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Jan 2016 09:41:27 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Sat, 2 Jan 2016 08:41:25 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 989292BB0052
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Jan 2016 09:41:22 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u01MfELe63832182
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Jan 2016 09:41:22 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u01Menow031981
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Jan 2016 09:40:50 +1100
Message-ID: <5687005E.602@linux.vnet.ibm.com>
Date: Sat, 02 Jan 2016 04:10:30 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Clarke <pc@us.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
CC: viresh.kumar@linaro.org, rjw@rjwysocki.net
Subject: Re: [PATCH] cpufreq: powernv: Redesign the presentation of throttle
 notification
References: <1450030657-9121-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <566F34A6.4060709@us.ibm.com>
In-Reply-To: <566F34A6.4060709@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 12/15/2015 02:59 AM, Paul Clarke wrote:
> On 12/13/2015 12:17 PM, Shilpasri G Bhat wrote:
>> Replace the throttling event console messages to perf trace event
>> "power:powernv_throttle" and throttle counter stats which are
>> exported in sysfs. The newly added sysfs files are as follows:
>>
>> 1)/sys/devices/system/node/node0/throttle_frequencies
>>    This gives the throttle stats for each of the available frequencies.
>>    The throttle stat of a frequency is the total number of times the max
>>    frequency was reduced to that frequency.
>>    # cat /sys/devices/system/node/node0/throttle_frequencies
>>    4023000 0
>>    3990000 0
>>    3956000 1
>>    3923000 0
>>    3890000 0
>>    3857000 2
>>    3823000 0
>>    3790000 0
>>    3757000 2
>>    3724000 1
>>    3690000 1
>>    ...
> 
> Is this data useful?  It seems like "elapsed time" at each frequency might be
> more useful, if any.
> 

Yes elapsed time is more useful data here. But the concern here is with the
accuracy of measurement/observation of elapsed time by the kernel. OCC can
throttle/unthrottle the frequency at the granularity of 250us. Although OCC
updates the throttle status to HOMER region immediately there may be a delay in
propagating this message by the opal-poller to the driver.

So instead we might want OCC to give us the throttled elapsed time stat for each
frequency and opal-poller/driver can take the snapshot of this info every n seconds.

>> 2)/sys/devices/system/node/node0/throttle_reasons
>>    This gives the stats for each of the supported throttle reasons.
>>    This gives the total number of times the frequency was throttled due
>>    to each of the reasons.
>>    # cat /sys/devices/system/node/node0/throttle_reasons
>>    No throttling 7
>>    Power Cap 0
>>    Processor Over Temperature 7
>>    Power Supply Failure 0
>>    Over Current 0
>>    OCC Reset 0
>>
>> 3)/sys/devices/system/node/node0/throttle_stat
>>    This gives the total number of throttle events occurred in turbo
>>    range of frequencies and non-turbo(below nominal) range of
>>    frequencies.
> 
> non-turbo should read "at or below nominal".  Maybe "sub-turbo" is a better term(?)
> 
>>    # cat /sys/devices/system/node/node0/throttle_stat
>>    Turbo 7
>>    Nominal 0
> 
> Should this read "Non-turbo" or "Sub-turbo" instead of "Nominal", since the
> events could well occur when already operating below nominal.
> 

Agree. Applied 'sub-turbo' in v2

>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> ---
>>   drivers/cpufreq/powernv-cpufreq.c | 186 +++++++++++++++++++++++++++++---------
>>   include/trace/events/power.h      |  22 +++++
>>   2 files changed, 166 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c
>> b/drivers/cpufreq/powernv-cpufreq.c
>> index cb50138..bdde9d6 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -28,6 +28,9 @@
>>   #include <linux/of.h>
>>   #include <linux/reboot.h>
>>   #include <linux/slab.h>
>> +#include <trace/events/power.h>
>> +#include <linux/device.h>
>> +#include <linux/node.h>
>>
>>   #include <asm/cputhreads.h>
>>   #include <asm/firmware.h>
>> @@ -43,12 +46,27 @@
>>   static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
>>   static bool rebooting, throttled, occ_reset;
>>
>> +static char throttle_reason[][30] = {
>> +                    "No throttling",
>> +                    "Power Cap",
>> +                    "Processor Over Temperature",
>> +                    "Power Supply Failure",
>> +                    "Over Current",
>> +                    "OCC Reset"
>> +                     };
> 
> I'm curious if this would be slightly more efficiently implemented as:
> static const char *throttle_reason[] = { ... };
> 
> Do you need 30 characters per string for a reason?
> 
> Regardless, it should be const.

Modified the declaration in v2 version of the patch.

> 
> [...]
> -- 
> PC

Thanks and Regards,
Shilpa
