Return-Path: <Dongsheng.Wang@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 77AAC1400E8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 17:45:49 +1000 (EST)
Received: from mail127-va3 (localhost [127.0.0.1])	by
 mail127-va3-R.bigfish.com (Postfix) with ESMTP id 59D2B3401BE	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 07:45:07 +0000 (UTC)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH 1/2] fsl/pci: fix RC cannot detect PME message coming
Date: Tue, 15 Apr 2014 15:43:18 +0800
Message-ID: <1397547799-29464-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>, jason.jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

PCI controller disable PME message report feature, that shouldn't
have happened. Fix it and enable PME message report feature.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 3f415e2..4bd091a 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1150,8 +1150,7 @@ static int fsl_pci_pme_probe(struct pci_controller *hose)
 	pci = hose->private_data;
 
 	/* Enable PTOD, ENL23D & EXL23D */
-	out_be32(&pci->pex_pme_mes_disr, 0);
-	setbits32(&pci->pex_pme_mes_disr,
+	clrbits32(&pci->pex_pme_mes_disr,
 		  PME_DISR_EN_PTOD | PME_DISR_EN_ENL23D | PME_DISR_EN_EXL23D);
 
 	out_be32(&pci->pex_pme_mes_ier, 0);
-- 
1.8.5
