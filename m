Return-Path: <pc@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD9621A01B2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 08:29:19 +1100 (AEDT)
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C7A44140B8C
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2015 08:29:18 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <pc@us.ibm.com>;
 Mon, 14 Dec 2015 16:29:16 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 1F16938C8039
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2015 16:29:12 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBELTBDK28311690
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2015 21:29:12 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBELTBMi031358
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2015 16:29:11 -0500
Subject: Re: [PATCH] cpufreq: powernv: Redesign the presentation of throttle
 notification
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
References: <1450030657-9121-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net
From: Paul Clarke <pc@us.ibm.com>
Message-ID: <566F34A6.4060709@us.ibm.com>
Date: Mon, 14 Dec 2015 15:29:10 -0600
MIME-Version: 1.0
In-Reply-To: <1450030657-9121-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/13/2015 12:17 PM, Shilpasri G Bhat wrote:
> Replace the throttling event console messages to perf trace event
> "power:powernv_throttle" and throttle counter stats which are
> exported in sysfs. The newly added sysfs files are as follows:
>
> 1)/sys/devices/system/node/node0/throttle_frequencies
>    This gives the throttle stats for each of the available frequencies.
>    The throttle stat of a frequency is the total number of times the max
>    frequency was reduced to that frequency.
>    # cat /sys/devices/system/node/node0/throttle_frequencies
>    4023000 0
>    3990000 0
>    3956000 1
>    3923000 0
>    3890000 0
>    3857000 2
>    3823000 0
>    3790000 0
>    3757000 2
>    3724000 1
>    3690000 1
>    ...

Is this data useful?  It seems like "elapsed time" at each frequency might be 
more useful, if any.

> 2)/sys/devices/system/node/node0/throttle_reasons
>    This gives the stats for each of the supported throttle reasons.
>    This gives the total number of times the frequency was throttled due
>    to each of the reasons.
>    # cat /sys/devices/system/node/node0/throttle_reasons
>    No throttling 7
>    Power Cap 0
>    Processor Over Temperature 7
>    Power Supply Failure 0
>    Over Current 0
>    OCC Reset 0
>
> 3)/sys/devices/system/node/node0/throttle_stat
>    This gives the total number of throttle events occurred in turbo
>    range of frequencies and non-turbo(below nominal) range of
>    frequencies.

non-turbo should read "at or below nominal".  Maybe "sub-turbo" is a better 
term(?)

>    # cat /sys/devices/system/node/node0/throttle_stat
>    Turbo 7
>    Nominal 0

Should this read "Non-turbo" or "Sub-turbo" instead of "Nominal", since the 
events could well occur when already operating below nominal.

> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>   drivers/cpufreq/powernv-cpufreq.c | 186 +++++++++++++++++++++++++++++---------
>   include/trace/events/power.h      |  22 +++++
>   2 files changed, 166 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index cb50138..bdde9d6 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -28,6 +28,9 @@
>   #include <linux/of.h>
>   #include <linux/reboot.h>
>   #include <linux/slab.h>
> +#include <trace/events/power.h>
> +#include <linux/device.h>
> +#include <linux/node.h>
>
>   #include <asm/cputhreads.h>
>   #include <asm/firmware.h>
> @@ -43,12 +46,27 @@
>   static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
>   static bool rebooting, throttled, occ_reset;
>
> +static char throttle_reason[][30] = {
> +					"No throttling",
> +					"Power Cap",
> +					"Processor Over Temperature",
> +					"Power Supply Failure",
> +					"Over Current",
> +					"OCC Reset"
> +				     };

I'm curious if this would be slightly more efficiently implemented as:
static const char *throttle_reason[] = { ... };

Do you need 30 characters per string for a reason?

Regardless, it should be const.

[...]
--
PC
