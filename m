Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7x8T6jwnzDvPg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 16:13:45 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA25DTra055946
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 01:13:44 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26f8xujbep-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 01:13:43 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Wed, 2 Nov 2016 15:13:41 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E0EE63578058
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 16:13:37 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA25Db5p4850014
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 16:13:37 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA25DaJT007507
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 16:13:37 +1100
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
 dave@stgolabs.net, konrad.wilk@oracle.com,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v7 03/11] kernel/locking: Drop the overload of {mutex,
 rwsem}_spin_on_owner
Date: Wed,  2 Nov 2016 05:08:30 -0400
In-Reply-To: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1478077718-37424-4-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An over-committed guest with more vCPUs than pCPUs has a heavy overload
in the two spin_on_owner. This blames on the lock holder preemption
issue.

Kernel has an interface bool vcpu_is_preempted(int cpu) to see if a vCPU
is currently running or not. So break the spin loops on true condition.

test-case:
perf record -a perf bench sched messaging -g 400 -p && perf report

before patch:
20.68%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner
 8.45%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
 4.12%  sched-messaging  [kernel.vmlinux]  [k] system_call
 3.01%  sched-messaging  [kernel.vmlinux]  [k] system_call_common
 2.83%  sched-messaging  [kernel.vmlinux]  [k] copypage_power7
 2.64%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
 2.00%  sched-messaging  [kernel.vmlinux]  [k] osq_lock

after patch:
 9.99%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
 5.28%  sched-messaging  [unknown]         [H] 0xc0000000000768e0
 4.27%  sched-messaging  [kernel.vmlinux]  [k] __copy_tofrom_user_power7
 3.77%  sched-messaging  [kernel.vmlinux]  [k] copypage_power7
 3.24%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
 3.02%  sched-messaging  [kernel.vmlinux]  [k] system_call
 2.69%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Juergen Gross <jgross@suse.com>
---
 kernel/locking/mutex.c      | 13 +++++++++++--
 kernel/locking/rwsem-xadd.c | 14 +++++++++++---
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index a70b90d..24face6 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -236,7 +236,11 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner)
 		 */
 		barrier();
 
-		if (!owner->on_cpu || need_resched()) {
+		/*
+		 * Use vcpu_is_preempted to detect lock holder preemption issue.
+		 */
+		if (!owner->on_cpu || need_resched() ||
+				vcpu_is_preempted(task_cpu(owner))) {
 			ret = false;
 			break;
 		}
@@ -261,8 +265,13 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
 
 	rcu_read_lock();
 	owner = READ_ONCE(lock->owner);
+
+	/*
+	 * As lock holder preemption issue, we both skip spinning if task is not
+	 * on cpu or its cpu is preempted
+	 */
 	if (owner)
-		retval = owner->on_cpu;
+		retval = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
 	rcu_read_unlock();
 	/*
 	 * if lock->owner is not set, the mutex owner may have just acquired
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 2337b4b..b664ce1 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -336,7 +336,11 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 		goto done;
 	}
 
-	ret = owner->on_cpu;
+	/*
+	 * As lock holder preemption issue, we both skip spinning if task is not
+	 * on cpu or its cpu is preempted
+	 */
+	ret = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
 done:
 	rcu_read_unlock();
 	return ret;
@@ -362,8 +366,12 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 		 */
 		barrier();
 
-		/* abort spinning when need_resched or owner is not running */
-		if (!owner->on_cpu || need_resched()) {
+		/*
+		 * abort spinning when need_resched or owner is not running or
+		 * owner's cpu is preempted.
+		 */
+		if (!owner->on_cpu || need_resched() ||
+				vcpu_is_preempted(task_cpu(owner))) {
 			rcu_read_unlock();
 			return false;
 		}
-- 
2.4.11
