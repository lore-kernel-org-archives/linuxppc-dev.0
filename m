Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS3Rl0vtZzDqKn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 12:53:07 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vS3Rk4skdz9s7n
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 12:53:06 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L1nYbD106913
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 20:53:04 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r3pqtxce-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 20:53:04 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 11:53:02 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DF2222CE8057
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 12:52:58 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1L1qodx11141280
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 12:52:58 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1L1qQaY024529
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 12:52:26 +1100
Subject: [RFC PATCH 3/7] powerpc/book3s: mce: Process the MCE event and
 recover if possible.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 21 Feb 2017 07:22:08 +0530
In-Reply-To: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
References: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148764192819.19289.6441584287460820329.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Once we get high level MCE error event from opal, process it and figure
out if it recoverable or not. If yes, take corrective actions.

TODO:
- Rework on handling of asynchronous MCE errors.
  - Update opal_recover_mce() to ignore async errors.
- Update flush_and_reload_slb() to avoid SLB reload in radix mode.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mce.h        |    3 +++
 arch/powerpc/kernel/mce.c             |   26 +++++++++++++++++++++++
 arch/powerpc/kernel/mce_power.c       |   38 +++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c |    2 ++
 4 files changed, 69 insertions(+)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 36db6b0..69e4a42 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -88,9 +88,12 @@ extern void save_mce_event(struct pt_regs *regs, long handled,
 			   struct mce_error_info *mce_err, uint64_t nip,
 			   uint64_t addr);
 extern int get_mce_event(struct OpalMachineCheckEvent *mce, bool release);
+extern int set_mce_event(struct OpalMachineCheckEvent *mce);
 extern void release_mce_event(void);
 extern void machine_check_queue_event(void);
 extern void machine_check_print_event_info(struct OpalMachineCheckEvent *evt);
 extern uint64_t get_mce_fault_addr(struct OpalMachineCheckEvent *evt);
+extern long handle_mce_errors(struct pt_regs *regs,
+					struct OpalMachineCheckEvent *evt);
 
 #endif /* __ASM_PPC64_MCE_H__ */
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 51a7c64..36da14a3 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -166,6 +166,32 @@ int get_mce_event(struct OpalMachineCheckEvent *mce, bool release)
 	return ret;
 }
 
+int set_mce_event(struct OpalMachineCheckEvent *mce)
+{
+	int index = __this_cpu_inc_return(mce_nest_count) - 1;
+	struct OpalMachineCheckEvent *mc_evt = this_cpu_ptr(&mce_event[index]);
+	int ret = 0;
+
+	/* Sanity check */
+	if (index < 0)
+		return ret;
+
+	/* Check if we have MCE info slot within array limit. */
+	if (index < MAX_MC_EVT) {
+		/* Copy the event structure and release the original */
+		if (mce) {
+			*mc_evt = *mce;
+			/* endian conversions */
+			mc_evt->srr0 = be64_to_cpu(mce->srr0);
+			mc_evt->srr1 = be64_to_cpu(mce->srr1);
+			mc_evt->u.ue_error.effective_address =
+				be64_to_cpu(mce->u.ue_error.effective_address);
+		}
+		ret = 1;
+	}
+	return ret;
+}
+
 void release_mce_event(void)
 {
 	get_mce_event(NULL, true);
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 7353991..91ed2ef 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -372,3 +372,41 @@ long __machine_check_early_realmode_p8(struct pt_regs *regs)
 	save_mce_event(regs, handled, &mce_error_info, nip, addr);
 	return handled;
 }
+
+static long flush_tlb(void)
+{
+	long handled = 0;
+
+	if (cur_cpu_spec && cur_cpu_spec->flush_tlb) {
+		cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
+		handled = 1;
+	}
+	return handled;
+}
+
+long handle_mce_errors(struct pt_regs *regs, struct OpalMachineCheckEvent *evt)
+{
+	long handled = 1;
+
+	if (evt->disposition == MCE_DISPOSITION_RECOVERED)
+		return handled;
+
+	switch (evt->error_type) {
+	case MCE_ERROR_TYPE_UE:
+		handled = mce_handle_ue_error(regs);
+		break;
+	case MCE_ERROR_TYPE_SLB:
+	case MCE_ERROR_TYPE_ERAT:
+		flush_and_reload_slb();
+		handled = 1;
+		break;
+	case MCE_ERROR_TYPE_TLB:
+		handled = flush_tlb();
+		break;
+	default:
+		handled = 0;
+	}
+	if (handled)
+		evt->disposition = MCE_DISPOSITION_RECOVERED;
+	return handled;
+}
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 263c57e..f1115c4 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -501,6 +501,8 @@ int opal_machine_check_early(struct pt_regs *regs, long *handled)
 	if (rc != OPAL_SUCCESS)
 		return -1;
 
+	*handled = handle_mce_errors(regs, &evt);
+	set_mce_event(&evt);
 	return 0;
 }
 
