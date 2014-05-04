Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 109AD1402EA
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 May 2014 14:33:02 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 02/13] PCI: Introduce new pci_is_bridge() helper function
Date: Sun, 4 May 2014 12:23:37 +0800
Message-ID: <1399177428-3784-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1399177428-3784-1-git-send-email-wangyijing@huawei.com>
References: <1399177428-3784-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, x86@kernel.org,
 Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PCIe Spec define the PCI bridge is the PCI device
which header type(bit 0 through 6) is 0x1(PCI bridge)
or 0x2(CardBus bridge).

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 include/linux/pci.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index aab57b4..9f5f89e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -477,6 +477,19 @@ static inline bool pci_is_root_bus(struct pci_bus *pbus)
 	return !(pbus->parent);
 }
 
+/**
+ * pci_is_bridge - check if the PCI device is a bridge
+ * @dev: PCI device
+ *
+ * Return true if the PCI device is bridge whether it has subordinate
+ * or not.
+ */
+static inline bool pci_is_bridge(struct pci_dev *dev)
+{
+	return dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
+		dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
+}
+
 static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 {
 	dev = pci_physfn(dev);
-- 
1.7.1
