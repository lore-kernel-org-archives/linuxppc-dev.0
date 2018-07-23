Return-Path: <jallen@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z4b65WX1zDqnK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 01:06:58 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6NF4DUk068813
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 11:06:54 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kdf3ve7as-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 11:06:52 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.ibm.com>;
 Mon, 23 Jul 2018 11:05:51 -0400
Date: Mon, 23 Jul 2018 10:05:48 -0500
From: John Allen <jallen@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
Subject: Re: [PATCH v2 1/2] powerpc/pseries: Avoid blocking rtas polling
 handling multiple PRRN events
References: <20180717194048.3057-1-jallen@linux.ibm.com>
 <20180717194048.3057-2-jallen@linux.ibm.com>
 <87muuihyjn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <87muuihyjn.fsf@concordia.ellerman.id.au>
Message-Id: <20180723150548.6syfciqtkohec66r@p50>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 23, 2018 at 11:27:56PM +1000, Michael Ellerman wrote:
>Hi John,
>
>I'm a bit puzzled by this one.
>
>John Allen <jallen@linux.ibm.com> writes:
>> When a PRRN event is being handled and another PRRN event comes in, the
>> second event will block rtas polling waiting on the first to complete,
>> preventing any further rtas events from being handled. This can be
>> especially problematic in case that PRRN events are continuously being
>> queued in which case rtas polling gets indefinitely blocked completely.
>>
>> This patch introduces a mutex that prevents any subsequent PRRN events from
>> running while there is a prrn event being handled, allowing rtas polling to
>> continue normally.
>>
>> Signed-off-by: John Allen <jallen@linux.ibm.com>
>> ---
>> v2:
>>   -Unlock prrn_lock when PRRN operations are complete, not after handler is
>>    scheduled.
>>   -Remove call to flush_work, the previous broken method of serializing
>>    PRRN events.
>> ---
>>  arch/powerpc/kernel/rtasd.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
>> index 44d66c33d59d..845fc5aec178 100644
>> --- a/arch/powerpc/kernel/rtasd.c
>> +++ b/arch/powerpc/kernel/rtasd.c
>> @@ -284,15 +286,17 @@ static void prrn_work_fn(struct work_struct *work)
>>  	 */
>>  	pseries_devicetree_update(-prrn_update_scope);
>>  	numa_update_cpu_topology(false);
>> +	mutex_unlock(&prrn_lock);
>>  }
>>
>>  static DECLARE_WORK(prrn_work, prrn_work_fn);
>>
>>  static void prrn_schedule_update(u32 scope)
>>  {
>> -	flush_work(&prrn_work);
>
>This seems like it's actually the core of the change. Previously we were
>basically blocking on the flush before continuing.

The idea here is to replace the blocking flush_work with a non-blocking 
mutex. So rather than waiting on the running PRRN event to complete, we 
bail out since a PRRN event is already running. The situation this is 
meant to address is flooding the workqueue with PRRN events, which like 
the situation in patch 2/2, these can be queued up faster than they can 
actually be handled.

>
>> -	prrn_update_scope = scope;
>
>I don't really understand the scope. With the old code we always ran the
>work function once for call, now we potentially throw away the scope
>value (if the try lock fails).

So anytime we actually want to run with the scope (in the event the 
trylock succeeds), we schedule the work with the scope value set 
accordingly as seen in the code below. In the case that we actually 
don't want to run a PRRN event (if one is already running) we do throw 
away the scope and ignore the request entirely.

>
>> -	schedule_work(&prrn_work);
>> +	if (mutex_trylock(&prrn_lock)) {
>> +		prrn_update_scope = scope;
>> +		schedule_work(&prrn_work);
>> +	}
>
>Ignoring the scope, the addition of the mutex should not actually make
>any difference. If you see the doco for schedule_work() it says:
>
> * This puts a job in the kernel-global workqueue if it was not already
> * queued and leaves it in the same position on the kernel-global
> * workqueue otherwise.
>
>
>So the mutex basically implements that existing behaviour. But maybe the
>scope is the issue? Like I said I don't really understand the scope
>value.
>
>
>So I guess I'm wondering if we just need to drop the flush_work() and
>the rest is not required?

To sum up the above, the behavior without the mutex is not the same as 
with the mutex. Without the mutex, that means that anytime we get a PRRN 
event, it will get queued on the workqueue which can get flooded if PRRN 
events are queued continuously. With the mutex, only one PRRN event can 
be queued for handling at once.

Hope that clears things up!

-John

>
>cheers
>
