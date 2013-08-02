Return-Path: <B25806@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ED7F52C0084
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 18:49:14 +1000 (EST)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/pci: Change the DECLARE_PCI_FIXUP_{HEADER => EARLY}
 macro of pci quirk
Date: Fri, 2 Aug 2013 16:46:25 +0800
Message-ID: <1375433185-20368-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bjorn Helgaas <bhelgaas@google.com>, Paul Mackerras <paulus@samba.org>,
 Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Freescale platform has class code = 0x0b2000, when it boots. This makes
kernel PCI bus code to setup these devices resulting into the following
notice information when trying to enable them:

pci 0000:00:00.0: ignoring class 0x0b2000 (doesn't match header type 01)

The above information is outputted by judging value of dev->class before
pci_setup_device() function, and the DECLARE_PCI_FIXUP_HEADER quirk runs
after pci_setup_device() function. But the DECLARE_PCI_FIXUP_EARLY quirk
runs before judging value of dev->class and pci_setup_device() function.
So we use the DECLARE_PCI_FIXUP_EARLY macro to fix this issue.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/sysdev/fsl_pci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 46ac1dd..3e8b9d4 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -36,7 +36,7 @@
 
 static int fsl_pcie_bus_fixup, is_mpc83xx_pci;
 
-static void quirk_fsl_pcie_header(struct pci_dev *dev)
+static void quirk_fsl_pcie_early(struct pci_dev *dev)
 {
 	u8 hdr_type;
 
@@ -556,7 +556,8 @@ no_bridge:
 }
 #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
 
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
+			quirk_fsl_pcie_early);
 
 #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
 struct mpc83xx_pcie_priv {
-- 
1.7.6.5
