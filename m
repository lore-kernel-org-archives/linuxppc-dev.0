Return-Path: <prvs=0626e31786=khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BZSx1t30zF0WV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 17:23:44 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2T6L9UJ057449
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 02:23:42 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h0qmmp7er-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 02:23:42 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 29 Mar 2018 07:23:40 +0100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2] powerpc/fscr: Enable interrupts earlier before calling
 get_user()
Date: Thu, 29 Mar 2018 11:53:37 +0530
Message-Id: <20180329062337.29437-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function get_user() can sleep while trying to fetch instruction
from user address space and causes the following warning from the
scheduler.

BUG: sleeping function called from invalid context

Though interrupts get enabled back but it happens bit later after
get_user() is called. This change moves enabling these interrupts
earlier covering the function get_user(). While at this, lets check
for kernel mode and crash as this interrupt should not have been
triggered from the kernel context.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Changes in V2:
- Moved facility string detection earlier in the function
- Used pr_emerg() and die() instead of BUG_ON() if kernel context
- Removed redundant user_mode() check at the end

 arch/powerpc/kernel/traps.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1e48d15..317593d 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1612,6 +1612,22 @@ void facility_unavailable_exception(struct pt_regs *regs)
 		value = mfspr(SPRN_FSCR);
 
 	status = value >> 56;
+	if ((hv || status >= 2) &&
+	    (status < ARRAY_SIZE(facility_strings)) &&
+	    facility_strings[status])
+		facility = facility_strings[status];
+
+	/* We should not have taken this interrupt in kernel */
+	if (!user_mode(regs)) {
+		pr_emerg("Facility '%s' unavailable (%d) exception in kernel"
+		       " mode at %lx\n", facility, status, regs->nip);
+		die("Unexpected facility unavailable exception", regs, SIGABRT);
+	}
+
+	/* We restore the interrupt state now */
+	if (!arch_irq_disabled_regs(regs))
+		local_irq_enable();
+
 	if (status == FSCR_DSCR_LG) {
 		/*
 		 * User is accessing the DSCR register using the problem
@@ -1678,25 +1694,11 @@ void facility_unavailable_exception(struct pt_regs *regs)
 		return;
 	}
 
-	if ((hv || status >= 2) &&
-	    (status < ARRAY_SIZE(facility_strings)) &&
-	    facility_strings[status])
-		facility = facility_strings[status];
-
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
-
 	pr_err_ratelimited("%sFacility '%s' unavailable (%d), exception at 0x%lx, MSR=%lx\n",
 		hv ? "Hypervisor " : "", facility, status, regs->nip, regs->msr);
 
 out:
-	if (user_mode(regs)) {
-		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-		return;
-	}
-
-	die("Unexpected facility unavailable exception", regs, SIGABRT);
+	_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 }
 #endif
 
-- 
1.8.3.1
