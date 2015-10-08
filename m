Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBF8B1A0142
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 15:00:02 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 39406140D9C
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 15:00:02 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 8 Oct 2015 14:00:00 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3DBB62BB0057
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 14:59:58 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t983xorw65667116
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 14:59:58 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t983xP5x006671
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 14:59:26 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 3/8] powerpc/eeh: Force reset on fenced PHB
Date: Thu,  8 Oct 2015 14:58:54 +1100
Message-Id: <1444276739-20372-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
index 32178a4..80dfe89 100644
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
+	    result != PCI_ERS_RESULT_NONE &&
+	    result != PCI_ERS_RESULT_NEED_RESET)
+		result = PCI_ERS_RESULT_NEED_RESET;
 
 	/* Get the current PCI slot state. This can take a long time,
 	 * sometimes over 300 seconds for certain systems.
-- 
2.1.0
