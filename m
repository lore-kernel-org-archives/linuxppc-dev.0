Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szMLm4q0HzDt1d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 17:22:56 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9J6JZmT025076
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 02:22:54 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 265kv3hsxs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 02:22:53 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Wed, 19 Oct 2016 00:22:53 -0600
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com,
 borntraeger@de.ibm.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v4 2/5] locking/osq: Drop the overload of osq_lock()
Date: Wed, 19 Oct 2016 06:20:13 -0400
In-Reply-To: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1476872416-42752-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An over-committed guest with more vCPUs than pCPUs has a heavy overload in
osq_lock().

This is because vCPU A hold the osq lock and yield out, vCPU B wait per_cpu
node->locked to be set. IOW, vCPU B wait vCPU A to run and unlock the osq
lock.

Kernel has an interface bool vcpu_is_preempted(int cpu) to see if a vCPU is
currently running or not. So break the spin loops on true condition.

test case:
perf record -a perf bench sched messaging -g 400 -p && perf report

before patch:
18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
 5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
 3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
 3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
 3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
 2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call

after patch:
20.68%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner
 8.45%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
 4.12%  sched-messaging  [kernel.vmlinux]  [k] system_call
 3.01%  sched-messaging  [kernel.vmlinux]  [k] system_call_common
 2.83%  sched-messaging  [kernel.vmlinux]  [k] copypage_power7
 2.64%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
 2.00%  sched-messaging  [kernel.vmlinux]  [k] osq_lock

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 kernel/locking/osq_lock.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 05a3785..39d1385 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -21,6 +21,11 @@ static inline int encode_cpu(int cpu_nr)
 	return cpu_nr + 1;
 }
 
+static inline int node_cpu(struct optimistic_spin_node *node)
+{
+	return node->cpu - 1;
+}
+
 static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
 {
 	int cpu_nr = encoded_cpu_val - 1;
@@ -118,8 +123,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	while (!READ_ONCE(node->locked)) {
 		/*
 		 * If we need to reschedule bail... so we can block.
+		 * Use vcpu_is_preempted to detech lock holder preemption issue
+		 * and break. vcpu_is_preempted is a macro defined by false if
+		 * arch does not support vcpu preempted check,
 		 */
-		if (need_resched())
+		if (need_resched() || vcpu_is_preempted(node_cpu(node->prev)))
 			goto unqueue;
 
 		cpu_relax_lowlatency();
-- 
2.4.11
