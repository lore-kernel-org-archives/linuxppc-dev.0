Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B8B22C0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 15:32:06 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Thu, 24 Jan 2013 14:25:48 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6FFB12BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 15:32:00 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0O4K4883211590
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 15:20:04 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0O4VwXq002450
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 15:32:00 +1100
Message-ID: <5100B8CC.4080406@linux.vnet.ibm.com>
Date: Thu, 24 Jan 2013 10:00:04 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5 04/45] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073347.13822.85876.stgit@srivatsabhat.in.ibm.com>
 <20130123185522.GG2373@mtj.dyndns.org> <51003B20.2060506@linux.vnet.ibm.com>
 <20130123195740.GI2373@mtj.dyndns.org>
In-Reply-To: <20130123195740.GI2373@mtj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org,
 linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 sbw@mit.edu, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/24/2013 01:27 AM, Tejun Heo wrote:
> Hello, Srivatsa.
> 
> On Thu, Jan 24, 2013 at 01:03:52AM +0530, Srivatsa S. Bhat wrote:
>> Hmm.. I split it up into steps to help explain the reasoning behind
>> the code sufficiently, rather than spring all of the intricacies at
>> one go (which would make it very hard to write the changelog/comments
>> also). The split made it easier for me to document it well in the
>> changelog, because I could deal with reasonable chunks of code/complexity
>> at a time. IMHO that helps people reading it for the first time to
>> understand the logic easily.
> 
> I don't know.  It's a judgement call I guess.  I personally would much
> prefer having ample documentation as comments in the source itself or
> as a separate Documentation/ file as that's what most people are gonna
> be looking at to figure out what's going on.  Maybe just compact it a
> bit and add more in-line documentation instead?
> 

OK, I'll think about this.

>>> The only two options are either punishing writers or identifying and
>>> updating all such possible deadlocks.  percpu_rwsem does the former,
>>> right?  I don't know how feasible the latter would be.
>>
>> I don't think we can avoid looking into all the possible deadlocks,
>> as long as we use rwlocks inside get/put_online_cpus_atomic() (assuming
>> rwlocks are fair). Even with Oleg's idea of using synchronize_sched()
>> at the writer, we still need to take care of locking rules, because the
>> synchronize_sched() only helps avoid the memory barriers at the reader,
>> and doesn't help get rid of the rwlocks themselves.
> 
> Well, percpu_rwlock don't have to use rwlock for the slow path.  It
> can implement its own writer starving locking scheme.  It's not like
> implementing slow path global rwlock logic is difficult.
>

Great idea! So probably I could use atomic ops or something similar in the
slow path to implement the scheme we need...

>> CPU 0                          CPU 1
>>
>> read_lock(&rwlock)
>>
>>                               write_lock(&rwlock) //spins, because CPU 0
>>                               //has acquired the lock for read
>>
>> read_lock(&rwlock)
>>    ^^^^^
>> What happens here? Does CPU 0 start spinning (and hence deadlock) or will
>> it continue realizing that it already holds the rwlock for read?
> 
> I don't think rwlock allows nesting write lock inside read lock.
> read_lock(); write_lock() will always deadlock.
> 

Sure, I understand that :-) My question was, what happens when *two* CPUs
are involved, as in, the read_lock() is invoked only on CPU 0 whereas the
write_lock() is invoked on CPU 1.

For example, the same scenario shown above, but with slightly different
timing, will NOT result in a deadlock:

Scenario 2:
  CPU 0                                CPU 1

read_lock(&rwlock)


read_lock(&rwlock) //doesn't spin

                                    write_lock(&rwlock) //spins, because CPU 0
                                    //has acquired the lock for read


So I was wondering whether the "fairness" logic of rwlocks would cause
the second read_lock() to spin (in the first scenario shown above) because
a writer is already waiting (and hence new readers should spin) and thus
cause a deadlock.

Regards,
Srivatsa S. Bhat
