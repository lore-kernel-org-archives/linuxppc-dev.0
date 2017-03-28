Return-Path: <srs0=5ini=3f=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsscl6Jw2zDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 00:46:31 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vsscl5mSCz8t1b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 00:46:31 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vsscl1tZtz9s7q
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2017 00:46:31 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2SDi0hb082622
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2017 09:46:29 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29frvp0nw6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2017 09:46:27 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 28 Mar 2017 23:46:21 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2SDkBuh42729702
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2017 00:46:19 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2SDjhw1012934
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2017 00:45:44 +1100
Subject: [PATCH 2/2] powerpc/book3s: Display task info for MCE error in user
 mode.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 28 Mar 2017 19:15:28 +0530
In-Reply-To: <149070869902.18309.14355142133222424050.stgit@jupiter.in.ibm.com>
References: <149070869902.18309.14355142133222424050.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149070872807.18309.16273606222489045198.stgit@jupiter.in.ibm.com>
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

[    1.268998] Severe Machine check interrupt [Recovered]
[    1.269024]   NIP: [0000000010039778] PID: 762 Comm: ebizzy
[    1.269048]   Initiator: CPU
[    1.269067]   Error type: SLB [Multihit]
[    1.269088]     Effective address: 0000000010039778

[    1.855084] Severe Machine check interrupt [Not recovered]
[    1.855111]   NIP: [0000000010039778] PID: 763 Comm: ebizzy
[    1.855135]   Initiator: CPU
[    1.855154]   Error type: UE [Page table walk ifetch]
[    1.855179]     Effective address: 0000000010039778
[    1.855210] ebizzy[763]: unhandled signal 7 at 0000000010039778 nip 0000000010039778 lr 0000000010001b44 code 30004

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mce.h        |    3 ++-
 arch/powerpc/kernel/mce.c             |   12 +++++++++---
 arch/powerpc/platforms/powernv/opal.c |    2 +-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index e3498b4..0d865fe 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -207,7 +207,8 @@ extern void save_mce_event(struct pt_regs *regs, long handled,
 extern int get_mce_event(struct machine_check_event *mce, bool release);
 extern void release_mce_event(void);
 extern void machine_check_queue_event(void);
-extern void machine_check_print_event_info(struct machine_check_event *evt);
+extern void machine_check_print_event_info(struct machine_check_event *evt,
+							bool user_mode);
 extern uint64_t get_mce_fault_addr(struct machine_check_event *evt);
 
 #endif /* __ASM_PPC64_MCE_H__ */
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index e82d4ee..304cbaf 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -228,12 +228,13 @@ static void machine_check_process_queued_event(struct irq_work *work)
 	while (__this_cpu_read(mce_queue_count) > 0) {
 		index = __this_cpu_read(mce_queue_count) - 1;
 		machine_check_print_event_info(
-				this_cpu_ptr(&mce_event_queue[index]));
+				this_cpu_ptr(&mce_event_queue[index]), false);
 		__this_cpu_dec(mce_queue_count);
 	}
 }
 
-void machine_check_print_event_info(struct machine_check_event *evt)
+void machine_check_print_event_info(struct machine_check_event *evt,
+								bool user_mode)
 {
 	const char *level, *sevstr, *subtype;
 	static const char *mc_ue_types[] = {
@@ -311,8 +312,13 @@ void machine_check_print_event_info(struct machine_check_event *evt)
 	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,
 	       evt->disposition == MCE_DISPOSITION_RECOVERED ?
 	       "Recovered" : "Not recovered");
-	printk("%s  NIP [%016llx]: %pS\n", level, evt->srr0,
+	if (user_mode) {
+		printk("%s  NIP: [%016llx] PID: %d Comm: %s\n", level,
+				evt->srr0, current->pid, current->comm);
+	} else {
+		printk("%s  NIP [%016llx]: %pS\n", level, evt->srr0,
 							(void *)evt->srr0);
+	}
 	printk("%s  Initiator: %s\n", level,
 	       evt->initiator == MCE_INITIATOR_CPU ? "CPU" : "Unknown");
 	switch (evt->error_type) {
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index e0f856b..296c942 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -435,7 +435,7 @@ int opal_machine_check(struct pt_regs *regs)
 		       evt.version);
 		return 0;
 	}
-	machine_check_print_event_info(&evt);
+	machine_check_print_event_info(&evt, user_mode(regs));
 
 	if (opal_recover_mce(regs, &evt))
 		return 1;
