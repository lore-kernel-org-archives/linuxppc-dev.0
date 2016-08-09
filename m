Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7rNK0XzpzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 20:38:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: gwshan@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 Michael Neuling <mikey@neuling.org>
Subject: [PATCH stable 4.6 3/4] powerpc/eeh: Fix wrong argument passed to
 eeh_rmv_device()
Date: Tue,  9 Aug 2016 20:38:07 +1000
Message-Id: <1470739088-17850-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1470739088-17850-1-git-send-email-mpe@ellerman.id.au>
References: <1470739088-17850-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gavin Shan <gwshan@linux.vnet.ibm.com>

commit cca0e542e02e48cce541a49c4046ec094ec27c1e upstream.

When calling eeh_rmv_device() in eeh_reset_device() for partial hotplug
case, @rmv_data instead of its address is the proper argument.
Otherwise, the stack frame is corrupted when writing to
@rmv_data (actually its address) in eeh_rmv_device(). It results in
kernel crash as observed.

This fixes the issue by passing @rmv_data, not its address to
eeh_rmv_device() in eeh_reset_device().

Fixes: 67086e32b564 ("powerpc/eeh: powerpc/eeh: Support error recovery for VF PE")
Reported-by: Pridhiviraj Paidipeddi <ppaidipe@in.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/eeh_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index c42627645b54..4a27a9684442 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -653,7 +653,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 			pci_unlock_rescan_remove();
 		}
 	} else if (frozen_bus) {
-		eeh_pe_dev_traverse(pe, eeh_rmv_device, &rmv_data);
+		eeh_pe_dev_traverse(pe, eeh_rmv_device, rmv_data);
 	}
 
 	/*
-- 
2.7.4
