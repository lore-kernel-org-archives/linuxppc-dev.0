Return-Path: <srs0=cfcn=ag=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmYLV1ZCJzDrFs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 14:16:18 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xmYLT6blDz8t2N
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 14:16:17 +1000 (AEST)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xmYLT1wsLz9s9Y
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Sep 2017 14:16:17 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id q76so1096876pfq.5
 for <linuxppc-dev@ozlabs.org>; Mon, 04 Sep 2017 21:16:17 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: npiggin@gmail.com,
	mahesh@linux.vnet.ibm.com,
	alistair@popple.id.au
Cc: linuxppc-dev@ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [rfc 3/3] powerpc/mce: hookup memory_failure for UE errors
Date: Tue,  5 Sep 2017 14:15:55 +1000
Message-Id: <20170905041555.27696-4-bsingharora@gmail.com>
In-Reply-To: <20170905041555.27696-1-bsingharora@gmail.com>
References: <20170905041555.27696-1-bsingharora@gmail.com>
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
 arch/powerpc/kernel/mce.c | 62 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index f41a75d..39986d5 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -39,11 +39,20 @@ static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT], mce_event);
 static DEFINE_PER_CPU(int, mce_queue_count);
 static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT], mce_event_queue);
 
+/* Queue for delayed MCE UE events. */
+static DEFINE_PER_CPU(int, mce_ue_count);
+static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT], mce_ue_event_queue);
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
@@ -143,6 +152,7 @@ void save_mce_event(struct pt_regs *regs, long handled,
 		if (phys_addr != ULONG_MAX) {
 			mce->u.ue_error.physical_address_provided = true;
 			mce->u.ue_error.physical_address = phys_addr;
+			machine_check_ue_event(mce);
 		}
 	}
 	return;
@@ -197,6 +207,26 @@ void release_mce_event(void)
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
@@ -219,7 +249,32 @@ void machine_check_queue_event(void)
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
+		}
+#endif
+		__this_cpu_dec(mce_ue_count);
+	}
+}
 /*
  * process pending MCE event from the mce event queue. This function will be
  * called during syscall exit.
@@ -227,6 +282,7 @@ void machine_check_queue_event(void)
 static void machine_check_process_queued_event(struct irq_work *work)
 {
 	int index;
+	struct machine_check_event *evt;
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
@@ -236,8 +292,8 @@ static void machine_check_process_queued_event(struct irq_work *work)
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
