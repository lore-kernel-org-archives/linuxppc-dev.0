Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 3491A2C02BC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 07:14:43 +1100 (EST)
Date: Sun, 10 Feb 2013 21:13:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 04/45] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
Message-ID: <20130210201312.GB6236@redhat.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073347.13822.85876.stgit@srivatsabhat.in.ibm.com>
 <20130208231017.GK2666@linux.vnet.ibm.com>
 <5117F0C0.2030605@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5117F0C0.2030605@linux.vnet.ibm.com>
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 mingo@kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
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

On 02/11, Srivatsa S. Bhat wrote:
>
> On 02/09/2013 04:40 AM, Paul E. McKenney wrote:
> >> +static void announce_writer_inactive(struct percpu_rwlock *pcpu_rwlock)
> >> +{
> >> +	unsigned int cpu;
> >> +
> >> +	drop_writer_signal(pcpu_rwlock, smp_processor_id());
> >
> > Why do we drop ourselves twice?  More to the point, why is it important to
> > drop ourselves first?
> >
>
> I don't see where we are dropping ourselves twice. Note that we are no longer
> in the cpu_online_mask, so the 'for' loop below won't include us. So we need
> to manually drop ourselves. It doesn't matter whether we drop ourselves first
> or later.

Yes, but this just reflects its usage in cpu-hotplug. cpu goes away under
_write_lock.

Perhaps _write_lock/unlock shoud use for_each_possible_cpu() instead?

Hmm... I think this makes sense anyway. Otherwise, in theory,
percpu_write_lock(random_non_hotplug_lock) can race with cpu_up?

Oleg.
