Return-Path: <b32579@lc1106.zin33.ap.freescale.net>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0DD56B6FAF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 May 2011 16:22:52 +1000 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][v2] powerpc/85xx: add host-pci(e) bridge only for RC
Date: Mon, 23 May 2011 11:51:46 +0530
Message-ID: <1306131706-15385-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: meet2prabhu@gmail.com, Vivek Mahajan <vivek.mahajan@freescale.com>,
	Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FSL PCIe controller can act as agent(EP) or host(RC).
Under Agent(EP) mode they are configured via Host. So it is not required to add
with the PCI(e) sub-system.

Add and configure PCIe controller only for RC mode.

Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(branch master)

 Chages for v2: Incorporated Kumar's comment
 	- Use PCI_CLASS_PROG instead of PCI_HEADER_TYPE 

 arch/powerpc/sysdev/fsl_pci.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 68ca929..4a1d37c 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -323,6 +323,7 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	struct pci_controller *hose;
 	struct resource rsrc;
 	const int *bus_range;
+	u8 progif;
 
 	if (!of_device_is_available(dev)) {
 		pr_warning("%s: disabled\n", dev->full_name);
@@ -353,6 +354,19 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 
 	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
 		PPC_INDIRECT_TYPE_BIG_ENDIAN);
+
+	early_read_config_byte(hose, 0, 0, PCI_CLASS_PROG, &progif);
+	if (progif & 1 ) {
+		u32 temp;
+
+		temp = (u32)hose->cfg_data & ~PAGE_MASK;
+		if (((u32)hose->cfg_data & PAGE_MASK) != (u32)hose->cfg_addr)
+			iounmap(hose->cfg_data - temp);
+		iounmap(hose->cfg_addr);
+		pcibios_free_controller(hose);
+		return 0;
+	}
+
 	setup_pci_cmd(hose);
 
 	/* check PCI express link status */
-- 
1.7.4.1
