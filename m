Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id D7D1C1A0295
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 12:35:45 +1100 (AEDT)
Date: Mon, 30 Nov 2015 19:35:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bhelgaas@google.com, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, mst@redhat.com, shangw@linux.vnet.ibm.com
Subject: Re: [PATCH] Enable MSI/MSI-X caps and disable MSI interrupts at PCI
 probe time - code move
Message-ID: <20151201013540.GB9306@localhost>
References: <1445437055-7017-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445437055-7017-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 21, 2015 at 12:17:35PM -0200, Guilherme G. Piccoli wrote:
> Commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel
> doesn't support MSI") changed the location of the code that initializes
> dev->msi_cap/msix_cap and disables MSI/MSI-X interrupts at PCI probe
> time in devices that have this flag set. It moved the code from
> pci_msi_init_pci_dev() to a new function named pci_msi_setup_pci_dev(),
> called by pci_setup_device().
> 
> In Open Firmware code path (PowerPC pSeries/SPARC archs) the function
> pci_setup_device() is not called, so MSI capabilities are never enabled,
> leading to error messages as:
> 
> 	bnx2x 0000:01:00.0: no msix capability found
> 
> Commit 4d9aac397a5d ("powerpc/PCI: Disable MSI/MSI-X interrupts at PCI
> probe time in OF case") solved the issue on PowerPC pSeries arch calling
> manually pci_msi_setup_pci_dev() on appropriate place. However, this
> modification does not solve the general case (SPARC arch should be
> modified too) and duplicates a lot of code, as pointed by Bjorn Helgaas.
> As suggested by him, worth to reorganize the code to generally solve the
> MSI caps issue and avoid too much code duplication.
> 
> This patch does exactly this: we remove both the pci_msi_setup_pci_dev()
> call from pci_setup_device() and the same call in OF code path of PowerPC
> pSeries arch. Then, we call pci_msi_setup_pci_dev() directly from
> pci_init_capabilities(). So, we can initialize MSI caps and disable MSI
> interruptions during PCI probe in general fashion, avoiding code
> duplication.
> 
> Notice that this patch has the same practical effect of reverting
> commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel
> doesn't support MSI") and commit 4d9aac397a5d ("powerpc/PCI: Disable
> MSI/MSI-X interrupts at PCI probe time in OF case"). Regarding the
> former, the author called pci_msi_setup_pci_dev() from pci_setup_device()
> because there was an early quirk used in pci_msi_off(), which depended on
> pci_msi_setup_pci_dev(). Since pci_msi_off() was completely removed by
> commit c6201cd8513d ("PCI/MSI: Remove unused pci_msi_off()"), we can call
> pci_msi_setup_pci_dev() directly from pci_init_capabilities().
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>

Thanks for your patience, Guilherme.

I applied this to pci/msi for v4.5.  I reworked the changelog and made
pci_msi_setup_pci_dev() static, since I think it's now only called
from drivers/pci/probe.c.

I didn't quite follow the last paragraph about reverting 1851617cd2da.
1851617cd2da moved the MSI init (dev->msi_cap init and MSI disable)
from pci/msi.c (where it was only done when CONFIG_PCI_MSI=y) to
pci/probe.c (where we did it for all non-OF arches, regardless of
CONFIG_PCI_MSI).  So I would characterize this patch as doing the MSI
init for *all* arches, regardless of CONFIG_PCI_MSI.

While looking at this, I noticed that pci_msi_init_pci_dev() is now
always empty, so I'll remove that in a separate patch.

Please let me know if this doesn't make sense:


commit e80e7edc55ba711f3fe23975061b3f1c336ceb95
Author: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Date:   Wed Oct 21 12:17:35 2015 -0200

    PCI/MSI: Initialize MSI capability for all architectures
    
    1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel doesn't
    support MSI") moved dev->msi_cap and dev->msix_cap initialization from the
    pci_init_capabilities() path (used on all architectures) to the
    pci_setup_device() path (not used on Open Firmware architectures).
    
    This broke MSI or MSI-X on Open Firmware machines.  4d9aac397a5d
    ("powerpc/PCI: Disable MSI/MSI-X interrupts at PCI probe time in OF case")
    fixed it for PowerPC but not for SPARC.
    
    Set up MSI and MSI-X (initialize msi_cap and msix_cap and disable MSI and
    MSI-X) in pci_init_capabilities() so all architectures do it the same way.
    
    This reverts 4d9aac397a5d since this patch fixes the problem generically
    for both PowerPC and SPARC.
    
    [bhelgaas: changelog, make pci_msi_setup_pci_dev() static]
    Fixes: 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel doesn't support MSI")
    Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 2e710c1..526ac67 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -187,9 +187,6 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 
 	pci_device_add(dev, bus);
 
-	/* Setup MSI caps & disable MSI/MSI-X interrupts */
-	pci_msi_setup_pci_dev(dev);
-
 	return dev;
 }
 EXPORT_SYMBOL(of_create_pci_dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index edb1984..cd94737 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1145,7 +1145,7 @@ int pci_cfg_space_size(struct pci_dev *dev)
 
 #define LEGACY_IO_RESOURCE	(IORESOURCE_IO | IORESOURCE_PCI_FIXED)
 
-void pci_msi_setup_pci_dev(struct pci_dev *dev)
+static void pci_msi_setup_pci_dev(struct pci_dev *dev)
 {
 	/*
 	 * Disable the MSI hardware to avoid screaming interrupts
@@ -1212,8 +1212,6 @@ int pci_setup_device(struct pci_dev *dev)
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
 
-	pci_msi_setup_pci_dev(dev);
-
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
 	/* device class may be changed after fixup */
@@ -1606,6 +1604,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* MSI/MSI-X list */
 	pci_msi_init_pci_dev(dev);
 
+	/* Setup MSI caps & disable MSI/MSI-X interrupts */
+	pci_msi_setup_pci_dev(dev);
+
 	/* Buffers for saving PCIe and PCI-X capabilities */
 	pci_allocate_cap_save_buffers(dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e828e7b..f9f79ad 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1248,8 +1248,6 @@ struct msix_entry {
 	u16	entry;	/* driver uses to specify entry, OS writes */
 };
 
-void pci_msi_setup_pci_dev(struct pci_dev *dev);
-
 #ifdef CONFIG_PCI_MSI
 int pci_msi_vec_count(struct pci_dev *dev);
 void pci_msi_shutdown(struct pci_dev *dev);
