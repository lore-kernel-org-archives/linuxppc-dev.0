Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A15D3DDEBB
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 13:01:39 +1000 (EST)
Date: Tue, 4 Sep 2007 21:08:30 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [POWERPC] pasemi: add pasemi_pci_getcfgaddr()
Message-ID: <20070905020830.GB25900@lixom.net>
References: <20070905020733.GA25900@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905020733.GA25900@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

commit aa37284d64c33d4755072d4bb4b5b1304d415d97
Author: Olof Johansson <olof@lixom.net>
Date:   Sat Sep 1 15:43:52 2007 -0500

    [POWERPC] pasemi: add pasemi_pci_getcfgaddr()
    
    Add pasemi_pci_getcfgaddr(), to get the remapped address of a specific
    config register for a PCI device.
    
    Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
index be84954..6fd2fe7 100644
--- a/arch/powerpc/platforms/pasemi/pasemi.h
+++ b/arch/powerpc/platforms/pasemi/pasemi.h
@@ -6,6 +6,8 @@ extern void pas_pci_init(void);
 extern void __devinit pas_pci_irq_fixup(struct pci_dev *dev);
 extern void __devinit pas_pci_dma_dev_setup(struct pci_dev *dev);
 
+extern void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset);
+
 extern void __init alloc_iobmap_l2(void);
 
 extern void __init pasemi_idle_init(void);
diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index 03d1d07..fcfb3df 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -175,3 +175,12 @@ void __init pas_pci_init(void)
 	/* Use the common resource allocation mechanism */
 	pci_probe_only = 1;
 }
+
+void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset)
+{
+	struct pci_controller *hose;
+
+	hose = pci_bus_to_host(bus);
+
+	return pa_pxp_cfg_addr(hose, hose->number, dev->devfn, int offset)
+}
