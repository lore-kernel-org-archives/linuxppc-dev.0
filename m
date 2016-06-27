Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdVWB49ngzDqRd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 23:43:02 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5RDYEij137976
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 09:43:00 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23spf8dak1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 09:43:00 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Mon, 27 Jun 2016 07:42:59 -0600
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org, mingo@redhat.com,
 mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
 Waiman.Long@hpe.com, boqun.feng@gmail.com, will.deacon@arm.com,
 dave@stgolabs.net, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH 0/3] implement vcpu preempted check
Date: Mon, 27 Jun 2016 13:41:27 -0400
Message-Id: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is to fix some bad issues on an over-committed guest.

test-caes:
perf record -a perf bench sched messaging -g 400 -p && perf report

18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
 5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
 3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
 3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
 3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
 2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call

osq takes a long time with preemption disabled which is really bad.

This is because vCPU A hold the osq lock and yield out, vCPU B wait
per_cpu node->locked to be set. IOW, vCPU B wait vCPU A to run and
unlock the osq lock. Even there is need_resched(), it did not help on
such scenario.

we may also need fix other XXX_spin_on_owner later based on this patch set.
these spin_on_onwer variant cause rcu stall.

Pan Xinhui (3):
  powerpc/spinlock: support vcpu preempted check
  locking/osq: Drop the overload of osq_lock()
  kernel/sched: introduce vcpu preempted check interface

 arch/powerpc/include/asm/lppaca.h   |  6 ++++++
 arch/powerpc/include/asm/spinlock.h | 15 +++++++++++++++
 include/linux/sched.h               |  9 +++++++++
 kernel/locking/osq_lock.c           | 16 +++++++++++++++-
 4 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.4.11
