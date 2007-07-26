Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A51BBDDEC9
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 19:59:23 +1000 (EST)
Date: Thu, 26 Jul 2007 18:59:17 +0900 (JST)
Message-Id: <20070726.185917.-1300519001.kouish@swc.toshiba.co.jp>
Subject: [PATCH 1/4] fix celleb pci section warnings
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix following warnings:
WARNING: vmlinux.o(.text+0x44ad0): Section mismatch: reference to .init.text:.__alloc_bootmem (between '.celleb_setup_phb' and '.celleb_fake_pci_write_config')
WARNING: vmlinux.o(.text+0x44dd8): Section mismatch: reference to .init.text:.free_bootmem (between '.celleb_setup_phb' and '.celleb_fake_pci_write_config')

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/pci.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/pci.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/pci.c
@@ -288,8 +288,8 @@ static inline void celleb_setup_pci_base
 	celleb_config_write_fake(config, PCI_COMMAND, 2, val);
 }
 
-static int __devinit celleb_setup_fake_pci_device(struct device_node *node,
-						  struct pci_controller *hose)
+static int __init celleb_setup_fake_pci_device(struct device_node *node,
+					       struct pci_controller *hose)
 {
 	unsigned int rlen;
 	int num_base_addr = 0;
@@ -418,8 +418,8 @@ error:
 	return 1;
 }
 
-static int __devinit phb_set_bus_ranges(struct device_node *dev,
-					struct pci_controller *phb)
+static int __init phb_set_bus_ranges(struct device_node *dev,
+				     struct pci_controller *phb)
 {
 	const int *bus_range;
 	unsigned int len;
@@ -434,7 +434,7 @@ static int __devinit phb_set_bus_ranges(
 	return 0;
 }
 
-static void __devinit celleb_alloc_private_mem(struct pci_controller *hose)
+static void __init celleb_alloc_private_mem(struct pci_controller *hose)
 {
 	if (mem_init_done)
 		hose->private_data =
@@ -444,7 +444,7 @@ static void __devinit celleb_alloc_priva
 			alloc_bootmem(sizeof(struct celleb_pci_private));
 }
 
-int __devinit celleb_setup_phb(struct pci_controller *phb)
+int __init celleb_setup_phb(struct pci_controller *phb)
 {
 	const char *name;
 	struct device_node *dev = phb->arch_data;
