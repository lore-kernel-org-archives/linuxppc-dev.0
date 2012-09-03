Return-Path: <r61911@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8C2CD2C039A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2012 18:22:19 +1000 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc/pci: Use PCIe IP block revision register instead
 of compatible
Date: Mon, 3 Sep 2012 17:22:10 +0800
Message-ID: <1346664130-7896-2-git-send-email-tie-fei.zang@freescale.com>
In-Reply-To: <1346664130-7896-1-git-send-email-tie-fei.zang@freescale.com>
References: <1346664130-7896-1-git-send-email-tie-fei.zang@freescale.com>
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

Freescale PCIe IP block revision bigger than rev2.2 will also need
redefine the sequence of inbound windows. So change to use IP block
revision instead of compatible for the judgment.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---

 arch/powerpc/sysdev/fsl_pci.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index a7b2a60..bce48e6 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -143,18 +143,20 @@ static void __init setup_pci_atmu(struct pci_controller *hose,
 	pr_debug("PCI memory map start 0x%016llx, size 0x%016llx\n",
 		 (u64)rsrc->start, (u64)resource_size(rsrc));
 
-	if (of_device_is_compatible(hose->dn, "fsl,qoriq-pcie-v2.2")) {
-		win_idx = 2;
-		start_idx = 0;
-		end_idx = 3;
-	}
-
 	pci = ioremap(rsrc->start, resource_size(rsrc));
 	if (!pci) {
 	    dev_err(hose->parent, "Unable to map ATMU registers\n");
 	    return;
 	}
 
+	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
+		if (in_be32(&pci->block_rev1) >= PCIE_IP_REV_2_2) {
+			win_idx = 2;
+			start_idx = 0;
+			end_idx = 3;
+		}
+	}
+
 	/* Disable all windows (except powar0 since it's ignored) */
 	for(i = 1; i < 5; i++)
 		out_be32(&pci->pow[i].powar, 0);
-- 
1.7.8.1
