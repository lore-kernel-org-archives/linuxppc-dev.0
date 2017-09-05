Return-Path: <daniel.black@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmcLY4854zDrDg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 16:31:33 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v856SeRp123217
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Sep 2017 02:31:30 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cs9x7pfse-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Sep 2017 02:31:29 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <daniel.black@au1.ibm.com>;
 Tue, 5 Sep 2017 16:31:26 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v856VOaF37617824
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Sep 2017 16:31:24 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v856VPxa011304
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Sep 2017 16:31:25 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 v856VPQx011298
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Sep 2017 16:31:25 +1000
Received: from hopper.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 786E8A010B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 16:31:23 +1000 (AEST)
From: Daniel Black <daniel.black@au1.ibm.com>
Subject: 4.13.0-next-20170904 WARNING: possible circular locking dependency
 detected
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 5 Sep 2017 16:31:23 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <7a34e370-9edc-fda1-7a13-a665f2d7b503@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


found on booting.

kvm bare metal host machine.

======================================================
WARNING: possible circular locking dependency detected
4.13.0-next-20170904 #1 Tainted: G        W
------------------------------------------------------
ppc64_cpu/4940 is trying to acquire lock:
 ((complete)&st->done){+.+.}, at: [<c00000000010e198>]
takedown_cpu+0xe8/0x1c0

but task is already holding lock:
 (sparse_irq_lock){+.+.}, at: [<c0000000001b282c>] irq_lock_sparse+0x2c/0x40

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sparse_irq_lock){+.+.}:
       lock_acquire+0xdc/0x2f0
       __mutex_lock+0xac/0xb60
       irq_lock_sparse+0x2c/0x40
       irq_affinity_online_cpu+0x2c/0x1f0
       cpuhp_invoke_callback+0x1b4/0xd90
       cpuhp_up_callbacks+0x58/0x150
       cpuhp_thread_fun+0x1cc/0x210
       smpboot_thread_fn+0x2fc/0x370
       kthread+0x200/0x210
       ret_from_kernel_thread+0x5c/0x70

-> #1 (cpuhp_state){+.+.}:
       smpboot_thread_fn+0x2fc/0x370
       kthread+0x200/0x210
       ret_from_kernel_thread+0x5c/0x70

-> #0 ((complete)&st->done){+.+.}:
       __lock_acquire+0x16a4/0x17f0
       lock_acquire+0xdc/0x2f0
       wait_for_common+0x8c/0x250
       takedown_cpu+0xe8/0x1c0
       cpuhp_invoke_callback+0x1b4/0xd90
       cpuhp_down_callbacks+0x78/0xf0
       _cpu_down+0x150/0x1b0
       do_cpu_down+0x68/0xb0
       cpu_subsys_offline+0x2c/0x50
       device_offline+0xcc/0x150
       online_store+0x6c/0xc0
       dev_attr_store+0x68/0xa0
       sysfs_kf_write+0x74/0xc0
       kernfs_fop_write+0x194/0x270
       __vfs_write+0x6c/0x1d0
       vfs_write+0xd8/0x240
       SyS_write+0x6c/0x110
       system_call+0x58/0x6c

other info that might help us debug this:

Chain exists of:
  (complete)&st->done --> cpuhp_state --> sparse_irq_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sparse_irq_lock);
                               lock(cpuhp_state);
                               lock(sparse_irq_lock);
  lock((complete)&st->done);

 *** DEADLOCK ***

8 locks held by ppc64_cpu/4940:
 #0:  (sb_writers#6){.+.+}, at: [<c0000000003ee850>] vfs_write+0x210/0x240
 #1:  (&of->mutex){+.+.}, at: [<c0000000004bc188>]
kernfs_fop_write+0x148/0x270
 #2:  (kn->count#130){.+.+}, at: [<c0000000004bc194>]
kernfs_fop_write+0x154/0x270
 #3:  (device_hotplug_lock){+.+.}, at: [<c00000000079a6c8>]
lock_device_hotplug_sysfs+0x28/0x80
 #4:  (&dev->mutex){....}, at: [<c00000000079c334>]
device_offline+0x84/0x150
 #5:  (cpu_add_remove_lock){+.+.}, at: [<c000000000110574>]
do_cpu_down+0x44/0xb0
 #6:  (cpu_hotplug_lock.rw_sem){++++}, at: [<c000000000194dbc>]
percpu_down_write+0x4c/0x160
 #7:  (sparse_irq_lock){+.+.}, at: [<c0000000001b282c>]
irq_lock_sparse+0x2c/0x40

stack backtrace:
CPU: 2 PID: 4940 Comm: ppc64_cpu Tainted: G        W
4.13.0-next-20170904 #1
Call Trace:
[c000001fb5d83510] [c000000000bcb7ec] dump_stack+0xe8/0x15c (unreliable)
[c000001fb5d83550] [c000000000199478] print_circular_bug+0x2e8/0x4f0
[c000001fb5d83600] [c00000000019ab58] check_prev_add+0x468/0xa90
[c000001fb5d83700] [c00000000019e684] __lock_acquire+0x16a4/0x17f0
[c000001fb5d83830] [c00000000019f47c] lock_acquire+0xdc/0x2f0
[c000001fb5d83900] [c000000000be7dcc] wait_for_common+0x8c/0x250
[c000001fb5d83980] [c00000000010e198] takedown_cpu+0xe8/0x1c0
[c000001fb5d839e0] [c00000000010e5b4] cpuhp_invoke_callback+0x1b4/0xd90
[c000001fb5d83a70] [c00000000010f318] cpuhp_down_callbacks+0x78/0xf0
[c000001fb5d83ac0] [c000000000112c30] _cpu_down+0x150/0x1b0
[c000001fb5d83b20] [c000000000110598] do_cpu_down+0x68/0xb0
[c000001fb5d83b60] [c0000000007a54ac] cpu_subsys_offline+0x2c/0x50
[c000001fb5d83b90] [c00000000079c37c] device_offline+0xcc/0x150
[c000001fb5d83bd0] [c00000000079c58c] online_store+0x6c/0xc0
[c000001fb5d83c20] [c000000000796aa8] dev_attr_store+0x68/0xa0
[c000001fb5d83c60] [c0000000004bd954] sysfs_kf_write+0x74/0xc0
[c000001fb5d83ca0] [c0000000004bc1d4] kernfs_fop_write+0x194/0x270
[c000001fb5d83cf0] [c0000000003ec6bc] __vfs_write+0x6c/0x1d0
[c000001fb5d83d90] [c0000000003ee718] vfs_write+0xd8/0x240
[c000001fb5d83de0] [c0000000003f06ac] SyS_write+0x6c/0x110
[c000001fb5d83e30] [c00000000000b96c] system_call+0x58/0x6c
[  OK  ] Started User Manager for UID 1004.
nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
ip_tables: (C) 2000-2006 Netfilter Core Team

Ubuntu 16.04.2 LTS p87 hvc0

p87 login: Initializing XFRM netlink socket
------------[ cut here ]------------
WARNING: CPU: 48 PID: 5464 at net/netfilter/core.c:218
__nf_hook_entries_try_shrink+0xd4/0x270
Modules linked in: ipt_MASQUERADE nf_nat_masquerade_ipv4 xfrm_user
xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4
xt_addrtype iptable_filter ip_tables xt_conntrack x_tables nf_nat
nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto leds_powernv
led_class powernv_op_panel powernv_rng rng_core kvm_hv kvm autofs4 xfs
btrfs zstd_decompress zstd_compress xxhash lzo_compress raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq
libcrc32c multipath mlx4_en crc32c_vpmsum raid10 lpfc be2net crc_t10dif
crct10dif_generic crct10dif_common mlx4_core
CPU: 48 PID: 5464 Comm: iptables Tainted: G        W
4.13.0-next-20170904 #1
task: c000003f88e95380 task.stack: c000003f8dc9c000
NIP:  c000000000ab02a4 LR: c000000000ab0200 CTR: 0000000000000000
REGS: c000003f8dc9f5b0 TRAP: 0700   Tainted: G        W
(4.13.0-next-20170904)
MSR:  900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR:
44004248  XER: 20000000
CFAR: c000000000ab0208 SOFTE: 1
GPR00: c000000000ab13bc c000003f8dc9f830 c00000000117ad00 0000000000000000
GPR04: 0000000000000003 c000001fea1504a0 0000000000000001 0000000000000001
GPR08: c000007fe34705b8 0000000000000001 c000007fe34705b8 0000000000000002
GPR12: 0000000000000018 c00000000fd50800 000001001c3423c0 00000000000000b0
GPR16: 0000000000000040 d000000019b92230 0000000000000001 c000000000dfff80
GPR20: c000000000e70f78 c0000000011082b0 c000000001108248 c0000000011185cd
GPR24: c000003f8dc9f8a0 d000000019b922a0 c0000000010fe100 c000000000ca2b00
GPR28: 0000000000000006 c000007fe34705a0 c0000000010fe9a0 c000007fe34705b0
NIP [c000000000ab02a4] __nf_hook_entries_try_shrink+0xd4/0x270
LR [c000000000ab0200] __nf_hook_entries_try_shrink+0x30/0x270
Call Trace:
[c000003f8dc9f830] [c000000000ab0350]
__nf_hook_entries_try_shrink+0x180/0x270 (unreliable)
[c000003f8dc9f880] [c000000000ab13bc] nf_unregister_net_hooks+0x24c/0x440
[c000003f8dc9f9a0] [d000000019b905d4] ipv4_hooks_unregister+0x19c/0x2a0
[nf_conntrack_ipv4]
[c000003f8dc9f9f0] [d0000000196bc6d0] nf_ct_netns_put+0x168/0x2b0
[nf_conntrack]
[c000003f8dc9fa40] [d0000000197f0038] conntrack_mt_destroy+0x30/0x50
[xt_conntrack]
[c000003f8dc9fa70] [d0000000199907a0] cleanup_match+0x68/0xa0 [ip_tables]
[c000003f8dc9fac0] [d00000001999082c] cleanup_entry+0x54/0xf0 [ip_tables]
[c000003f8dc9fb20] [d0000000199913dc] __do_replace+0x224/0x2d0 [ip_tables]
[c000003f8dc9fbe0] [d000000019993cfc] do_ipt_set_ctl+0x1d4/0x284 [ip_tables]
[c000003f8dc9fc90] [c000000000ab4dd8] nf_setsockopt+0x88/0x100
[c000003f8dc9fce0] [c000000000accaac] ip_setsockopt+0xdc/0x130
[c000003f8dc9fd30] [c000000000b061a8] raw_setsockopt+0xa8/0xf0
[c000003f8dc9fd80] [c000000000a1a19c] sock_common_setsockopt+0x5c/0x80
[c000003f8dc9fdd0] [c000000000a1845c] SyS_setsockopt+0x9c/0x120
[c000003f8dc9fe30] [c00000000000b96c] system_call+0x58/0x6c
Instruction dump:
60000000 60000000 60420000 e92a0009 7fa9d800 7eaa4040 419e00f4 4096fff0
7f833840 419e00f8 7c690034 5529d97e <0b090000> 2fa30000 419e0178 7c633850
---[ end trace a4ed76330b561e7f ]---
------------[ cut here ]------------
WARNING: CPU: 48 PID: 5464 at net/netfilter/core.c:218
__nf_hook_entries_try_shrink+0xd4/0x270
Modules linked in: ipt_MASQUERADE nf_nat_masquerade_ipv4 xfrm_user
xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4
xt_addrtype iptable_filter ip_tables xt_conntrack x_tables nf_nat
nf_conntrack overlay bridge stp llc binfmt_misc vmx_crypto leds_powernv
led_class powernv_op_panel powernv_rng rng_core kvm_hv kvm autofs4 xfs
btrfs zstd_decompress zstd_compress xxhash lzo_compress raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq
libcrc32c multipath mlx4_en crc32c_vpmsum raid10 lpfc be2net crc_t10dif
crct10dif_generic crct10dif_common mlx4_core
CPU: 48 PID: 5464 Comm: iptables Tainted: G        W
4.13.0-next-20170904 #1
task: c000003f88e95380 task.stack: c000003f8dc9c000
NIP:  c000000000ab02a4 LR: c000000000ab0200 CTR: 0000000000000000
REGS: c000003f8dc9f5b0 TRAP: 0700   Tainted: G        W
(4.13.0-next-20170904)
MSR:  900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR:
44004248  XER: 20000000
CFAR: c000000000ab0290 SOFTE: 1
GPR00: c000000000ab13bc c000003f8dc9f830 c00000000117ad00 0000000000000000
GPR04: 0000000000000004 c000001fe98b14b0 0000000000000002 0000000000000002
GPR08: c000007fe4722330 0000000000000001 c000007fe4722330 0000000000000003
GPR12: 0000000000000028 c00000000fd50800 000001001c3423c0 00000000000000b0
GPR16: 0000000000000040 d000000019b92280 0000000000000001 c000000000dfff80
GPR20: c000000000e70f78 c0000000011082b0 c000000001108248 c0000000011185cd
GPR24: c000003f8dc9f8a0 d000000019b922a0 c0000000010fe100 c000000000ca2b00
GPR28: 0000000000000006 c000007fe4722300 c0000000010fe988 c000007fe4722320
NIP [c000000000ab02a4] __nf_hook_entries_try_shrink+0xd4/0x270
LR [c000000000ab0200] __nf_hook_entries_try_shrink+0x30/0x270
Call Trace:
[c000003f8dc9f830] [c000000000ab0350]
__nf_hook_entries_try_shrink+0x180/0x270 (unreliable)
[c000003f8dc9f880] [c000000000ab13bc] nf_unregister_net_hooks+0x24c/0x440
[c000003f8dc9f9a0] [d000000019b905d4] ipv4_hooks_unregister+0x19c/0x2a0
[nf_conntrack_ipv4]
[c000003f8dc9f9f0] [d0000000196bc6d0] nf_ct_netns_put+0x168/0x2b0
[nf_conntrack]
[c000003f8dc9fa40] [d0000000197f0038] conntrack_mt_destroy+0x30/0x50
[xt_conntrack]
[c000003f8dc9fa70] [d0000000199907a0] cleanup_match+0x68/0xa0 [ip_tables]
[c000003f8dc9fac0] [d00000001999082c] cleanup_entry+0x54/0xf0 [ip_tables]
[c000003f8dc9fb20] [d0000000199913dc] __do_replace+0x224/0x2d0 [ip_tables]
[c000003f8dc9fbe0] [d000000019993cfc] do_ipt_set_ctl+0x1d4/0x284 [ip_tables]
[c000003f8dc9fc90] [c000000000ab4dd8] nf_setsockopt+0x88/0x100
[c000003f8dc9fce0] [c000000000accaac] ip_setsockopt+0xdc/0x130
[c000003f8dc9fd30] [c000000000b061a8] raw_setsockopt+0xa8/0xf0
[c000003f8dc9fd80] [c000000000a1a19c] sock_common_setsockopt+0x5c/0x80
[c000003f8dc9fdd0] [c000000000a1845c] SyS_setsockopt+0x9c/0x120
[c000003f8dc9fe30] [c00000000000b96c] system_call+0x58/0x6c
Instruction dump:
60000000 60000000 60420000 e92a0009 7fa9d800 7eaa4040 419e00f4 4096fff0
7f833840 419e00f8 7c690034 5529d97e <0b090000> 2fa30000 419e0178 7c633850
---[ end trace a4ed76330b561e80 ]---
libvirt-guests.sh[5660]: libvirt-guests is configured not to start any
guests on boot
tun: Universal TUN/TAP device driver, 1.6
virbr0: port 1(virbr0-nic) entered blocking state
virbr0: port 1(virbr0-nic) entered disabled state
device virbr0-nic entered promiscuous mode
virbr0: port 1(virbr0-nic) entered blocking state
virbr0: port 1(virbr0-nic) entered listening state
virbr0: port 1(virbr0-nic) entered learning state
virbr0: port 1(virbr0-nic) entered disabled state
br0: port 2(vnet0) entered blocking state
br0: port 2(vnet0) entered disabled state
device vnet0 entered promiscuous mode
br0: port 2(vnet0) entered blocking state
br0: port 2(vnet0) entered forwarding state
KVM: couldn't grab cpu 97
