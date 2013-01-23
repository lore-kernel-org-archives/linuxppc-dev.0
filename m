Return-Path: <htejun@gmail.com>
Received: from mail-qc0-f170.google.com (mail-qc0-f170.google.com
 [209.85.216.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7CD872C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 05:55:33 +1100 (EST)
Received: by mail-qc0-f170.google.com with SMTP id d42so3919339qca.29
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2013 10:55:30 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 23 Jan 2013 10:55:22 -0800
From: Tejun Heo <tj@kernel.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 04/45] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
Message-ID: <20130123185522.GG2373@mtj.dyndns.org>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073347.13822.85876.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130122073347.13822.85876.stgit@srivatsabhat.in.ibm.com>
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
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

Hello, Srivatsa.

First of all, I'm not sure whether we need to be this step-by-step
when introducing something new.  It's not like we're transforming an
existing implementation and it doesn't seem to help understanding the
series that much either.

On Tue, Jan 22, 2013 at 01:03:53PM +0530, Srivatsa S. Bhat wrote:
> Using global rwlocks as the backend for per-CPU rwlocks helps us avoid many
> lock-ordering related problems (unlike per-cpu locks). However, global

So, unfortunately, this already seems broken, right?  The problem here
seems to be that previously, say, read_lock() implied
preempt_disable() but as this series aims to move away from it, it
introduces the problem of locking order between such locks and the new
contruct.

The only two options are either punishing writers or identifying and
updating all such possible deadlocks.  percpu_rwsem does the former,
right?  I don't know how feasible the latter would be.  Srivatsa,
you've been looking at all the places which would require conversion,
how difficult would doing the latter be?

> +#define reader_uses_percpu_refcnt(pcpu_rwlock, cpu)			\
> +		(ACCESS_ONCE(per_cpu(*((pcpu_rwlock)->reader_refcnt), cpu)))
> +
> +#define reader_nested_percpu(pcpu_rwlock)				\
> +			(__this_cpu_read(*((pcpu_rwlock)->reader_refcnt)) > 1)
> +
> +#define writer_active(pcpu_rwlock)					\
> +			(__this_cpu_read(*((pcpu_rwlock)->writer_signal)))

Why are these in the public header file?  Are they gonna be used to
inline something?

> +static inline void raise_writer_signal(struct percpu_rwlock *pcpu_rwlock,
> +				       unsigned int cpu)
> +{
> +	per_cpu(*pcpu_rwlock->writer_signal, cpu) = true;
> +}
> +
> +static inline void drop_writer_signal(struct percpu_rwlock *pcpu_rwlock,
> +				      unsigned int cpu)
> +{
> +	per_cpu(*pcpu_rwlock->writer_signal, cpu) = false;
> +}
> +
> +static void announce_writer_active(struct percpu_rwlock *pcpu_rwlock)
> +{
> +	unsigned int cpu;
> +
> +	for_each_online_cpu(cpu)
> +		raise_writer_signal(pcpu_rwlock, cpu);
> +
> +	smp_mb(); /* Paired with smp_rmb() in percpu_read_[un]lock() */
> +}
> +
> +static void announce_writer_inactive(struct percpu_rwlock *pcpu_rwlock)
> +{
> +	unsigned int cpu;
> +
> +	drop_writer_signal(pcpu_rwlock, smp_processor_id());
> +
> +	for_each_online_cpu(cpu)
> +		drop_writer_signal(pcpu_rwlock, cpu);
> +
> +	smp_mb(); /* Paired with smp_rmb() in percpu_read_[un]lock() */
> +}

It could be just personal preference but I find the above one line
wrappers more obfuscating than anything else.  What's the point of
wrapping writer_signal = true/false into a separate function?  These
simple wrappers just add layers that people have to dig through to
figure out what's going on without adding anything of value.  I'd much
prefer collapsing these into the percpu_write_[un]lock().

Thanks.

-- 
tejun
