Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2ACFE67C66
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Nov 2006 14:53:03 +1100 (EST)
Message-Id: <200611090352.kA93qvUN003813@shell0.pdx.osdl.net>
Subject: [patch 2/3] ppc4xx: Compilation fixes for PCI-less configs
To: paulus@samba.org
From: akpm@osdl.org
Date: Wed, 08 Nov 2006 19:52:57 -0800
Cc: akpm@osdl.org, wojtekka@toxygen.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Wojtek Kaniewski <wojtekka@toxygen.net>

Fix compilation without PCI support for Bubinga, CPCI405 and EP405. 
bios_fixup() for these boards uses functions available only with
CONFIG_PCI, so linker fails.

Signed-off-by: Wojtek Kaniewski <wojtekka@toxygen.net>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@ozlabs.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc/platforms/4xx/bubinga.c |    2 ++
 arch/ppc/platforms/4xx/cpci405.c |    2 ++
 arch/ppc/platforms/4xx/ep405.c   |    2 ++
 3 files changed, 6 insertions(+)

diff -puN arch/ppc/platforms/4xx/bubinga.c~ppc4xx-compilation-fixes-for-pci-less-configs arch/ppc/platforms/4xx/bubinga.c
--- a/arch/ppc/platforms/4xx/bubinga.c~ppc4xx-compilation-fixes-for-pci-less-configs
+++ a/arch/ppc/platforms/4xx/bubinga.c
@@ -116,6 +116,7 @@ bubinga_early_serial_map(void)
 void __init
 bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
 {
+#ifdef CONFIG_PCI
 
 	unsigned int bar_response, bar;
 	/*
@@ -212,6 +213,7 @@ bios_fixup(struct pci_controller *hose, 
 	printk(" ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
 
 #endif
+#endif
 }
 
 void __init
diff -puN arch/ppc/platforms/4xx/cpci405.c~ppc4xx-compilation-fixes-for-pci-less-configs arch/ppc/platforms/4xx/cpci405.c
--- a/arch/ppc/platforms/4xx/cpci405.c~ppc4xx-compilation-fixes-for-pci-less-configs
+++ a/arch/ppc/platforms/4xx/cpci405.c
@@ -126,6 +126,7 @@ cpci405_setup_arch(void)
 void __init
 bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
 {
+#ifdef CONFIG_PCI
 	unsigned int bar_response, bar;
 
 	/* Disable region first */
@@ -167,6 +168,7 @@ bios_fixup(struct pci_controller *hose, 
 					PCI_FUNC(hose->first_busno), bar,
 					&bar_response);
 	}
+#endif
 }
 
 void __init
diff -puN arch/ppc/platforms/4xx/ep405.c~ppc4xx-compilation-fixes-for-pci-less-configs arch/ppc/platforms/4xx/ep405.c
--- a/arch/ppc/platforms/4xx/ep405.c~ppc4xx-compilation-fixes-for-pci-less-configs
+++ a/arch/ppc/platforms/4xx/ep405.c
@@ -68,6 +68,7 @@ ep405_setup_arch(void)
 void __init
 bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
 {
+#ifdef CONFIG_PCI
 	unsigned int bar_response, bar;
 	/*
 	 * Expected PCI mapping:
@@ -130,6 +131,7 @@ bios_fixup(struct pci_controller *hose, 
 		    PCI_FUNC(hose->first_busno), bar, bar_response);
 	}
 	/* end work arround */
+#endif
 }
 
 void __init
_
