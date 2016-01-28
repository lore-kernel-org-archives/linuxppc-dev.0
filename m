Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 201DC1A030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 20:38:05 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E56A3140B94
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 20:38:04 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 28 Jan 2016 19:38:01 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0A9E62CE8054
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 20:37:57 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0S9bnt820512850
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 20:37:57 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0S9bOwe002483
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 20:37:24 +1100
Message-ID: <56A9E136.8090900@linux.vnet.ibm.com>
Date: Thu, 28 Jan 2016 15:06:54 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org,
 ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 bsingharora@gmail.com, mpe@ellerman.id.au, linux-api@vger.kernel.org
Subject: Re: [PATCH v7 6/6] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453965941-7363-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20160128084041.GK3935@vireshk>
In-Reply-To: <20160128084041.GK3935@vireshk>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Viresh,

On 01/28/2016 02:10 PM, Viresh Kumar wrote:
> On 28-01-16, 12:55, Shilpasri G Bhat wrote:
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index b683e8e..dea4620 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -271,3 +271,48 @@ Description:	Parameters for the CPU cache attributes
>>  			- WriteBack: data is written only to the cache line and
>>  				     the modified cache line is written to main
>>  				     memory only when it is replaced
>> +
>> +What:		/sys/devices/system/cpu/cpufreq/chip*/throttle_stats
> 
> What about the chip directory ? Shouldn't that be documented? And
> shouldn't that mention that this is just for powerpc ?
> 
> And before that, I don't think that you are doing this properly. I am
> sorry that I never came to a point where I could review it, and you
> continued with it, version after version.
> 
> But, I really have strong objections to the way this is done. And you
> are making things more complex then they are.
> 
> So, these stats are per-policy, right ?

First of all sorry about the version log.
No these stats are not per-policy. They are per-chip. The throttle event is
common for all cores in the chip.

> 
> Then why aren't they added on the policy->kobj instead, just like
> cpufreq-stats? And maybe inside cpufreq-stats folder only?
> 
> That will solve many complexities you have in place here and will look
> sane as well.
> 
> Right now, you have stats as two places, cpu/cpufreq/chip/ and
> cpu/cpuX/cpufreq/stats/, which doesn't look wise and adds to
> confusion.
> 
> What do you say?
> 

Yes agree that it will be much cleaner with policy->kobj. But using policy->kobj
will result in multiple copies of the throttle-chip stats exported for each
policy in the chip. And moving it to cpu/cpuX/cpufreq/stats/
will add a dependency on CONFIG_CPU_FREQ_STAT

We want throttle attributes to be either in cpu/cpufreq or cpu/cpuX/cpufreq. If
multiple copies is not an issue, then I will move it to cpu/cpuX/cpufreq.

Thanks and Regards,
Shilpa
