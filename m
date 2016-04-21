Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrHFm5lmfzDqh1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 21:53:32 +1000 (AEST)
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 21 Apr 2016 17:23:30 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3LBrPIt54460452
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 17:23:25 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3LHLMRM017161
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 22:51:24 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: alistair@popple.id.au, david@gibson.dropbear.id.au, ruscur@russell.cc,
 mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 1/3] powerpc/eeh: Ignore error handlers in
 eeh_pe_reset_and_recover()
Date: Thu, 21 Apr 2016 21:53:05 +1000
Message-Id: <1461239595-5627-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function eeh_pe_reset_and_recover() is used to recover EEH
error when the passthrou device are transferred to guest and
backwords, meaning the device's driver is vfio-pci or none.
When the driver is vfio-pci that provides error_detected() error
handler only, the handler simply stops the guest and it's not
expected behaviour. On the other hand, no error handlers will
be called if we don't have a bound driver.

This ignores all error handlers provided by device driver in
eeh_pe_reset_and_recover() to avoid the exceptional behaviour.

Fixes: 5cfb20b9 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
Cc: stable@vger.kernel.org #v3.18+
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index fb6207d..1c7d703 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -552,7 +552,7 @@ static int eeh_clear_pe_frozen_state(struct eeh_pe *pe,
 
 int eeh_pe_reset_and_recover(struct eeh_pe *pe)
 {
-	int result, ret;
+	int ret;
 
 	/* Bail if the PE is being recovered */
 	if (pe->state & EEH_PE_RECOVERING)
@@ -564,9 +564,6 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
 	/* Save states */
 	eeh_pe_dev_traverse(pe, eeh_dev_save_state, NULL);
 
-	/* Report error */
-	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
-
 	/* Issue reset */
 	ret = eeh_reset_pe(pe);
 	if (ret) {
@@ -581,15 +578,9 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
 		return ret;
 	}
 
-	/* Notify completion of reset */
-	eeh_pe_dev_traverse(pe, eeh_report_reset, &result);
-
 	/* Restore device state */
 	eeh_pe_dev_traverse(pe, eeh_dev_restore_state, NULL);
 
-	/* Resume */
-	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
-
 	/* Clear recovery mode */
 	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
 
-- 
2.1.0
