Return-Path: <kernelfans@gmail.com>
Received: from mail-ig0-x233.google.com (mail-ig0-x233.google.com
 [IPv6:2607:f8b0:4001:c05::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABF101A0388
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 18:25:59 +1100 (AEDT)
Received: by mail-ig0-f179.google.com with SMTP id h18so2945547igc.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 00:25:57 -0700 (PDT)
From: kernelfans@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [RFC 05/11] sched: introduce stop_cpus_async() to schedule special
 tsk on cpu
Date: Thu, 16 Oct 2014 15:29:54 -0400
Message-Id: <1413487800-7162-6-git-send-email-kernelfans@gmail.com>
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

The proto will be:
     cpu1                              cpuX
  stop_cpus_async()
                                  bring cpuX to a special state
                                  signal flag and trapped
  check for flag

The func help powerpc to reuse the scheme of cpu_stopper_task
to force the secondary hwthread goto NAP state, in which state,
cpu will not run any longer until the master cpu tells them to
go.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 include/linux/stop_machine.h |  2 ++
 kernel/stop_machine.c        | 25 ++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index d2abbdb..871c1bf 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -32,6 +32,8 @@ int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *
 void stop_one_cpu_nowait(unsigned int cpu, cpu_stop_fn_t fn, void *arg,
 			 struct cpu_stop_work *work_buf);
 int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg);
+int stop_cpus_async(const struct cpumask *cpumask, cpu_stop_fn_t fn,
+	void *arg);
 int try_stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg);
 
 #else	/* CONFIG_SMP */
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 695f0c6..d26fd6a 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -354,13 +354,15 @@ static void queue_stop_cpus_work(const struct cpumask *cpumask,
 }
 
 static int __stop_cpus(const struct cpumask *cpumask,
-		       cpu_stop_fn_t fn, void *arg)
+		       cpu_stop_fn_t fn, void *arg, bool sync)
 {
 	struct cpu_stop_done done;
 
-	cpu_stop_init_done(&done, cpumask_weight(cpumask));
+	if (sync)
+		cpu_stop_init_done(&done, cpumask_weight(cpumask));
 	queue_stop_cpus_work(cpumask, fn, arg, &done);
-	wait_for_completion(&done.completion);
+	if (sync)
+		wait_for_completion(&done.completion);
 	return done.executed ? done.ret : -ENOENT;
 }
 
@@ -398,7 +400,20 @@ int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg)
 
 	/* static works are used, process one request at a time */
 	mutex_lock(&stop_cpus_mutex);
-	ret = __stop_cpus(cpumask, fn, arg);
+	ret = __stop_cpus(cpumask, fn, arg, true);
+	mutex_unlock(&stop_cpus_mutex);
+	return ret;
+}
+
+/* similar to stop_cpus(), but not wait for the ack. */
+int stop_cpus_async(const struct cpumask *cpumask, cpu_stop_fn_t fn,
+	void *arg)
+{
+	int ret;
+
+	/* static works are used, process one request at a time */
+	mutex_lock(&stop_cpus_mutex);
+	ret = __stop_cpus(cpumask, fn, arg, false);
 	mutex_unlock(&stop_cpus_mutex);
 	return ret;
 }
@@ -428,7 +443,7 @@ int try_stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg)
 	/* static works are used, process one request at a time */
 	if (!mutex_trylock(&stop_cpus_mutex))
 		return -EAGAIN;
-	ret = __stop_cpus(cpumask, fn, arg);
+	ret = __stop_cpus(cpumask, fn, arg, true);
 	mutex_unlock(&stop_cpus_mutex);
 	return ret;
 }
-- 
1.8.3.1
