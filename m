Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrxKk444YzDqZD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:29:14 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 22 Apr 2016 23:29:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CE5512BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:29:10 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3MDT2eK65273960
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:29:10 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3MDScUZ002391
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:28:38 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: alistair@popple.id.au, david@gibson.dropbear.id.au, ruscur@russell.cc,
 mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 2/3] powerpc/eeh: Restore config from edev in
 eeh_pe_reset_and_recover()
Date: Fri, 22 Apr 2016 23:28:03 +1000
Message-Id: <1461331687-1069-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1461331687-1069-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1461331687-1069-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

This restores the config space from the content saved to the
EEH device when it's populated, to resolve above issue.

Fixes: 5cfb20b9 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
Cc: stable@vger.kernel.org #v3.18+
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/kernel/eeh_driver.c | 39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 1c7d703..ec6e889 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -163,22 +163,6 @@ static bool eeh_dev_removed(struct eeh_dev *edev)
 	return false;
 }
 
-static void *eeh_dev_save_state(void *data, void *userdata)
-{
-	struct eeh_dev *edev = data;
-	struct pci_dev *pdev;
-
-	if (!edev)
-		return NULL;
-
-	pdev = eeh_dev_to_pci_dev(edev);
-	if (!pdev)
-		return NULL;
-
-	pci_save_state(pdev);
-	return NULL;
-}
-
 /**
  * eeh_report_error - Report pci error to each device driver
  * @data: eeh device
@@ -304,22 +288,6 @@ static void *eeh_report_reset(void *data, void *userdata)
 	return NULL;
 }
 
-static void *eeh_dev_restore_state(void *data, void *userdata)
-{
-	struct eeh_dev *edev = data;
-	struct pci_dev *pdev;
-
-	if (!edev)
-		return NULL;
-
-	pdev = eeh_dev_to_pci_dev(edev);
-	if (!pdev)
-		return NULL;
-
-	pci_restore_state(pdev);
-	return NULL;
-}
-
 /**
  * eeh_report_resume - Tell device to resume normal operations
  * @data: eeh device
@@ -561,9 +529,6 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
 	/* Put the PE into recovery mode */
 	eeh_pe_state_mark(pe, EEH_PE_RECOVERING);
 
-	/* Save states */
-	eeh_pe_dev_traverse(pe, eeh_dev_save_state, NULL);
-
 	/* Issue reset */
 	ret = eeh_reset_pe(pe);
 	if (ret) {
@@ -578,8 +543,8 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
 		return ret;
 	}
 
-	/* Restore device state */
-	eeh_pe_dev_traverse(pe, eeh_dev_restore_state, NULL);
+	/* Restore device's config space */
+	eeh_pe_restore_bars(pe);
 
 	/* Clear recovery mode */
 	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
-- 
2.1.0
