Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E12851A0331
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 10:53:27 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 15 Feb 2016 09:53:26 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CCA342BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 10:53:23 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1ENrFEN10551752
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 10:53:23 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1ENqpKU019912
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 10:52:51 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/eeh: Remove duplicated check in eeh_dump_pe_log()
Date: Mon, 15 Feb 2016 10:52:26 +1100
Message-Id: <1455493946-27967-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When eeh_dump_pe_log() is called in eeh_slot_error_detail(), we
already have the check that the PE isn't in PCI config blocked
state. So we needn't the duplicated check in eeh_dump_pe_log().

This removes the duplicated check in eeh_dump_pe_log().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 8c6005c..46b41be 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -268,13 +268,6 @@ static void *eeh_dump_pe_log(void *data, void *flag)
 	struct eeh_dev *edev, *tmp;
 	size_t *plen = flag;
 
-	/* If the PE's config space is blocked, 0xFF's will be
-	 * returned. It's pointless to collect the log in this
-	 * case.
-	 */
-	if (pe->state & EEH_PE_CFG_BLOCKED)
-		return NULL;
-
 	eeh_pe_for_each_dev(pe, edev, tmp)
 		*plen += eeh_dump_dev_log(edev, pci_regs_buf + *plen,
 					  EEH_PCI_REGS_LOG_LEN - *plen);
-- 
2.1.0
