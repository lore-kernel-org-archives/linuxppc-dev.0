Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 567CD1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 14:13:11 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2308B140D96
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2015 14:13:11 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 7 Oct 2015 13:13:11 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 47DD83578052
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2015 14:13:08 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t973CtZh12058722
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Oct 2015 14:13:04 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t973CZZ5024966
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Oct 2015 14:12:35 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 3/5] powerpc/eeh: Force reset on fenced PHB
Date: Wed,  7 Oct 2015 14:12:07 +1100
Message-Id: <1444187529-32217-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1444187529-32217-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1444187529-32217-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On fenced PHB, the error handlers in the drivers of its subordinate
devices could return PCI_ERS_RESULT_CAN_RECOVER, indicating no reset
will be issued during the recovery. It's conflicting with the fact
that fenced PHB won't be recovered without reset.

This limits the return value from the error handlers in the drivers
of the fenced PHB's subordinate devices to PCI_ERS_RESULT_NEED_NONE
or PCI_ERS_RESULT_NEED_RESET, to ensure reset will be issued during
recovery.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 32178a4..76d918b 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -664,9 +664,17 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	 * to accomplish the reset.  Each child gets a report of the
 	 * status ... if any child can't handle the reset, then the entire
 	 * slot is dlpar removed and added.
+	 *
+	 * When the PHB is fenced, we have to issue a reset to recover from
+	 * the error. Override the result if necessary to have partially
+	 * hotplug for this case.
 	 */
 	pr_info("EEH: Notify device drivers to shutdown\n");
 	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
+	if ((pe->type & EEH_PE_PHB) &&
+	    result != PCI_ERS_RESULT_NEED_NONE &&
+	    result != PCI_ERS_RESULT_NEED_RESET)
+		result = PCI_ERS_RESULT_NEED_RESET;
 
 	/* Get the current PCI slot state. This can take a long time,
 	 * sometimes over 300 seconds for certain systems.
-- 
2.1.0
