Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4cq744f2zDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 14:46:59 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s4cq64vGGz9t0P
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 14:46:58 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u744hbio041226
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 00:46:56 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24kkahrmey-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 04 Aug 2016 00:46:55 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 4 Aug 2016 10:16:52 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5B7C63940061
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 10:16:50 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u744jAof18940380
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 10:15:10 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u744knAV006270
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 10:16:49 +0530
Subject: [PATCH] powerpc/book3s: Fix MCE console messages for unrecoverable
 MCE.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, stable@vger.kernel.org
Date: Thu, 04 Aug 2016 10:16:48 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147028600879.16761.7577655191376075114.stgit@jupiter.in.ibm.com>
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

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/mce.c             |    3 ++-
 arch/powerpc/platforms/powernv/opal.c |    2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

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
index 5385434..8154171 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -401,6 +401,8 @@ static int opal_recover_mce(struct pt_regs *regs,
 
 	if (!(regs->msr & MSR_RI)) {
 		/* If MSR_RI isn't set, we cannot recover */
+		printk(KERN_ERR "Machine check interrupt unrecoverable:"
+				" MSR(RI=0)\n");
 		recovered = 0;
 	} else if (evt->disposition == MCE_DISPOSITION_RECOVERED) {
 		/* Platform corrected itself */
