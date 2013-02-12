Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 373BC2C040B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 05:32:36 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 12 Feb 2013 13:30:36 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 2E0743CD0C90
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2013 11:16:08 -0500 (EST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1CGG7mk11796494
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2013 11:16:07 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1CGFleY007447
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2013 09:15:51 -0700
Date: Tue, 12 Feb 2013 08:15:30 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 04/45] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
Message-ID: <20130212161530.GA9929@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073347.13822.85876.stgit@srivatsabhat.in.ibm.com>
 <20130208231017.GK2666@linux.vnet.ibm.com>
 <20130210180607.GA1375@redhat.com>
 <20130210195417.GK2666@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130210195417.GK2666@linux.vnet.ibm.com>
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 mingo@kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sbw@mit.edu,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org,
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

On Sun, Feb 10, 2013 at 11:54:17AM -0800, Paul E. McKenney wrote:
> On Sun, Feb 10, 2013 at 07:06:07PM +0100, Oleg Nesterov wrote:
> > On 02/08, Paul E. McKenney wrote:
> 
> [ . . . ]
> 
> > > > +static inline void sync_reader(struct percpu_rwlock *pcpu_rwlock,
> > > > +			       unsigned int cpu)
> > > > +{
> > > > +	smp_rmb(); /* Paired with smp_[w]mb() in percpu_read_[un]lock() */
> > >
> > > As I understand it, the purpose of this memory barrier is to ensure
> > > that the stores in drop_writer_signal() happen before the reads from
> > > ->reader_refcnt in reader_uses_percpu_refcnt(), thus preventing the
> > > race between a new reader attempting to use the fastpath and this writer
> > > acquiring the lock.  Unless I am confused, this must be smp_mb() rather
> > > than smp_rmb().
> > 
> > And note that before sync_reader() we call announce_writer_active() which
> > already adds mb() before sync_all_readers/sync_reader, so this rmb() looks
> > unneeded.
> > 
> > But, at the same time, could you confirm that we do not need another mb()
> > after sync_all_readers() in percpu_write_lock() ? I mean, without mb(),
> > can't this reader_uses_percpu_refcnt() LOAD leak into the critical section
> > protected by ->global_rwlock? Then this LOAD can be re-ordered with other
> > memory operations done by the writer.
> 
> As soon as I get the rest of the way through Thomas's patchset.  ;-)

There is a memory barrier associated with write_lock(), but it is
only required to keep the critical section inside the lock -- and is
permitted to allow stuff outside of the lock to be reordered into the
critical section.  So I believe we do indeed need an smp_mb() between
sync_all_readers() and write_lock() in percpu_write_lock().

Good eyes, Oleg!

							Thanx, Paul
