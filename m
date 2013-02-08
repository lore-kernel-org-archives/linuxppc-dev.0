Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 773292C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2013 09:48:00 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 8 Feb 2013 15:47:56 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 4DDD71FF0044
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 15:47:52 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r18MlsjW319466
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 15:47:54 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r18Mljsn012648
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 15:47:53 -0700
Date: Fri, 8 Feb 2013 14:47:42 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v5 04/45] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
Message-ID: <20130208224742.GJ2666@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073347.13822.85876.stgit@srivatsabhat.in.ibm.com>
 <20130123185522.GG2373@mtj.dyndns.org>
 <51003B20.2060506@linux.vnet.ibm.com>
 <20130123195740.GI2373@mtj.dyndns.org>
 <5100B8CC.4080406@linux.vnet.ibm.com>
 <87ip6gutsq.fsf@sejong.aot.lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87ip6gutsq.fsf@sejong.aot.lge.com>
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org,
 linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, rjw@sisk.pl, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 sbw@mit.edu, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 29, 2013 at 08:12:37PM +0900, Namhyung Kim wrote:
> On Thu, 24 Jan 2013 10:00:04 +0530, Srivatsa S. Bhat wrote:
> > On 01/24/2013 01:27 AM, Tejun Heo wrote:
> >> On Thu, Jan 24, 2013 at 01:03:52AM +0530, Srivatsa S. Bhat wrote:
> >>> CPU 0                          CPU 1
> >>>
> >>> read_lock(&rwlock)
> >>>
> >>>                               write_lock(&rwlock) //spins, because CPU 0
> >>>                               //has acquired the lock for read
> >>>
> >>> read_lock(&rwlock)
> >>>    ^^^^^
> >>> What happens here? Does CPU 0 start spinning (and hence deadlock) or will
> >>> it continue realizing that it already holds the rwlock for read?
> >> 
> >> I don't think rwlock allows nesting write lock inside read lock.
> >> read_lock(); write_lock() will always deadlock.
> >> 
> >
> > Sure, I understand that :-) My question was, what happens when *two* CPUs
> > are involved, as in, the read_lock() is invoked only on CPU 0 whereas the
> > write_lock() is invoked on CPU 1.
> >
> > For example, the same scenario shown above, but with slightly different
> > timing, will NOT result in a deadlock:
> >
> > Scenario 2:
> >   CPU 0                                CPU 1
> >
> > read_lock(&rwlock)
> >
> >
> > read_lock(&rwlock) //doesn't spin
> >
> >                                     write_lock(&rwlock) //spins, because CPU 0
> >                                     //has acquired the lock for read
> >
> >
> > So I was wondering whether the "fairness" logic of rwlocks would cause
> > the second read_lock() to spin (in the first scenario shown above) because
> > a writer is already waiting (and hence new readers should spin) and thus
> > cause a deadlock.
> 
> In my understanding, current x86 rwlock does basically this (of course,
> in an atomic fashion):
> 
> 
> #define RW_LOCK_BIAS 0x10000
> 
> rwlock_init(rwlock)
> {
> 	rwlock->lock = RW_LOCK_BIAS;
> }
> 
> arch_read_lock(rwlock)
> {
> retry:
> 	if (--rwlock->lock >= 0)
> 		return;
> 
>         rwlock->lock++;
>         while (rwlock->lock < 1)
>         	continue;
> 
>         goto retry;
> }
> 
> arch_write_lock(rwlock)
> {
> retry:
> 	if ((rwlock->lock -= RW_LOCK_BIAS) == 0)
>         	return;
> 
>         rwlock->lock += RW_LOCK_BIAS;
> 	while (rwlock->lock != RW_LOCK_BIAS)
> 		continue;
> 
>         goto retry;
> }
> 
> 
> So I can't find where the 'fairness' logic comes from..

I looked through several of the rwlock implementations, and in all of
them the writer backs off if it sees readers -- or refrains from asserting
ownership of the lock to begin with.

So it should be OK to use rwlock as shown in the underlying patch.

							Thanx, Paul
