Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 916D62C02C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 07:11:33 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 11 Feb 2013 06:05:48 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 916642CE804A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 07:11:28 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1AJxAsr62980130
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:59:11 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1AKBQib008025
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 07:11:27 +1100
Message-ID: <5117FE74.4020000@linux.vnet.ibm.com>
Date: Mon, 11 Feb 2013 01:39:24 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 04/45] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073347.13822.85876.stgit@srivatsabhat.in.ibm.com>
 <20130208231017.GK2666@linux.vnet.ibm.com> <20130210180607.GA1375@redhat.com>
 <5117F403.1050300@linux.vnet.ibm.com> <20130210195042.GA6236@redhat.com>
In-Reply-To: <20130210195042.GA6236@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 mingo@kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sbw@mit.edu, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/11/2013 01:20 AM, Oleg Nesterov wrote:
> On 02/11, Srivatsa S. Bhat wrote:
>>
>> On 02/10/2013 11:36 PM, Oleg Nesterov wrote:
>>>>> +static void announce_writer_inactive(struct percpu_rwlock *pcpu_rwlock)
>>>>> +{
>>>>> +   unsigned int cpu;
>>>>> +
>>>>> +   drop_writer_signal(pcpu_rwlock, smp_processor_id());
>>>>
>>>> Why do we drop ourselves twice?  More to the point, why is it important to
>>>> drop ourselves first?
>>>
>>> And don't we need mb() _before_ we clear ->writer_signal ?
>>>
>>
>> Oh, right! Or, how about moving announce_writer_inactive() to _after_
>> write_unlock()?
> 
> Not sure this will help... but, either way it seems we have another
> problem...
> 
> percpu_rwlock tries to be "generic". This means we should "ignore" its
> usage in hotplug, and _write_lock should not race with _write_unlock.
> 

Yes, good point!

> IOW. Suppose that _write_unlock clears ->writer_signal. We need to ensure
> that this can't race with another write which wants to set this flag.
> Perhaps it should be counter as well, and it should be protected by
> the same ->global_rwlock, but _write_lock() should drop it before
> sync_all_readers() and then take it again?

Hmm, or we could just add an extra mb() like you suggested, and keep it
simple...

> 
>>>>> +static inline void sync_reader(struct percpu_rwlock *pcpu_rwlock,
>>>>> +			       unsigned int cpu)
>>>>> +{
>>>>> +	smp_rmb(); /* Paired with smp_[w]mb() in percpu_read_[un]lock() */
>>>>
>>>> As I understand it, the purpose of this memory barrier is to ensure
>>>> that the stores in drop_writer_signal() happen before the reads from
>>>> ->reader_refcnt in reader_uses_percpu_refcnt(), thus preventing the
>>>> race between a new reader attempting to use the fastpath and this writer
>>>> acquiring the lock.  Unless I am confused, this must be smp_mb() rather
>>>> than smp_rmb().
>>>
>>> And note that before sync_reader() we call announce_writer_active() which
>>> already adds mb() before sync_all_readers/sync_reader, so this rmb() looks
>>> unneeded.
>>>
>>
>> My intention was to help the writer see the ->reader_refcnt drop to zero
>> ASAP; hence I used smp_wmb() at reader and smp_rmb() here at the writer.
> 
> Hmm, interesting... Not sure, but can't really comment. However I can
> answer your next question:
>

Paul told me in another mail that I was expecting too much out of memory
barriers, like increasing the speed of electrons and what not ;-)
[ It would have been cool though, if it had such magical powers :P ]
 
>> Please correct me if my understanding of memory barriers is wrong here..
> 
> Who? Me??? No we have paulmck for that ;)
>

Haha ;-)

Regards,
Srivatsa S. Bhat
