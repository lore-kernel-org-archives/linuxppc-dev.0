Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw5Sn1KngzDqSQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 17:46:32 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6L7iMPB015907
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 03:46:30 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24as6fjdwx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 03:46:30 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Thu, 21 Jul 2016 03:46:29 -0400
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v3 1/4] kernel/sched: introduce vcpu preempted check interface
Date: Thu, 21 Jul 2016 07:45:11 -0400
In-Reply-To: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1469101514-49475-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch supports to fix lock holder preemption issue.

For kernel users, we could use bool vcpu_is_preempted(int cpu) to detech if
one vcpu is preempted or not.

The default implementation is a macro defined by false. So compiler can
wrap it out if arch dose not support such vcpu pteempted check.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 include/linux/sched.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6e42ada..cbe0574 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -3293,6 +3293,18 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
 
 #endif /* CONFIG_SMP */
 
+/*
+ * In order to deal with a various lock holder preemption issues provide an
+ * interface to see if a vCPU is currently running or not.
+ *
+ * This allows us to terminate optimistic spin loops and block, analogous to
+ * the native optimistic spin heuristic of testing if the lock owner task is
+ * running or not.
+ */
+#ifndef vcpu_is_preempted
+#define vcpu_is_preempted(cpu)	false
+#endif
+
 extern long sched_setaffinity(pid_t pid, const struct cpumask *new_mask);
 extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 
-- 
2.4.11
