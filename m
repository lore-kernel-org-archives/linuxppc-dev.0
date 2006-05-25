Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5AD7567A41
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 12:30:45 +1000 (EST)
Subject: Re: via-pmu runs device_power_down in atomic context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1148457661.11734.9.camel@johannes>
References: <1148457661.11734.9.camel@johannes>
Content-Type: text/plain
Date: Thu, 25 May 2006 12:28:15 +1000
Message-Id: <1148524096.13249.119.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-24 at 10:01 +0200, Johannes Berg wrote:
> Hey,
> 
> Everytime I suspend my powerbook, I see the following trace:
> 
> [10655.887546] BUG: sleeping function called from invalid context at include/linux/rwsem.h:43
> [10655.887558] in_atomic():0, irqs_disabled():1
> [10655.887562] Call Trace:
> [10655.887565] [C581BD20] [C00081E8] show_stack+0x50/0x190 (unreliable)
> [10655.887582] [C581BD50] [C0023BB0] __might_sleep+0xcc/0xe8
> [10655.887592] [C581BD60] [C0038290] blocking_notifier_call_chain+0x2c/0xc0
> [10655.887606] [C581BD80] [C01E90C0] cpufreq_suspend+0x130/0x148
> [10655.887616] [C581BDB0] [C019D9E8] sysdev_suspend+0x10c/0x300
> [10655.887627] [C581BDF0] [C01A3888] device_power_down+0x74/0xac
> [10655.887636] [C581BE10] [C01B1264] pmac_suspend_devices+0x98/0x188
> [10655.887643] [C581BE30] [C01B18F0] pmu_ioctl+0x59c/0xbc0
> [10655.887649] [C581BED0] [C008E898] do_ioctl+0x80/0x84
> [10655.887660] [C581BEE0] [C008E928] vfs_ioctl+0x8c/0x48c
> [10655.887666] [C581BF10] [C008ED68] sys_ioctl+0x40/0x74
> [10655.887673] [C581BF40] [C000F3A4] ret_from_syscall+0x0/0x38
> 
> The might_sleep() comes from down_read() and this happens because
> blocking_notifier_call_chain calls it, it is also commented to run in
> process context so this is all proper.

device_power_down should be called with interrupts off, thus the PMU
driver is fine. It's a misnamed function, it calls the sysdev's suspend
and those should be called with irq off. I think the problem is more due
to some cpufreq or notifier change that somebody done to recent kernels
and that added some might_sleep.... I wonder why. 

Andrew, what's up there ? What is this new
"blocking_notifier_call_chain" thing ? notifiers use to not use
semaphores and not be blocking... at least powermac implementation of
cpufreq relies on that.

> However, it obviously isn't run at process context. Looking why, I see
> this in via-pmu.c:
>         /* We can now disable MSR_EE. This code of course works properly only
>          * on UP machines... For SMP, if we ever implement sleep, we'll have to
>          * stop the "other" CPUs way before we do all that stuff.
>          */
>         local_irq_disable();
> 
>         /* Broadcast power down irq
>          * This isn't that useful in most cases (only directly wired devices can
>          * use this but still... This will take care of sysdev's as well, so
>          * we exit from here with local irqs disabled and PIC off.
>          */
>         ret = device_power_down(PMSG_SUSPEND);
> 
> Apparently this was a deliberate decision.
> 
> So the question is: which is correct? I can test and submit a patch to
> fix the issue at either end; if cpufreq is wrong I'd move from a
> blocking_ to an atomic_notifier_call_chain, if via-pmu.c is wrong I'd
> call device_power_down earlier...
> 
> johannes
