Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05A061A077B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 03:15:49 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AF5CC140CAA
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Feb 2016 03:15:48 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 4 Feb 2016 02:15:47 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 331543578052
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Feb 2016 03:15:42 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13GFN1I51445792
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Feb 2016 03:15:31 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13GF9eC014731
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Feb 2016 03:15:09 +1100
Message-ID: <56B22779.3030605@linux.vnet.ibm.com>
Date: Wed, 03 Feb 2016 21:44:49 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: linuxppc-dev@ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 bsingharora@gmail.com, mpe@ellerman.id.au
Subject: Re: [PATCH v8 0/6] cpufreq: powernv: Redesign the presentation of
 throttle notification and solve bug-fixes in the driver
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAJZ5v0g28Px=KPa3uCW86w+u35CKkHd7rCrbTfxDjKHmcBuOEQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g28Px=KPa3uCW86w+u35CKkHd7rCrbTfxDjKHmcBuOEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Rafael,

On 02/03/2016 07:10 PM, Rafael J. Wysocki wrote:
> Hi,
> 
> On Tue, Feb 2, 2016 at 8:41 PM, Shilpasri G Bhat
> <shilpa.bhat@linux.vnet.ibm.com> wrote:
>> In POWER8, OCC(On-Chip-Controller) can throttle the frequency of the
>> CPU when the chip crosses its thermal and power limits. Currently,
>> powernv-cpufreq driver detects and reports this event as a console
>> message. Some machines may not sustain the max turbo frequency in all
>> conditions and can be throttled frequently. This can lead to the
>> flooding of console with throttle messages. So this patchset aims to
>> redesign the presentation of this event via sysfs counters and
>> tracepoints. And it also fixes couple of bugs reported in the driver.
>>
>> - Patch [1] fixes a memory leak bug
>> - Patch [2] fixes the cpu hot-plug bug in powernv_cpufreq_work_fn().
>> - Patch [3] solves a bug in powernv_cpufreq_throttle_check(), which
>>   calls in to cpu_to_chip_id() in hot path which reads DT every time
>>   to find the chip id.
>> - Patches [4] to [6] will add a perf trace point
>>   "power:powernv_throttle" and sysfs throttle counter stats in
>>   /sys/devices/system/cpu/cpufreq/chipN.
>>
>> Changes from v7:
>> - Changes in patch[6] involves adding a table to represent the
>>   throtle stats in frequency X reason layout. Detailed version log
>>   in the patch.
>>
>> Changes from v6:
>> - Changes wrt comments from Balbir Singh and Viresh Kumar. Details in
>>   the version log of the patches.
>>
>> Changes from v5:
>> - Fix kbuild error:
>> drivers/cpufreq/powernv-cpufreq.c:428:2: error: implicit declaration of
>> function 'get_online_cpus' [-Werror=implicit-function-declaration]
>>
>> Changes from v4:
>> - Fix a hot-plug bug in powernv_cpufreq_work_fn()
>> - Changes wrt Gautham's and Shreyas's comments
>>
>> Changes from v3:
>> - Add a fix to replace cpu_to_chip_id() with simpler PIR shift to
>>   obtain the chip id.
>> - Break patch2 in to two patches separating the tracepoint and sysfs
>>   attribute changes.
>>
>> Changes from v2:
>> - Fixed kbuild test warning.
>> drivers/cpufreq/powernv-cpufreq.c:609:2: warning: ignoring return
>> value of 'kstrtoint', declared with attribute warn_unused_result
>> [-Wunused-result]
>> Shilpasri G Bhat (6):
>>   cpufre: powernv: Free 'chips' on module exit
>>   cpufreq: powernv: Hot-plug safe the kworker thread
>>   cpufreq: powernv: Remove cpu_to_chip_id() from hot-path
>>   cpufreq: powernv/tracing: Add powernv_throttle tracepoint
>>   cpufreq: powernv: Replace pr_info with trace print for throttle event
>>   cpufreq: powernv: Add sysfs attributes to show throttle stats
> 
> It looks like patches [1-5/6] are not objectionable and I can apply
> them without the last one if you want me to.
> 

Yes please apply Patch[1-5]. Thanks.

Regards,
Shilpa
