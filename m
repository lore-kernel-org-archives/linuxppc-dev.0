Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9077ADDEBD
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:51:00 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 13/25] [POWERPC] Removed setup_indirect_pci_nomap
Date: Mon, 23 Jul 2007 15:50:00 -0500
Message-Id: <11852238322319-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1185223830411-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<11852238193371-git-send-email-galak@kernel.crashing.org>
	<1185223821183-git-send-email-galak@kernel.crashing.org>
	<11852238233066-git-send-email-galak@kernel.crashing.org>
	<11852238241475-git-send-email-galak@kernel.crashing.org>
	<11852238253550-git-send-email-galak@kernel.crashing.org>
	<11852238271141-git-send-email-galak@kernel.crashing.org>
	<11852238283648-git-send-email-galak@kernel.crashing.org>
	<1185223830411-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We don't use setup_indirect_pci_nomap in arch/powerpc and it appears
the users that needed it from arch/ppc are now using setup_indirect_pci.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/indirect_pci.c |   17 ++++-------------
 include/asm-powerpc/pci-bridge.h   |    2 --
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index bc5b4e2..ad341f5 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -149,24 +149,15 @@ static struct pci_ops indirect_pci_ops =
 };
 
 void __init
-setup_indirect_pci_nomap(struct pci_controller* hose, void __iomem * cfg_addr,
-	void __iomem * cfg_data)
-{
-	hose->cfg_addr = cfg_addr;
-	hose->cfg_data = cfg_data;
-	hose->ops = &indirect_pci_ops;
-}
-
-void __init
 setup_indirect_pci(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data)
 {
 	unsigned long base = cfg_addr & PAGE_MASK;
-	void __iomem *mbase, *addr, *data;
+	void __iomem *mbase;
 
 	mbase = ioremap(base, PAGE_SIZE);
-	addr = mbase + (cfg_addr & ~PAGE_MASK);
+	hose->cfg_addr = mbase + (cfg_addr & ~PAGE_MASK);
 	if ((cfg_data & PAGE_MASK) != base)
 		mbase = ioremap(cfg_data & PAGE_MASK, PAGE_SIZE);
-	data = mbase + (cfg_data & ~PAGE_MASK);
-	setup_indirect_pci_nomap(hose, addr, data);
+	hose->cfg_data = mbase + (cfg_data & ~PAGE_MASK);
+	hose->ops = &indirect_pci_ops;
 }
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index 9754357..13cb0a9 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -87,8 +87,6 @@ int early_write_config_dword(struct pci_controller *hose, int bus, int dev_fn,
 extern int early_find_capability(struct pci_controller *hose, int bus,
 				 int dev_fn, int cap);
 
-extern void setup_indirect_pci_nomap(struct pci_controller* hose,
-			       void __iomem *cfg_addr, void __iomem *cfg_data);
 extern void setup_indirect_pci(struct pci_controller* hose,
 			       u32 cfg_addr, u32 cfg_data);
 extern void setup_grackle(struct pci_controller *hose);
-- 
1.5.2.2
