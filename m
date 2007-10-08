Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23F97DDF30
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 22:52:39 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l98CpPtt006248
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Oct 2007 16:51:25 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l98CpP9J006245
	for linuxppc-dev@ozlabs.org; Mon, 8 Oct 2007 16:51:25 +0400
Date: Mon, 8 Oct 2007 16:51:24 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC PCI: add 64-bit physical address support to
	setup_indirect_pci.
Message-ID: <20071008125124.GA6225@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add 64-bit physical address support to setup_indirect_pci().

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/sysdev/indirect_pci.c |    6 ++++--
 include/asm-powerpc/pci-bridge.h   |    3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff -pruN linux-2.6.orig/arch/powerpc/sysdev/indirect_pci.c linux-2.6/arch/powerpc/sysdev/indirect_pci.c
--- linux-2.6.orig/arch/powerpc/sysdev/indirect_pci.c	2007-10-08 16:29:54.000000000 +0400
+++ linux-2.6/arch/powerpc/sysdev/indirect_pci.c	2007-10-08 16:45:40.000000000 +0400
@@ -149,9 +149,11 @@ static struct pci_ops indirect_pci_ops =
 };
 
 void __init
-setup_indirect_pci(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data, u32 flags)
+setup_indirect_pci(struct pci_controller* hose,
+		   resource_size_t cfg_addr,
+		   resource_size_t cfg_data, u32 flags)
 {
-	unsigned long base = cfg_addr & PAGE_MASK;
+	resource_size_t base = cfg_addr & PAGE_MASK;
 	void __iomem *mbase;
 
 	mbase = ioremap(base, PAGE_SIZE);
diff -pruN linux-2.6.orig/include/asm-powerpc/pci-bridge.h linux-2.6/include/asm-powerpc/pci-bridge.h
--- linux-2.6.orig/include/asm-powerpc/pci-bridge.h	2007-10-08 16:30:41.000000000 +0400
+++ linux-2.6/include/asm-powerpc/pci-bridge.h	2007-10-08 16:45:40.000000000 +0400
@@ -98,7 +98,8 @@ extern int early_find_capability(struct 
 				 int dev_fn, int cap);
 
 extern void setup_indirect_pci(struct pci_controller* hose,
-			       u32 cfg_addr, u32 cfg_data, u32 flags);
+			       resource_size_t cfg_addr,
+			       resource_size_t cfg_data, u32 flags);
 extern void setup_grackle(struct pci_controller *hose);
 extern void __init update_bridge_resource(struct pci_dev *dev,
 					  struct resource *res);
