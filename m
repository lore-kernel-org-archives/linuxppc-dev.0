Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqCLq4kMrzDqKN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 18:54:27 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id g202so2782780pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 01:54:27 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: sjitindarsingh@gmail.com, pbonzini@redhat.com, rkrcmar@redhat.com,
 agraf@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, kvm-ppc@vger.kernel.org
Subject: [PATCH V3 5/5] powerpc/kvm/stats: Implement existing and add new halt
 polling vcpu stats
Date: Wed, 13 Jul 2016 18:54:13 +1000
Message-Id: <1468400053-5115-1-git-send-email-sjitindarsingh@gmail.com>
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
over all the vcpus for a running guest it doesn't matter which vcpu
they are attributed to, thus we choose the current runner vcpu of the
vcore.

Also add new vcpu stats: halt_block_time_successful_poll and
halt_block_time_waited to be used to accumulate the total time spend
blocked when we either successfully polled, or unsuccessfully polled and
then waited respectively, and halt_successful_wait to accumulate the number
of times the vcpu waited.

Given that halt_poll_time and halt_wait_time are expressed in nanoseconds
it is necessary to represent these as 64-bit quantities, otherwise they
would overflow after only about 4 seconds.

Given that the total time spend either successfully polling or
unsuccessfully polling and then waiting will be known, and the number of
times that each was done, it will be possible to determine the average
block time of the vcore when it either successfully polls or
unsuccessfully polls and then waits. This will give the ability to tune
the kvm module parameters based on the calculated average block time in
each scenario.

---
Change Log:

V1 -> V2:
	- Nothing
V2 -> V3:
	- Rename vcpu stats to express with greater clarity what
	  they represent:
		halt_poll_time -> halt_block_time_successful_poll
		halt_wait_time -> halt_block_time_waited

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h |  3 +++
 arch/powerpc/kvm/book3s.c           |  5 +++++
 arch/powerpc/kvm/book3s_hv.c        | 16 ++++++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 5c52a9f..c0e16d4 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -114,8 +114,11 @@ struct kvm_vcpu_stat {
 	u64 emulated_inst_exits;
 	u64 dec_exits;
 	u64 ext_intr_exits;
+	u64 halt_block_time_successful_poll;
+	u64 halt_block_time_waited;
 	u64 halt_successful_poll;
 	u64 halt_attempted_poll;
+	u64 halt_successful_wait;
 	u64 halt_poll_invalid;
 	u64 halt_wakeup;
 	u64 dbell_exits;
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 47018fc..0c1295b 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -52,8 +52,13 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "dec",         VCPU_STAT(dec_exits) },
 	{ "ext_intr",    VCPU_STAT(ext_intr_exits) },
 	{ "queue_intr",  VCPU_STAT(queue_intr) },
+	{ "halt_block_time_successful_poll_ns",
+			VCPU_STAT(halt_block_time_successful_poll) },
+	{ "halt_block_time_waited_ns",
+			VCPU_STAT(halt_block_time_waited) },
 	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll), },
 	{ "halt_attempted_poll", VCPU_STAT(halt_attempted_poll), },
+	{ "halt_successful_wait",	VCPU_STAT(halt_successful_wait) },
 	{ "halt_poll_invalid", VCPU_STAT(halt_poll_invalid) },
 	{ "halt_wakeup", VCPU_STAT(halt_wakeup) },
 	{ "pf_storage",  VCPU_STAT(pf_storage) },
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 0d8ce14..975a757 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2679,8 +2679,8 @@ static int kvmppc_vcore_check_block(struct kvmppc_vcore *vc)
  */
 static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 {
-	int do_sleep = 1;
 	ktime_t cur, start;
+	int do_sleep = 1;
 	u64 block_ns;
 	DECLARE_SWAITQUEUE(wait);
 
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
+		vc->runner->stat.halt_block_time_waited += block_ns;
+	else if (vc->halt_poll_ns)
+		vc->runner->stat.halt_block_time_successful_poll += block_ns;
+
 	if (halt_poll_max_ns) {
 		if (block_ns <= vc->halt_poll_ns)
 			;
-- 
2.5.5
