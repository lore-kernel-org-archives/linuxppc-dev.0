Return-Path: <prvs=0626e31786=khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BX2Q3HmFzDqh0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 15:33:59 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2T4XuXh016741
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 00:33:57 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h0qquap7t-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 00:33:57 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 29 Mar 2018 05:33:49 +0100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/fscr: Enable interrupts earlier before calling
 get_user()
Date: Thu, 29 Mar 2018 10:03:44 +0530
Message-Id: <20180329043344.16652-1-khandual@linux.vnet.ibm.com>
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
 arch/powerpc/kernel/traps.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1e48d15..4d5a55e 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1611,6 +1611,13 @@ void facility_unavailable_exception(struct pt_regs *regs)
 	else
 		value = mfspr(SPRN_FSCR);
 
+	/* We should not have taken this interrupt in kernel */
+	BUG_ON(!user_mode(regs));
+
+	/* We restore the interrupt state now */
+	if (!arch_irq_disabled_regs(regs))
+		local_irq_enable();
+
 	status = value >> 56;
 	if (status == FSCR_DSCR_LG) {
 		/*
@@ -1683,10 +1690,6 @@ void facility_unavailable_exception(struct pt_regs *regs)
 	    facility_strings[status])
 		facility = facility_strings[status];
 
-	/* We restore the interrupt state now */
-	if (!arch_irq_disabled_regs(regs))
-		local_irq_enable();
-
 	pr_err_ratelimited("%sFacility '%s' unavailable (%d), exception at 0x%lx, MSR=%lx\n",
 		hv ? "Hypervisor " : "", facility, status, regs->nip, regs->msr);
 
-- 
2.9.3
