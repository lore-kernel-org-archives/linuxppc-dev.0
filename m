Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C90C72C07B6
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:05:50 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 16 Aug 2013 17:52:30 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8EE2F3578053
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:05:39 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7G7ndkA4456924
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 17:49:39 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7G85cii000428
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:05:39 +1000
Subject: [RFC PATCH v2 10/10] powerpc/powernv: Machine check exception
 handling.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 16 Aug 2013 13:35:36 +0530
Message-ID: <20130816080536.680.95791.stgit@mars.in.ibm.com>
In-Reply-To: <20130816080213.680.50794.stgit@mars.in.ibm.com>
References: <20130816080213.680.50794.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Add basic error handling in machine check exception handler.

- If MSR_RI isn't set, we can not recover.
- Check if disposition set to OpalMCE_DISPOSITION_RECOVERED.
- Check if address at fault is inside kernel address space, if not then send
  SIGBUS to process if we hit exception when in userspace.
- If address at fault is not provided then and if we get a synchronous machine
  check while in userspace then kill the task.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mce.h        |    1 +
 arch/powerpc/kernel/mce.c             |   27 +++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c |   43 ++++++++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index d319161..3ff1208 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -190,5 +190,6 @@ extern void save_mce_event(struct pt_regs *regs, long handled,
 			   struct mce_error_info *mce_err, uint64_t addr);
 extern int get_mce_event(struct machine_check_event *mce, bool release);
 extern void release_mce_event(void);
+extern uint64_t get_mce_fault_addr(struct machine_check_event *evt);
 
 #endif /* __ASM_PPC64_MCE_H__ */
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index aeecdf1..659778e 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -162,3 +162,30 @@ void release_mce_event(void)
 {
 	get_mce_event(NULL, true);
 }
+
+uint64_t get_mce_fault_addr(struct machine_check_event *evt)
+{
+	switch (evt->error_type) {
+	case MCE_ERROR_TYPE_UE:
+		if (evt->u.ue_error.effective_address_provided)
+			return evt->u.ue_error.effective_address;
+		break;
+	case MCE_ERROR_TYPE_SLB:
+		if (evt->u.slb_error.effective_address_provided)
+			return evt->u.slb_error.effective_address;
+		break;
+	case MCE_ERROR_TYPE_ERAT:
+		if (evt->u.erat_error.effective_address_provided)
+			return evt->u.erat_error.effective_address;
+		break;
+	case MCE_ERROR_TYPE_TLB:
+		if (evt->u.tlb_error.effective_address_provided)
+			return evt->u.tlb_error.effective_address;
+		break;
+	default:
+	case MCE_ERROR_TYPE_UNKNOWN:
+		break;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(get_mce_fault_addr);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 8545b33..7af3b12 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/slab.h>
+#include <linux/sched.h>
 #include <asm/opal.h>
 #include <asm/firmware.h>
 #include <asm/mce.h>
@@ -240,6 +241,44 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 	return written;
 }
 
+static int opal_recover_mce(struct pt_regs *regs,
+					struct machine_check_event *evt)
+{
+	int recovered = 0;
+	uint64_t ea = get_mce_fault_addr(evt);
+
+	if (!(regs->msr & MSR_RI)) {
+		/* If MSR_RI isn't set, we cannot recover */
+		recovered = 0;
+	} else if (evt->disposition == MCE_DISPOSITION_RECOVERED) {
+		/* Platform corrected itself */
+		recovered = 1;
+	} else if (ea && !is_kernel_addr(ea)) {
+		/*
+		 * Faulting address is not in kernel text. We should be fine.
+		 * We need to find which process uses this address.
+		 * For now, kill the task if we have received exception when
+		 * in userspace.
+		 *
+		 * TODO: Queue up this address for hwpoisioning later.
+		 */
+		if (user_mode(regs) && !is_global_init(current)) {
+			_exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
+			recovered = 1;
+		} else
+			recovered = 0;
+	} else if (user_mode(regs) && !is_global_init(current) &&
+		evt->severity == MCE_SEV_ERROR_SYNC) {
+		/*
+		 * If we have received a synchronous error when in userspace
+		 * kill the task.
+		 */
+		_exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
+		recovered = 1;
+	}
+	return recovered;
+}
+
 int opal_machine_check(struct pt_regs *regs)
 {
 	struct machine_check_event evt;
@@ -350,7 +389,9 @@ int opal_machine_check(struct pt_regs *regs)
 		printk("%s  Error type: Unknown\n", level);
 		break;
 	}
-	return evt.severity == MCE_SEV_FATAL ? 0 : 1;
+	if (opal_recover_mce(regs, &evt))
+		return 1;
+	return 0;
 }
 
 static irqreturn_t opal_interrupt(int irq, void *data)
