Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6169E1A1930
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 04:45:32 +1000 (AEST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 19 Aug 2015 15:45:28 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 194531DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 14:44:23 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7JIhgGK18612518
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 15:43:43 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7JIjMF3004431
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 15:45:23 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: gpiccoli@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org, bhelgaas@google.com,
 mst@redhat.com
Subject: [PATCH v2 1/2] PCI: Make pci_msi_setup_pci_dev() non-static for use
 by arch code
Date: Wed, 19 Aug 2015 15:45:22 -0300
Message-Id: <1440009922-30248-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
In-Reply-To: <1439945086.23217.5.camel@ellerman.id.au>,
 <1439932077-11427-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1439945086.23217.5.camel@ellerman.id.au>,
 <1439932077-11427-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks very much for your suggestions Michael. I agree with them all,
so I'm sending the patch v2 (see below).

About the relevant mailing lists, I already sent to the linux-pci and
already cc'ed Bjorn Helgaas - the problem is that I made a mistake and
sent 2 different emails using git send-email. I'm really sorry about
this.

Now I'm trying to correct my mistake sending this message
simultaneously to both lists (and to a bunch of cc's) using two
Message-IDs in my reply. Hope it works...

Cheers


Changes since v2:
 * Made commit message more clear
 * Added "Fixes" line
 * Improved commit reference by using 12 first chars of SHA

>8----------8<

Commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel
doesn't support MSI") changed the location of the code that disables
MSI/MSI-X interrupts at PCI probe time in devices that have this flag
set. It moved the code from pci_msi_init_pci_dev() to a new function
named pci_msi_setup_pci_dev(), called by pci_setup_device().

The pseries PCI probing code does not call pci_setup_device(), so since
the aforementioned commit the function pci_msi_setup_pci_dev() is not
called and MSI/MSI-X interrupts are left enabled, which is a bug. To fix
this, the pseries PCI probe should manually call pci_msi_setup_pci_dev(),
so this patch makes it non-static.

Fixes: 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel
doesn't support MSI")

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
