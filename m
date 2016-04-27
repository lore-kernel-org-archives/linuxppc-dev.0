Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvhqp0dr5zDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:16:22 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 27 Apr 2016 11:16:20 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 762FF3578057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:16:12 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3R1FqpZ7143902
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:16:05 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3R1FNrF023661
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:15:23 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: alistair@popple.id.au, ruscur@russell.cc, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v3 1/4] powerpc/eeh: Don't report error in
 eeh_pe_reset_and_recover()
Date: Wed, 27 Apr 2016 11:14:50 +1000
Message-Id: <1461719696-28044-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

This ignores the error handler in eeh_pe_reset_and_recover()
that reports the error to device driver to avoid the exceptional
behaviour.

Fixes: 5cfb20b9 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
Cc: stable@vger.kernel.org #v3.18+
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Russell Currey <ruscur@russell.cc>
---
v3: Split from PATCH[v2 1/3] according to David's comment
---
 arch/powerpc/kernel/eeh_driver.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index fb6207d..3ce16da 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -564,9 +564,6 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
 	/* Save states */
 	eeh_pe_dev_traverse(pe, eeh_dev_save_state, NULL);
 
-	/* Report error */
-	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
-
 	/* Issue reset */
 	ret = eeh_reset_pe(pe);
 	if (ret) {
-- 
2.1.0
