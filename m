Return-Path: <dzickus@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5Yk53FTTzDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 07:32:12 +1100 (AEDT)
Date: Mon, 2 Oct 2017 16:32:09 -0400
From: Don Zickus <dzickus@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC GIT Pull] core watchdog sanitizing
Message-ID: <20171002203209.rjug625pfmgh674j@redhat.com>
References: <alpine.DEB.2.20.1710011217510.3874@nanos>
 <CA+55aFxQsmSb=zohGZOZK7eR4n5xOHNArmCa9j1b7+wJ+khQrg@mail.gmail.com>
 <alpine.DEB.2.20.1710021957480.2114@nanos>
 <CA+55aFyVX_aPac8dSJPED-XLTtfQOYe_eCV7HdYKABgGazWHAg@mail.gmail.com>
 <alpine.DEB.2.20.1710022105570.2114@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1710022105570.2114@nanos>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 02, 2017 at 07:32:57PM +0000, Thomas Gleixner wrote:
> On Mon, 2 Oct 2017, Linus Torvalds wrote:
> > Side note: would it perhaps make sense to have that
> > cpus_read_lock/unlock() sequence around the whole reconfiguration
> > section?
> > 
> > Because while looking at that sequence, it looks a bit odd to me that
> > cpu's can come and go in the middle of the nmi watchdog
> > reconfiguration sequence.
> > 
> > In particular, what happens if a new CPU is brought up just as the NMI
> > matchdog is being reconfigured? The NMI's have been stopped for the
> > old CPU's, what happens for the new one that came up in between that
> > watchdog_nmi_stop/start?
> > 
> > This may be all obviously safe, I'm just asking for clarification.
> 
> It's safe because the newly upcoming CPU will see an empty enabled mask in
> the powerpc implementation. The perf based implementation has a similar
> protection.
> 
> Though yes, it would be more obvious to expand the cpus locked
> section. That requires a bit of shuffling. Untested patch below.
> 
> Thanks,
> 
> 	tglx
> 
> 8<------------------
> 
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -359,21 +359,17 @@ void watchdog_nmi_stop(void)
>  {
>  	int cpu;
>  
> -	cpus_read_lock();
>  	for_each_cpu(cpu, &wd_cpus_enabled)
>  		stop_wd_on_cpu(cpu);
> -	cpus_read_unlock();
>  }
>  
>  void watchdog_nmi_start(void)
>  {
>  	int cpu;
>  
> -	cpus_read_lock();
>  	watchdog_calc_timeouts();
>  	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask)
>  		start_wd_on_cpu(cpu);
> -	cpus_read_unlock();
>  }
>  
>  /*
> --- a/kernel/smpboot.c
> +++ b/kernel/smpboot.c
> @@ -351,7 +351,7 @@ void smpboot_update_cpumask_percpu_threa
>  	static struct cpumask tmp;
>  	unsigned int cpu;
>  
> -	get_online_cpus();
> +	lockdep_assert_cpus_held();
>  	mutex_lock(&smpboot_threads_lock);
>  
>  	/* Park threads that were exclusively enabled on the old mask. */
> @@ -367,7 +367,6 @@ void smpboot_update_cpumask_percpu_threa
>  	cpumask_copy(old, new);
>  
>  	mutex_unlock(&smpboot_threads_lock);
> -	put_online_cpus();
>  }
>  
>  static DEFINE_PER_CPU(atomic_t, cpu_hotplug_state) = ATOMIC_INIT(CPU_POST_DEAD);
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -535,7 +535,6 @@ static void softlockup_update_smpboot_th
>  
>  	smpboot_update_cpumask_percpu_thread(&watchdog_threads,
>  					     &watchdog_allowed_mask);
> -	__lockup_detector_cleanup();
>  }
>  
>  /* Temporarily park all watchdog threads */
> @@ -554,6 +553,7 @@ static void softlockup_unpark_threads(vo
>  
>  static void softlockup_reconfigure_threads(void)

There is a second copy of ^^^^, you will need to add identical locking there
too.

I can test both of these patches tomorrow.

Cheers,
Don

>  {
> +	cpus_read_lock();
>  	watchdog_nmi_stop();
>  	softlockup_park_all_threads();
>  	set_sample_period();
> @@ -561,6 +561,12 @@ static void softlockup_reconfigure_threa
>  	if (watchdog_enabled && watchdog_thresh)
>  		softlockup_unpark_threads();
>  	watchdog_nmi_start();
> +	cpus_read_unlock();
> +	/*
> +	 * Must be called outside the cpus locked section to prevent
> +	 * recursive locking in the perf code.
> +	 */
> +	__lockup_detector_cleanup();
>  }
>  
>  /*
> 
