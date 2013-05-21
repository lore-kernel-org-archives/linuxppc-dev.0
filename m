Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 23ADE2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 14:58:58 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r4L4wnJT002964
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 23:58:50 -0500
Message-ID: <1369112327.6387.41.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Add an option to wipe PCI bridges on shutdown
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 21 May 2013 14:58:47 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Older kernels such as 3.6 used by Fedora 18 have a problem with
the way more recent kernels configure the PCI bridge windows due
to my crappy old resource allocation code (we now use the generic
code which is way better).

In order to be able to safely kexec into those earlier kernels
(which we may need to do in some circumstances to launch distro
installers), we need to cleanup the bridges to avoid tripping
that bug.

This adds an option to do that, which is expected to be enabled
on kernels used as kexec-based bootloaders.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/Kconfig    |    5 ++++
 arch/powerpc/platforms/powernv/pci-ioda.c |   42 +++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index d3e840d..91bec0e 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -19,3 +19,8 @@ config PPC_POWERNV_RTAS
 	default y
 	select PPC_ICS_RTAS
 	select PPC_RTAS
+
+config PPC_POWERNV_PCI_CLEANUP
+       depends on KEXEC && PCI && PPC_POWERNV
+       bool "Wipe PCI bridges on shutdown for safer kexec to earlier kernels"
+       default y
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3937aaa..194e921 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1050,6 +1050,48 @@ static u32 pnv_ioda_bdfn_to_pe(struct pnv_phb *phb, struct pci_bus *bus,
 
 static void pnv_pci_ioda_shutdown(struct pnv_phb *phb)
 {
+#ifdef CONFIG_PPC_POWERNV_PCI_CLEANUP
+	struct pci_dev *pdev = NULL;
+
+	for_each_pci_dev(pdev) {
+		u16 cmd;
+
+		/*
+		 * We clear the base stuff, the main thing is bridge
+		 * windows which is what hurts 3.6 old IODA PCI allocation
+		 * code.
+		 */
+		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+		cmd &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY |
+			 PCI_COMMAND_IO);
+		pci_write_config_word(pdev, PCI_COMMAND, cmd);
+		if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+			pr_info("Cleaning up bridge %s\n", pci_name(pdev));
+			pci_write_config_word(pdev, PCI_IO_BASE_UPPER16, 0xffff);
+			pci_write_config_byte(pdev, PCI_IO_BASE, 0xf0);
+			pci_write_config_word(pdev, PCI_IO_LIMIT_UPPER16, 0x0);
+			pci_write_config_byte(pdev, PCI_IO_LIMIT, 0x0);
+
+			pci_write_config_word(pdev, PCI_MEMORY_BASE, 0xfff0);
+			pci_write_config_word(pdev, PCI_MEMORY_LIMIT, 0);
+
+			pci_write_config_dword(pdev, PCI_PREF_BASE_UPPER32, 0xffffffff);
+			pci_write_config_word(pdev, PCI_PREF_MEMORY_BASE, 0xfff0);
+			pci_write_config_dword(pdev, PCI_PREF_LIMIT_UPPER32, 0);
+			pci_write_config_word(pdev, PCI_PREF_MEMORY_LIMIT, 0);
+
+			/* Re-enable bridge windows (now that they are closed
+			 * this is safe) as some versions of Linux will fail to
+			 * do it
+			 */
+			pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+			cmd |= PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY |
+				PCI_COMMAND_IO;
+			pci_write_config_word(pdev, PCI_COMMAND, cmd);
+		}
+	}
+#endif /* CONFIG_PPC_POWERNV_PCI_CLEANUP */
+
 	opal_pci_reset(phb->opal_id, OPAL_PCI_IODA_TABLE_RESET,
 		       OPAL_ASSERT_RESET);
 }
