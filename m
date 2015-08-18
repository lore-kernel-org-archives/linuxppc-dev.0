Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EBB41A04EF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 07:14:00 +1000 (AEST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 18 Aug 2015 18:13:55 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 01379352007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 17:12:46 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7ILCAgn27394408
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 18:12:11 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7ILDoeK010248
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 18:13:51 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH 1/2] PCI: Make pci_msi_setup_pci_dev() non-static for use by
 arch code
Date: Tue, 18 Aug 2015 18:13:49 -0300
Message-Id: <1439932430-13375-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
In-Reply-To: <1439932430-13375-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1439932430-13375-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 1851617cd2 ("PCI/MSI: Disable MSI at enumeration even if kernel
doesn't support MSI") changed the location of the code that disables
MSI/MSI-X interrupts at PCI probe time in devices that have this flag set.
It moved the code from pci_msi_init_pci_dev() to a new function named
pci_msi_setup_pci_dev(), called by pci_setup_device().

Since then, the pSeries platform of the powerpc architecture needs to
disable MSI at PCI probe time manually, as the code flow doesn't
reach pci_setup_device(). For doing so, it wants to call
pci_msi_setup_pci_dev(). This patch makes the required function
non-static, so that it will be called on PCI probe path on powerpc pSeries
platform in next patch.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
 drivers/pci/probe.c | 2 +-
 include/linux/pci.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cefd636..520c5b6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1103,7 +1103,7 @@ int pci_cfg_space_size(struct pci_dev *dev)
 
 #define LEGACY_IO_RESOURCE	(IORESOURCE_IO | IORESOURCE_PCI_FIXED)
 
-static void pci_msi_setup_pci_dev(struct pci_dev *dev)
+void pci_msi_setup_pci_dev(struct pci_dev *dev)
 {
 	/*
 	 * Disable the MSI hardware to avoid screaming interrupts
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8a0321a..860c751 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1202,6 +1202,7 @@ struct msix_entry {
 	u16	entry;	/* driver uses to specify entry, OS writes */
 };
 
+void pci_msi_setup_pci_dev(struct pci_dev *dev);
 
 #ifdef CONFIG_PCI_MSI
 int pci_msi_vec_count(struct pci_dev *dev);
-- 
2.1.0
