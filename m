Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gYQ24j55zF10S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 23:03:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: John Allen <jallen@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
Subject: Re: [PATCH v2 1/2] powerpc/pseries: Avoid blocking rtas polling
 handling multiple PRRN events
In-Reply-To: <20180723150548.6syfciqtkohec66r@p50>
References: <20180717194048.3057-1-jallen@linux.ibm.com>
 <20180717194048.3057-2-jallen@linux.ibm.com>
 <87muuihyjn.fsf@concordia.ellerman.id.au>
 <20180723150548.6syfciqtkohec66r@p50>
Date: Wed, 01 Aug 2018 23:02:59 +1000
Message-ID: <87lg9qfddo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi John,

I'm still not sure about this one.

John Allen <jallen@linux.ibm.com> writes:
> On Mon, Jul 23, 2018 at 11:27:56PM +1000, Michael Ellerman wrote:
>>Hi John,
>>
>>I'm a bit puzzled by this one.
>>
>>John Allen <jallen@linux.ibm.com> writes:
>>> When a PRRN event is being handled and another PRRN event comes in, the
>>> second event will block rtas polling waiting on the first to complete,
>>> preventing any further rtas events from being handled. This can be
>>> especially problematic in case that PRRN events are continuously being
>>> queued in which case rtas polling gets indefinitely blocked completely.
>>>
>>> This patch introduces a mutex that prevents any subsequent PRRN events from
>>> running while there is a prrn event being handled, allowing rtas polling to
>>> continue normally.
>>>
>>> Signed-off-by: John Allen <jallen@linux.ibm.com>
>>> ---
>>> v2:
>>>   -Unlock prrn_lock when PRRN operations are complete, not after handler is
>>>    scheduled.
>>>   -Remove call to flush_work, the previous broken method of serializing
>>>    PRRN events.
>>> ---
>>>  arch/powerpc/kernel/rtasd.c | 10 +++++++---
>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
>>> index 44d66c33d59d..845fc5aec178 100644
>>> --- a/arch/powerpc/kernel/rtasd.c
>>> +++ b/arch/powerpc/kernel/rtasd.c
>>> @@ -284,15 +286,17 @@ static void prrn_work_fn(struct work_struct *work)
>>>  	 */
>>>  	pseries_devicetree_update(-prrn_update_scope);
>>>  	numa_update_cpu_topology(false);
>>> +	mutex_unlock(&prrn_lock);
>>>  }
>>>
>>>  static DECLARE_WORK(prrn_work, prrn_work_fn);
>>>
>>>  static void prrn_schedule_update(u32 scope)
>>>  {
>>> -	flush_work(&prrn_work);
>>
>>This seems like it's actually the core of the change. Previously we were
>>basically blocking on the flush before continuing.
>
> The idea here is to replace the blocking flush_work with a non-blocking 
> mutex. So rather than waiting on the running PRRN event to complete, we 
> bail out since a PRRN event is already running.

OK, but why is it OK to bail out?

The firmware sent you an error log asking you to do something, with a
scope value that has some meaning, and now you're just going to drop
that on the floor?

Maybe it is OK to just drop these events? Or maybe you're saying that
because the system is crashing under the load of too many events it's OK
to drop the events in this case.

> The situation this is 
> meant to address is flooding the workqueue with PRRN events, which like 
> the situation in patch 2/2, these can be queued up faster than they can 
> actually be handled.

I'm not really sure why this is a problem though.

The current code synchronously processes the events, so there should
only ever be one in flight.

I guess the issue is that each one can queue multiple events on the
hotplug work queue?

But still, we have terabytes of RAM, we should be able to queue a lot
of events before it becomes a problem.

So what exactly is getting flooded, what's the symptom?

If the queuing of the hotplug events is the problem, then why don't we
stop doing that? We could just process them synchronously from the PRRN
update, that would naturally throttle them.

cheers
