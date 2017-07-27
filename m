Return-Path: <srs0=t3cf=66=linutronix.de=tglx@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJD0B1LzSzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 23:51:06 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xJD096mrcz8sWS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 23:51:05 +1000 (AEST)
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xJD086sfkz9s74
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2017 23:51:04 +1000 (AEST)
Date: Thu, 27 Jul 2017 15:26:00 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/smp: Call smp_ops->setup_cpu() directly on the
 boot CPU
In-Reply-To: <1501161817-4654-1-git-send-email-mpe@ellerman.id.au>
Message-ID: <alpine.DEB.2.20.1707271525450.1903@nanos>
References: <1501161817-4654-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 27 Jul 2017, Michael Ellerman wrote:
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

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
