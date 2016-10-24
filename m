Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2T631YshzDt4f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 18:52:42 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9O7nBSS044991
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 03:52:40 -0400
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 269cc6pegk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 03:52:40 -0400
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Mon, 24 Oct 2016 08:52:38 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 883B92190023
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 08:51:51 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9O7qZDS23199800
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 07:52:35 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9O7qWOK019002
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 01:52:34 -0600
Subject: Re: [PATCH 2/5] stop_machine: yield CPU during stop machine
To: Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
 <1477051138-1610-3-git-send-email-borntraeger@de.ibm.com>
 <20161021120536.GC3142@twins.programming.kicks-ass.net>
 <20161022110636.410f20bd@roar.ozlabs.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>,
 virtualization@lists.linux-foundation.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 24 Oct 2016 09:52:31 +0200
MIME-Version: 1.0
In-Reply-To: <20161022110636.410f20bd@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <251574ff-13ba-c0df-76c3-cb7df30894cb@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/22/2016 02:06 AM, Nicholas Piggin wrote:
> On Fri, 21 Oct 2016 14:05:36 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Fri, Oct 21, 2016 at 01:58:55PM +0200, Christian Borntraeger wrote:
>>> stop_machine can take a very long time if the hypervisor does
>>> overcommitment for guest CPUs. When waiting for "the one", lets
>>> give up our CPU by using the new cpu_relax_yield.  
>>
>> This seems something that would apply to most other virt stuff. Lets Cc
>> a few more lists for that.
>>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  kernel/stop_machine.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
>>> index ec9ab2f..1eb8266 100644
>>> --- a/kernel/stop_machine.c
>>> +++ b/kernel/stop_machine.c
>>> @@ -194,7 +194,7 @@ static int multi_cpu_stop(void *data)
>>>  	/* Simple state machine */
>>>  	do {
>>>  		/* Chill out and ensure we re-read multi_stop_state. */
>>> -		cpu_relax();
>>> +		cpu_relax_yield();
>>>  		if (msdata->state != curstate) {
>>>  			curstate = msdata->state;
>>>  			switch (curstate) {
>>> -- 
>>> 2.5.5
>>>   
> 
> This is the only caller of cpu_relax_yield()?

As of today yes. Right now the yielding (call to hypervisor) in 
cpu_relax is only done for s390. Some time ago Heiko did remove 
that also from s390 with commit 57f2ffe14fd125c2 ("s390: remove 
diag 44 calls from cpu_relax()")

As it turns out this make stop_machine run really slow on virtualized
systems. For example the kprobes test during bootup took several seconds 
instead of just running unnoticed with large guests. Therefore, we 
reintroduced that with commit 4d92f50249eb ("s390: reintroduce diag 44
calls for cpu_relax()"), but the only place where we noticed the missing
yield was in the stop_machine code.

I would assume that we might find some other places where this makes
sense in the future, but I expect that we have much less places for 
yield than we need for lowlatency.

PS: We do something similar for our arch implementation for spinlocks,
but there  we use the directed yield as we know which CPU holds the lock.


> 
> As a step to removing cpu_yield_lowlatency this series is nice so I
> have no objection. But "general" kernel coders still have basically
> no chance of using this properly.
> 
> I wonder what can be done about that. I've got that spin_do/while
> series I'll rebase on top of this, but a spin_yield variant of them
> is of no more help to the caller.
> 
> What makes this unique? Long latency and not performance critical?

I think what makes this unique is that ALL cpus spin and wait for one.
It was really the only place that I noticed a regression with Heikos
first patch.

> Most places where we spin and maybe yield have been moved to arch
> code, but I wonder whether we can make an easier to use architecture
> independent API?


Peter, I will fixup the patch set (I forgot to remove the lowlatency
in 2 places) and push it on my tree for linux-next. Lets see what happens.
Would the tip tree be the right place if things work out ok?
