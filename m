Return-Path: <preeti@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2761D1A00C8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 17:06:48 +1100 (AEDT)
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 37F811401DA
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 17:06:46 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 16 Feb 2015 01:06:44 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id EC6B86E8040
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 00:58:34 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1G66h2L26804394
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 06:06:43 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1G66gEn001066
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2015 01:06:42 -0500
Message-ID: <54E188EA.3070600@linux.vnet.ibm.com>
Date: Mon, 16 Feb 2015 11:36:34 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: paulmck@linux.vnet.ibm.com
Subject: Re: suspicious RCU usage clockevents_lock, tick_broadcast_lock,
 hrtimer_bases.lock
References: <54DD4BF6.1070503@au1.ibm.com>
 <54DD8B37.2040903@linux.vnet.ibm.com> <54DDA645.6080600@linux.vnet.ibm.com>
 <20150213142603.GV4166@linux.vnet.ibm.com>
 <54E161B0.5020105@linux.vnet.ibm.com>
 <20150216055017.GE4166@linux.vnet.ibm.com>
In-Reply-To: <20150216055017.GE4166@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Sam Bobroff <sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/16/2015 11:20 AM, Paul E. McKenney wrote:
> On Mon, Feb 16, 2015 at 08:49:12AM +0530, Preeti U Murthy wrote:
>> On 02/13/2015 07:56 PM, Paul E. McKenney wrote:
>>> On Fri, Feb 13, 2015 at 12:52:45PM +0530, Preeti U Murthy wrote:
>>>> On 02/13/2015 10:57 AM, Preeti U Murthy wrote:
>>>>> On 02/13/2015 06:27 AM, Sam Bobroff wrote:
>>>>>> Hello,
>>>>>>
>>>>>> I'm receiving this while booting a vanilla 3.19 kernel on a Power 8 machine:
>>>>>
>>>>> Does the below patch fix the issue ?
>>>>>
>>>>> From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>>>>>
>>>>> [PATCH] tick/hrtimer-broadcast: Fix a suspicious RCU usage in the tick broadcast path
>>>>>
>>>>> ---
>>>>>  kernel/time/tick-broadcast-hrtimer.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
>>>>> index eb682d5..57b8e32 100644
>>>>> --- a/kernel/time/tick-broadcast-hrtimer.c
>>>>> +++ b/kernel/time/tick-broadcast-hrtimer.c
>>>>> @@ -62,7 +62,7 @@ static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
>>>>>          * HRTIMER_RESTART.
>>>>>          */
>>>>>         if (hrtimer_try_to_cancel(&bctimer) >= 0) {
>>>>> -               hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED);
>>>>> +               RCU_NONIDLE(hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED));
>>>>>                 /* Bind the "device" to the cpu */
>>>>>                 bc->bound_on = smp_processor_id();
>>>>>         } else if (bc->bound_on == smp_processor_id()) {
>>>>>
>>>> Actually the below patch is the complete fix. Paul can you please
>>>> review this ?  As an alternate solution I checked to see if its
>>>> possible to move rcu_idle_enter()/exit() closer to the
>>>> cpuidle_enter() call, but that won't work as you may have already
>>>> tried earlier.
>>>>
>>>> -----------------------------------------------------------------
>>>>
>>>> tick/broadcast-hrtimer : Fix suspicious RCU usage in idle loop
>>>>
>>>> From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>>>>
>>>> The hrtimer mode of broadcast queues hrtimers in the idle entry
>>>> path so as to wakeup cpus in deep idle states. hrtimer_{start/cancel}
>>>> functions call into tracing which uses RCU. But it is not legal to call
>>>> into RCU in cpuidle because it is one of the quiescent states. Hence
>>>> protect this region with RCU_NONIDLE which informs RCU that the cpu
>>>> is momentarily non-idle.
>>>>
>>>> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>>>
>>> Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>>>
>>> Another alternative would be to change the hrtimer_{start/cancel}()
>>> functions' tracepoints to the _rcuidle form.  The advantage of this
>>> approach is less RCU-notification overhead when tracing is enabled.
>>
>> But since the hrtimer_{start/cancel} functions' tracepoints are more
>> often called from paths which are in the non-quiescent states, wouldn't
>> we be doing an rcu_irq_enter/exit() redundantly far too often in that case ?
> 
> And the other advantage of doing it the way you did (and I -did- give
> you a Reviewed-by!) is that you are incurring the extra overhead from
> the idle loop, where that extra overhead is less likely to be holding
> something else up.  So, yes, I do agree with your patch.

Ok. I was just unsure which approach you meant by 'this' in the above
statement 'The advantage of this approach is less RCU-notification
overhead..'. Hence wanted to make sure that I had understood you right.
Alright, I'll send out this patch to tglx with your Reviewed-by then.

Thanks!

Regards
Preeti U Murthy

> 							Thanx, Paul
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
