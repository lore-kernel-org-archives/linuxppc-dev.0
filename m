Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C31211A0206
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:27:06 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A46621400DE
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:27:06 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 08:27:05 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 24020357805D
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:27:03 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOMR2wQ40370218
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:27:03 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOMR2t2001883
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:27:02 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc/powernv: Replace OPAL_DEASSERT_RESET with
 EEH_RESET_DEACTIVATE
Date: Tue, 25 Nov 2014 09:26:59 +1100
Message-Id: <1416868020-4129-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1416868020-4129-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1416868020-4129-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The flag passed to ioda_eeh_phb_reset() should be EEH_RESET_DEACTIVATE,
which is translated to OPAL_DEASSERT_RESET or something else by the
EEH backend accordingly.

The patch replaces OPAL_DEASSERT_RESET with EEH_RESET_DEACTIVATE for
ioda_eeh_phb_reset().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d035035..ba1b4cb 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2102,7 +2102,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	if (is_kdump_kernel()) {
 		pr_info("  Issue PHB reset ...\n");
 		ioda_eeh_phb_reset(hose, EEH_RESET_FUNDAMENTAL);
-		ioda_eeh_phb_reset(hose, OPAL_DEASSERT_RESET);
+		ioda_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
 	}
 
 	/* Remove M64 resource if we can't configure it successfully */
-- 
1.8.3.2
