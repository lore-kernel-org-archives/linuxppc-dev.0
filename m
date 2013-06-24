Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 306362C0099
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 09:26:08 +1000 (EST)
Message-ID: <1372116363.18733.189.camel@gandalf.local.home>
Subject: Re: [PATCH 04/45] CPU hotplug: Add infrastructure to check lacking
 hotplug synchronization
From: Steven Rostedt <rostedt@goodmis.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Mon, 24 Jun 2013 19:26:03 -0400
In-Reply-To: <20130623133841.19094.69631.stgit@srivatsabhat.in.ibm.com>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
 <20130623133841.19094.69631.stgit@srivatsabhat.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 Alex Shi <alex.shi@intel.com>, vincent.guittot@linaro.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 xiaoguangrong@linux.vnet.ibm.com,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, wangyun@linux.vnet.ibm.com,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 namhyung@kernel.org, tglx@linutronix.de, laijs@cn.fujitsu.com,
 zhong@linux.vnet.ibm.com, netdev@vger.kernel.org, oleg@redhat.com, sbw@mit.edu,
 tj@kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-06-23 at 19:08 +0530, Srivatsa S. Bhat wrote:


Just to make the code a little cleaner, can you add:

> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 860f51a..e90d9d7 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -63,6 +63,72 @@ static struct {
>  	.refcount = 0,
>  };
>  
> +#ifdef CONFIG_DEBUG_HOTPLUG_CPU
> +
> +static DEFINE_PER_CPU(unsigned long, atomic_reader_refcnt);
> +
> +static int current_is_hotplug_safe(const struct cpumask *mask)
> +{
> +
> +	/* If we are not dealing with cpu_online_mask, don't complain. */
> +	if (mask != cpu_online_mask)
> +		return 1;
> +
> +	/* If this is the task doing hotplug, don't complain. */
> +	if (unlikely(current == cpu_hotplug.active_writer))
> +		return 1;
> +
> +	/* If we are in early boot, don't complain. */
> +	if (system_state != SYSTEM_RUNNING)
> +		return 1;
> +
> +	/*
> +	 * Check if the current task is in atomic context and it has
> +	 * invoked get_online_cpus_atomic() to synchronize with
> +	 * CPU Hotplug.
> +	 */
> +	if (preempt_count() || irqs_disabled())
> +		return this_cpu_read(atomic_reader_refcnt);
> +	else
> +		return 1; /* No checks for non-atomic contexts for now */
> +}
> +
> +static inline void warn_hotplug_unsafe(void)
> +{
> +	WARN_ONCE(1, "Must use get/put_online_cpus_atomic() to synchronize"
> +		     " with CPU hotplug\n");
> +}
> +
> +/*
> + * Check if the task (executing in atomic context) has the required protection
> + * against CPU hotplug, while accessing the specified cpumask.
> + */
> +void check_hotplug_safe_cpumask(const struct cpumask *mask)
> +{
> +	if (!current_is_hotplug_safe(mask))
> +		warn_hotplug_unsafe();
> +}
> +EXPORT_SYMBOL_GPL(check_hotplug_safe_cpumask);
> +
> +/*
> + * Similar to check_hotplug_safe_cpumask(), except that we don't complain
> + * if the task (executing in atomic context) is testing whether the CPU it
> + * is executing on is online or not.
> + *
> + * (A task executing with preemption disabled on a CPU, automatically prevents
> + *  offlining that CPU, irrespective of the actual implementation of CPU
> + *  offline. So we don't enforce holding of get_online_cpus_atomic() for that
> + *  case).
> + */
> +void check_hotplug_safe_cpu(unsigned int cpu, const struct cpumask *mask)
> +{
> +	if(!current_is_hotplug_safe(mask) && cpu != smp_processor_id())
> +		warn_hotplug_unsafe();
> +}
> +EXPORT_SYMBOL_GPL(check_hotplug_safe_cpu);
> +

static inline void atomic_reader_refcnt_inc(void)
{
	this_cpu_inc(atomic_reader_refcnt);
}
static inline void atomic_reader_refcnt_dec(void)
{
	this_cpu_dec(atomic_reader_refcnt);
}

#else
static inline void atomic_reader_refcnt_inc(void)
{
}
static inline void atomic_reader_refcnt_dec(void)
{
}
#endif

> +#endif
> +
>  void get_online_cpus(void)
>  {
>  	might_sleep();
> @@ -189,13 +255,22 @@ unsigned int get_online_cpus_atomic(void)
>  	 * from going offline.
>  	 */
>  	preempt_disable();
> +
> +#ifdef CONFIG_DEBUG_HOTPLUG_CPU
> +	this_cpu_inc(atomic_reader_refcnt);
> +#endif

Replace the #ifdef with just:

	atomic_reader_refcnt_inc();

>  	return smp_processor_id();
>  }
>  EXPORT_SYMBOL_GPL(get_online_cpus_atomic);
>  
>  void put_online_cpus_atomic(void)
>  {
> +
> +#ifdef CONFIG_DEBUG_HOTPLUG_CPU
> +	this_cpu_dec(atomic_reader_refcnt);
> +#endif

And

	atomic_reader_refcnt_dec();

-- Steve

>  	preempt_enable();
> +
>  }
>  EXPORT_SYMBOL_GPL(put_online_cpus_atomic);
>  
