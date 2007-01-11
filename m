Return-Path: <michael@ozlabs.org>
To: Greg Kroah-Hartman <greg@kroah.com>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 11 Jan 2007 22:25:16 +1100
Subject: [PATCH 1/7] Rip out the existing powerpc msi stubs
In-Reply-To: <1168514716.63474.857278133999.qpush@cradle>
Message-Id: <20070111112502.5825CDDEFF@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Olof Johannsson <olof@lixom.net>, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rip out the existing powerpc msi stubs. These were the start of an
implementation based on ppc_md calls, but were never used in mainline.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/irq.c     |   28 ----------------------------
 include/asm-powerpc/machdep.h |    5 -----
 2 files changed, 33 deletions(-)

Index: msi/arch/powerpc/kernel/irq.c
===================================================================
--- msi.orig/arch/powerpc/kernel/irq.c
+++ msi/arch/powerpc/kernel/irq.c
@@ -945,34 +945,6 @@ arch_initcall(irq_late_init);
 
 #endif /* CONFIG_PPC_MERGE */
 
-#ifdef CONFIG_PCI_MSI
-int pci_enable_msi(struct pci_dev * pdev)
-{
-	if (ppc_md.enable_msi)
-		return ppc_md.enable_msi(pdev);
-	else
-		return -1;
-}
-EXPORT_SYMBOL(pci_enable_msi);
-
-void pci_disable_msi(struct pci_dev * pdev)
-{
-	if (ppc_md.disable_msi)
-		ppc_md.disable_msi(pdev);
-}
-EXPORT_SYMBOL(pci_disable_msi);
-
-void pci_scan_msi_device(struct pci_dev *dev) {}
-int pci_enable_msix(struct pci_dev* dev, struct msix_entry *entries, int nvec) {return -1;}
-void pci_disable_msix(struct pci_dev *dev) {}
-void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
-void disable_msi_mode(struct pci_dev *dev, int pos, int type) {}
-void pci_no_msi(void) {}
-EXPORT_SYMBOL(pci_enable_msix);
-EXPORT_SYMBOL(pci_disable_msix);
-
-#endif
-
 #ifdef CONFIG_PPC64
 static int __init setup_noirqdistrib(char *str)
 {
Index: msi/include/asm-powerpc/machdep.h
===================================================================
--- msi.orig/include/asm-powerpc/machdep.h
+++ msi/include/asm-powerpc/machdep.h
@@ -243,11 +243,6 @@ struct machdep_calls {
 	 */
 	void (*machine_kexec)(struct kimage *image);
 #endif /* CONFIG_KEXEC */
-
-#ifdef CONFIG_PCI_MSI
-	int (*enable_msi)(struct pci_dev *pdev);
-	void (*disable_msi)(struct pci_dev *pdev);
-#endif /* CONFIG_PCI_MSI */
 };
 
 extern void power4_idle(void);
