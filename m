Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [59.145.155.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5AB04DDE07
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Apr 2009 22:26:19 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id n35CQ6Pk009542
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Apr 2009 17:56:06 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n35CQ0nu4509768
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Apr 2009 17:56:00 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n35CPoC4003632
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Apr 2009 17:55:50 +0530
Message-ID: <49D8A34C.2020200@in.ibm.com>
Date: Sun, 05 Apr 2009 17:55:48 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.29-git12 : lockdep warning
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: peterz@infradead.org, linuxppc-dev@ozlabs.org, mingo@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With 2.6.29-git12 on a powerpc box i observed the following
warning

=================================
2.6.29-git12 #1
inconsistent {IN-RECLAIM_FS-W} -> {RECLAIM_FS-ON-W} usage.
yum-updatesd-he/6947 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&inode->inotify_mutex){+.+.?.}, at: [<c000000000154a04>] .inotify_inode_queue_event+0x6c/0x160
  [<c000000000098198>] .lock_acquire+0x54/0x80
  [<c000000000154bb0>] .inotify_inode_is_dead+0x38/0xcc
  [<c0000000001319f0>] .d_kill+0x68/0xac
  [<c0000000001320b4>] .shrink_dcache_memory+0x134/0x214
  [<c0000000000e82fc>] .shrink_slab+0x144/0x20c
  [<c0000000000e936c>] .kswapd+0x43c/0x628
  [<c0000000000850e0>] .kthread+0x78/0xc4
  [<c00000000002bd6c>] .kernel_thread+0x54/0x70
irq event stamp: 223781
hardirqs last  enabled at (223781): [<c0000000001101c8>] .kmem_cache_alloc+0x184/0x200
hardirqs last disabled at (223780): [<c00000000010f204>] .cache_grow+0x3b0/0x48c
softirqs last  enabled at (222934): [<c00000000002ba64>] .call_do_softirq+0x14/0x24
softirqs last disabled at (222923): [<c00000000002ba64>] .call_do_softirq+0x14/0x24

other info that might help us debug this:
4 locks held by yum-updatesd-he/6947:
 #0:  (&type->i_mutex_dir_key#4){+.+.+.}, at: [<c00000000012c53c>] .do_filp_open+0x188/0x874
 #1:  (&inode->inotify_mutex){+.+.?.}, at: [<c000000000154a04>] .inotify_inode_queue_event+0x6c/0x160
 #2:  (&ih->mutex){+.+...}, at: [<c000000000154a34>] .inotify_inode_queue_event+0x9c/0x160
 #3:  (&dev->ev_mutex){+.+...}, at: [<c000000000156330>] .inotify_dev_queue_event+0x50/0x1d8

stack backtrace:
Call Trace:
[c0000000541ff4f0] [c0000000000115cc] .show_stack+0x70/0x184 (unreliable)
[c0000000541ff5a0] [c000000000093a00] .print_usage_bug+0x1bc/0x1ec
[c0000000541ff650] [c000000000093dac] .mark_lock+0x37c/0x6c0
[c0000000541ff700] [c000000000094148] .mark_held_locks+0x58/0xac
[c0000000541ff790] [c000000000097f54] .lockdep_trace_alloc+0xc4/0xf4
[c0000000541ff810] [c00000000010fc24] .__kmalloc+0x98/0x25c
[c0000000541ff8b0] [c000000000156244] .kernel_event+0xbc/0x158
[c0000000541ff950] [c000000000156400] .inotify_dev_queue_event+0x120/0x1d8
[c0000000541ffa00] [c000000000154a84] .inotify_inode_queue_event+0xec/0x160
[c0000000541ffad0] [c0000000001292cc] .vfs_create+0x168/0x1e4
[c0000000541ffb70] [c00000000012c5f0] .do_filp_open+0x23c/0x874
[c0000000541ffd10] [c00000000011aecc] .do_sys_open+0x80/0x140
[c0000000541ffdc0] [c000000000161748] .compat_sys_open+0x24/0x38
[c0000000541ffe30] [c000000000008554] syscall_exit+0x0/0x40

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
