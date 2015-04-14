Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F10431A119D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 16:49:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc/eeh: Fix crash in eeh_add_device_early() on Cell
Date: Tue, 14 Apr 2015 16:49:05 +1000
Message-Id: <1428994146-23180-1-git-send-email-mpe@ellerman.id.au>
Cc: gwshan@linux.vnet.ibm.com, dja@axtens.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent change to the EEH probing causes a crash on Cell because
eeh_ops is NULL.

Check if EEH is enabled and if not bail out.

Fixes: ff57b454ddb9 ("powerpc/eeh: Do probe on pci_dn")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/eeh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 76253eb146be..a4c62eb0ee48 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1053,7 +1053,7 @@ void eeh_add_device_early(struct pci_dn *pdn)
 	struct pci_controller *phb;
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 
-	if (!edev)
+	if (!edev || !eeh_enabled())
 		return;
 
 	/* USB Bus children of PCI devices will not have BUID's */
-- 
2.1.0
