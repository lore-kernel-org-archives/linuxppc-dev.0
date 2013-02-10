Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BB02B2C029C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 06:26:54 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 11 Feb 2013 00:55:12 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7DB88E004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 00:57:35 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1AJQiLC32637166
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 00:56:44 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1AJQjeq005864
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2013 19:26:47 GMT
Message-ID: <5117F403.1050300@linux.vnet.ibm.com>
Date: Mon, 11 Feb 2013 00:54:51 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 04/45] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073347.13822.85876.stgit@srivatsabhat.in.ibm.com>
 <20130208231017.GK2666@linux.vnet.ibm.com> <20130210180607.GA1375@redhat.com>
In-Reply-To: <20130210180607.GA1375@redhat.com>
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

On 02/10/2013 11:36 PM, Oleg Nesterov wrote:
> On 02/08, Paul E. McKenney wrote:
>>
>> On Tue, Jan 22, 2013 at 01:03:53PM +0530, Srivatsa S. Bhat wrote:
>>>
>>>  void percpu_read_unlock(struct percpu_rwlock *pcpu_rwlock)
>>>  {
>>> -	read_unlock(&pcpu_rwlock->global_rwlock);
>>
>> We need an smp_mb() here to keep the critical section ordered before the
>> this_cpu_dec() below.  Otherwise, if a writer shows up just after we
>> exit the fastpath, that writer is not guaranteed to see the effects of
>> our critical section.  Equivalently, the prior read-side critical section
>> just might see some of the writer's updates, which could be a bit of
>> a surprise to the reader.
> 
> Agreed, we should not assume that a "reader" doesn't write. And we should
> ensure that this "read" section actually completes before this_cpu_dec().
>

Right, will fix.
 
>>> +	/*
>>> +	 * We never allow heterogeneous nesting of readers. So it is trivial
>>> +	 * to find out the kind of reader we are, and undo the operation
>>> +	 * done by our corresponding percpu_read_lock().
>>> +	 */
>>> +	if (__this_cpu_read(*pcpu_rwlock->reader_refcnt)) {
>>> +		this_cpu_dec(*pcpu_rwlock->reader_refcnt);
>>> +		smp_wmb(); /* Paired with smp_rmb() in sync_reader() */
>>
>> Given an smp_mb() above, I don't understand the need for this smp_wmb().
>> Isn't the idea that if the writer sees ->reader_refcnt decremented to
>> zero, it also needs to see the effects of the corresponding reader's
>> critical section?
> 
> I am equally confused ;)
> 
> OTOH, we can probably aboid any barrier if reader_nested_percpu() == T.
> 

Good point! Will add that optimization, thank you!

> 
>>> +static void announce_writer_inactive(struct percpu_rwlock *pcpu_rwlock)
>>> +{
>>> +   unsigned int cpu;
>>> +
>>> +   drop_writer_signal(pcpu_rwlock, smp_processor_id());
>>
>> Why do we drop ourselves twice?  More to the point, why is it important to
>> drop ourselves first?
> 
> And don't we need mb() _before_ we clear ->writer_signal ?
> 

Oh, right! Or, how about moving announce_writer_inactive() to _after_
write_unlock()?

>>> +static inline void sync_reader(struct percpu_rwlock *pcpu_rwlock,
>>> +			       unsigned int cpu)
>>> +{
>>> +	smp_rmb(); /* Paired with smp_[w]mb() in percpu_read_[un]lock() */
>>
>> As I understand it, the purpose of this memory barrier is to ensure
>> that the stores in drop_writer_signal() happen before the reads from
>> ->reader_refcnt in reader_uses_percpu_refcnt(), thus preventing the
>> race between a new reader attempting to use the fastpath and this writer
>> acquiring the lock.  Unless I am confused, this must be smp_mb() rather
>> than smp_rmb().
> 
> And note that before sync_reader() we call announce_writer_active() which
> already adds mb() before sync_all_readers/sync_reader, so this rmb() looks
> unneeded.
> 

My intention was to help the writer see the ->reader_refcnt drop to zero
ASAP; hence I used smp_wmb() at reader and smp_rmb() here at the writer.
Please correct me if my understanding of memory barriers is wrong here..

> But, at the same time, could you confirm that we do not need another mb()
> after sync_all_readers() in percpu_write_lock() ? I mean, without mb(),
> can't this reader_uses_percpu_refcnt() LOAD leak into the critical section
> protected by ->global_rwlock? Then this LOAD can be re-ordered with other
> memory operations done by the writer.
> 

Hmm.. it appears that we need a smp_mb() there.

> 
> 
> Srivatsa, I think that the code would be more understandable if you kill
> the helpers like sync_reader/raise_writer_signal. Perhaps even all "write"
> helpers, I am not sure. At least, it seems to me that all barriers should
> be moved to percpu_write_lock/unlock. But I won't insist of course, up to
> you.
> 

Sure, sure. Even Tejun pointed out that those helpers are getting in the way
of readability. I'll get rid of them in the next version.

> And cosmetic nit... How about
> 
> 	struct xxx {
> 		unsigned long	reader_refcnt;
> 		bool		writer_signal;
> 	}
> 
> 	struct percpu_rwlock {
> 		struct xxx __percpu	*xxx;
> 		rwlock_t		global_rwlock;
> 	};
> 
> ?
> 
> This saves one alloc_percpu() and ensures that reader_refcnt/writer_signal
> are always in the same cache-line.
>

Ok, that sounds better. Will make that change. Thanks a lot Oleg!

Regards,
Srivatsa S. Bhat
