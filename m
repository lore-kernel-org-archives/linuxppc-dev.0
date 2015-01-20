Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65C971A00FB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 22:25:21 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 20 Jan 2015 06:25:18 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 2C5A3C90041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 06:16:28 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0KBPFH825821320
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 11:25:16 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0KBPF63005389
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 06:25:15 -0500
Message-ID: <54BE3B0E.2050502@linux.vnet.ibm.com>
Date: Tue, 20 Jan 2015 16:55:02 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] idle/tick-broadcast: Exit cpu idle poll loop when cleared
 from tick_broadcast_force_mask
References: <20150119052754.20256.54721.stgit@preeti.in.ibm.com>
 <alpine.DEB.2.11.1501201216420.5526@nanos>
In-Reply-To: <alpine.DEB.2.11.1501201216420.5526@nanos>
Content-Type: text/plain; charset=ISO-8859-1
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/20/2015 04:51 PM, Thomas Gleixner wrote:
> On Mon, 19 Jan 2015, Preeti U Murthy wrote:
>> An idle cpu enters cpu_idle_poll() if it is set in the tick_broadcast_force_mask.
>> This is so that it does not incur the overhead of entering idle states when it is expected
>> to be woken up anytime then through a broadcast IPI. The condition that forces an exit out
>> of the idle polling is the check on setting of the TIF_NEED_RESCHED flag for the idle thread.
>>
>> When the broadcast IPI does arrive, it is not guarenteed that the handler sets the
>> TIF_NEED_RESCHED flag. Hence although the cpu is cleared in the tick_broadcast_force_mask,
>> it continues to loop in cpu_idle_poll unnecessarily wasting power. Hence exit the idle
>> poll loop if the tick_broadcast_force_mask gets cleared and enter idle states.
>>
>> Of course if the cpu has entered cpu_idle_poll() on being asked to poll explicitly,
>> it continues to poll till it is asked to reschedule.
>>
>> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>> ---
>>
>>  kernel/sched/idle.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> index c47fce7..aaf1c1d 100644
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -47,7 +47,8 @@ static inline int cpu_idle_poll(void)
>>  	rcu_idle_enter();
>>  	trace_cpu_idle_rcuidle(0, smp_processor_id());
>>  	local_irq_enable();
>> -	while (!tif_need_resched())
>> +	while (!tif_need_resched() &&
>> +		(cpu_idle_force_poll || tick_check_broadcast_expired()))
> 
> You explain the tick_check_broadcast_expired() bit, but what about the
> cpu_idle_force_poll part?

The last few lines which say "Of course if the cpu has entered
cpu_idle_poll() on being asked to poll explicitly, it continues to poll
till it is asked to reschedule" explains the cpu_idle_force_poll part.
Perhaps I should s/poll explicitly/do cpu_idle_force_poll ?

Regards
Preeti U Murthy
> 
> Thanks,
> 
> 	tglx
> 
