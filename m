Return-Path: <jallen@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41knJQ3h4ZzF3HL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 05:09:25 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w76J9G5U017666
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2018 15:09:22 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kpufr9rqa-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Aug 2018 15:09:22 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.ibm.com>;
 Mon, 6 Aug 2018 15:09:20 -0400
Date: Mon, 6 Aug 2018 14:09:17 -0500
From: John Allen <jallen@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
Subject: Re: [PATCH v2 1/2] powerpc/pseries: Avoid blocking rtas polling
 handling multiple PRRN events
References: <20180717194048.3057-1-jallen@linux.ibm.com>
 <20180717194048.3057-2-jallen@linux.ibm.com>
 <87muuihyjn.fsf@concordia.ellerman.id.au>
 <20180723150548.6syfciqtkohec66r@p50>
 <87lg9qfddo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <87lg9qfddo.fsf@concordia.ellerman.id.au>
Message-Id: <20180806190916.p5eqyuwjvevoipq5@p50.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2018 at 11:02:59PM +1000, Michael Ellerman wrote:
>Hi John,
>
>I'm still not sure about this one.
>
>John Allen <jallen@linux.ibm.com> writes:
>> On Mon, Jul 23, 2018 at 11:27:56PM +1000, Michael Ellerman wrote:
>>>Hi John,
>>>
>>>I'm a bit puzzled by this one.
>>>
>>>John Allen <jallen@linux.ibm.com> writes:
>>>> When a PRRN event is being handled and another PRRN event comes in, the
>>>> second event will block rtas polling waiting on the first to complete,
>>>> preventing any further rtas events from being handled. This can be
>>>> especially problematic in case that PRRN events are continuously being
>>>> queued in which case rtas polling gets indefinitely blocked completely.
>>>>
>>>> This patch introduces a mutex that prevents any subsequent PRRN events from
>>>> running while there is a prrn event being handled, allowing rtas polling to
>>>> continue normally.
>>>>
>>>> Signed-off-by: John Allen <jallen@linux.ibm.com>
>>>> ---
>>>> v2:
>>>>   -Unlock prrn_lock when PRRN operations are complete, not after handler is
>>>>    scheduled.
>>>>   -Remove call to flush_work, the previous broken method of serializing
>>>>    PRRN events.
>>>> ---
>>>>  arch/powerpc/kernel/rtasd.c | 10 +++++++---
>>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
>>>> index 44d66c33d59d..845fc5aec178 100644
>>>> --- a/arch/powerpc/kernel/rtasd.c
>>>> +++ b/arch/powerpc/kernel/rtasd.c
>>>> @@ -284,15 +286,17 @@ static void prrn_work_fn(struct work_struct *work)
>>>>  	 */
>>>>  	pseries_devicetree_update(-prrn_update_scope);
>>>>  	numa_update_cpu_topology(false);
>>>> +	mutex_unlock(&prrn_lock);
>>>>  }
>>>>
>>>>  static DECLARE_WORK(prrn_work, prrn_work_fn);
>>>>
>>>>  static void prrn_schedule_update(u32 scope)
>>>>  {
>>>> -	flush_work(&prrn_work);
>>>
>>>This seems like it's actually the core of the change. Previously we were
>>>basically blocking on the flush before continuing.
>>
>> The idea here is to replace the blocking flush_work with a non-blocking
>> mutex. So rather than waiting on the running PRRN event to complete, we
>> bail out since a PRRN event is already running.
>
>OK, but why is it OK to bail out?
>
>The firmware sent you an error log asking you to do something, with a
>scope value that has some meaning, and now you're just going to drop
>that on the floor?
>
>Maybe it is OK to just drop these events? Or maybe you're saying that
>because the system is crashing under the load of too many events it's OK
>to drop the events in this case.

I think I see your point. If a PRRN event comes in while another is 
currently running, the new one may contain a different list of LMBs/CPUs 
and the old list becomes outdated. With the mutex, the only event that 
gets handled is the oldest and we will lose any additional changes 
beyond the initial event. Therefore, as you mentioned in your previous 
message, the behavior of the global workqueue should work just fine once 
we remove the call to flush_work.  While a prrn event is running, only 
one will remain on the workqueue, then when the first one completes, the 
newly scheduled work function should grab the latest PRRN list.

I will send a new version of the patch with just the call to flush_work 
removed.

-John

>
>> The situation this is
>> meant to address is flooding the workqueue with PRRN events, which like
>> the situation in patch 2/2, these can be queued up faster than they can
>> actually be handled.
>
>I'm not really sure why this is a problem though.
>
>The current code synchronously processes the events, so there should
>only ever be one in flight.
>
>I guess the issue is that each one can queue multiple events on the
>hotplug work queue?
>
>But still, we have terabytes of RAM, we should be able to queue a lot
>of events before it becomes a problem.
>
>So what exactly is getting flooded, what's the symptom?
>
>If the queuing of the hotplug events is the problem, then why don't we
>stop doing that? We could just process them synchronously from the PRRN
>update, that would naturally throttle them.
>
>cheers
>
