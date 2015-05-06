Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5C731A17F3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 21:57:21 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 6 May 2015 17:27:19 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 9BCB1E0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 17:30:08 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t46BueAV43712692
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 May 2015 17:26:40 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t46BN2nL016426
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 May 2015 16:53:02 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
Subject: [PATCH 1/3] procfs: add guest steal time in /proc/<pid>/stat
Date: Wed,  6 May 2015 17:26:34 +0530
Message-Id: <763805b68b8741de0172099163d9650c0352d724.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: ego@linux.vnet.ibm.com, agraf@suse.de, mingo@redhat.com, paulus@samba.org,
 warrier@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce a field in /proc/<pid>/stat to expose guest steal time.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 fs/proc/array.c       | 6 ++++++
 include/linux/sched.h | 7 +++++++
 kernel/fork.c         | 2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index fd02a9e..ad8e616 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -381,6 +381,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long rsslim = 0;
 	char tcomm[sizeof(task->comm)];
 	unsigned long flags;
+	cputime_t gstime;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -400,6 +401,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	sigemptyset(&sigcatch);
 	cutime = cstime = utime = stime = 0;
 	cgtime = gtime = 0;
+	gstime = 0;
 
 	if (lock_task_sighand(task, &flags)) {
 		struct signal_struct *sig = task->signal;
@@ -428,6 +430,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 				min_flt += t->min_flt;
 				maj_flt += t->maj_flt;
 				gtime += task_gtime(t);
+				gstime += task_gstime(t);
 			} while_each_thread(task, t);
 
 			min_flt += sig->min_flt;
@@ -450,6 +453,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		maj_flt = task->maj_flt;
 		task_cputime_adjusted(task, &utime, &stime);
 		gtime = task_gtime(task);
+		gstime = task_gstime(task);
 	}
 
 	/* scale priority and nice values from timeslices to -20..20 */
@@ -523,6 +527,8 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	else
 		seq_put_decimal_ll(m, ' ', 0);
 
+	seq_put_decimal_ull(m, ' ', cputime_to_clock_t(gstime));
+
 	seq_putc(m, '\n');
 	if (mm)
 		mmput(mm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 26a2e61..e28f869 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1430,6 +1430,7 @@ struct task_struct {
 
 	cputime_t utime, stime, utimescaled, stimescaled;
 	cputime_t gtime;
+	cputime_t gstime;
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	struct cputime prev_cputime;
 #endif
@@ -1956,6 +1957,12 @@ static inline cputime_t task_gtime(struct task_struct *t)
 	return t->gtime;
 }
 #endif
+
+static inline cputime_t task_gstime(struct task_struct *t)
+{
+	return t->gstime;
+}
+
 extern void task_cputime_adjusted(struct task_struct *p, cputime_t *ut, cputime_t *st);
 extern void thread_group_cputime_adjusted(struct task_struct *p, cputime_t *ut, cputime_t *st);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 03c1eaa..edf4ffb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1339,7 +1339,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
 
 	init_sigpending(&p->pending);
 
-	p->utime = p->stime = p->gtime = 0;
+	p->utime = p->stime = p->gtime = p->gstime = 0;
 	p->utimescaled = p->stimescaled = 0;
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	p->prev_cputime.utime = p->prev_cputime.stime = 0;
-- 
2.3.7
