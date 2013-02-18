Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA5D12C0079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 03:33:41 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 19 Feb 2013 02:26:18 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 345B72BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 03:33:32 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1IGXUpw4522284
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 03:33:30 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1IGXUgR004938
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 03:33:31 +1100
Message-ID: <5122575E.5030405@linux.vnet.ibm.com>
Date: Mon, 18 Feb 2013 22:01:26 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH v6 07/46] percpu_rwlock: Allow writers to be readers,
 and add lockdep annotations
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <20130218123913.26245.7713.stgit@srivatsabhat.in.ibm.com>
 <CANN689Ec4g7jMapv8ChAEom+gEDQ8RDVLa07CKwJ==YO+MUUrA@mail.gmail.com>
In-Reply-To: <CANN689Ec4g7jMapv8ChAEom+gEDQ8RDVLa07CKwJ==YO+MUUrA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, namhyung@kernel.org, mingo@kernel.org,
 linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, vincent.guittot@linaro.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/18/2013 09:21 PM, Michel Lespinasse wrote:
> On Mon, Feb 18, 2013 at 8:39 PM, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> @@ -200,6 +217,16 @@ void percpu_write_lock_irqsave(struct percpu_rwlock *pcpu_rwlock,
>>
>>         smp_mb(); /* Complete the wait-for-readers, before taking the lock */
>>         write_lock_irqsave(&pcpu_rwlock->global_rwlock, *flags);
>> +
>> +       /*
>> +        * It is desirable to allow the writer to acquire the percpu-rwlock
>> +        * for read (if necessary), without deadlocking or getting complaints
>> +        * from lockdep. To achieve that, just increment the reader_refcnt of
>> +        * this CPU - that way, any attempt by the writer to acquire the
>> +        * percpu-rwlock for read, will get treated as a case of nested percpu
>> +        * reader, which is safe, from a locking perspective.
>> +        */
>> +       this_cpu_inc(pcpu_rwlock->rw_state->reader_refcnt);
> 
> I find this quite disgusting, but once again this may be because I
> don't like unfair recursive rwlocks.
> 

:-)

> In my opinion, the alternative of explicitly not taking the read lock
> when one already has the write lock sounds *much* nicer.

I don't seem to recall any strong reasons to do it this way, so I don't have
any strong opinions on doing it this way. But one of the things to note is that,
in the CPU Hotplug case, the readers are *way* more hotter than the writer.
So avoiding extra checks/'if' conditions/memory barriers in the reader-side
is very welcome. (If we slow down the read-side, we get a performance hit
even when *not* doing hotplug!). Considering this, the logic used in this
patchset seems better, IMHO.

Regards,
Srivatsa S. Bhat
