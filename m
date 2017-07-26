Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHYWv1PxkzDqmS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 21:57:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: tglx@linutronix.de <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>
Subject: Possible circular locking dependency detected between
 cpu_hotplug_lock.rw_sem and wfc.work
Date: Wed, 26 Jul 2017 21:57:45 +1000
Message-ID: <87mv7r5s1y.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Thomas,

I'm seeing the lockdep barf below on some bare metal Power8 machines.

This seems to be caused by our smp_cpus_done(), which does:

  void __init smp_cpus_done(unsigned int max_cpus)
  {
  	/*
  	 * We want the setup_cpu() here to be called on the boot CPU, but
  	 * init might run on any CPU, so make sure it's invoked on the boot
  	 * CPU.
  	 */
  	if (smp_ops && smp_ops->setup_cpu)
  		work_on_cpu_safe(boot_cpuid, smp_setup_cpu_workfn, NULL);


I don't think CPU hotplug can happen at this point, so I don't think
there's really a bug.

But it looks like the work_on_cpu_safe() call could just go away, since
you pinned init to the boot CPU in 8fb12156b8db ("init: Pin init task to
the boot CPU, initially"). Though I can't see where init is unpinned, so
maybe we do still need to do it?

cheers


[    1.468911] ipr: IBM Power RAID SCSI Device Driver version: 2.6.4 (March 14, 2017)
[    1.469032] ipr 0001:08:00.0: Found IOA with IRQ: 0
[    1.469167] 
[    1.469193] ======================================================
[    1.469250] WARNING: possible circular locking dependency detected
[    1.469309] 4.12.0-gcc6-gb40b238 #1 Not tainted
[    1.469355] ------------------------------------------------------
[    1.469413] kworker/0:1/971 is trying to acquire lock:
[    1.469459]  (cpu_hotplug_lock.rw_sem){++++++}, at: [<c000000000100974>] apply_workqueue_attrs+0x34/0xa0
[    1.469544] 
[    1.469544] but task is already holding lock:
[    1.469602]  ((&wfc.work)){+.+.+.}, at: [<c0000000000fdb2c>] process_one_work+0x25c/0x800
[    1.469674] 
[    1.469674] which lock already depends on the new lock.
[    1.469674] 
[    1.469744] 
[    1.469744] the existing dependency chain (in reverse order) is:
[    1.469813] 
[    1.469813] -> #1 ((&wfc.work)){+.+.+.}:
[    1.469862]        flush_work+0x74/0x340
[    1.469898]        work_on_cpu+0xb8/0xe0
[    1.469934]        work_on_cpu_safe+0x80/0xd0
[    1.469982]        smp_cpus_done+0x54/0xb0
[    1.470017]        smp_init+0x1a0/0x1cc
[    1.470053]        kernel_init_freeable+0x1f4/0x3b0
[    1.470100]        kernel_init+0x24/0x160
[    1.470137]        ret_from_kernel_thread+0x5c/0x74
[    1.470183] 
[    1.470183] -> #0 (cpu_hotplug_lock.rw_sem){++++++}:
[    1.470244]        lock_acquire+0xec/0x2e0
[    1.470279]        cpus_read_lock+0x4c/0xd0
[    1.470315]        apply_workqueue_attrs+0x34/0xa0
[    1.470362]        __alloc_workqueue_key+0x1b4/0x5b4
[    1.470410]        scsi_host_alloc+0x328/0x4b0
[    1.470457]        ipr_probe+0xb4/0x1f00
[    1.470493]        local_pci_probe+0x6c/0x140
[    1.470541]        work_for_cpu_fn+0x38/0x60
[    1.470588]        process_one_work+0x310/0x800
[    1.470635]        worker_thread+0x2b0/0x520
[    1.470682]        kthread+0x164/0x1b0
[    1.470718]        ret_from_kernel_thread+0x5c/0x74
[    1.470764] 
[    1.470764] other info that might help us debug this:
[    1.470764] 
[    1.470834]  Possible unsafe locking scenario:
[    1.470834] 
[    1.470891]        CPU0                    CPU1
[    1.470937]        ----                    ----
[    1.470984]   lock((&wfc.work));
[    1.471020]                                lock(cpu_hotplug_lock.rw_sem);
[    1.471078]                                lock((&wfc.work));
[    1.471136]   lock(cpu_hotplug_lock.rw_sem);
[    1.471183] 
[    1.471183]  *** DEADLOCK ***
[    1.471183] 
[    1.471242] 2 locks held by kworker/0:1/971:
[    1.471289]  #0:  ("events"){.+.+.+}, at: [<c0000000000fdb2c>] process_one_work+0x25c/0x800
[    1.471360]  #1:  ((&wfc.work)){+.+.+.}, at: [<c0000000000fdb2c>] process_one_work+0x25c/0x800
[    1.471488] 
[    1.471488] stack backtrace:
[    1.471582] CPU: 0 PID: 971 Comm: kworker/0:1 Not tainted 4.12.0-gcc6-gb40b238 #1
[    1.471721] Workqueue: events work_for_cpu_fn
[    1.471813] Call Trace:
[    1.471859] [c0000007f877f560] [c000000000b491b8] dump_stack+0xe8/0x160 (unreliable)
[    1.471996] [c0000007f877f5a0] [c000000000153e68] print_circular_bug+0x288/0x3d0
[    1.472133] [c0000007f877f640] [c000000000157ec8] __lock_acquire+0x1858/0x1a20
[    1.472271] [c0000007f877f7b0] [c000000000158bfc] lock_acquire+0xec/0x2e0
[    1.472386] [c0000007f877f880] [c0000000000d4f8c] cpus_read_lock+0x4c/0xd0
[    1.472501] [c0000007f877f8b0] [c000000000100974] apply_workqueue_attrs+0x34/0xa0
[    1.472639] [c0000007f877f8f0] [c000000000102ef4] __alloc_workqueue_key+0x1b4/0x5b4
[    1.472776] [c0000007f877f9b0] [c00000000078cd58] scsi_host_alloc+0x328/0x4b0
[    1.472913] [c0000007f877fa50] [c0000000007bd414] ipr_probe+0xb4/0x1f00
[    1.473028] [c0000007f877fbb0] [c0000000006157fc] local_pci_probe+0x6c/0x140
[    1.473166] [c0000007f877fc40] [c0000000000f8298] work_for_cpu_fn+0x38/0x60
[    1.473281] [c0000007f877fc70] [c0000000000fdbe0] process_one_work+0x310/0x800
[    1.473418] [c0000007f877fd30] [c0000000000fe380] worker_thread+0x2b0/0x520
[    1.473534] [c0000007f877fdc0] [c000000000107c84] kthread+0x164/0x1b0
[    1.473649] [c0000007f877fe30] [c00000000000b6e8] ret_from_kernel_thread+0x5c/0x74
