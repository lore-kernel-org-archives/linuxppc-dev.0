Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7j4g63tyzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 15:09:23 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s7j4g08Tzz9sR9
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Aug 2016 15:09:22 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7958eCt089350
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Aug 2016 01:09:20 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24nbs150fj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 09 Aug 2016 01:09:20 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 9 Aug 2016 15:09:17 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5150A3578056
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Aug 2016 15:09:16 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7959G4r28639264
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Aug 2016 15:09:16 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7959FdV021570
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Aug 2016 15:09:16 +1000
Subject: [PATCH v2] powerpc/book3s: Fix MCE console messages for
 unrecoverable MCE.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Date: Tue, 09 Aug 2016 10:39:13 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147071935386.31859.2652230204782393894.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

When machine check occurs with MSR(RI=0), it means MC interrupt is
unrecoverable and kernel goes down to panic path. But the console
message still shows it as recovered. This patch fixes the MCE console
messages.

Fixes: 36df96f8acaf ("powerpc/book3s: Decode and save machine check event.")
Cc: stable@vger.kernel.org
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
Changes in v2:
- Used pr_err() instead of printk().
---
 arch/powerpc/kernel/mce.c             |    3 ++-
 arch/powerpc/platforms/powernv/opal.c |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index ef267fd..5e7ece0 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -92,7 +92,8 @@ void save_mce_event(struct pt_regs *regs, long handled,
 	mce->in_use = 1;
 
 	mce->initiator = MCE_INITIATOR_CPU;
-	if (handled)
+	/* Mark it recovered if we have handled it and MSR(RI=1). */
+	if (handled && (regs->msr & MSR_RI))
 		mce->disposition = MCE_DISPOSITION_RECOVERED;
 	else
 		mce->disposition = MCE_DISPOSITION_NOT_RECOVERED;
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 738c9b1..48fa512 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -399,6 +399,7 @@ static int opal_recover_mce(struct pt_regs *regs,
 
 	if (!(regs->msr & MSR_RI)) {
 		/* If MSR_RI isn't set, we cannot recover */
+		pr_err("Machine check interrupt unrecoverable: MSR(RI=0)\n");
 		recovered = 0;
 	} else if (evt->disposition == MCE_DISPOSITION_RECOVERED) {
 		/* Platform corrected itself */
