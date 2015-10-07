Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DEFC1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 14:13:10 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6C6AE140D95
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2015 14:13:10 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 7 Oct 2015 13:13:09 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DA1B32CE8054
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2015 14:13:07 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t973CsJ441025630
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Oct 2015 14:13:03 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t973CYTF024935
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Oct 2015 14:12:34 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 1/5] powerpc/eeh: Don't unfreeze PHB PE after reset
Date: Wed,  7 Oct 2015 14:12:05 +1100
Message-Id: <1444187529-32217-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerNV platform, the PE is kept in frozen state until the PE
reset is completed to avoid recursive EEH error caused by MMIO
access during the period of EEH reset. The PE's frozen state is
cleared after BARs of PCI device included in the PE are restored
and enabled. However, we needn't clear the frozen state for PHB PE
explicitly at this point as there is no real PE for PHB PE. As the
PHB PE is always binding with PE#0, we actually clear PE#0, which
is wrong. It doesn't incur any problem though.

This checks if the PE is PHB PE and doesn't clear the frozen state
if it is.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 89eb4bc..3a626ed 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -587,10 +587,16 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	eeh_ops->configure_bridge(pe);
 	eeh_pe_restore_bars(pe);
 
-	/* Clear frozen state */
-	rc = eeh_clear_pe_frozen_state(pe, false);
-	if (rc)
-		return rc;
+	/*
+	 * If it's PHB PE, the frozen state on all available PEs should have
+	 * been cleared by the PHB reset. Otherwise, we unfreeze the PE and its
+	 * child PEs because they might be in frozen state.
+	 */
+	if (!(pe->type & EEH_PE_PHB)) {
+		rc = eeh_clear_pe_frozen_state(pe, false);
+		if (rc)
+			return rc;
+	}
 
 	/* Give the system 5 seconds to finish running the user-space
 	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes,
-- 
2.1.0
