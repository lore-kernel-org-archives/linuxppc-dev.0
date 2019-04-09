Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4C2C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 09:32:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC31F20833
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 09:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC31F20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dhs04613zDqGM
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 19:32:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=huntbag@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dhnJ4g5gzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 19:29:08 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x399RdTl098882
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Apr 2019 05:29:04 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rrrsj025h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 05:29:03 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <huntbag@linux.vnet.ibm.com>;
 Tue, 9 Apr 2019 10:29:00 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 9 Apr 2019 10:28:57 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x399Sun927656238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Apr 2019 09:28:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1545A405B;
 Tue,  9 Apr 2019 09:28:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1033FA4054;
 Tue,  9 Apr 2019 09:28:55 +0000 (GMT)
Received: from oc0383214508.ibm.com (unknown [9.124.35.65])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  9 Apr 2019 09:28:54 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] cpuidle : auto-promotion for cpuidle states
To: Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
References: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com>
 <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
 <87r2acwpp2.fsf@dja-thinkpad.axtens.net>
From: Abhishek <huntbag@linux.vnet.ibm.com>
Date: Tue, 9 Apr 2019 14:58:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87r2acwpp2.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19040909-0012-0000-0000-0000030CD81C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040909-0013-0000-0000-00002144F7AF
Message-Id: <a8368cfa-9667-5f5b-cafe-f4830ece0f26@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-09_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090061
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: daniel.lezcano@linaro.org, rjw@rjwysocki.net, ego@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Daniel,

Thanks for such a descriptive review. I will include all the suggestions 
made in my next iteration.

--Abhishek

On 04/08/2019 07:42 PM, Daniel Axtens wrote:
> Hi Abhishek,
>
>> Currently, the cpuidle governors (menu /ladder) determine what idle state
>> an idling CPU should enter into based on heuristics that depend on the
>> idle history on that CPU. Given that no predictive heuristic is perfect,
>> there are cases where the governor predicts a shallow idle state, hoping
>> that the CPU will be busy soon. However, if no new workload is scheduled
>> on that CPU in the near future, the CPU will end up in the shallow state.
>>
>> In case of POWER, this is problematic, when the predicted state in the
>> aforementioned scenario is a lite stop state, as such lite states will
>> inhibit SMT folding, thereby depriving the other threads in the core from
>> using the core resources.
>>
>> To address this, such lite states need to be autopromoted. The cpuidle-
>> core can queue timer to correspond with the residency value of the next
>> available state. Thus leading to auto-promotion to a deeper idle state as
>> soon as possible.
>>
> This sounds sensible to me, although I'm not really qualified to offer a
> full power-management opinion on it. I have some general code questions
> and comments, however, which are below:
>
>> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
>> ---
>>
>> v1->v2 : Removed timeout_needed and rebased to current upstream kernel
>>
>>   drivers/cpuidle/cpuidle.c          | 68 +++++++++++++++++++++++++++++-
>>   drivers/cpuidle/governors/ladder.c |  3 +-
>>   drivers/cpuidle/governors/menu.c   | 22 +++++++++-
>>   include/linux/cpuidle.h            | 10 ++++-
>>   4 files changed, 99 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 7f108309e..11ce43f19 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -36,6 +36,11 @@ static int enabled_devices;
>>   static int off __read_mostly;
>>   static int initialized __read_mostly;
>>   
>> +struct auto_promotion {
>> +	struct hrtimer  hrtimer;
>> +	unsigned long	timeout_us;
>> +};
>> +
>>   int cpuidle_disabled(void)
>>   {
>>   	return off;
>> @@ -188,6 +193,54 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>>   }
>>   #endif /* CONFIG_SUSPEND */
>>   
>> +enum hrtimer_restart auto_promotion_hrtimer_callback(struct hrtimer *hrtimer)
>> +{
>> +	return HRTIMER_NORESTART;
>> +}
>> +
>> +#ifdef CONFIG_CPU_IDLE_AUTO_PROMOTION
> As far as I can tell, this config flag isn't defined until the next
> patch, making this dead code for now. Is this intentional?
>
>> +DEFINE_PER_CPU(struct auto_promotion, ap);
> A quick grep suggests that most per-cpu variable have more descriptive
> names, perhaps this one should too.
>
>> +
>> +static void cpuidle_auto_promotion_start(int cpu, struct cpuidle_state *state)
>> +{
>> +	struct auto_promotion *this_ap = &per_cpu(ap, cpu);
>> +
>> +	if (state->flags & CPUIDLE_FLAG_AUTO_PROMOTION)
>> +		hrtimer_start(&this_ap->hrtimer, ns_to_ktime(this_ap->timeout_us
>> +					* 1000), HRTIMER_MODE_REL_PINNED);
> Would it be clearer to have both sides of the multiplication on the same
> line? i.e.
> +		hrtimer_start(&this_ap->hrtimer,
> +			      ns_to_ktime(this_ap->timeout_us * 1000),
> +			      HRTIMER_MODE_REL_PINNED);
>
>> +}
>> +
>> +static void cpuidle_auto_promotion_cancel(int cpu)
>> +{
>> +	struct hrtimer *hrtimer;
>> +
>> +	hrtimer = &per_cpu(ap, cpu).hrtimer;
>> +	if (hrtimer_is_queued(hrtimer))
>> +		hrtimer_cancel(hrtimer);
>> +}
>> +
>> +static void cpuidle_auto_promotion_update(int cpu, unsigned long timeout)
>> +{
>> +	per_cpu(ap, cpu).timeout_us = timeout;
>> +}
>> +
>> +static void cpuidle_auto_promotion_init(int cpu, struct cpuidle_driver *drv)
>> +{
>> +	struct auto_promotion *this_ap = &per_cpu(ap, cpu);
>> +
>> +	hrtimer_init(&this_ap->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +	this_ap->hrtimer.function = auto_promotion_hrtimer_callback;
>> +}
>> +#else
>> +static inline void cpuidle_auto_promotion_start(int cpu, struct cpuidle_state
>> +						*state) { }
>> +static inline void cpuidle_auto_promotion_cancel(int cpu) { }
>> +static inline void cpuidle_auto_promotion_update(int cpu, unsigned long
>> +						timeout) { }
>> +static inline void cpuidle_auto_promotion_init(int cpu, struct cpuidle_driver
>> +						*drv) { }
> Several of these have the type, then a line break, and then the name
> (unsigned long\n  timeout). This is a bit harder to read, they should
> probably all be on the same line.
>
>> +#endif
>> +
>>   /**
>>    * cpuidle_enter_state - enter the state and update stats
>>    * @dev: cpuidle device for this cpu
>> @@ -225,12 +278,17 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>>   	trace_cpu_idle_rcuidle(index, dev->cpu);
>>   	time_start = ns_to_ktime(local_clock());
>>   
>> +	cpuidle_auto_promotion_start(dev->cpu, target_state);
>> +
>>   	stop_critical_timings();
>>   	entered_state = target_state->enter(dev, drv, index);
>>   	start_critical_timings();
>>   
>>   	sched_clock_idle_wakeup_event();
>>   	time_end = ns_to_ktime(local_clock());
>> +
>> +	cpuidle_auto_promotion_cancel(dev->cpu);
>> +
>>   	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
>>   
>>   	/* The cpu is no longer idle or about to enter idle. */
>> @@ -312,7 +370,13 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>>   int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>   		   bool *stop_tick)
>>   {
>> -	return cpuidle_curr_governor->select(drv, dev, stop_tick);
>> +	unsigned long timeout_us, ret;
>> +
>> +	timeout_us = UINT_MAX;
>> +	ret = cpuidle_curr_governor->select(drv, dev, stop_tick, &timeout_us);
>> +	cpuidle_auto_promotion_update(dev->cpu, timeout_us);
>> +
>> +	return ret;
>>   }
>>   
>>   /**
>> @@ -658,6 +722,8 @@ int cpuidle_register(struct cpuidle_driver *drv,
>>   		device = &per_cpu(cpuidle_dev, cpu);
>>   		device->cpu = cpu;
>>   
>> +		cpuidle_auto_promotion_init(cpu, drv);
>> +
>>   #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>>   		/*
>>   		 * On multiplatform for ARM, the coupled idle states could be
>> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
>> index f0dddc66a..65b518dd7 100644
>> --- a/drivers/cpuidle/governors/ladder.c
>> +++ b/drivers/cpuidle/governors/ladder.c
>> @@ -64,7 +64,8 @@ static inline void ladder_do_selection(struct ladder_device *ldev,
>>    * @dummy: not used
> I think you need an addition to the docstring for your new variable.
>
>>    */
>>   static int ladder_select_state(struct cpuidle_driver *drv,
>> -			       struct cpuidle_device *dev, bool *dummy)
>> +			       struct cpuidle_device *dev, bool *dummy,
>> +			       unsigned long *unused)
>>   {
>>   	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
>>   	struct ladder_device_state *last_state;
>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
>> index 5951604e7..835e337de 100644
>> --- a/drivers/cpuidle/governors/menu.c
>> +++ b/drivers/cpuidle/governors/menu.c
>> @@ -276,7 +276,7 @@ static unsigned int get_typical_interval(struct menu_device *data,
>>    * @stop_tick: indication on whether or not to stop the tick
> Likewise here.
>
>>    */
>>   static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>> -		       bool *stop_tick)
>> +		       bool *stop_tick, unsigned long *timeout)
>>   {
>>   	struct menu_device *data = this_cpu_ptr(&menu_devices);
>>   	int latency_req = cpuidle_governor_latency_req(dev->cpu);
>> @@ -442,6 +442,26 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>   		}
>>   	}
>>   
>> +#ifdef CPUIDLE_FLAG_AUTO_PROMOTION
>> +	if (drv->states[idx].flags & CPUIDLE_FLAG_AUTO_PROMOTION) {
>> +		/*
>> +		 * Timeout is intended to be defined as sum of target residency
>> +		 * of next available state, entry latency and exit latency. If
>> +		 * time interval equal to timeout is spent in current state,
>> +		 * and if it is a shallow lite state, we may want to auto-
>> +		 * promote from such state.
> This comment makes sense if you already understand auto-promotion. That's
> fair enough - you wrote it and you presumably understand what your code
> does :) But for me it's a bit confusing! I think you want to start with
> a sentence about what autopromotion is (preferably not using
> power-specific terminology) and then explain the calculation of the
> timeouts.
>
>> +		 */
>> +		for (i = idx + 1; i < drv->state_count; i++) {
>> +			if (drv->states[i].disabled ||
>> +					dev->states_usage[i].disable)
>> +				continue;
>> +			*timeout = drv->states[i].target_residency +
>> +					2 * drv->states[i].exit_latency;
>> +			break;
>> +		}
>> +	}
>> +#endif
>> +
>>   	return idx;
>>   }
>>   
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index 3b3947232..84d76d1ec 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -72,6 +72,13 @@ struct cpuidle_state {
>>   #define CPUIDLE_FLAG_POLLING	BIT(0) /* polling state */
>>   #define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
>>   #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
>> +/*
>> + * State with only and only fast state bit set don't even lose user context.
> "only and only"?
>> + * But such states prevent other sibling threads from thread folding benefits.
>> + * And hence we don't want to stay for too long in such states and want to
>> + * auto-promote from it.
> I think this comment mixes Power-specific and generic concepts. (But I'm
> not a PM expert so tell me if I'm wrong here.) I think, if I've
> understood correctly: in the generic code, the bit represents a state
> that we do not want to linger in, which we want to definitely leave
> after some time. On Power, we have a state that doesn't lose user
> context but which prevents thread folding, so this is an example of a
> state where we want to auto-promote.
>
>> + */
>> +#define CPUIDLE_FLAG_AUTO_PROMOTION	BIT(3)
>>   
>>   struct cpuidle_device_kobj;
>>   struct cpuidle_state_kobj;
>> @@ -243,7 +250,8 @@ struct cpuidle_governor {
>>   
>>   	int  (*select)		(struct cpuidle_driver *drv,
>>   					struct cpuidle_device *dev,
>> -					bool *stop_tick);
>> +					bool *stop_tick, unsigned long
>> +					*timeout);
>>   	void (*reflect)		(struct cpuidle_device *dev, int index);
>>   };
>>   
>> -- 
>> 2.17.1

