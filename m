Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLV3K4dG6zDrLP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 16:31:41 +1000 (AEST)
In-Reply-To: <1501161817-4654-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: tglx@linutronix.de
Subject: Re: powerpc/smp: Call smp_ops->setup_cpu() directly on the boot CPU
Message-Id: <3xLV3K2XfPz9sRr@ozlabs.org>
Date: Mon, 31 Jul 2017 16:31:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-07-27 at 13:23:37 UTC, Michael Ellerman wrote:
> In smp_cpus_done() we need to call smp_ops->setup_cpu() for the boot
> CPU, which means it has to run *on* the boot CPU.
> 
> In the past we ensured it ran on the boot CPU by changing the CPU
> affinity mask of current directly. That was removed in commit
> 6d11b87d55eb ("powerpc/smp: Replace open coded task affinity logic"),
> and replaced with a work queue call.
> 
> Unfortunately using a work queue leads to a lockdep warning, now that
> the CPU hotplug lock is a regular semaphore:
> 
>   ======================================================
>   WARNING: possible circular locking dependency detected
>   ...
>   kworker/0:1/971 is trying to acquire lock:
>    (cpu_hotplug_lock.rw_sem){++++++}, at: [<c000000000100974>] apply_workqueue_attrs+0x34/0xa0
> 
>   but task is already holding lock:
>    ((&wfc.work)){+.+.+.}, at: [<c0000000000fdb2c>] process_one_work+0x25c/0x800
>   ...
>        CPU0                    CPU1
>        ----                    ----
>   lock((&wfc.work));
>                                lock(cpu_hotplug_lock.rw_sem);
>                                lock((&wfc.work));
>   lock(cpu_hotplug_lock.rw_sem);
> 
> Although the deadlock can't happen in practice, because
> smp_cpus_done() only runs in early boot before CPU hotplug is allowed,
> lockdep can't tell that.
> 
> Luckily in commit 8fb12156b8db ("init: Pin init task to the boot CPU,
> initially") tglx changed the generic code to pin init to the boot CPU
> to begin with. The unpinning of init from the boot CPU happens in
> sched_init_smp(), which is called after smp_cpus_done().
> 
> So smp_cpus_done() is always called on the boot CPU, which means we
> don't need the work queue call at all - and the lockdep warning goes
> away.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/7b7622bb95eb587cbaa79608e47b83

cheers
