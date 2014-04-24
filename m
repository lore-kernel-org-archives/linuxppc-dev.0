Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B5D5114018B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:34 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:34 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1AF9C3578048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:31 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O80GbJ54722676
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:16 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80USq017551
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:30 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 20/25] powerpc/eeh: Can't recover from non-PE-reset case
Date: Thu, 24 Apr 2014 18:00:26 +1000
Message-Id: <1398326431-24305-21-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When PCI_ERS_RESULT_CAN_RECOVER returned from device drivers, the
EEH core should enable I/O and DMA for the affected PE. However,
it was missed to have DMA enabled in eeh_handle_normal_event().
Besides, the frozen state of the affected PE should be cleared
after successful recovery, but we didn't.

The patch fixes both of the issues as above.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index f99ba9b..7100a5b 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -640,7 +640,6 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 			result = PCI_ERS_RESULT_NEED_RESET;
 		} else {
 			pr_info("EEH: Notify device drivers to resume I/O\n");
-			result = PCI_ERS_RESULT_NONE;
 			eeh_pe_dev_traverse(pe, eeh_report_mmio_enabled, &result);
 		}
 	}
@@ -652,10 +651,17 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 
 		if (rc < 0)
 			goto hard_fail;
-		if (rc)
+		if (rc) {
 			result = PCI_ERS_RESULT_NEED_RESET;
-		else
+		} else {
+			/*
+			 * We didn't do PE reset for the case. The PE
+			 * is still in frozen state. Clear it before
+			 * resuming the PE.
+			 */
+			eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
 			result = PCI_ERS_RESULT_RECOVERED;
+		}
 	}
 
 	/* If any device has a hard failure, then shut off everything. */
-- 
1.8.3.2
