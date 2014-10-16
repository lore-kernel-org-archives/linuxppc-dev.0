Return-Path: <kernelfans@gmail.com>
Received: from mail-ig0-x22a.google.com (mail-ig0-x22a.google.com
 [IPv6:2607:f8b0:4001:c05::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F67B1A03CB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 18:25:42 +1100 (AEDT)
Received: by mail-ig0-f170.google.com with SMTP id hn15so587738igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 00:25:39 -0700 (PDT)
From: kernelfans@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [RFC 01/11] sched: introduce sys_cpumask in tsk to adapt asymmetric
 system
Date: Thu, 16 Oct 2014 15:29:50 -0400
Message-Id: <1413487800-7162-2-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some system such as powerpc, some tsk (vcpu thread) can only run on
the dedicated cpu. Since we adapt some asymmetric method to monitor the
whole physical cpu. (powerKVM only allows the primary hwthread to
set up runtime env for the secondary when entering guest).

Nowadays, powerKVM run with all the secondary hwthread offline to ensure
the vcpu threads only run on the primary thread. But we plan to keep all
cpus online when running powerKVM to give more power when switching back
to host, so introduce sys_allowed cpumask to reflect the cpuset which
the vcpu thread can run on.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 include/linux/init_task.h |  1 +
 include/linux/sched.h     |  6 ++++++
 kernel/sched/core.c       | 10 ++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 2bb4c4f3..c56f69e 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -172,6 +172,7 @@ extern struct task_group root_task_group;
 	.normal_prio	= MAX_PRIO-20,					\
 	.policy		= SCHED_NORMAL,					\
 	.cpus_allowed	= CPU_MASK_ALL,					\
+	.sys_allowed = CPU_MASK_ALL,			\
 	.nr_cpus_allowed= NR_CPUS,					\
 	.mm		= NULL,						\
 	.active_mm	= &init_mm,					\
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5c2c885..ce429f3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1260,7 +1260,10 @@ struct task_struct {
 
 	unsigned int policy;
 	int nr_cpus_allowed;
+	/* Anded user and sys_allowed */
 	cpumask_t cpus_allowed;
+	/* due to the feature of asymmetric, some tsk can only run on such cpu */
+	cpumask_t sys_allowed;
 
 #ifdef CONFIG_PREEMPT_RCU
 	int rcu_read_lock_nesting;
@@ -2030,6 +2033,9 @@ static inline void tsk_restore_flags(struct task_struct *task,
 }
 
 #ifdef CONFIG_SMP
+extern void set_cpus_sys_allowed(struct task_struct *p,
+			const struct cpumask *new_mask);
+
 extern void do_set_cpus_allowed(struct task_struct *p,
 			       const struct cpumask *new_mask);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ec1a286..2cd1ae3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4596,13 +4596,19 @@ void init_idle(struct task_struct *idle, int cpu)
 }
 
 #ifdef CONFIG_SMP
+void set_cpus_sys_allowed(struct task_struct *p,
+	const struct cpumask *new_mask)
+{
+	cpumask_copy(&p->sys_allowed, new_mask);
+}
+
 void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
 	if (p->sched_class && p->sched_class->set_cpus_allowed)
 		p->sched_class->set_cpus_allowed(p, new_mask);
 
-	cpumask_copy(&p->cpus_allowed, new_mask);
-	p->nr_cpus_allowed = cpumask_weight(new_mask);
+	cpumask_and(&p->cpus_allowed, &p->sys_allowed, new_mask);
+	p->nr_cpus_allowed = cpumask_weight(&p->cpus_allowed);
 }
 
 /*
-- 
1.8.3.1
