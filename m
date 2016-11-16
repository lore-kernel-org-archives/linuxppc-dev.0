Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJR7j55c5zDvrR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 12:12:33 +1100 (AEDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, alistair@popple.id.au,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH] powerpc/powernv: Don't warn on PE init if unfreeze is
 unsupported
Date: Wed, 16 Nov 2016 12:12:26 +1100
Message-Id: <20161116011226.24589-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Whenever a PE is initialised in powernv, opal_pci_eeh_freeze_clear() is
called.  This is to remove any existing freeze, and has no negative side
effects if the PE is already in an unfrozen state.  On PHB backends that
don't support this operation and return OPAL_UNSUPPORTED, this creates a
scary and misleading warning message.

Skip the warning message on init if OPAL_UNSUPPORTED is returned.

As far as I'm aware, this currently only affects NPUs.

Fixes: 313483d ("powerpc/powernv: Unfreeze PE on allocation")
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d4b33dd..dcdfee0 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -145,7 +145,7 @@ static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
 	 */
 	rc = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
 				       OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
-	if (rc != OPAL_SUCCESS)
+	if (rc != OPAL_SUCCESS && rc != OPAL_UNSUPPORTED)
 		pr_warn("%s: Error %lld unfreezing PHB#%d-PE#%d\n",
 			__func__, rc, phb->hose->global_number, pe_no);
 
-- 
2.10.2
