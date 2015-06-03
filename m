Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E2931A0947
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 14:52:51 +1000 (AEST)
From: David Gibson <david@gibson.dropbear.id.au>
To: gwshan@au1.ibm.com,
	mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] powerpc/eeh: Fix trivial error in eeh_restore_dev_state()
Date: Wed,  3 Jun 2015 14:52:59 +1000
Message-Id: <1433307179-17020-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 28158cd "powerpc/eeh: Enhance pcibios_set_pcie_reset_state()"
introduced a fix for a problem where certain configurations could lead to
pci_reset_function() destroying the state of PCI devices other than the one
specified.

Unfortunately, the fix has a trivial bug - it calls pci_save_state() again,
when it should be calling pci_restore_state().  This corrects the problem.

Cc: Gavin Shan <gwshan@au1.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kernel/eeh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 9ee61d1..ece4181 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -719,7 +719,7 @@ static void *eeh_restore_dev_state(void *data, void *userdata)
 
 	/* The caller should restore state for the specified device */
 	if (pdev != dev)
-		pci_save_state(pdev);
+		pci_restore_state(pdev);
 
 	return NULL;
 }
-- 
2.4.2
