Return-Path: <michael@ozlabs.org>
To: Greg Kroah-Hartman <greg@kroah.com>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 06 Mar 2007 16:06:49 +0100
Subject: [PATCH 2/2] Make pcibios_add_platform_entries() return errors
In-Reply-To: <1173193568.89821.610708199943.qpush@concordia>
Message-Id: <20070306150725.68D97DDF36@ozlabs.org>
Cc: linux-mips@linux-mips.org, dev-etrax@axis.com, linux-ia64@vger.kernel.org,
	discuss@x86-64.org, chris@zankel.net, linuxppc-dev@ozlabs.org,
	linux-m68k@lists.linux-m68k.org, ink@jurassic.park.msu.ru,
	gerg@uclinux.org, sparclinux@vger.kernel.org,
	uclinux-v850@lsi.nec.co.jp, linux-pci@atrey.karlin.mff.cuni.cz,
	parisc-linux@parisc-linux.org, kernel@wantstofly.org, rth@twiddle.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently pcibios_add_platform_entries() returns void, but could fail,
so instead have it return an int and propagate errors up to
pci_create_sysfs_dev_files().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/pci_32.c |    4 ++--
 arch/powerpc/kernel/pci_64.c |    4 ++--
 drivers/pci/pci-sysfs.c      |    9 ++++++---
 include/linux/pci.h          |    2 +-
 4 files changed, 11 insertions(+), 8 deletions(-)

Index: msi-new/arch/powerpc/kernel/pci_32.c
===================================================================
--- msi-new.orig/arch/powerpc/kernel/pci_32.c
+++ msi-new/arch/powerpc/kernel/pci_32.c
@@ -1037,10 +1037,10 @@ void pcibios_make_OF_bus_map(void)
 #endif /* CONFIG_PPC_OF */
 
 /* Add sysfs properties */
-void pcibios_add_platform_entries(struct pci_dev *pdev)
+int pcibios_add_platform_entries(struct pci_dev *pdev)
 {
 #ifdef CONFIG_PPC_OF
-	device_create_file(&pdev->dev, &dev_attr_devspec);
+	return device_create_file(&pdev->dev, &dev_attr_devspec);
 #endif /* CONFIG_PPC_OF */
 }
 
Index: msi-new/arch/powerpc/kernel/pci_64.c
===================================================================
--- msi-new.orig/arch/powerpc/kernel/pci_64.c
+++ msi-new/arch/powerpc/kernel/pci_64.c
@@ -863,9 +863,9 @@ static ssize_t pci_show_devspec(struct d
 }
 static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
 
-void pcibios_add_platform_entries(struct pci_dev *pdev)
+int pcibios_add_platform_entries(struct pci_dev *pdev)
 {
-	device_create_file(&pdev->dev, &dev_attr_devspec);
+	return device_create_file(&pdev->dev, &dev_attr_devspec);
 }
 
 #define ISA_SPACE_MASK 0x1
Index: msi-new/drivers/pci/pci-sysfs.c
===================================================================
--- msi-new.orig/drivers/pci/pci-sysfs.c
+++ msi-new/drivers/pci/pci-sysfs.c
@@ -600,9 +600,9 @@ static struct bin_attribute pcie_config_
 	.write = pci_write_config,
 };
 
-void __attribute__ ((weak)) pcibios_add_platform_entries(struct pci_dev *dev)
+int __attribute__ ((weak)) pcibios_add_platform_entries(struct pci_dev *dev)
 {
-	return;
+	return 0;
 }
 
 int __must_check pci_create_sysfs_dev_files (struct pci_dev *pdev)
@@ -644,10 +644,13 @@ int __must_check pci_create_sysfs_dev_fi
 		}
 	}
 	/* add platform-specific attributes */
-	pcibios_add_platform_entries(pdev);
+	if (pcibios_add_platform_entries(pdev))
+		goto err_rom_attr;
 
 	return 0;
 
+err_rom_attr:
+	sysfs_remove_bin_file(&pdev->dev.kobj, rom_attr);
 err_rom:
 	kfree(rom_attr);
 err_bin_file:
Index: msi-new/include/linux/pci.h
===================================================================
--- msi-new.orig/include/linux/pci.h
+++ msi-new/include/linux/pci.h
@@ -857,7 +857,7 @@ extern int pci_pci_problems;
 extern unsigned long pci_cardbus_io_size;
 extern unsigned long pci_cardbus_mem_size;
 
-extern void pcibios_add_platform_entries(struct pci_dev *dev);
+extern int pcibios_add_platform_entries(struct pci_dev *dev);
 
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */
