Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 84D8D1A0341
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:15:02 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 10:15:01 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 67D972CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:14:59 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1Q0Epqn10551626
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:14:59 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1Q0EQ3c028906
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:14:27 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc/eeh: Remove duplicated check in eeh_dump_pe_log()
Date: Fri, 26 Feb 2016 11:14:00 +1100
Message-Id: <1456445640-24085-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When eeh_dump_pe_log() is only called by eeh_slot_error_detail(),
we already have the check that the PE isn't in PCI config blocked
state in eeh_slot_error_detail(). So we needn't the duplicated
check in eeh_dump_pe_log().

This removes the duplicated check in eeh_dump_pe_log(). No logical
changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
v2: Improved commit log
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
