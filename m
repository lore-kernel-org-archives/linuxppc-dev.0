Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdVW92pmGzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 23:43:01 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5RDYDTu029102
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 09:42:59 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23sjug9vyd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 09:42:59 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Mon, 27 Jun 2016 07:42:58 -0600
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org, mingo@redhat.com,
 mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
 Waiman.Long@hpe.com, boqun.feng@gmail.com, will.deacon@arm.com,
 dave@stgolabs.net, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH 1/3] kernel/sched: introduce vcpu preempted check interface
Date: Mon, 27 Jun 2016 13:41:28 -0400
In-Reply-To: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1467049290-32359-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

this supports to fix lock holder preempted issue which run as a guest

for kernel users, we could use bool vcpu_is_preempted(int cpu) to detech
if one vcpu is preempted or not.

The default implementation is a macrodefined by false. So compiler can
wrap it out if arch dose not support such vcpu pteempted check.

archs can implement it by define arch_vcpu_is_preempted().

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 include/linux/sched.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6e42ada..dc0a9c3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -3293,6 +3293,15 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
 
 #endif /* CONFIG_SMP */
 
+#ifdef arch_vcpu_is_preempted
+static inline bool vcpu_is_preempted(int cpu)
+{
+	return arch_vcpu_is_preempted(cpu);
+}
+#else
+#define vcpu_is_preempted(cpu)	false
+#endif
+
 extern long sched_setaffinity(pid_t pid, const struct cpumask *new_mask);
 extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 
-- 
2.4.11
