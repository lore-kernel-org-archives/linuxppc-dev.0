Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE8532C0293
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 05:40:48 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 11 Feb 2013 04:39:06 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1E0E92CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 05:40:40 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1AISVKC131548
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 05:28:31 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1AIeb7P011154
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 05:40:39 +1100
Message-ID: <5117E92C.3050207@linux.vnet.ibm.com>
Date: Mon, 11 Feb 2013 00:08:36 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v5 04/45] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073347.13822.85876.stgit@srivatsabhat.in.ibm.com>
 <20130123185522.GG2373@mtj.dyndns.org> <51003B20.2060506@linux.vnet.ibm.com>
 <20130123195740.GI2373@mtj.dyndns.org> <5100B8CC.4080406@linux.vnet.ibm.com>
 <87ip6gutsq.fsf@sejong.aot.lge.com>
 <20130208224742.GJ2666@linux.vnet.ibm.com>
In-Reply-To: <20130208224742.GJ2666@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org,
 linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, rjw@sisk.pl, Namhyung Kim <namhyung@kernel.org>,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, oleg@redhat.com, sbw@mit.edu,
 Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/09/2013 04:17 AM, Paul E. McKenney wrote:
> On Tue, Jan 29, 2013 at 08:12:37PM +0900, Namhyung Kim wrote:
>> On Thu, 24 Jan 2013 10:00:04 +0530, Srivatsa S. Bhat wrote:
>>> On 01/24/2013 01:27 AM, Tejun Heo wrote:
>>>> On Thu, Jan 24, 2013 at 01:03:52AM +0530, Srivatsa S. Bhat wrote:
>>>>> CPU 0                          CPU 1
>>>>>
>>>>> read_lock(&rwlock)
>>>>>
>>>>>                               write_lock(&rwlock) //spins, because CPU 0
>>>>>                               //has acquired the lock for read
>>>>>
>>>>> read_lock(&rwlock)
>>>>>    ^^^^^
>>>>> What happens here? Does CPU 0 start spinning (and hence deadlock) or will
>>>>> it continue realizing that it already holds the rwlock for read?
>>>>
>>>> I don't think rwlock allows nesting write lock inside read lock.
>>>> read_lock(); write_lock() will always deadlock.
>>>>
>>>
>>> Sure, I understand that :-) My question was, what happens when *two* CPUs
>>> are involved, as in, the read_lock() is invoked only on CPU 0 whereas the
>>> write_lock() is invoked on CPU 1.
>>>
>>> For example, the same scenario shown above, but with slightly different
>>> timing, will NOT result in a deadlock:
>>>
>>> Scenario 2:
>>>   CPU 0                                CPU 1
>>>
>>> read_lock(&rwlock)
>>>
>>>
>>> read_lock(&rwlock) //doesn't spin
>>>
>>>                                     write_lock(&rwlock) //spins, because CPU 0
>>>                                     //has acquired the lock for read
>>>
>>>
>>> So I was wondering whether the "fairness" logic of rwlocks would cause
>>> the second read_lock() to spin (in the first scenario shown above) because
>>> a writer is already waiting (and hence new readers should spin) and thus
>>> cause a deadlock.
>>
>> In my understanding, current x86 rwlock does basically this (of course,
>> in an atomic fashion):
>>
>>
>> #define RW_LOCK_BIAS 0x10000
>>
>> rwlock_init(rwlock)
>> {
>> 	rwlock->lock = RW_LOCK_BIAS;
>> }
>>
>> arch_read_lock(rwlock)
>> {
>> retry:
>> 	if (--rwlock->lock >= 0)
>> 		return;
>>
>>         rwlock->lock++;
>>         while (rwlock->lock < 1)
>>         	continue;
>>
>>         goto retry;
>> }
>>
>> arch_write_lock(rwlock)
>> {
>> retry:
>> 	if ((rwlock->lock -= RW_LOCK_BIAS) == 0)
>>         	return;
>>
>>         rwlock->lock += RW_LOCK_BIAS;
>> 	while (rwlock->lock != RW_LOCK_BIAS)
>> 		continue;
>>
>>         goto retry;
>> }
>>
>>
>> So I can't find where the 'fairness' logic comes from..
> 
> I looked through several of the rwlock implementations, and in all of
> them the writer backs off if it sees readers -- or refrains from asserting
> ownership of the lock to begin with.
> 
> So it should be OK to use rwlock as shown in the underlying patch.
> 

Thanks a lot for confirming that Paul! So I guess we can use rwlocks
as it is, since its behaviour suits our needs perfectly. So I won't tinker
with atomic counters for a while, atleast not until someone starts making
rwlocks fair.. ;-)

Regards,
Srivatsa S. Bhat
