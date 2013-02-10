Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 7CA112C0292
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 05:43:39 +1100 (EST)
Date: Sun, 10 Feb 2013 19:42:09 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 05/45] percpu_rwlock: Make percpu-rwlocks IRQ-safe,
 optimally
Message-ID: <20130210184209.GA3041@redhat.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073400.13822.52336.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130122073400.13822.52336.stgit@srivatsabhat.in.ibm.com>
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

only one cosmetic nit...

On 01/22, Srivatsa S. Bhat wrote:
>
> +#define READER_PRESENT		(1UL << 16)
> +#define READER_REFCNT_MASK	(READER_PRESENT - 1)
> +
>  #define reader_uses_percpu_refcnt(pcpu_rwlock, cpu)			\
>  		(ACCESS_ONCE(per_cpu(*((pcpu_rwlock)->reader_refcnt), cpu)))
>
>  #define reader_nested_percpu(pcpu_rwlock)				\
> -			(__this_cpu_read(*((pcpu_rwlock)->reader_refcnt)) > 1)
> +	(__this_cpu_read(*((pcpu_rwlock)->reader_refcnt)) & READER_REFCNT_MASK)
>
>  #define writer_active(pcpu_rwlock)					\
>  			(__this_cpu_read(*((pcpu_rwlock)->writer_signal)))

I think this all can go to lib/percpu-rwlock.c. Nobody needs to know
these implementation details.

Oleg.
