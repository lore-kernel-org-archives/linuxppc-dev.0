Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV1HD18gFzDqjK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 19:21:44 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id hf6so1175825pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 02:21:44 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 agraf@suse.com, rkrcmar@redhat.com,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 4/4] powerpc/kvm/stats: Implement existing and add new halt
 polling vcpu stats
Date: Wed, 15 Jun 2016 19:21:08 +1000
Message-Id: <1465982468-18833-4-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1465982468-18833-1-git-send-email-sjitindarsingh@gmail.com>
References: <1465982468-18833-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vcpu stats are used to collect information about a vcpu which can be viewed
in the debugfs. For example halt_attempted_poll and halt_successful_poll
are used to keep track of the number of times the vcpu attempts to and
successfully polls. These stats are currently not used on powerpc.

Implement incrementation of the halt_attempted_poll and
halt_successful_poll vcpu stats for powerpc. Since these stats are summed
over all the vcpus for all running guests it doesn't matter which vcpu
they are attributed to, thus we choose the current runner vcpu of the
vcore.

Also add new vcpu stats: halt_poll_time and halt_wait_time to be used to
accumulate the total time spend polling and waiting respectively, and
halt_successful_wait to accumulate the number of times the vcpu waits.
Given that halt_poll_time and halt_wait_time are expressed in nanoseconds
it is necessary to represent these as 64-bit quantities, otherwise they
would overflow after only about 4 seconds.

Given that the total time spend either polling or waiting will be known and
the number of times that each was done, it will be possible to determine
the average poll and wait times. This will give the ability to tune the kvm
module parameters based on the calculated average wait and poll times.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h |  3 +++
 arch/powerpc/kvm/book3s.c           |  3 +++
 arch/powerpc/kvm/book3s_hv.c        | 14 +++++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index b34efe8..2ece5fc 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -114,8 +114,11 @@ struct kvm_vcpu_stat {
 	u32 emulated_inst_exits;
 	u32 dec_exits;
 	u32 ext_intr_exits;
+	u64 halt_poll_time;
+	u64 halt_wait_time;
 	u32 halt_successful_poll;
 	u32 halt_attempted_poll;
+	u32 halt_successful_wait;
 	u32 halt_poll_invalid;
 	u32 halt_wakeup;
 	u32 dbell_exits;
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index ed9132b..6217bea 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -53,8 +53,11 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "dec",         VCPU_STAT(dec_exits) },
 	{ "ext_intr",    VCPU_STAT(ext_intr_exits) },
 	{ "queue_intr",  VCPU_STAT(queue_intr) },
+	{ "halt_poll_time_ns",		VCPU_STAT_U64(halt_poll_time) },
+	{ "halt_wait_time_ns",		VCPU_STAT_U64(halt_wait_time) },
 	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll), },
 	{ "halt_attempted_poll", VCPU_STAT(halt_attempted_poll), },
+	{ "halt_successful_wait",	VCPU_STAT(halt_successful_wait) },
 	{ "halt_poll_invalid", VCPU_STAT(halt_poll_invalid) },
 	{ "halt_wakeup", VCPU_STAT(halt_wakeup) },
 	{ "pf_storage",  VCPU_STAT(pf_storage) },
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 0d8ce14..a0dae63 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2688,6 +2688,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	cur = start = ktime_get();
 	if (vc->halt_poll_ns) {
 		ktime_t stop = ktime_add_ns(start, vc->halt_poll_ns);
+		++vc->runner->stat.halt_attempted_poll;
 
 		vc->vcore_state = VCORE_POLLING;
 		spin_unlock(&vc->lock);
@@ -2703,8 +2704,10 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 		spin_lock(&vc->lock);
 		vc->vcore_state = VCORE_INACTIVE;
 
-		if (!do_sleep)
+		if (!do_sleep) {
+			++vc->runner->stat.halt_successful_poll;
 			goto out;
+		}
 	}
 
 	prepare_to_swait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
@@ -2712,6 +2715,9 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	if (kvmppc_vcore_check_block(vc)) {
 		finish_swait(&vc->wq, &wait);
 		do_sleep = 0;
+		/* If we polled, count this as a successful poll */
+		if (vc->halt_poll_ns)
+			++vc->runner->stat.halt_successful_poll;
 		goto out;
 	}
 
@@ -2723,12 +2729,18 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	spin_lock(&vc->lock);
 	vc->vcore_state = VCORE_INACTIVE;
 	trace_kvmppc_vcore_blocked(vc, 1);
+	++vc->runner->stat.halt_successful_wait;
 
 	cur = ktime_get();
 
 out:
 	block_ns = ktime_to_ns(cur) - ktime_to_ns(start);
 
+	if (do_sleep)
+		vc->runner->stat.halt_wait_time += block_ns;
+	else if (vc->halt_poll_ns)
+		vc->runner->stat.halt_poll_time += block_ns;
+
 	if (halt_poll_max_ns) {
 		if (block_ns <= vc->halt_poll_ns)
 			;
-- 
2.5.5
