Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D9DD2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 04:58:28 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 23:25:59 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4B0D23940059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:28:22 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1IHwJ2W32178242
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:28:20 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1IHwKa5029208
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 04:58:22 +1100
Message-ID: <51226B46.9080707@linux.vnet.ibm.com>
Date: Mon, 18 Feb 2013 23:26:22 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH v6 04/46] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <20130218123856.26245.46705.stgit@srivatsabhat.in.ibm.com>
 <CANN689F9S7c1M8+cEpz3tsxGF34+NTRBLvxgPUOtbvav5u+RRA@mail.gmail.com>
 <5122551E.1080703@linux.vnet.ibm.com>
In-Reply-To: <5122551E.1080703@linux.vnet.ibm.com>
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

On 02/18/2013 09:51 PM, Srivatsa S. Bhat wrote:
> Hi Michel,
> 
> On 02/18/2013 09:15 PM, Michel Lespinasse wrote:
>> Hi Srivasta,
>>
>> I admit not having followed in detail the threads about the previous
>> iteration, so some of my comments may have been discussed already
>> before - apologies if that is the case.
>>
>> On Mon, Feb 18, 2013 at 8:38 PM, Srivatsa S. Bhat
>> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>>> Reader-writer locks and per-cpu counters are recursive, so they can be
>>> used in a nested fashion in the reader-path, which makes per-CPU rwlocks also
>>> recursive. Also, this design of switching the synchronization scheme ensures
>>> that you can safely nest and use these locks in a very flexible manner.
[...]
>>>  void percpu_write_lock(struct percpu_rwlock *pcpu_rwlock)
>>>  {
>>> +       unsigned int cpu;
>>> +
>>> +       /*
>>> +        * Tell all readers that a writer is becoming active, so that they
>>> +        * start switching over to the global rwlock.
>>> +        */
>>> +       for_each_possible_cpu(cpu)
>>> +               per_cpu_ptr(pcpu_rwlock->rw_state, cpu)->writer_signal = true;
>>
>> I don't see anything preventing a race with the corresponding code in
>> percpu_write_unlock() that sets writer_signal back to false. Did I
>> miss something here ? It seems to me we don't have any guarantee that
>> all writer signals will be set to true at the end of the loop...
>>
> 
> Ah, thanks for pointing that out! IIRC Oleg had pointed this issue in the last
> version, but back then, I hadn't fully understood what he meant. Your
> explanation made it clear. I'll work on fixing this.
> 

We can fix this by using the simple patch (untested) shown below.
The alternative would be to acquire the rwlock for write, update the
->writer_signal values, release the lock, wait for readers to switch,
again acquire the rwlock for write with interrupts disabled etc... which
makes it kinda messy, IMHO. So I prefer the simple version shown below.


diff --git a/lib/percpu-rwlock.c b/lib/percpu-rwlock.c
index bf95e40..64ccd3f 100644
--- a/lib/percpu-rwlock.c
+++ b/lib/percpu-rwlock.c
@@ -50,6 +50,12 @@
 	(__this_cpu_read((pcpu_rwlock)->rw_state->writer_signal))
 
 
+/*
+ * Spinlock to synchronize access to the writer's data-structures
+ * (->writer_signal) from multiple writers.
+ */
+static DEFINE_SPINLOCK(writer_side_lock);
+
 int __percpu_init_rwlock(struct percpu_rwlock *pcpu_rwlock,
 			 const char *name, struct lock_class_key *rwlock_key)
 {
@@ -191,6 +197,8 @@ void percpu_write_lock_irqsave(struct percpu_rwlock *pcpu_rwlock,
 {
 	unsigned int cpu;
 
+	spin_lock(&writer_side_lock);
+
 	/*
 	 * Tell all readers that a writer is becoming active, so that they
 	 * start switching over to the global rwlock.
@@ -252,5 +260,6 @@ void percpu_write_unlock_irqrestore(struct percpu_rwlock *pcpu_rwlock,
 		per_cpu_ptr(pcpu_rwlock->rw_state, cpu)->writer_signal = false;
 
 	write_unlock_irqrestore(&pcpu_rwlock->global_rwlock, *flags);
+	spin_unlock(&writer_side_lock);
 }
