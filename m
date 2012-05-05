Return-Path: <anton.vorontsov@linaro.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD6E3B710D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2012 11:48:51 +1000 (EST)
Received: by mail-ob0-f179.google.com with SMTP id up19so4953274obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2012 18:48:51 -0700 (PDT)
Date: Fri, 4 May 2012 18:47:28 -0700
From: Anton Vorontsov <anton.vorontsov@linaro.org>
To: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] cpu: Document clear_tasks_mm_cpumask()
Message-ID: <20120505014728.GA9079@lizard>
References: <20120423070641.GA27702@lizard> <20120423070736.GA30752@lizard>
 <20120426165911.00cebd31.akpm@linux-foundation.org>
 <1335869133.13683.125.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1335869133.13683.125.camel@twins>
Cc: linaro-kernel@lists.linaro.org, Mike Frysinger <vapier@gentoo.org>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, linuxppc-dev@lists.ozlabs.org,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Paul Mundt <lethal@linux-sh.org>,
 John Stultz <john.stultz@linaro.org>, patches@linaro.org,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Russell King <linux@arm.linux.org.uk>, uclinux-dist-devel@blackfin.uclinux.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds more comments on clear_tasks_mm_cpumask, plus adds
a runtime check: the function is only suitable for offlined CPUs,
and if called inappropriately, the kernel should scream aloud.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---

On Tue, May 01, 2012 at 12:45:33PM +0200, Peter Zijlstra wrote:
> On Thu, 2012-04-26 at 16:59 -0700, Andrew Morton wrote:
> > > +void clear_tasks_mm_cpumask(int cpu)
> > 
> > The operation of this function was presumably obvious to you at the
> > time you wrote it, but that isn't true of other people at later times.
> > 
> > Please document it?
[...]
> > If someone tries to use this function for a different purpose, or
> > copies-and-modifies it for a different purpose, we just shot them in
> > the foot.
> > 
> > They'd be pretty dumb to do that without reading the local comment,
> > but still...
> 
> Methinks something simple like:
> 
> 	WARN_ON(cpu_online(cpu));
> 
> Ought to cure that worry, no? :-)

Yeah, this is all good ideas, thanks.

How about the following patch?

 kernel/cpu.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index ecdf499..1bfa26f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -13,6 +13,7 @@
 #include <linux/oom.h>
 #include <linux/rcupdate.h>
 #include <linux/export.h>
+#include <linux/bug.h>
 #include <linux/kthread.h>
 #include <linux/stop_machine.h>
 #include <linux/mutex.h>
@@ -173,6 +174,18 @@ void __ref unregister_cpu_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(unregister_cpu_notifier);
 
+/**
+ * clear_tasks_mm_cpumask - Safely clear tasks' mm_cpumask for a CPU
+ * @cpu: a CPU id
+ *
+ * This function walks up all processes, finds a valid mm struct for
+ * each one and then clears a corresponding bit in mm's cpumask. While
+ * this all sounds trivial, there are various non-obvious corner cases,
+ * which this function tries to solve in a safe manner.
+ *
+ * Also note that the function uses a somewhat relaxed locking scheme,
+ * so it may be called only for an already offlined CPU.
+ */
 void clear_tasks_mm_cpumask(int cpu)
 {
 	struct task_struct *p;
@@ -184,10 +197,15 @@ void clear_tasks_mm_cpumask(int cpu)
 	 * Thus, we may use rcu_read_lock() here, instead of grabbing
 	 * full-fledged tasklist_lock.
 	 */
+	WARN_ON(cpu_online(cpu));
 	rcu_read_lock();
 	for_each_process(p) {
 		struct task_struct *t;
 
+		/*
+		 * Main thread might exit, but other threads may still have
+		 * a valid mm. Find one.
+		 */
 		t = find_lock_task_mm(p);
 		if (!t)
 			continue;
-- 
1.7.9.2
