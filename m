Return-Path: <kda@linux-powerpc.org>
Received: from mail-pg0-x22f.google.com (mail-pg0-x22f.google.com
 [IPv6:2607:f8b0:400e:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsGSN2JHNzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 01:22:11 +1100 (AEDT)
Received: by mail-pg0-x22f.google.com with SMTP id g2so41322734pge.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 07:22:11 -0700 (PDT)
MIME-Version: 1.0
From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Mon, 27 Mar 2017 17:22:07 +0300
Message-ID: <CAOJe8K3iHAP8LTAL16b1=BxDbEDpxEGEEiAj6_UbyDFgNUX_kw@mail.gmail.com>
Subject: tty/hvc: possible irq lock inversion dependency detected
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Ok, now we have a new locking issue with interrupts which I found on my P8 box.
I haven't found where we take the console_lock, only in hvc_remove.

BTW, Ben, looks like it's a bug in hvc_remove:
we take spin_lock and then semaphore lock.

[178327.461954] =========================================================
[178327.462043] [ INFO: possible irq lock inversion dependency detected ]
[178327.462105] 4.11.0-rc3-00022-gc7e790c #1 Not tainted
[178327.462154] ---------------------------------------------------------
[178327.462216] swapper/0/0 just changed the state of lock:
[178327.462266]  (&(&hp->lock)->rlock){-.....}, at:
[<c0000000020121dc>] .hvc_poll+0x4c/0x380
[178327.462348] but this lock took another, HARDIRQ-unsafe lock in the past:
[178327.462409]  (console_lock){+.+.+.}
[178327.462414]

and interrupts could create inverse lock ordering between them.

[178327.462559]
other info that might help us debug this:
[178327.462621]  Possible interrupt unsafe locking scenario:

[178327.462682]        CPU0                    CPU1
[178327.462731]        ----                    ----
[178327.462780]   lock(console_lock);
[178327.462820]                                local_irq_disable();
[178327.462880]                                lock(&(&hp->lock)->rlock);
[178327.462945]                                lock(console_lock);
[178327.463008]   <Interrupt>
[178327.463034]     lock(&(&hp->lock)->rlock);
[178327.463074]
 *** DEADLOCK ***

[178327.463137] no locks held by swapper/0/0.
[178327.463174]
the shortest dependencies between 2nd lock and 1st lock:
[178327.463248]  -> (console_lock){+.+.+.} ops: 6747393622016 {
[178327.463316]     HARDIRQ-ON-W at:
[178327.463359]                       .lock_acquire+0xf0/0x340
[178327.463410]                       .console_lock+0x60/0xa0
[178327.463463]                       .con_init+0x24/0x2d0
[178327.463514]                       .console_init+0x4c/0x6c
[178327.463566]                       .start_kernel+0x3d4/0x584
[178327.463629]                       start_here_common+0x1c/0x520
[178327.463690]     SOFTIRQ-ON-W at:
[178327.463731]                       .lock_acquire+0xf0/0x340
[178327.463782]                       .console_lock+0x60/0xa0
[178327.463833]                       .con_init+0x24/0x2d0
[178327.463884]                       .console_init+0x4c/0x6c
[178327.463935]                       .start_kernel+0x3d4/0x584
[178327.463998]                       start_here_common+0x1c/0x520
[178327.464059]     RECLAIM_FS-ON-W at:
[178327.464100]                          .lockdep_trace_alloc+0xa8/0x180
[178327.464163]                          .kmem_cache_alloc_trace+0x5c/0x4f0
[178327.464227]                          .device_create_groups_vargs+0x74/0x1b0
[178327.464301]                          .device_create+0x2c/0x40
[178327.464364]                          .fb_console_init+0x64/0x1cc
[178327.464426]                          .do_one_initcall+0x5c/0x1c0
[178327.464489]                          .kernel_init_freeable+0x2d4/0x3ac
[178327.464551]                          .kernel_init+0x1c/0x130
[178327.464614]                          .ret_from_kernel_thread+0x58/0x70
[178327.464674]     INITIAL USE at:
[178327.464715]                      0x1a492c0
[178327.464754]                      0x1a58870
[178327.464792]                      0x1a5b94c
[178327.464830]                      0x2781bcc
[178327.464869]                      0x2782108
[178327.464907]                      0x191b448
[178327.464945]   }
[178327.464973]   ... key      at: [<c000000002d97140>]
console_lock_dep_map+0x0/0x30
[178327.465046]   ... acquired at:
[178327.465085]    .console_lock+0x60/0xa0
[178327.465124]    .hvc_remove+0xa8/0xf0
[178327.465163]    .hvc_opal_remove+0x28/0x90
[178327.465201]    .platform_drv_remove+0x44/0x80
[178327.465251]    .driver_probe_device+0x144/0x4d0
[178327.465302]    .__driver_attach+0x10c/0x110
[178327.465352]    .bus_for_each_dev+0x84/0xf0
[178327.465391]    .driver_attach+0x24/0x40
[178327.465429]    .bus_add_driver+0x278/0x300
[178327.465468]    .driver_register+0x8c/0x170
[178327.465507]    .__platform_driver_register+0x48/0x60
[178327.465557]    .hvc_opal_init+0x30/0x4c
[178327.465596]    .do_one_initcall+0x5c/0x1c0
[178327.465635]    .kernel_init_freeable+0x2d4/0x3ac
[178327.465685]    .kernel_init+0x1c/0x130
[178327.465725]    .ret_from_kernel_thread+0x58/0x70

[178327.465799] -> (&(&hp->lock)->rlock){-.....} ops: 8160437862400 {
[178327.465867]    IN-HARDIRQ-W at:
[178327.465908]                     .lock_acquire+0xf0/0x340
[178327.465960]                     ._raw_spin_lock_irqsave+0x68/0xd0
[178327.466022]                     .hvc_poll+0x4c/0x380
[178327.466074]                     .hvc_handle_interrupt+0x14/0x40
[178327.466136]                     .__handle_irq_event_percpu+0xe4/0x630
[178327.466199]                     .handle_irq_event_percpu+0x28/0x80
[178327.466262]                     .handle_irq_event+0x54/0xa0
[178327.466324]                     .handle_level_irq+0xf8/0x1f0
[178327.466387]                     .generic_handle_irq+0x40/0x70
[178327.466449]                     .opal_handle_events+0xa4/0x130
[178327.466511]                     .opal_interrupt+0x2c/0x40
[178327.466562]                     .__handle_irq_event_percpu+0xe4/0x630
[178327.466625]                     .handle_irq_event_percpu+0x28/0x80
[178327.466687]                     .handle_irq_event+0x54/0xa0
[178327.466750]                     .handle_fasteoi_irq+0x10c/0x2a0
[178327.466812]                     .generic_handle_irq+0x40/0x70
[178327.466874]                     .__do_irq+0xd4/0x510
[178327.466925]                     .call_do_irq+0x14/0x24
[178327.466975]                     .do_IRQ+0xc8/0x180
[178327.467026]                     hardware_interrupt_common+0x168/0x170
[178327.467089]                     .arch_local_irq_restore.part.16+0x40/0xa0
[178327.467152]                     .cpuidle_enter_state+0x10c/0x500
[178327.467214]                     .call_cpuidle+0x3c/0x80
[178327.467264]                     .do_idle+0x2d0/0x350
[178327.467315]                     .cpu_startup_entry+0x2c/0x30
[178327.467376]                     .rest_init+0x1b8/0x1e0
[178327.467427]                     .start_kernel+0x568/0x584
[178327.467478]                     start_here_common+0x1c/0x520
[178327.467539]    INITIAL USE at:
[178327.467580]                    .lock_acquire+0xf0/0x340
[178327.467631]                    ._raw_spin_lock_irqsave+0x68/0xd0
[178327.467693]                    .hvc_remove+0x34/0xf0
[178327.467744]                    .hvc_opal_remove+0x28/0x90
[178327.467795]                    .platform_drv_remove+0x44/0x80
[178327.467857]                    .driver_probe_device+0x144/0x4d0
[178327.467919]                    .__driver_attach+0x10c/0x110
[178327.467981]                    .bus_for_each_dev+0x84/0xf0
[178327.468066]                    .driver_attach+0x24/0x40
[178327.468159]                    .bus_add_driver+0x278/0x300
[178327.468252]                    .driver_register+0x8c/0x170
[178327.468345]                    .__platform_driver_register+0x48/0x60
[178327.468461]                    .hvc_opal_init+0x30/0x4c
[178327.468553]                    .do_one_initcall+0x5c/0x1c0
[178327.468647]                    .kernel_init_freeable+0x2d4/0x3ac
[178327.468761]                    .kernel_init+0x1c/0x130
[178327.468856]                    .ret_from_kernel_thread+0x58/0x70
[178327.468969]  }
[178327.469019]  ... key      at: [<c000000003e5b684>] __key.26474+0x0/0xc
[178327.469133]  ... acquired at:
[178327.469205]    .mark_lock+0x59c/0x900
[178327.469276]    .__lock_acquire+0xdb4/0x1e70
[178327.469369]    .lock_acquire+0xf0/0x340
[178327.469439]    ._raw_spin_lock_irqsave+0x68/0xd0
[178327.469533]    .hvc_poll+0x4c/0x380
[178327.469603]    .hvc_handle_interrupt+0x14/0x40
[178327.469696]    .__handle_irq_event_percpu+0xe4/0x630
[178327.469789]    .handle_irq_event_percpu+0x28/0x80
[178327.469882]    .handle_irq_event+0x54/0xa0
[178327.469952]    .handle_level_irq+0xf8/0x1f0
[178327.470046]    .generic_handle_irq+0x40/0x70
[178327.470138]    .opal_handle_events+0xa4/0x130
[178327.470231]    .opal_interrupt+0x2c/0x40
[178327.470303]    .__handle_irq_event_percpu+0xe4/0x630
[178327.470396]    .handle_irq_event_percpu+0x28/0x80
[178327.470489]    .handle_irq_event+0x54/0xa0
[178327.470559]    .handle_fasteoi_irq+0x10c/0x2a0
[178327.470653]    .generic_handle_irq+0x40/0x70
[178327.470746]    .__do_irq+0xd4/0x510
[178327.470816]    .call_do_irq+0x14/0x24
[178327.470888]    .do_IRQ+0xc8/0x180
[178327.470959]    hardware_interrupt_common+0x168/0x170
[178327.471051]    .arch_local_irq_restore.part.16+0x40/0xa0
[178327.471144]    .cpuidle_enter_state+0x10c/0x500
[178327.471237]    .call_cpuidle+0x3c/0x80
[178327.471308]    .do_idle+0x2d0/0x350
[178327.471379]    .cpu_startup_entry+0x2c/0x30
[178327.471472]    .rest_init+0x1b8/0x1e0
[178327.471543]    .start_kernel+0x568/0x584
[178327.471614]    start_here_common+0x1c/0x520

[178327.471754]
stack backtrace:
[178327.471849] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.11.0-rc3-00022-gc7e790c #1
[178327.471985] Call Trace:
[178327.472036] [c000000ffff8b070] [c0000000023eef10]
.dump_stack+0xe4/0x150 (unreliable)
[178327.472177] [c000000ffff8b100] [c000000001a44e78]
.print_irq_inversion_bug+0x278/0x300
[178327.472319] [c000000ffff8b1b0] [c000000001a44f94]
.check_usage_forwards+0x94/0x150
[178327.472460] [c000000ffff8b2a0] [c000000001a460cc] .mark_lock+0x59c/0x900
[178327.472559] [c000000ffff8b360] [c000000001a47a94]
.__lock_acquire+0xdb4/0x1e70
[178327.472634] [c000000ffff8b4d0] [c000000001a492c0] .lock_acquire+0xf0/0x340
[178327.472698] [c000000ffff8b5b0] [c0000000023df4e8]
._raw_spin_lock_irqsave+0x68/0xd0
[178327.472773] [c000000ffff8b640] [c0000000020121dc] .hvc_poll+0x4c/0x380
[178327.472837] [c000000ffff8b730] [c000000002013614]
.hvc_handle_interrupt+0x14/0x40
[178327.472913] [c000000ffff8b7a0] [c000000001a5df54]
.__handle_irq_event_percpu+0xe4/0x630
[178327.472989] [c000000ffff8b8a0] [c000000001a5e4c8]
.handle_irq_event_percpu+0x28/0x80
[178327.473064] [c000000ffff8b930] [c000000001a5e574]
.handle_irq_event+0x54/0xa0
[178327.473139] [c000000ffff8b9c0] [c000000001a63168]
.handle_level_irq+0xf8/0x1f0
[178327.473217] [c000000ffff8ba50] [c000000001a5cb90]
.generic_handle_irq+0x40/0x70
[178327.473292] [c000000ffff8bac0] [c000000001981a84]
.opal_handle_events+0xa4/0x130
[178327.473367] [c000000ffff8bb60] [c000000001981b4c] .opal_interrupt+0x2c/0x40
[178327.473443] [c000000ffff8bbe0] [c000000001a5df54]
.__handle_irq_event_percpu+0xe4/0x630
[178327.473519] [c000000ffff8bce0] [c000000001a5e4c8]
.handle_irq_event_percpu+0x28/0x80
[178327.473595] [c000000ffff8bd70] [c000000001a5e574]
.handle_irq_event+0x54/0xa0
[178327.473670] [c000000ffff8be00] [c000000001a635fc]
.handle_fasteoi_irq+0x10c/0x2a0
[178327.473745] [c000000ffff8be90] [c000000001a5cb90]
.generic_handle_irq+0x40/0x70
[178327.473821] [c000000ffff8bf00] [c000000001926954] .__do_irq+0xd4/0x510
[178327.473884] [c000000ffff8bf90] [c00000000193ac8c] .call_do_irq+0x14/0x24
[178327.473948] [c000000002f1f7e0] [c000000001926e58] .do_IRQ+0xc8/0x180
[178327.474012] [c000000002f1f890] [c000000001918e38]
hardware_interrupt_common+0x168/0x170
[178327.474089] --- interrupt: 501 at .arch_local_irq_restore.part.16+0x5c/0xa0
    LR = .arch_local_irq_restore.part.16+0x40/0xa0
[178327.474318] [c000000002f1fbf0] [c0000000022238fc]
.cpuidle_enter_state+0x10c/0x500
[178327.474460] [c000000002f1fca0] [c000000001a35e7c] .call_cpuidle+0x3c/0x80
[178327.474579] [c000000002f1fd10] [c000000001a362c0] .do_idle+0x2d0/0x350
[178327.474699] [c000000002f1fde0] [c000000001a3669c]
.cpu_startup_entry+0x2c/0x30
[178327.474840] [c000000002f1fe60] [c00000000191dfa8] .rest_init+0x1b8/0x1e0
[178327.474961] [c000000002f1fef0] [c00000000277a678] .start_kernel+0x568/0x584
[178327.475102] [c000000002f1ff90] [c00000000191b47c] start_here_common+0x1c/0x5
