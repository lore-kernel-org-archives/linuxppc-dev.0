Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvhqp1jDyzDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:16:22 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 27 Apr 2016 11:16:22 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0F18E3578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:16:10 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3R1Fqao8913378
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:16:00 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3R1FSKg023770
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:15:28 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: alistair@popple.id.au, ruscur@russell.cc, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v3 2/4] powerpc/eeh: Restore initial state in
 eeh_pe_reset_and_recover()
Date: Wed, 27 Apr 2016 11:14:51 +1000
Message-Id: <1461719696-28044-2-git-send-email-gwshan@linux.vnet.ibm.com>
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
error when the passthrou device are transferred to guest and
backwards. The content in the device's config space will be lost
on PE reset issued in the middle of the recovery. The function
saves/restores it before/after the reset. However, config access
to some adapters like Broadcom BCM5719 at this point will causes
fenced PHB. The config space is always blocked and we save 0xFF's
that are restored at late point. The memory BARs are totally
corrupted, causing another EEH error upon access to one of the
memory BARs.

This restores the config space on those adapters like BCM5719
from the content saved to the EEH device when it's populated,
to resolve above issue.

Fixes: 5cfb20b9 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
Cc: stable@vger.kernel.org #v3.18+
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/kernel/eeh_driver.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 3ce16da..31e4c7e 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -171,6 +171,16 @@ static void *eeh_dev_save_state(void *data, void *userdata)
 	if (!edev)
 		return NULL;
 
+	/*
+	 * We cannot access the config space on some adapters.
+	 * Otherwise, it will cause fenced PHB. We don't save
+	 * the content in their config space and will restore
+	 * from the initial config space saved when the EEH
+	 * device is created.
+	 */
+	if (edev->pe && (edev->pe->state & EEH_PE_CFG_RESTRICTED))
+		return NULL;
+
 	pdev = eeh_dev_to_pci_dev(edev);
 	if (!pdev)
 		return NULL;
@@ -312,6 +322,19 @@ static void *eeh_dev_restore_state(void *data, void *userdata)
 	if (!edev)
 		return NULL;
 
+	/*
+	 * The content in the config space isn't saved because
+	 * the blocked config space on some adapters. We have
+	 * to restore the initial saved config space when the
+	 * EEH device is created.
+	 */
+	if (edev->pe && (edev->pe->state & EEH_PE_CFG_RESTRICTED)) {
+		if (list_is_last(&edev->list, &edev->pe->edevs))
+			eeh_pe_restore_bars(edev->pe);
+
+		return NULL;
+	}
+
 	pdev = eeh_dev_to_pci_dev(edev);
 	if (!pdev)
 		return NULL;
-- 
2.1.0
