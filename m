Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 363DB1A05AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:24:32 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 22 May 2014 18:24:31 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7F5D22BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:24:29 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4M8OEa34784468
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:24:14 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4M8NvPm018997
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:23:57 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v6 3/3] powerpc/eeh: Avoid event on passed PE
Date: Thu, 22 May 2014 18:23:54 +1000
Message-Id: <1400747034-15045-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400747034-15045-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400747034-15045-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

If we detects frozen state on PE that has been passed through to somebody
else. we needn't handle it. Instead, we rely on the device's owner to
detect and recover it. The patch avoid EEH event on the frozen passed PE so
that the device's owner can have chance to handle that.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c                 | 8 ++++++++
 arch/powerpc/platforms/powernv/eeh-ioda.c | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index b90a474..aee6cc5 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -403,6 +403,14 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	if (ret > 0)
 		return ret;
 
+	/*
+	 * If the PE isn't owned by us, we shouldn't check the
+	 * state. Instead, let the owner handle it if the PE has
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
