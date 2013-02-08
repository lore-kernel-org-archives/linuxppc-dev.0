Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E1632C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2013 10:48:05 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 8 Feb 2013 16:48:03 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 997BD19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 16:47:59 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r18Nm0SA400604
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 16:48:00 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r18Nluuq023157
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Feb 2013 16:47:59 -0700
Date: Fri, 8 Feb 2013 15:47:54 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 06/45] percpu_rwlock: Allow writers to be readers, and
 add lockdep annotations
Message-ID: <20130208234754.GM2666@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073416.13822.96504.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130122073416.13822.96504.stgit@srivatsabhat.in.ibm.com>
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
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

On Tue, Jan 22, 2013 at 01:04:23PM +0530, Srivatsa S. Bhat wrote:
> CPU hotplug (which will be the first user of per-CPU rwlocks) has a special
> requirement with respect to locking: the writer, after acquiring the per-CPU
> rwlock for write, must be allowed to take the same lock for read, without
> deadlocking and without getting complaints from lockdep. In comparison, this
> is similar to what get_online_cpus()/put_online_cpus() does today: it allows
> a hotplug writer (who holds the cpu_hotplug.lock mutex) to invoke it without
> locking issues, because it silently returns if the caller is the hotplug
> writer itself.
> 
> This can be easily achieved with per-CPU rwlocks as well (even without a
> "is this a writer?" check) by incrementing the per-CPU refcount of the writer
> immediately after taking the global rwlock for write, and then decrementing
> the per-CPU refcount before releasing the global rwlock.
> This ensures that any reader that comes along on that CPU while the writer is
> active (on that same CPU), notices the non-zero value of the nested counter
> and assumes that it is a nested read-side critical section and proceeds by
> just incrementing the refcount. Thus we prevent the reader from taking the
> global rwlock for read, which prevents the writer from deadlocking itself.
> 
> Add that support and teach lockdep about this special locking scheme so
> that it knows that this sort of usage is valid. Also add the required lockdep
> annotations to enable it to detect common locking problems with per-CPU
> rwlocks.

Very nice!  The write-side interrupt disabling ensures that the task
stays on CPU, as required.

One request: Could we please have a comment explaining the reasons for
the writer incrementing and decrementing the reader reference count?

It looked really really strange to me until I came back and read the
commit log.  ;-)

							Thanx, Paul

> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> 
>  lib/percpu-rwlock.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/lib/percpu-rwlock.c b/lib/percpu-rwlock.c
> index a8d177a..054a50a 100644
> --- a/lib/percpu-rwlock.c
> +++ b/lib/percpu-rwlock.c
> @@ -84,6 +84,10 @@ void percpu_read_lock_irqsafe(struct percpu_rwlock *pcpu_rwlock)
> 
>  		if (likely(!writer_active(pcpu_rwlock))) {
>  			this_cpu_inc(*pcpu_rwlock->reader_refcnt);
> +
> +			/* Pretend that we take global_rwlock for lockdep */
> +			rwlock_acquire_read(&pcpu_rwlock->global_rwlock.dep_map,
> +					    0, 0, _RET_IP_);
>  		} else {
>  			/* Writer is active, so switch to global rwlock. */
> 
> @@ -108,6 +112,12 @@ void percpu_read_lock_irqsafe(struct percpu_rwlock *pcpu_rwlock)
>  			if (!writer_active(pcpu_rwlock)) {
>  				this_cpu_inc(*pcpu_rwlock->reader_refcnt);
>  				read_unlock(&pcpu_rwlock->global_rwlock);
> +
> +				/*
> +				 * Pretend that we take global_rwlock for lockdep
> +				 */
> +				rwlock_acquire_read(&pcpu_rwlock->global_rwlock.dep_map,
> +						    0, 0, _RET_IP_);
>  			}
>  		}
>  	}
> @@ -128,6 +138,14 @@ void percpu_read_unlock_irqsafe(struct percpu_rwlock *pcpu_rwlock)
>  	if (reader_nested_percpu(pcpu_rwlock)) {
>  		this_cpu_dec(*pcpu_rwlock->reader_refcnt);
>  		smp_wmb(); /* Paired with smp_rmb() in sync_reader() */
> +
> +		/*
> +		 * If this is the last decrement, then it is time to pretend
> +		 * to lockdep that we are releasing the read lock.
> +		 */
> +		if (!reader_nested_percpu(pcpu_rwlock))
> +			rwlock_release(&pcpu_rwlock->global_rwlock.dep_map,
> +				       1, _RET_IP_);
>  	} else {
>  		read_unlock(&pcpu_rwlock->global_rwlock);
>  	}
> @@ -205,11 +223,14 @@ void percpu_write_lock_irqsave(struct percpu_rwlock *pcpu_rwlock,
>  	announce_writer_active(pcpu_rwlock);
>  	sync_all_readers(pcpu_rwlock);
>  	write_lock_irqsave(&pcpu_rwlock->global_rwlock, *flags);
> +	this_cpu_inc(*pcpu_rwlock->reader_refcnt);
>  }
> 
>  void percpu_write_unlock_irqrestore(struct percpu_rwlock *pcpu_rwlock,
>  			 unsigned long *flags)
>  {
> +	this_cpu_dec(*pcpu_rwlock->reader_refcnt);
> +
>  	/*
>  	 * Inform all readers that we are done, so that they can switch back
>  	 * to their per-cpu refcounts. (We don't need to wait for them to
> 
