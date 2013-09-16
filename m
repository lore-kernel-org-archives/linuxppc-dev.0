Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1059F2C01F1
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:42:16 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 16 Sep 2013 22:31:10 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7DD782CE8051
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:42:13 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8GCg21d60751984
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:42:02 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8GCgCvF003445
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:42:13 +1000
Subject: [RFC PATCH v4 10/12] powerpc/book3s: Queue up and process delayed MCE
 events.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 16 Sep 2013 18:12:10 +0530
Message-ID: <20130916124210.16111.23468.stgit@mars.in.ibm.com>
In-Reply-To: <20130916123908.16111.4657.stgit@mars.in.ibm.com>
References: <20130916123908.16111.4657.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

When machine check real mode handler can not continue into host kernel
in V mode, it returns from the interrupt and we loose MCE event which
never gets logged. In such a situation queue up the MCE event so that
we can log it later when we get back into host kernel with r1 pointing to
kernel stack e.g. during syscall exit.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mce.h        |    3 +
 arch/powerpc/kernel/entry_64.S        |    5 +
 arch/powerpc/kernel/exceptions-64s.S  |    7 +-
 arch/powerpc/kernel/mce.c             |  154 +++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c |   97 ---------------------
 5 files changed, 168 insertions(+), 98 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 87cad2a..3276b40 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -190,5 +190,8 @@ extern void save_mce_event(struct pt_regs *regs, long handled,
 			   struct mce_error_info *mce_err, uint64_t addr);
 extern int get_mce_event(struct machine_check_event *mce, bool release);
 extern void release_mce_event(void);
+extern void machine_check_queue_event(void);
+extern void machine_check_process_queued_event(void);
+extern void machine_check_print_event_info(struct machine_check_event *evt);
 
 #endif /* __ASM_PPC64_MCE_H__ */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2bd0b88..71bcd41 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -183,6 +183,11 @@ syscall_exit:
 	bl	.do_show_syscall_exit
 	ld	r3,RESULT(r1)
 #endif
+#ifdef CONFIG_PPC_BOOK3S_64
+BEGIN_FTR_SECTION
+	bl	.machine_check_process_queued_event
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
+#endif
 	CURRENT_THREAD_INFO(r12, r1)
 
 	ld	r8,_MSR(r1)
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0a92ba4..ce57cec 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -824,7 +824,8 @@ BEGIN_FTR_SECTION
 	/* Supervisor state loss */
 	li	r0,1
 	stb	r0,PACA_NAPSTATELOST(r13)
-3:	MACHINE_CHECK_HANDLER_WINDUP
+3:	bl	.machine_check_queue_event
+	MACHINE_CHECK_HANDLER_WINDUP
 	GET_PACA(r13)
 	ld	r1,PACAR1(r13)
 	b	.power7_enter_nap_mode
@@ -864,8 +865,10 @@ BEGIN_FTR_SECTION
 2:
 	/*
 	 * Return from MC interrupt.
-	 * TODO: Queue up the MCE event so that we can log it later.
+	 * Queue up the MCE event so that we can log it later, while
+	 * returning from kernel or opal call.
 	 */
+	bl	.machine_check_queue_event
 	MACHINE_CHECK_HANDLER_WINDUP
 	rfid
 9:
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index aeecdf1..1cca4b6 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -31,6 +31,10 @@
 static DEFINE_PER_CPU(int, mce_nest_count);
 static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT], mce_event);
 
+/* Queue for delayed MCE events. */
+static DEFINE_PER_CPU(int, mce_queue_count);
+static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT], mce_event_queue);
+
 static void mce_set_error_info(struct machine_check_event *mce,
 			       struct mce_error_info *mce_err)
 {
@@ -162,3 +166,153 @@ void release_mce_event(void)
 {
 	get_mce_event(NULL, true);
 }
+
+/*
+ * Queue up the MCE event which then can be handled later.
+ */
+void machine_check_queue_event(void)
+{
+	int index;
+	struct machine_check_event evt;
+
+	if (!get_mce_event(&evt, MCE_EVENT_RELEASE))
+		return;
+
+	index = __get_cpu_var(mce_queue_count)++;
+	/* If queue is full, just return for now. */
+	if (index >= MAX_MC_EVT) {
+		__get_cpu_var(mce_queue_count)--;
+		return;
+	}
+	__get_cpu_var(mce_event_queue[index]) = evt;
+}
+
+/*
+ * process pending MCE event from the mce event queue. This function will be
+ * called during syscall exit.
+ */
+void machine_check_process_queued_event(void)
+{
+	int index;
+
+	preempt_disable();
+	/*
+	 * For now just print it to console.
+	 * TODO: log this error event to FSP or nvram.
+	 */
+	while (__get_cpu_var(mce_queue_count) > 0) {
+		index = __get_cpu_var(mce_queue_count) - 1;
+		machine_check_print_event_info(
+				&__get_cpu_var(mce_event_queue[index]));
+		__get_cpu_var(mce_queue_count)--;
+	}
+	preempt_enable();
+}
+
+void machine_check_print_event_info(struct machine_check_event *evt)
+{
+	const char *level, *sevstr, *subtype;
+	static const char *mc_ue_types[] = {
+		"Indeterminate",
+		"Instruction fetch",
+		"Page table walk ifetch",
+		"Load/Store",
+		"Page table walk Load/Store",
+	};
+	static const char *mc_slb_types[] = {
+		"Indeterminate",
+		"Parity",
+		"Multihit",
+	};
+	static const char *mc_erat_types[] = {
+		"Indeterminate",
+		"Parity",
+		"Multihit",
+	};
+	static const char *mc_tlb_types[] = {
+		"Indeterminate",
+		"Parity",
+		"Multihit",
+	};
+
+	/* Print things out */
+	if (evt->version != MCE_V1) {
+		pr_err("Machine Check Exception, Unknown event version %d !\n",
+		       evt->version);
+		return;
+	}
+	switch(evt->severity) {
+	case MCE_SEV_NO_ERROR:
+		level = KERN_INFO;
+		sevstr = "Harmless";
+		break;
+	case MCE_SEV_WARNING:
+		level = KERN_WARNING;
+		sevstr = "";
+		break;
+	case MCE_SEV_ERROR_SYNC:
+		level = KERN_ERR;
+		sevstr = "Severe";
+		break;
+	case MCE_SEV_FATAL:
+	default:
+		level = KERN_ERR;
+		sevstr = "Fatal";
+		break;
+	}
+
+	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,
+	       evt->disposition == MCE_DISPOSITION_RECOVERED ?
+	       "Recovered" : "[Not recovered");
+	printk("%s  Initiator: %s\n", level,
+	       evt->initiator == MCE_INITIATOR_CPU ? "CPU" : "Unknown");
+	switch(evt->error_type) {
+	case MCE_ERROR_TYPE_UE:
+		subtype = evt->u.ue_error.ue_error_type <
+			ARRAY_SIZE(mc_ue_types) ?
+			mc_ue_types[evt->u.ue_error.ue_error_type]
+			: "Unknown";
+		printk("%s  Error type: UE [%s]\n", level, subtype);
+		if (evt->u.ue_error.effective_address_provided)
+			printk("%s    Effective address: %016llx\n",
+			       level, evt->u.ue_error.effective_address);
+		if (evt->u.ue_error.physical_address_provided)
+			printk("%s      Physial address: %016llx\n",
+			       level, evt->u.ue_error.physical_address);
+		break;
+	case MCE_ERROR_TYPE_SLB:
+		subtype = evt->u.slb_error.slb_error_type <
+			ARRAY_SIZE(mc_slb_types) ?
+			mc_slb_types[evt->u.slb_error.slb_error_type]
+			: "Unknown";
+		printk("%s  Error type: SLB [%s]\n", level, subtype);
+		if (evt->u.slb_error.effective_address_provided)
+			printk("%s    Effective address: %016llx\n",
+			       level, evt->u.slb_error.effective_address);
+		break;
+	case MCE_ERROR_TYPE_ERAT:
+		subtype = evt->u.erat_error.erat_error_type <
+			ARRAY_SIZE(mc_erat_types) ?
+			mc_erat_types[evt->u.erat_error.erat_error_type]
+			: "Unknown";
+		printk("%s  Error type: ERAT [%s]\n", level, subtype);
+		if (evt->u.erat_error.effective_address_provided)
+			printk("%s    Effective address: %016llx\n",
+			       level, evt->u.erat_error.effective_address);
+		break;
+	case MCE_ERROR_TYPE_TLB:
+		subtype = evt->u.tlb_error.tlb_error_type <
+			ARRAY_SIZE(mc_tlb_types) ?
+			mc_tlb_types[evt->u.tlb_error.tlb_error_type]
+			: "Unknown";
+		printk("%s  Error type: TLB [%s]\n", level, subtype);
+		if (evt->u.tlb_error.effective_address_provided)
+			printk("%s    Effective address: %016llx\n",
+			       level, evt->u.tlb_error.effective_address);
+		break;
+	default:
+	case MCE_ERROR_TYPE_UNKNOWN:
+		printk("%s  Error type: Unknown\n", level);
+		break;
+	}
+}
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index bcbbcdc..f789514 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -247,29 +247,6 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 int opal_machine_check(struct pt_regs *regs)
 {
 	struct machine_check_event evt;
-	const char *level, *sevstr, *subtype;
-	static const char *opal_mc_ue_types[] = {
-		"Indeterminate",
-		"Instruction fetch",
-		"Page table walk ifetch",
-		"Load/Store",
-		"Page table walk Load/Store",
-	};
-	static const char *opal_mc_slb_types[] = {
-		"Indeterminate",
-		"Parity",
-		"Multihit",
-	};
-	static const char *opal_mc_erat_types[] = {
-		"Indeterminate",
-		"Parity",
-		"Multihit",
-	};
-	static const char *opal_mc_tlb_types[] = {
-		"Indeterminate",
-		"Parity",
-		"Multihit",
-	};
 
 	if (!get_mce_event(&evt, MCE_EVENT_RELEASE))
 		return 0;
@@ -280,80 +257,8 @@ int opal_machine_check(struct pt_regs *regs)
 		       evt.version);
 		return 0;
 	}
-	switch(evt.severity) {
-	case MCE_SEV_NO_ERROR:
-		level = KERN_INFO;
-		sevstr = "Harmless";
-		break;
-	case MCE_SEV_WARNING:
-		level = KERN_WARNING;
-		sevstr = "";
-		break;
-	case MCE_SEV_ERROR_SYNC:
-		level = KERN_ERR;
-		sevstr = "Severe";
-		break;
-	case MCE_SEV_FATAL:
-	default:
-		level = KERN_ERR;
-		sevstr = "Fatal";
-		break;
-	}
+	machine_check_print_event_info(&evt);
 
-	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,
-	       evt.disposition == MCE_DISPOSITION_RECOVERED ?
-	       "Recovered" : "[Not recovered");
-	printk("%s  Initiator: %s\n", level,
-	       evt.initiator == MCE_INITIATOR_CPU ? "CPU" : "Unknown");
-	switch(evt.error_type) {
-	case MCE_ERROR_TYPE_UE:
-		subtype = evt.u.ue_error.ue_error_type <
-			ARRAY_SIZE(opal_mc_ue_types) ?
-			opal_mc_ue_types[evt.u.ue_error.ue_error_type]
-			: "Unknown";
-		printk("%s  Error type: UE [%s]\n", level, subtype);
-		if (evt.u.ue_error.effective_address_provided)
-			printk("%s    Effective address: %016llx\n",
-			       level, evt.u.ue_error.effective_address);
-		if (evt.u.ue_error.physical_address_provided)
-			printk("%s      Physial address: %016llx\n",
-			       level, evt.u.ue_error.physical_address);
-		break;
-	case MCE_ERROR_TYPE_SLB:
-		subtype = evt.u.slb_error.slb_error_type <
-			ARRAY_SIZE(opal_mc_slb_types) ?
-			opal_mc_slb_types[evt.u.slb_error.slb_error_type]
-			: "Unknown";
-		printk("%s  Error type: SLB [%s]\n", level, subtype);
-		if (evt.u.slb_error.effective_address_provided)
-			printk("%s    Effective address: %016llx\n",
-			       level, evt.u.slb_error.effective_address);
-		break;
-	case MCE_ERROR_TYPE_ERAT:
-		subtype = evt.u.erat_error.erat_error_type <
-			ARRAY_SIZE(opal_mc_erat_types) ?
-			opal_mc_erat_types[evt.u.erat_error.erat_error_type]
-			: "Unknown";
-		printk("%s  Error type: ERAT [%s]\n", level, subtype);
-		if (evt.u.erat_error.effective_address_provided)
-			printk("%s    Effective address: %016llx\n",
-			       level, evt.u.erat_error.effective_address);
-		break;
-	case MCE_ERROR_TYPE_TLB:
-		subtype = evt.u.tlb_error.tlb_error_type <
-			ARRAY_SIZE(opal_mc_tlb_types) ?
-			opal_mc_tlb_types[evt.u.tlb_error.tlb_error_type]
-			: "Unknown";
-		printk("%s  Error type: TLB [%s]\n", level, subtype);
-		if (evt.u.tlb_error.effective_address_provided)
-			printk("%s    Effective address: %016llx\n",
-			       level, evt.u.tlb_error.effective_address);
-		break;
-	default:
-	case MCE_ERROR_TYPE_UNKNOWN:
-		printk("%s  Error type: Unknown\n", level);
-		break;
-	}
 	return evt.severity == MCE_SEV_FATAL ? 0 : 1;
 }
 
