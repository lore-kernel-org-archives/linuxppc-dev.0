Return-Path: <jiang.liu@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id 55FAD1A00B5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 02:19:26 +1100 (AEDT)
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Grant Likely <grant.likely@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Alexander Gordeev <agordeev@redhat.com>, Anton Blanchard <anton@samba.org>,
 Jiang Liu <jiang.liu@linux.intel.com>, Yijing Wang <wangyijing@huawei.com>
Subject: [RFC Part4 v1 11/17] PCI,
 MSI: Rename __read_msi_msg() as __pci_read_msi_msg()
Date: Sun,  9 Nov 2014 23:10:33 +0800
Message-Id: <1415545839-28263-12-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
References: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rename __read_msi_msg() as __pci_read_msi_msg() and kill unused
read_msi_msg(). It's a preparation to separate generic MSI code
from PCI core.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/powerpc/platforms/pseries/msi.c |    2 +-
 arch/x86/pci/xen.c                   |    2 +-
 drivers/pci/msi.c                    |    9 +--------
 include/linux/msi.h                  |    3 +--
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 8ab5add4ac82..90f756d0f58f 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -476,7 +476,7 @@ again:
 		irq_set_msi_desc(virq, entry);
 
 		/* Read config space back so we can restore after reset */
-		__read_msi_msg(entry, &msg);
+		__pci_read_msi_msg(entry, &msg);
 		entry->msg = msg;
 	}
 
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 093f5f4272d3..a48ca2f8b93e 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -229,7 +229,7 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		return 1;
 
 	list_for_each_entry(msidesc, &dev->msi_list, list) {
-		__read_msi_msg(msidesc, &msg);
+		__pci_read_msi_msg(msidesc, &msg);
 		pirq = MSI_ADDR_EXT_DEST_ID(msg.address_hi) |
 			((msg.address_lo >> MSI_ADDR_DEST_ID_SHIFT) & 0xff);
 		if (msg.data != XEN_PIRQ_MSI_DATA ||
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index e1814f4be4b9..6011dfb475a1 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -243,7 +243,7 @@ void default_restore_msi_irqs(struct pci_dev *dev)
 		default_restore_msi_irq(dev, entry->irq);
 }
 
-void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
+void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	BUG_ON(entry->dev->current_state != PCI_D0);
 
@@ -273,13 +273,6 @@ void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 	}
 }
 
-void read_msi_msg(unsigned int irq, struct msi_msg *msg)
-{
-	struct msi_desc *entry = irq_get_msi_desc(irq);
-
-	__read_msi_msg(entry, msg);
-}
-
 void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	if (entry->dev->current_state != PCI_D0) {
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 19502186a64d..4b0d070ff481 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -61,9 +61,8 @@ void msi_domain_deactivate(struct irq_domain *domain,
 
 #ifdef CONFIG_PCI_MSI
 /* Helper functions */
-void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
+void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
-void read_msi_msg(unsigned int irq, struct msi_msg *msg);
 void write_msi_msg(unsigned int irq, struct msi_msg *msg);
 
 /*
-- 
1.7.10.4
