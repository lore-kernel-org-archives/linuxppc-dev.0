Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 351A71A00FA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 19:46:00 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 05/21] PCI/MSI: Introduce weak arch_find_msi_chip() to find
 MSI chip
Date: Fri, 5 Sep 2014 18:09:50 +0800
Message-ID: <1409911806-10519-6-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 Yijing Wang <wangyijing@huawei.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
 Arnd Bergmann <arnd@arndb.de>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>,
 Ralf Baechle <ralf@linux-mips.org>, iommu@lists.linux-foundation.org,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce weak arch_find_msi_chip() to find the match msi_chip.
Currently, MSI chip associates pci bus to msi_chip. Because in
ARM platform, there may be more than one MSI controller in system.
Associate pci bus to msi_chip help pci device to find the match
msi_chip and setup MSI/MSI-X irq correctly. But in other platform,
like in x86. we only need one MSI chip, because all device use
the same MSI address/data and irq etc. So it's no need to associate
pci bus to MSI chip, just use a arch function, arch_find_msi_chip()
to return the MSI chip for simplicity. The default weak
arch_find_msi_chip() used in ARM platform, find the MSI chip
by pci bus.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a77e7f7..539c11d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -29,9 +29,14 @@ static int pci_msi_enable = 1;
 
 /* Arch hooks */
 
+struct msi_chip * __weak arch_find_msi_chip(struct pci_dev *dev)
+{
+	return dev->bus->msi;
+}
+
 int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
-	struct msi_chip *chip = dev->bus->msi;
+	struct msi_chip *chip = arch_find_msi_chip(dev);
 	int err;
 
 	if (!chip || !chip->setup_irq)
-- 
1.7.1
