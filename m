Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4rK468QSzDvNS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:25:28 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9S4NsAo062992
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 00:25:26 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26bvc1st1k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 00:25:26 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Fri, 28 Oct 2016 14:25:24 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 527C62CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:25:21 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9S4PLF99306182
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:25:21 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9S4PJXv020922
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:25:21 +1100
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com,
 borntraeger@de.ibm.com, rkrcmar@redhat.com, David.Laight@ACULAB.COM,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v6 00/11] implement vcpu preempted check 
Date: Fri, 28 Oct 2016 04:11:16 -0400
Message-Id: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

change from v5:
	spilt x86/kvm patch into guest/host part.
	introduce kvm_write_guest_offset_cached.
	fix some typos.
	rebase patch onto 4.9.2
change from v4:
	spilt x86 kvm vcpu preempted check into two patches.
	add documentation patch.
	add x86 vcpu preempted check patch under xen
	add s390 vcpu preempted check patch 
change from v3:
	add x86 vcpu preempted check patch
change from v2:
	no code change, fix typos, update some comments
change from v1:
	a simplier definition of default vcpu_is_preempted
	skip mahcine type check on ppc, and add config. remove dedicated macro.
	add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner. 
	add more comments
	thanks boqun and Peter's suggestion.

This patch set aims to fix lock holder preemption issues.

test-case:
perf record -a perf bench sched messaging -g 400 -p && perf report

18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
 5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
 3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
 3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
 3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
 2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call

We introduce interface bool vcpu_is_preempted(int cpu) and use it in some spin
loops of osq_lock, rwsem_spin_on_owner and mutex_spin_on_owner.
These spin_on_onwer variant also cause rcu stall before we apply this patch set

We also have observed some performace improvements in uninx benchmark tests.

PPC test result:
1 copy - 0.94%
2 copy - 7.17%
4 copy - 11.9%
8 copy -  3.04%
16 copy - 15.11%

details below:
Without patch:

1 copy - File Write 4096 bufsize 8000 maxblocks      2188223.0 KBps  (30.0 s, 1 samples)
2 copy - File Write 4096 bufsize 8000 maxblocks      1804433.0 KBps  (30.0 s, 1 samples)
4 copy - File Write 4096 bufsize 8000 maxblocks      1237257.0 KBps  (30.0 s, 1 samples)
8 copy - File Write 4096 bufsize 8000 maxblocks      1032658.0 KBps  (30.0 s, 1 samples)
16 copy - File Write 4096 bufsize 8000 maxblocks       768000.0 KBps  (30.1 s, 1 samples)

With patch: 

1 copy - File Write 4096 bufsize 8000 maxblocks      2209189.0 KBps  (30.0 s, 1 samples)
2 copy - File Write 4096 bufsize 8000 maxblocks      1943816.0 KBps  (30.0 s, 1 samples)
4 copy - File Write 4096 bufsize 8000 maxblocks      1405591.0 KBps  (30.0 s, 1 samples)
8 copy - File Write 4096 bufsize 8000 maxblocks      1065080.0 KBps  (30.0 s, 1 samples)
16 copy - File Write 4096 bufsize 8000 maxblocks       904762.0 KBps  (30.0 s, 1 samples)

X86 test result:
	test-case			after-patch	  before-patch
Execl Throughput                       |    18307.9 lps  |    11701.6 lps 
File Copy 1024 bufsize 2000 maxblocks  |  1352407.3 KBps |   790418.9 KBps
File Copy 256 bufsize 500 maxblocks    |   367555.6 KBps |   222867.7 KBps
File Copy 4096 bufsize 8000 maxblocks  |  3675649.7 KBps |  1780614.4 KBps
Pipe Throughput                        | 11872208.7 lps  | 11855628.9 lps 
Pipe-based Context Switching           |  1495126.5 lps  |  1490533.9 lps 
Process Creation                       |    29881.2 lps  |    28572.8 lps 
Shell Scripts (1 concurrent)           |    23224.3 lpm  |    22607.4 lpm 
Shell Scripts (8 concurrent)           |     3531.4 lpm  |     3211.9 lpm 
System Call Overhead                   | 10385653.0 lps  | 10419979.0 lps 

Christian Borntraeger (1):
  s390/spinlock: Provide vcpu_is_preempted

Juergen Gross (1):
  x86, xen: support vcpu preempted check

Pan Xinhui (9):
  kernel/sched: introduce vcpu preempted check interface
  locking/osq: Drop the overload of osq_lock()
  kernel/locking: Drop the overload of {mutex,rwsem}_spin_on_owner
  powerpc/spinlock: support vcpu preempted check
  x86, paravirt: Add interface to support kvm/xen vcpu preempted check
  KVM: Introduce kvm_write_guest_offset_cached
  x86, kvm/x86.c: support vcpu preempted check
  x86, kernel/kvm.c: support vcpu preempted check
  Documentation: virtual: kvm: Support vcpu preempted check

 Documentation/virtual/kvm/msr.txt     |  9 ++++++++-
 arch/powerpc/include/asm/spinlock.h   |  8 ++++++++
 arch/s390/include/asm/spinlock.h      |  8 ++++++++
 arch/s390/kernel/smp.c                |  9 +++++++--
 arch/s390/lib/spinlock.c              | 25 ++++++++-----------------
 arch/x86/include/asm/paravirt_types.h |  2 ++
 arch/x86/include/asm/spinlock.h       |  8 ++++++++
 arch/x86/include/uapi/asm/kvm_para.h  |  4 +++-
 arch/x86/kernel/kvm.c                 | 12 ++++++++++++
 arch/x86/kernel/paravirt-spinlocks.c  |  6 ++++++
 arch/x86/kvm/x86.c                    | 16 ++++++++++++++++
 arch/x86/xen/spinlock.c               |  3 ++-
 include/linux/kvm_host.h              |  2 ++
 include/linux/sched.h                 | 12 ++++++++++++
 kernel/locking/mutex.c                | 15 +++++++++++++--
 kernel/locking/osq_lock.c             | 10 +++++++++-
 kernel/locking/rwsem-xadd.c           | 16 +++++++++++++---
 virt/kvm/kvm_main.c                   | 20 ++++++++++++++------
 18 files changed, 151 insertions(+), 34 deletions(-)

-- 
2.4.11
