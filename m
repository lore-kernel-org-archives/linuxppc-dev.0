Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYnJT0Mk6zDr9D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 22:35:52 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5LCY0GO118358
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 08:35:51 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n2u7bhrx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 08:35:51 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Tue, 21 Jun 2016 18:05:48 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 80A2CE005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 18:09:27 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5LCZiCv45940794
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 18:05:44 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5LCZe4O016168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 18:05:44 +0530
Date: Tue, 21 Jun 2016 20:35:22 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, paulus@samba.org,
 mpe@ellerman.id.au, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com
Subject: Re: [PATCH v5 1/6] qspinlock: powerpc support qspinlock
References: <1464859370-5162-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1464859370-5162-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1464917520.26773.11.camel@kernel.crashing.org>
 <1464917548.26773.12.camel@au1.ibm.com> <57510353.1020209@linux.vnet.ibm.com>
 <1464928427.26773.26.camel@kernel.crashing.org>
 <20160606155907.GH30909@twins.programming.kicks-ass.net>
 <1465249297.4274.72.camel@kernel.crashing.org>
In-Reply-To: <1465249297.4274.72.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5769348A.1060505@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年06月07日 05:41, Benjamin Herrenschmidt wrote:
> On Mon, 2016-06-06 at 17:59 +0200, Peter Zijlstra wrote:
>> On Fri, Jun 03, 2016 at 02:33:47PM +1000, Benjamin Herrenschmidt wrote:
>>>
>>>   - For the above, can you show (or describe) where the qspinlock
>>>     improves things compared to our current locks.
>> So currently PPC has a fairly straight forward test-and-set spinlock
>> IIRC. You have this because LPAR/virt muck and lock holder preemption
>> issues etc..
>> qspinlock is 1) a fair lock (like ticket locks) and 2) provides
>> out-of-word spinning, reducing cacheline pressure.
>
> Thanks Peter. I think I understand the theory, but I'd like see it
> translate into real numbers.
>
>> Esp. on multi-socket x86 we saw the out-of-word spinning being a big win
>> over our ticket locks.
>>
>> And fairness, brought to us by the ticket locks a long time ago,
>> eliminated starvation issues we had, where a spinner local to the holder
>> would 'always' win from a spinner further away. So under heavy enough
>> local contention, the spinners on 'remote' CPUs would 'never' get to own
>> the lock.
>
> I think our HW has tweaks to avoid that from happening with the simple
> locks in the underlying ll/sc implementation. In any case, what I'm
> asking is actual tests to verify it works as expected for us.
>
IF HW has such tweaks then there mush be performance drop when total cpu's number grows up.
And I got such clues

one simple benchmark test:
it tests how many spin_lock/spin_unlock pairs can be done within 15 seconds on all cpus.
say,
while(!done) {
	spin_lock()
	this_cpu_inc(loops)
	spin_unlock()
}

I do the test on two machines, one is using powerKVM, and the other is using pHyp.
the result below shows what the sum of loops is in the end, with xxxxK form.

cpu count	| pv-qspinlock	| test-set spinlock|
----------------------------------------------------
8 (powerKVM)	|	62830K	|	67340K	|
------------------------------------------------
8 (pHyp)	|	49800K	|	59330K	|
------------------------------------------------
32 (pHyp)	|	87580K	|	20990K	|
-------------------------------------------------

while cpu count grows up, the lock/unlock pairs ops of test-set spinlock drops very much.
this is because the cache bouncing in different physical cpus.

So to verify how both spinlock impact the data-cache,
another simple benchmark test.
code looks like:

struct _x {
	spinlock_t lk;
	unsigned long x;
} x;

while(!this_cpu_read(stop)) {
	int i = 0xff
	spin_lock(x.lk)
	this_cpu_inc(loops)
	while(i--)
		READ_ONCE(x.x);
	spin_unlock(x.lk)
}

the result below shows what the sum of loops is in the end, with xxxxK form.

cpu count	| pv-qspinlock	| test-set spinlock|
------------------------------------------------
8 (pHyp)	|	13240K	|	9780K	|
------------------------------------------------
32 (pHyp)	|	25790K	|	9700K	|
------------------------------------------------

obviously pv-qspinlock is more cache-friendly, and has better performance than test-set spinlock.

More test is going on, I will send out new patch set with the result.
HOPE *within* this week. unixbench really takes a long time.

thanks
xinhui
>> pv-qspinlock tries to preserve the fairness while allowing limited lock
>> stealing and explicitly managing which vcpus to wake.
>
> Right.
>>>
>>> 	While there's
>>>     theory and to some extent practice on x86, it would be nice to
>>>     validate the effects on POWER.
>> Right; so that will have to be from benchmarks which I cannot help you
>> with ;-)
>
> Precisely :-) This is what I was asking for ;-)
>
> Cheers,
> Ben.
>
