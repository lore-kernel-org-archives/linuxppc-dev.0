Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A007F140122
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:14 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 14 May 2014 14:12:10 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3ED972CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:06 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4E4Bogu11141440
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:11:51 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4E4C5o1004857
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:05 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 4/8] powerpc/eeh: Avoid event on passed PE
Date: Wed, 14 May 2014 14:11:58 +1000
Message-Id: <1400040722-29608-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, agraf@suse.de, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we detects frozen state on PE that has been passed to guest, we
needn't handle it. Instead, we rely on the guest to detect and recover
it. The patch avoid EEH event on the frozen passed PE so that the guest
can have chance to handle that.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c                 | 8 ++++++++
 arch/powerpc/platforms/powernv/eeh-ioda.c | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 9c6b899..6543f05 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -400,6 +400,14 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	if (ret > 0)
 		return ret;
 
+	/*
+	 * If the PE has been passed to guest, we won't check the
+	 * state. Instead, let the guest handle it if the PE has
+	 * been frozen.
+	 */
+	if (eeh_pe_passed(pe))
+		return 0;
+
 	/* If we already have a pending isolation event for this
 	 * slot, we know it's bad already, we don't need to check.
 	 * Do this checking under a lock; as multiple PCI devices
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 1b5982f..03a3ed2 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -890,7 +890,8 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 				opal_pci_eeh_freeze_clear(phb->opal_id, frozen_pe_no,
 					OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
 				ret = EEH_NEXT_ERR_NONE;
-			} else if ((*pe)->state & EEH_PE_ISOLATED) {
+			} else if ((*pe)->state & EEH_PE_ISOLATED ||
+				   eeh_pe_passed(*pe)) {
 				ret = EEH_NEXT_ERR_NONE;
 			} else {
 				pr_err("EEH: Frozen PHB#%x-PE#%x (%s) detected\n",
-- 
1.8.3.2
