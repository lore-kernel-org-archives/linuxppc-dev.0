Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 278621A0260
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 11:23:21 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 14D731400B7
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2015 11:23:20 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 27 Mar 2015 10:23:18 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E1EF83578048
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2015 11:23:15 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2R0N7Yr26738828
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2015 11:23:15 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2R0Mgho011725
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2015 11:22:42 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/eeh: Fix PE#0 check in eeh_add_to_parent_pe()
Date: Fri, 27 Mar 2015 11:22:17 +1100
Message-Id: <1427415737-937-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function eeh_add_parent_pe() is used to create a PE or add one
edev to its parent PE. Current code checks if PE#0 is valid for the
later case. Actually, we should validate PE#0 for both cases when
EEH core regards PE#0 as invalid one (without flag EEH_VALID_PE_ZERO).
Otherwise, not all EEH devices can be added to its parent PE#0 for
EEH on P7IOC.

The patch fixes the issue by validating PE#0 for the two cases. So far,
we don't have PE#0 for EEH on P7IOC, but it will show up when we enable
M64 for P7IOC. The patch also makes the error message more meaningful.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index f33cecc..35f0b62 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -328,6 +328,13 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 {
 	struct eeh_pe *pe, *parent;
 
+	/* Check if the PE number is valid */
+	if (!eeh_has_flag(EEH_VALID_PE_ZERO) && !edev->pe_config_addr) {
+		pr_err("%s: Invalid PE#0 for edev 0x%x on PHB#%d\n",
+		       __func__, edev->config_addr, edev->phb->global_number);
+		return -EINVAL;
+	}
+
 	/*
 	 * Search the PE has been existing or not according
 	 * to the PE address. If that has been existing, the
@@ -336,12 +343,6 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	 */
 	pe = eeh_pe_get(edev);
 	if (pe && !(pe->type & EEH_PE_INVALID)) {
-		if (!edev->pe_config_addr) {
-			pr_err("%s: PE with addr 0x%x already exists\n",
-				__func__, edev->config_addr);
-			return -EEXIST;
-		}
-
 		/* Mark the PE as type of PCI bus */
 		pe->type = EEH_PE_BUS;
 		edev->pe = pe;
-- 
1.8.3.2
