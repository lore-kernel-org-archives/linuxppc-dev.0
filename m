Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsWWT2rjyzDqlw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 16:11:17 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id d8so7219238pgt.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 23:11:17 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	mahesh@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v2 5/5] powerpc/mce: hookup memory_failure for UE errors
Date: Wed, 13 Sep 2017 16:10:49 +1000
Message-Id: <20170913061049.13256-6-bsingharora@gmail.com>
In-Reply-To: <20170913061049.13256-1-bsingharora@gmail.com>
References: <20170913061049.13256-1-bsingharora@gmail.com>
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
---
 arch/powerpc/kernel/mce.c | 67 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index c7acc33..f20345a 100644
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
@@ -219,7 +250,36 @@ void machine_check_queue_event(void)
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
+			if (evt->u.ue_error.physical_address_provided)
+				memory_failure(evt->u.ue_error.physical_address,
+						SIGBUS, 0);
+			else
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
@@ -227,6 +287,7 @@ void machine_check_queue_event(void)
 static void machine_check_process_queued_event(struct irq_work *work)
 {
 	int index;
+	struct machine_check_event *evt;
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
@@ -236,8 +297,8 @@ static void machine_check_process_queued_event(struct irq_work *work)
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
