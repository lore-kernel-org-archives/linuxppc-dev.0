Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrxKx5lxvzDqQB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:29:25 +1000 (AEST)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 22 Apr 2016 23:29:25 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E18D03578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:29:06 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3MDSpxS66519280
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:29:06 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3MDSQu8027749
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:28:27 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: alistair@popple.id.au, david@gibson.dropbear.id.au, ruscur@russell.cc,
 mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 1/3] powerpc/eeh: Ignore error handlers in
 eeh_pe_reset_and_recover()
Date: Fri, 22 Apr 2016 23:28:02 +1000
Message-Id: <1461331687-1069-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function eeh_pe_reset_and_recover() is used to recover EEH
error when the passthrough device are transferred to guest and
backwards, meaning the device's driver is vfio-pci or none.
When the driver is vfio-pci that provides error_detected() error
handler only, the handler simply stops the guest and it's not
expected behaviour. On the other hand, no error handlers will
be called if we don't have a bound driver.

This ignores all error handlers provided by device driver in
eeh_pe_reset_and_recover() to avoid the exceptional behaviour.

Fixes: 5cfb20b9 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
Cc: stable@vger.kernel.org #v3.18+
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Russell Currey <ruscur@russell.cc>
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
