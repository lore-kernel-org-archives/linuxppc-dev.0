Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78EBDDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 15:30:30 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l945UPCp025447
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 00:30:26 -0500
Date: Thu, 4 Oct 2007 00:29:59 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] FSL: Access PCIe LTSSM register with correct size
Message-ID: <Pine.LNX.4.64.0710040029160.11519@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The LTSSM register is actual 32-bits wide so we should be doing a
dword access.

---
 arch/powerpc/sysdev/fsl_pci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

minor cleanup patch

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 98290f4..af090c9 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -160,8 +160,8 @@ static void __init quirk_fsl_pcie_transparent(struct pci_dev *dev)

 int __init fsl_pcie_check_link(struct pci_controller *hose)
 {
-	u16 val;
-	early_read_config_word(hose, 0, 0, PCIE_LTSSM, &val);
+	u32 val;
+	early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
 	if (val < PCIE_LTSSM_L0)
 		return 1;
 	return 0;
-- 
1.5.2.4
