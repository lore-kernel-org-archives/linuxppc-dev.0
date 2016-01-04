Return-Path: <Zhiqiang.Hou@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0118.outbound.protection.outlook.com [207.46.100.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E9ED81A1142
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jan 2016 20:26:00 +1100 (AEDT)
From: Zhiqiang Hou <Zhiqiang.Hou@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <mpe@ellerman.id.au>
CC: <scottwood@freescale.com>, <akpm@linux-foundation.org>, <robh@kernel.org>,
 <Mingkai.Hu@freescale.com>, Hou Zhiqiang <Zhiqiang.Hou@freescale.com>
Subject: [PATCH] powerpc/fsl-pci: Correct the comparison of the LTSSM
Date: Mon, 4 Jan 2016 15:45:17 +0800
Message-ID: <1451893517-20934-1-git-send-email-Zhiqiang.Hou@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>

Only the value PCIE_LTSSM_L0 stands for the link is up, instead
of >= PCIE_LTSSM_L0.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 610f472..1595f55 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -73,7 +73,7 @@ static int fsl_pcie_check_link(struct pci_controller *hose)
 					       PCIE_LTSSM, 4, &val);
 		else
 			early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
-		if (val < PCIE_LTSSM_L0)
+		if (val != PCIE_LTSSM_L0)
 			return 1;
 	} else {
 		struct ccsr_pci __iomem *pci = hose->private_data;
-- 
2.1.0.27.g96db324
