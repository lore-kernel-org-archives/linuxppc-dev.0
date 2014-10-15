Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 702EE1A02FD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 04:29:41 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Oct 2014 03:29:39 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3F0422CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 04:29:37 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9FH4sjB64487478
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 04:05:03 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9FHT429027116
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 04:29:04 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: "kvm-ppc\@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: lockdep warning with 2d65a9f48fcdf7866aab6457bc707ca233e0c791
Date: Wed, 15 Oct 2014 22:58:45 +0530
Message-ID: <87d29tkzsi.fsf@linux.vnet.ibm.com>
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


=============================================
[ INFO: possible recursive locking detected ]
3.17.0+ #31 Not tainted
---------------------------------------------
qemu-system-ppc/9112 is trying to acquire lock:
 (&(&vcpu->arch.tbacct_lock)->rlock){......}, at: [<d000000011591f84>] .vcore_stolen_time+0x44/0xb0 [kvm_hv]

but task is already holding lock:
 (&(&vcpu->arch.tbacct_lock)->rlock){......}, at: [<d000000011592524>] .kvmppc_remove_runnable.part.2+0x34/0xd0 [kvm_hv]

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&(&vcpu->arch.tbacct_lock)->rlock);
  lock(&(&vcpu->arch.tbacct_lock)->rlock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by qemu-system-ppc/9112:
 #0:  (&vcpu->mutex){+.+.+.}, at: [<c00000000008687c>] .vcpu_load+0x2c/0xf0
 #1:  (&(&vcore->lock)->rlock){+.+...}, at: [<d000000011594790>] .kvmppc_vcpu_run_hv+0x770/0x1720 [kvm_hv]
 #2:  (&(&vcpu->arch.tbacct_lock)->rlock){......}, at: [<d000000011592524>] .kvmppc_remove_runnable.part.2+0x34/0xd0 [kvm_hv]

stack backtrace:
CPU: 56 PID: 9112 Comm: qemu-system-ppc Not tainted 3.17.0+ #31
Call Trace:
[c000000fe488f330] [c0000000000167dc] .show_stack+0x7c/0x1f0 (unreliable)
[c000000fe488f400] [c0000000008ea148] .dump_stack+0x9c/0xd8
[c000000fe488f480] [c000000000110c6c] .__lock_acquire+0x151c/0x1ef0
[c000000fe488f600] [c000000000111fb0] .lock_acquire+0xd0/0x1b0
[c000000fe488f6d0] [c0000000008ddedc] ._raw_spin_lock_irq+0x5c/0x80
[c000000fe488f760] [d000000011591f84] .vcore_stolen_time+0x44/0xb0 [kvm_hv]
[c000000fe488f7f0] [d00000001159253c] .kvmppc_remove_runnable.part.2+0x4c/0xd0 [kvm_hv]
[c000000fe488f890] [d0000000115950c0] .kvmppc_vcpu_run_hv+0x10a0/0x1720 [kvm_hv]
[c000000fe488f9f0] [c000000000091d1c] .kvmppc_vcpu_run+0x2c/0x40
[c000000fe488fa60] [c00000000008efd4] .kvm_arch_vcpu_ioctl_run+0x54/0x170
[c000000fe488faf0] [c000000000086f78] .kvm_vcpu_ioctl+0x5c8/0x780
[c000000fe488fcb0] [c000000000264b54] .do_vfs_ioctl+0x474/0x770
[c000000fe488fd90] [c000000000264ea8] .SyS_ioctl+0x58/0xb0
[c000000fe488fe30] [c000000000009264] syscall_exit+0x0/0x98
