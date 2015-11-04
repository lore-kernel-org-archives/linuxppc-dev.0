Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22F521A0CB2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:52 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 23:13:51 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7B7612CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:49 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDfmw23330942
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:49 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDG6M009785
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:17 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 38/50] powerpc/powernv: Exclude root bus in
 pnv_pci_reset_secondary_bus()
Date: Thu,  5 Nov 2015 00:12:38 +1100
Message-Id: <1446642770-4681-39-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When pnv_pci_reset_secondary_bus() is called to issue reset on
the indicated secondary bus, the bus can't be root bus. So we
needn't consider root bus in the function.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index a7d84a4..c69b6a1 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -880,16 +880,8 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 
 void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 {
-	struct pci_controller *hose;
-
-	if (pci_is_root_bus(dev->bus)) {
-		hose = pci_bus_to_host(dev->bus);
-		pnv_eeh_root_reset(hose, EEH_RESET_HOT);
-		pnv_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
-	} else {
-		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
-		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
-	}
+	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
+	pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
 }
 
 /**
-- 
2.1.0
