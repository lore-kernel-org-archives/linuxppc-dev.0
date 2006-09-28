Return-Path: <michael@ozlabs.org>
To: <linux-kernel@vger.kernel.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 29 Sep 2006 07:53:34 +1000
Subject: [RFC/PATCH 1/7] Rip out the existing powerpc msi stubs
In-Reply-To: <1159480412.269240.988552559176.qpush@concordia>
Message-Id: <20060928215335.D576367BFB@ozlabs.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rip out the existing powerpc msi stubs.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/irq.c     |   28 ----------------------------
 include/asm-powerpc/machdep.h |    5 -----
 2 files changed, 33 deletions(-)

Index: to-merge/arch/powerpc/kernel/irq.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/irq.c
+++ to-merge/arch/powerpc/kernel/irq.c
@@ -820,34 +820,6 @@ arch_initcall(irq_late_init);
 
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
Index: to-merge/include/asm-powerpc/machdep.h
===================================================================
--- to-merge.orig/include/asm-powerpc/machdep.h
+++ to-merge/include/asm-powerpc/machdep.h
@@ -239,11 +239,6 @@ struct machdep_calls {
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
