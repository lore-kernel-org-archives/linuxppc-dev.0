Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvhqh5sfnzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:16:16 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 27 Apr 2016 11:16:14 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0C0652BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:16:05 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3R1FqJV36962510
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:16:04 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3R1FSc6023787
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:15:28 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: alistair@popple.id.au, ruscur@russell.cc, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v3 3/4] powerpc/eeh: Ignore handlers in
 eeh_pe_reset_and_recover()
Date: Wed, 27 Apr 2016 11:14:52 +1000
Message-Id: <1461719696-28044-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1461719696-28044-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1461719696-28044-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
backwards, meaning the device's driver is vfio-pci or none. In
both cases, the handlers triggered by eeh_report_reset() and
eeh_report_resume() shouldn't be called.

This ignores the error handlers from eeh_report_reset() and
eeh_report_resume().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Russell Currey <ruscur@russell.cc>
---
v3: Split from PATCH[v2 1/3] according to David's comment
---
 arch/powerpc/kernel/eeh_driver.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 31e4c7e..a16212d 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -575,7 +575,7 @@ static int eeh_clear_pe_frozen_state(struct eeh_pe *pe,
 
 int eeh_pe_reset_and_recover(struct eeh_pe *pe)
 {
-	int result, ret;
+	int ret;
 
 	/* Bail if the PE is being recovered */
 	if (pe->state & EEH_PE_RECOVERING)
@@ -601,15 +601,9 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
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
