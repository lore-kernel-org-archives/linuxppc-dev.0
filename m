Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 24D862C02EB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 09:14:10 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sun, 10 Feb 2013 15:14:07 -0700
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 2D29C3E40040
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2013 15:13:56 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1AME3hi101426
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2013 15:14:03 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1AME0K2024334
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2013 15:14:03 -0700
Date: Sun, 10 Feb 2013 14:13:57 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 04/45] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
Message-ID: <20130210221357.GN2666@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073347.13822.85876.stgit@srivatsabhat.in.ibm.com>
 <20130208231017.GK2666@linux.vnet.ibm.com>
 <20130210180607.GA1375@redhat.com>
 <5117F403.1050300@linux.vnet.ibm.com>
 <20130210195042.GA6236@redhat.com>
 <5117FE74.4020000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5117FE74.4020000@linux.vnet.ibm.com>
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, sbw@mit.edu, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 11, 2013 at 01:39:24AM +0530, Srivatsa S. Bhat wrote:
> On 02/11/2013 01:20 AM, Oleg Nesterov wrote:
> > On 02/11, Srivatsa S. Bhat wrote:
> >>
> >> On 02/10/2013 11:36 PM, Oleg Nesterov wrote:
> >>>>> +static void announce_writer_inactive(struct percpu_rwlock *pcpu_rwlock)
> >>>>> +{
> >>>>> +   unsigned int cpu;
> >>>>> +
> >>>>> +   drop_writer_signal(pcpu_rwlock, smp_processor_id());
> >>>>
> >>>> Why do we drop ourselves twice?  More to the point, why is it important to
> >>>> drop ourselves first?
> >>>
> >>> And don't we need mb() _before_ we clear ->writer_signal ?
> >>>
> >>
> >> Oh, right! Or, how about moving announce_writer_inactive() to _after_
> >> write_unlock()?
> > 
> > Not sure this will help... but, either way it seems we have another
> > problem...
> > 
> > percpu_rwlock tries to be "generic". This means we should "ignore" its
> > usage in hotplug, and _write_lock should not race with _write_unlock.
> > 
> 
> Yes, good point!
> 
> > IOW. Suppose that _write_unlock clears ->writer_signal. We need to ensure
> > that this can't race with another write which wants to set this flag.
> > Perhaps it should be counter as well, and it should be protected by
> > the same ->global_rwlock, but _write_lock() should drop it before
> > sync_all_readers() and then take it again?
> 
> Hmm, or we could just add an extra mb() like you suggested, and keep it
> simple...
> 
> > 
> >>>>> +static inline void sync_reader(struct percpu_rwlock *pcpu_rwlock,
> >>>>> +			       unsigned int cpu)
> >>>>> +{
> >>>>> +	smp_rmb(); /* Paired with smp_[w]mb() in percpu_read_[un]lock() */
> >>>>
> >>>> As I understand it, the purpose of this memory barrier is to ensure
> >>>> that the stores in drop_writer_signal() happen before the reads from
> >>>> ->reader_refcnt in reader_uses_percpu_refcnt(), thus preventing the
> >>>> race between a new reader attempting to use the fastpath and this writer
> >>>> acquiring the lock.  Unless I am confused, this must be smp_mb() rather
> >>>> than smp_rmb().
> >>>
> >>> And note that before sync_reader() we call announce_writer_active() which
> >>> already adds mb() before sync_all_readers/sync_reader, so this rmb() looks
> >>> unneeded.
> >>>
> >>
> >> My intention was to help the writer see the ->reader_refcnt drop to zero
> >> ASAP; hence I used smp_wmb() at reader and smp_rmb() here at the writer.
> > 
> > Hmm, interesting... Not sure, but can't really comment. However I can
> > answer your next question:
> 
> Paul told me in another mail that I was expecting too much out of memory
> barriers, like increasing the speed of electrons and what not ;-)
> [ It would have been cool though, if it had such magical powers :P ]

"But because you have used the special mb_tachyonic instruction, the
speed of light is 600,000 km/s for the next five clock cycles"...  ;-)

							Thanx, Paul

> >> Please correct me if my understanding of memory barriers is wrong here..
> > 
> > Who? Me??? No we have paulmck for that ;)
> >
> 
> Haha ;-)
> 
> Regards,
> Srivatsa S. Bhat
> 
