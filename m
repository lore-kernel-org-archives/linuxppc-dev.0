Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 31AF4DDD0D
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 05:00:19 +1000 (EST)
Date: Fri, 17 Aug 2007 11:59:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michael Neuling <mikey@neuling.org>, Jay Lan <jlan@engr.sgi.com>
Subject: Re: [PATCH 1/2] Add scaled time to taskstats based process accounting
Message-Id: <20070817115951.e1368a7d.akpm@linux-foundation.org>
In-Reply-To: <19998.1187312981@neuling.org>
References: <20070816070922.37B5370074@localhost.localdomain>
	<46C3FC41.4000609@linux.vnet.ibm.com>
	<19998.1187312981@neuling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Benjamin, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 17 Aug 2007 11:09:41 +1000
Michael Neuling <mikey@neuling.org> wrote:

> This adds items to the taststats struct to account for user and system
> time based on scaling the CPU frequency and instruction issue rates.
> 
> Adds account_(user|system)_time_scaled callbacks which architectures
> can use to account for time using this mechanism.
> 
> ...
> 
> Index: linux-2.6-ozlabs/include/linux/kernel_stat.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/include/linux/kernel_stat.h
> +++ linux-2.6-ozlabs/include/linux/kernel_stat.h
> @@ -52,7 +52,9 @@ static inline int kstat_irqs(int irq)
>  }
>  
>  extern void account_user_time(struct task_struct *, cputime_t);
> +extern void account_user_time_scaled(struct task_struct *, cputime_t);
>  extern void account_system_time(struct task_struct *, int, cputime_t);
> +extern void account_system_time_scaled(struct task_struct *, cputime_t);
>  extern void account_steal_time(struct task_struct *, cputime_t);
>  
>  #endif /* _LINUX_KERNEL_STAT_H */
> Index: linux-2.6-ozlabs/include/linux/sched.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/include/linux/sched.h
> +++ linux-2.6-ozlabs/include/linux/sched.h
> @@ -1020,7 +1020,7 @@ struct task_struct {
>  	int __user *clear_child_tid;		/* CLONE_CHILD_CLEARTID */
>  
>  	unsigned int rt_priority;
> -	cputime_t utime, stime;
> +	cputime_t utime, stime, utimescaled, stimescaled;

Adding 8 or 16 bytes to the task_struct for all architectures for something
which only powerpc uses?

Is there any prospect that other CPUs can use this?

>  	unsigned long nvcsw, nivcsw; /* context switch counts */
>  	struct timespec start_time; 		/* monotonic time */
>  	struct timespec real_start_time;	/* boot based time */
> Index: linux-2.6-ozlabs/include/linux/taskstats.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/include/linux/taskstats.h
> +++ linux-2.6-ozlabs/include/linux/taskstats.h
> @@ -31,7 +31,7 @@
>   */
>  
>  
> -#define TASKSTATS_VERSION	5
> +#define TASKSTATS_VERSION	6
>  #define TS_COMM_LEN		32	/* should be >= TASK_COMM_LEN
>  					 * in linux/sched.h */
>  
> @@ -85,9 +85,12 @@ struct taskstats {
>  	 * On some architectures, value will adjust for cpu time stolen
>  	 * from the kernel in involuntary waits due to virtualization.
>  	 * Value is cumulative, in nanoseconds, without a corresponding count
> -	 * and wraps around to zero silently on overflow
> +	 * and wraps around to zero silently on overflow.  The
> +	 * _scaled_ version accounts for cpus which can scale the
> +	 * number of instructions executed each cycle.
>  	 */
>  	__u64	cpu_run_real_total;
> +	__u64	cpu_scaled_run_real_total;
>  
>  	/* cpu "virtual" running time
>  	 * Uses time intervals seen by the kernel i.e. no adjustment
> @@ -142,6 +145,10 @@ struct taskstats {
>  	__u64	write_char;		/* bytes written */
>  	__u64	read_syscalls;		/* read syscalls */
>  	__u64	write_syscalls;		/* write syscalls */
> +
> +	/* time accounting for SMT machines */
> +	__u64	ac_utimescaled;		/* utime scaled on frequency etc */
> +	__u64	ac_stimescaled;		/* stime scaled on frequency etc */
>  	/* Extended accounting fields end */

umm, should we be adding new fields in the middle of this message?  I
thought we should only add to the end, for back-compatibility, but maybe I
misremember.
