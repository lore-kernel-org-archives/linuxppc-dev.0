Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdVWC75lGzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 23:43:03 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5RDYGT8110788
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 09:43:02 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23sm9dr53w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 09:43:01 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Mon, 27 Jun 2016 07:42:59 -0600
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org, mingo@redhat.com,
 mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
 Waiman.Long@hpe.com, boqun.feng@gmail.com, will.deacon@arm.com,
 dave@stgolabs.net, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH 3/3] locking/osq: Drop the overload of osq_lock()
Date: Mon, 27 Jun 2016 13:41:30 -0400
In-Reply-To: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1467049290-32359-4-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An over-committed guest with more vCPUs than pCPUs has a heavy overload
in osq_lock().

This is because vCPU A hold the osq lock and yield out, vCPU B wait
per_cpu node->locked to be set. IOW, vCPU B wait vCPU A to run and
unlock the osq lock. Such spinning is meaningless.

So lets use vcpu_is_preempted() to detect if we need stop the spinning

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

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 kernel/locking/osq_lock.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 05a3785..9e86f0b 100644
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
@@ -118,8 +123,17 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	while (!READ_ONCE(node->locked)) {
 		/*
 		 * If we need to reschedule bail... so we can block.
+		 * An over-committed guest with more vCPUs than pCPUs
+		 * might fall in this loop and cause a huge overload.
+		 * This is because vCPU A(prev) hold the osq lock and yield out
+		 * vCPU B(node) wait ->locked to be set, IOW, it wait utill
+		 * vCPU A run and unlock the osq lock. Such spin is meaningless
+		 * use vcpu_is_preempted to detech such case. IF arch does not
+		 * support vcpu preempted check, vcpu_is_preempted is a macro
+		 * defined by false.
 		 */
-		if (need_resched())
+		if (need_resched() ||
+			vcpu_is_preempted(node_cpu(node->prev)))
 			goto unqueue;
 
 		cpu_relax_lowlatency();
-- 
2.4.11
