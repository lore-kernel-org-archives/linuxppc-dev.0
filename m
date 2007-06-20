Return-Path: <mita@fixstars.com>
Message-ID: <36420.202.32.178.37.1182306728.squirrel@webmail.fixstars.com>
In-Reply-To: <20070618224923.221791941@arndb.de>
References: <20070618224247.972139855@arndb.de>
	<20070618224923.221791941@arndb.de>
Date: Wed, 20 Jun 2007 11:32:08 +0900 (JST)
Subject: Re: [Cbe-oss-dev] [patch 2/5] Add support to OProfile for profiling
	Cell/B.E. SPUs
From: mita@fixstars.com
To: "Arnd Bergmann" <arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-2022-jp
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Maynard Johnson <mpjohn@us.ibm.com>,
	cbe-oss-dev@ozlabs.org, Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +static enum hrtimer_restart profile_spus(struct hrtimer * timer)
> +{
> +	ktime_t kt;
> +	int cpu, node, k, num_samples, spu_num;
> +
> +	if (!spu_prof_running)
> +		goto stop;
> +
> +	for_each_online_cpu(cpu) {
> +		if (cbe_get_hw_thread_id(cpu))
> +			continue;
> +
> +		node = cbe_cpu_to_node(cpu);
> +
> +		/* There should only be on kernel thread at a time processing
> +		 * the samples.	 In the very unlikely case that the processing
> +		 * is taking a very long time and multiple kernel threads are
> +		 * started to process the samples.  Make sure only one kernel
> +		 * thread is working on the samples array at a time.  The
> +		 * sample array must be loaded and then processed for a given
> +		 * cpu.	 The sample array is not per cpu.
> +		 */
> +		spin_lock_irqsave(&sample_array_lock,
> +				  sample_array_lock_flags);
> +		num_samples = cell_spu_pc_collection(cpu);
> +
> +		if (num_samples == 0) {
> +			spin_unlock_irqrestore(&sample_array_lock,
> +					       sample_array_lock_flags);
> +			continue;
> +		}
> +
> +		for (k = 0; k < SPUS_PER_NODE; k++) {
> +			spu_num = k + (node * SPUS_PER_NODE);
> +			spu_sync_buffer(spu_num,
> +					samples + (k * TRACE_ARRAY_SIZE),
> +					num_samples);
> +		}
> +
> +		spin_unlock_irqrestore(&sample_array_lock,
> +				       sample_array_lock_flags);
> +
> +	}
> +	smp_wmb();
> +
> +	kt = ktime_set(0, profiling_interval);
> +	if (!spu_prof_running)
> +		goto stop;
> +	hrtimer_forward(timer, timer->base->get_time(), kt);
> +	return HRTIMER_RESTART;
> +
> + stop:
> +	printk(KERN_INFO "SPU_PROF: spu-prof timer ending\n");
> +	return HRTIMER_NORESTART;
> +}
> +
> +static struct hrtimer timer;
> +/*
> + * Entry point for SPU profiling.
> + * NOTE:  SPU profiling is done system-wide, not per-CPU.
> + *
> + * cycles_reset is the count value specified by the user when
> + * setting up OProfile to count SPU_CYCLES.
> + */
> +void start_spu_profiling(unsigned int cycles_reset) {
> +
> +	ktime_t kt;
> +
> +	pr_debug("timer resolution: %lu\n",
> +		 TICK_NSEC);
> +	kt = ktime_set(0, profiling_interval);
> +	hrtimer_init(&timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	timer.expires = kt;
> +	timer.function = profile_spus;
> +
> +	/* Allocate arrays for collecting SPU PC samples */
> +	samples = (u32 *) kzalloc(SPUS_PER_NODE *
> +				  TRACE_ARRAY_SIZE * sizeof(u32), GFP_KERNEL);
> +

 - Unnecessary cast for kzalloc().

 - Allocation failure is ignored here. But there is no error handling
   in timer fuction (profile_spus), too.

> +	spu_prof_running = 1;
> +	hrtimer_start(&timer, kt, HRTIMER_MODE_REL);
> +}
> +
