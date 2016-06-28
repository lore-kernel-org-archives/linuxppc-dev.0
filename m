Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf2VF1s0yzDqnm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 20:44:04 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5SAdF9g024277
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 06:44:02 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23sp5125tr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 06:44:01 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 06:44:01 -0400
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mpe@ellerman.id.au,
 paulus@samba.org, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, will.deacon@arm.com, boqun.feng@gmail.com,
 dave@stgolabs.net, schwidefsky@de.ibm.com,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v2 0/4] implement vcpu preempted check
Date: Tue, 28 Jun 2016 10:43:07 -0400
Message-Id: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

change fomr v1:
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

Pan Xinhui (4):
  kernel/sched: introduce vcpu preempted check interface
  powerpc/spinlock: support vcpu preempted check
  locking/osq: Drop the overload of osq_lock()
  kernel/locking: Drop the overload of {mutex,rwsem}_spin_on_owner

 arch/powerpc/include/asm/spinlock.h | 18 ++++++++++++++++++
 include/linux/sched.h               | 12 ++++++++++++
 kernel/locking/mutex.c              | 15 +++++++++++++--
 kernel/locking/osq_lock.c           | 10 +++++++++-
 kernel/locking/rwsem-xadd.c         | 16 +++++++++++++---
 5 files changed, 65 insertions(+), 6 deletions(-)

-- 
2.4.11
