Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzlfj4fW8zDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 01:37:33 +1000 (AEST)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Tue, 3 May 2016 21:07:30 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C334D2C90019
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 20:59:04 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u43FT4Aj20840702
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 20:59:04 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u43FQkms000551
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 20:59:03 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH-next v2 1/2] cpufreq: powernv: Move smp_call_function_any()
 out of irq safe block
Date: Tue,  3 May 2016 20:49:35 +0530
Message-Id: <1462288776-26721-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
In-Reply-To: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix a WARN_ON caused by smp_call_function_any() when irq is disabled,
because of changes made in the patch ('cpufreq: powernv: Ramp-down
 global pstate slower than local-pstate')
https://patchwork.ozlabs.org/patch/612058/

 WARNING: CPU: 0 PID: 4 at kernel/smp.c:291
smp_call_function_single+0x170/0x180

 Call Trace:
 [c0000007f648f9f0] [c0000007f648fa90] 0xc0000007f648fa90 (unreliable)
 [c0000007f648fa30] [c0000000001430e0] smp_call_function_any+0x170/0x1c0
 [c0000007f648fa90] [c0000000007b4b00]
powernv_cpufreq_target_index+0xe0/0x250
 [c0000007f648fb00] [c0000000007ac9dc]
__cpufreq_driver_target+0x20c/0x3d0
 [c0000007f648fbc0] [c0000000007b1b4c] od_dbs_timer+0xcc/0x260
 [c0000007f648fc10] [c0000000007b3024] dbs_work_handler+0x54/0xa0
 [c0000007f648fc50] [c0000000000c49a8] process_one_work+0x1d8/0x590
 [c0000007f648fce0] [c0000000000c4e08] worker_thread+0xa8/0x660
 [c0000007f648fd80] [c0000000000cca88] kthread+0x108/0x130
 [c0000007f648fe30] [c0000000000095e8] ret_from_kernel_thread+0x5c/0x74

- Calling smp_call_function_any() with interrupt disabled (through
 spin_lock_irqsave) could cause a deadlock, as smp_call_function_any()
 relies on the IPI to complete. This is detected in the
 smp_call_function_any() call and hence the WARN_ON.

- As the spinlock (gpstates->lock) is only used to synchronize access of
 global_pstate_info  between timer irq handler and target_index calls. And
 the timer irq handler just try_locks() hence it would not cause a
 deadlock. Hence could do without making spinlocks irq safe.

- As the smp_call_function_any() is a blocking call and does not access
 global_pstates_info, it could reduce the critcal section by moving
 smp_call_function_any() after giving up the lock.

Reported-by: Abdul Haleem <abdhalee@linux.vnet.linux.com>
Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
Patch is based on Rafael's linux-next
 drivers/cpufreq/powernv-cpufreq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 144c732..1f0e20c 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -581,9 +581,10 @@ void gpstate_timer_handler(unsigned long data)
 	gpstates->last_gpstate = freq_data.gpstate_id;
 	gpstates->last_lpstate = freq_data.pstate_id;
 
+	spin_unlock(&gpstates->gpstate_lock);
+
 	/* Timer may get migrated to a different cpu on cpu hot unplug */
 	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
-	spin_unlock(&gpstates->gpstate_lock);
 }
 
 /*
@@ -596,7 +597,6 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 {
 	struct powernv_smp_call_data freq_data;
 	unsigned int cur_msec, gpstate_id;
-	unsigned long flags;
 	struct global_pstate_info *gpstates = policy->driver_data;
 
 	if (unlikely(rebooting) && new_index != get_nominal_index())
@@ -607,7 +607,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 
 	cur_msec = jiffies_to_msecs(get_jiffies_64());
 
-	spin_lock_irqsave(&gpstates->gpstate_lock, flags);
+	spin_lock(&gpstates->gpstate_lock);
 	freq_data.pstate_id = powernv_freqs[new_index].driver_data;
 
 	if (!gpstates->last_sampled_time) {
@@ -654,13 +654,14 @@ gpstates_done:
 	gpstates->last_gpstate = freq_data.gpstate_id;
 	gpstates->last_lpstate = freq_data.pstate_id;
 
+	spin_unlock(&gpstates->gpstate_lock);
+
 	/*
 	 * Use smp_call_function to send IPI and execute the
 	 * mtspr on target CPU.  We could do that without IPI
 	 * if current CPU is within policy->cpus (core)
 	 */
 	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
-	spin_unlock_irqrestore(&gpstates->gpstate_lock, flags);
 	return 0;
 }
 
-- 
2.5.5
