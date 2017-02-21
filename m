Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS3Rz2YWmzDqMN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 12:53:19 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vS3Ry4x6vz9s8G
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 12:53:18 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L1nE64134501
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 20:53:16 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r62ymdhb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 20:53:16 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 07:23:12 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 70143125805B
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:23:16 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1L1q7S623724224
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:22:07 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1L1r9QX027314
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:23:09 +0530
Subject: [RFC PATCH 7/7] powerpc/book3s: Display task info for MCE error in
 user mode.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 21 Feb 2017 07:23:07 +0530
In-Reply-To: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
References: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148764198775.19289.5210872217484227093.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

For MCE that hit while in use mode MSR(HV=1,PR=1), print the task info on the
console MCE error log. This will help to identify application that stumbled
upon MCE error.

After this patch the MCE console log would look like:

[    2.246155] Severe Machine check interrupt [Recovered]
[    2.246178]   Initiator: CPU
[    2.246199]   NIP: [0000000010039778] PID: 813 Comm: ebizzy
[    2.246223]   Error type: ERAT [Multihit]
[    2.246244]     Effective address: 00003fff94070000

[114560.247515] Severe Machine check interrupt [Recovered]
[114560.247562]   Initiator: CPU
[114560.247599]   NIP [d00000000d2e019c]: init_module+0x19c/0x260 [bork_kernel]
[114560.247666]   Error type: SLB [Multihit]
[114560.247701]     Effective address: d000000023db0000


Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mce.h        |    3 ++-
 arch/powerpc/kernel/mce.c             |   12 +++++++++---
 arch/powerpc/platforms/powernv/opal.c |    2 +-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 69e4a42..99dd1f3 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -91,7 +91,8 @@ extern int get_mce_event(struct OpalMachineCheckEvent *mce, bool release);
 extern int set_mce_event(struct OpalMachineCheckEvent *mce);
 extern void release_mce_event(void);
 extern void machine_check_queue_event(void);
-extern void machine_check_print_event_info(struct OpalMachineCheckEvent *evt);
+extern void machine_check_print_event_info(struct OpalMachineCheckEvent *evt,
+							bool user_mode);
 extern uint64_t get_mce_fault_addr(struct OpalMachineCheckEvent *evt);
 extern long handle_mce_errors(struct pt_regs *regs,
 					struct OpalMachineCheckEvent *evt);
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 035ef53..af36824 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -235,12 +235,13 @@ static void machine_check_process_queued_event(struct irq_work *work)
 	while (__this_cpu_read(mce_queue_count) > 0) {
 		index = __this_cpu_read(mce_queue_count) - 1;
 		machine_check_print_event_info(
-				this_cpu_ptr(&mce_event_queue[index]));
+				this_cpu_ptr(&mce_event_queue[index]), false);
 		__this_cpu_dec(mce_queue_count);
 	}
 }
 
-void machine_check_print_event_info(struct OpalMachineCheckEvent *evt)
+void machine_check_print_event_info(struct OpalMachineCheckEvent *evt,
+							bool user_mode)
 {
 	const char *level, *sevstr, *subtype;
 	static const char *mc_ue_types[] = {
@@ -320,8 +321,13 @@ void machine_check_print_event_info(struct OpalMachineCheckEvent *evt)
 	       "Recovered" : "[Not recovered");
 	printk("%s  Initiator: %s\n", level,
 	       evt->initiator == MCE_INITIATOR_CPU ? "CPU" : "Unknown");
-	printk("%s  NIP [%016llx]: %pS\n", level, evt->srr0,
+	if (user_mode) {
+		printk("%s  NIP: [%016llx] PID: %d Comm: %s\n", level,
+				evt->srr0, current->pid, current->comm);
+	} else {
+		printk("%s  NIP [%016llx]: %pS\n", level, evt->srr0,
 							(void *)evt->srr0);
+	}
 	switch (evt->error_type) {
 	case MCE_ERROR_TYPE_UE:
 		subtype = evt->u.ue_error.ue_error_type <
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index f1115c4..49f193c 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -444,7 +444,7 @@ int opal_machine_check(struct pt_regs *regs)
 		       evt.version);
 		return 0;
 	}
-	machine_check_print_event_info(&evt);
+	machine_check_print_event_info(&evt, user_mode(regs));
 
 	if (opal_recover_mce(regs, &evt))
 		return 1;
