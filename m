Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 697CADDF13
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:50:45 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 03/25] [POWERPC] Add the ability to find PCI capabilities
	early on
Date: Mon, 23 Jul 2007 15:49:50 -0500
Message-Id: <11852238161546-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11852238151983-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added early_find_capability that wraps pci_bus_find_capability and uses
fake_pci_bus() to allow us to call it before we've fully setup the
pci_controller.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/pci_32.c     |    7 +++++++
 include/asm-powerpc/pci-bridge.h |    3 +++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 0adf077..bfcfa14 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -1468,3 +1468,10 @@ EARLY_PCI_OP(read, dword, u32 *)
 EARLY_PCI_OP(write, byte, u8)
 EARLY_PCI_OP(write, word, u16)
 EARLY_PCI_OP(write, dword, u32)
+
+extern int pci_bus_find_capability (struct pci_bus *bus, unsigned int devfn, int cap);
+int early_find_capability(struct pci_controller *hose, int bus, int devfn,
+			  int cap)
+{
+	return pci_bus_find_capability(fake_pci_bus(hose, bus), devfn, cap);
+}
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index e72c2a6..7a00b8e 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -79,6 +79,9 @@ int early_write_config_word(struct pci_controller *hose, int bus, int dev_fn,
 int early_write_config_dword(struct pci_controller *hose, int bus, int dev_fn,
 			     int where, u32 val);
 
+extern int early_find_capability(struct pci_controller *hose, int bus,
+				 int dev_fn, int cap);
+
 extern void setup_indirect_pci_nomap(struct pci_controller* hose,
 			       void __iomem *cfg_addr, void __iomem *cfg_data);
 extern void setup_indirect_pci(struct pci_controller* hose,
-- 
1.5.2.2
