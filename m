Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3JSG3hCVzDsQS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 14:27:26 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id a7so232644pfj.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 21:27:26 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v4 5/5] powerpc/mce: hookup memory_failure for UE errors
Date: Fri, 29 Sep 2017 14:26:55 +1000
Message-Id: <20170929042655.14570-6-bsingharora@gmail.com>
In-Reply-To: <20170929042655.14570-1-bsingharora@gmail.com>
References: <20170929042655.14570-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we are in user space and hit a UE error, we now have the
basic infrastructure to walk the page tables and find out
the effective address that was accessed, since the DAR
is not valid.

We use a work_queue content to hookup the bad pfn, any
other context causes problems, since memory_failure itself
can call into schedule() via lru_drain_ bits.

We could probably poison the struct page to avoid a race
between detection and taking corrective action.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce.c | 70 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index ee148f4..299553e 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -39,11 +39,21 @@ static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT], mce_event);
 static DEFINE_PER_CPU(int, mce_queue_count);
 static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT], mce_event_queue);
 
+/* Queue for delayed MCE UE events. */
+static DEFINE_PER_CPU(int, mce_ue_count);
+static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT],
+					mce_ue_event_queue);
+
 static void machine_check_process_queued_event(struct irq_work *work);
+void machine_check_ue_event(struct machine_check_event *evt);
+static void machine_process_ue_event(struct work_struct *work);
+
 static struct irq_work mce_event_process_work = {
         .func = machine_check_process_queued_event,
 };
 
+DECLARE_WORK(mce_ue_event_work, machine_process_ue_event);
+
 static void mce_set_error_info(struct machine_check_event *mce,
 			       struct mce_error_info *mce_err)
 {
@@ -143,6 +153,7 @@ void save_mce_event(struct pt_regs *regs, long handled,
 		if (phys_addr != ULONG_MAX) {
 			mce->u.ue_error.physical_address_provided = true;
 			mce->u.ue_error.physical_address = phys_addr;
+			machine_check_ue_event(mce);
 		}
 	}
 	return;
@@ -197,6 +208,26 @@ void release_mce_event(void)
 	get_mce_event(NULL, true);
 }
 
+
+/*
+ * Queue up the MCE event which then can be handled later.
+ */
+void machine_check_ue_event(struct machine_check_event *evt)
+{
+	int index;
+
+	index = __this_cpu_inc_return(mce_ue_count) - 1;
+	/* If queue is full, just return for now. */
+	if (index >= MAX_MC_EVT) {
+		__this_cpu_dec(mce_ue_count);
+		return;
+	}
+	memcpy(this_cpu_ptr(&mce_ue_event_queue[index]), evt, sizeof(*evt));
+
+	/* Queue work to process this event later. */
+	schedule_work(&mce_ue_event_work);
+}
+
 /*
  * Queue up the MCE event which then can be handled later.
  */
@@ -219,7 +250,39 @@ void machine_check_queue_event(void)
 	/* Queue irq work to process this event later. */
 	irq_work_queue(&mce_event_process_work);
 }
-
+/*
+ * process pending MCE event from the mce event queue. This function will be
+ * called during syscall exit.
+ */
+static void machine_process_ue_event(struct work_struct *work)
+{
+	int index;
+	struct machine_check_event *evt;
+
+	while (__this_cpu_read(mce_ue_count) > 0) {
+		index = __this_cpu_read(mce_ue_count) - 1;
+		evt = this_cpu_ptr(&mce_ue_event_queue[index]);
+#ifdef CONFIG_MEMORY_FAILURE
+		/*
+		 * This should probably queued elsewhere, but
+		 * oh! well
+		 */
+		if (evt->error_type == MCE_ERROR_TYPE_UE) {
+			if (evt->u.ue_error.physical_address_provided) {
+				unsigned long pfn;
+
+				pfn = evt->u.ue_error.physical_address >>
+					PAGE_SHIFT;
+				memory_failure(pfn, SIGBUS, 0);
+			} else
+				pr_warn("Failed to identify bad address from "
+					"where the uncorrectable error (UE) "
+					"was generated\n");
+		}
+#endif
+		__this_cpu_dec(mce_ue_count);
+	}
+}
 /*
  * process pending MCE event from the mce event queue. This function will be
  * called during syscall exit.
@@ -227,6 +290,7 @@ void machine_check_queue_event(void)
 static void machine_check_process_queued_event(struct irq_work *work)
 {
 	int index;
+	struct machine_check_event *evt;
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
@@ -236,8 +300,8 @@ static void machine_check_process_queued_event(struct irq_work *work)
 	 */
 	while (__this_cpu_read(mce_queue_count) > 0) {
 		index = __this_cpu_read(mce_queue_count) - 1;
-		machine_check_print_event_info(
-				this_cpu_ptr(&mce_event_queue[index]), false);
+		evt = this_cpu_ptr(&mce_event_queue[index]);
+		machine_check_print_event_info(evt, false);
 		__this_cpu_dec(mce_queue_count);
 	}
 }
-- 
2.9.5
