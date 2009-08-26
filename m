Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 5CF78B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 16:07:06 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id j5so750225wah.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Aug 2009 23:07:05 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH V2 1/3] powerpc/pci: Remove dead checks for CONFIG_PPC_OF
To: benh@kernel.crashing.org, galak@kernel.crashing.org, sfr@canb.auug.org.au,
	linuxppc-dev@lists.ozlabs.org
Date: Wed, 26 Aug 2009 00:07:02 -0600
Message-ID: <20090826060659.30936.75706.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

PPC_OF is always selected for arch/powerpc.  This patch removes the stale
#defines

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Kumar Gala <galak@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |    8 --------
 arch/powerpc/kernel/pci_32.c     |    9 ---------
 2 files changed, 0 insertions(+), 17 deletions(-)


diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 5a56e97..23eeb3e 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -176,8 +176,6 @@ int pci_domain_nr(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_domain_nr);
 
-#ifdef CONFIG_PPC_OF
-
 /* This routine is meant to be used early during boot, when the
  * PCI bus numbers have not yet been assigned, and you need to
  * issue PCI config cycles to an OF device.
@@ -210,17 +208,11 @@ static ssize_t pci_show_devspec(struct device *dev,
 	return sprintf(buf, "%s", np->full_name);
 }
 static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
-#endif /* CONFIG_PPC_OF */
 
 /* Add sysfs properties */
 int pcibios_add_platform_entries(struct pci_dev *pdev)
 {
-#ifdef CONFIG_PPC_OF
 	return device_create_file(&pdev->dev, &dev_attr_devspec);
-#else
-	return 0;
-#endif /* CONFIG_PPC_OF */
-
 }
 
 char __devinit *pcibios_setup(char *str)
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 3ae1c66..1e807fe 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -34,9 +34,7 @@ int pcibios_assign_bus_offset = 1;
 void pcibios_make_OF_bus_map(void);
 
 static void fixup_cpc710_pci64(struct pci_dev* dev);
-#ifdef CONFIG_PPC_OF
 static u8* pci_to_OF_bus_map;
-#endif
 
 /* By default, we don't re-assign bus numbers. We do this only on
  * some pmacs
@@ -83,7 +81,6 @@ fixup_cpc710_pci64(struct pci_dev* dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CPC710_PCI64,	fixup_cpc710_pci64);
 
-#ifdef CONFIG_PPC_OF
 /*
  * Functions below are used on OpenFirmware machines.
  */
@@ -357,12 +354,6 @@ pci_create_OF_bus_map(void)
 	}
 }
 
-#else /* CONFIG_PPC_OF */
-void pcibios_make_OF_bus_map(void)
-{
-}
-#endif /* CONFIG_PPC_OF */
-
 static void __devinit pcibios_scan_phb(struct pci_controller *hose)
 {
 	struct pci_bus *bus;
