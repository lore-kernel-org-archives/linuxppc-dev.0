Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 94EAA14016E
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 May 2014 14:26:44 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 01/13] PCI: rename pci_is_bridge() to pci_has_subordinate()
Date: Sun, 4 May 2014 12:23:36 +0800
Message-ID: <1399177428-3784-2-git-send-email-wangyijing@huawei.com>
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

pci_is_bridge() which seems to determine whether device is a bridge,
returns true only when the subordinate bus exists. This confuses
people. PCI device is a bridge means its header type(bit 0 through 6)
is 0x1(PCI bridge) or 0x2(CardBus bridge). Rename the current
pci_is_bridge() helper function to pci_has_subordinate().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci-driver.c |    8 ++++----
 drivers/pci/pci.h        |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d911e0c..b7850cb 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -580,14 +580,14 @@ static void pci_pm_default_resume(struct pci_dev *pci_dev)
 {
 	pci_fixup_device(pci_fixup_resume, pci_dev);
 
-	if (!pci_is_bridge(pci_dev))
+	if (!pci_has_subordinate(pci_dev))
 		pci_enable_wake(pci_dev, PCI_D0, false);
 }
 
 static void pci_pm_default_suspend(struct pci_dev *pci_dev)
 {
 	/* Disable non-bridge devices without PM support */
-	if (!pci_is_bridge(pci_dev))
+	if (!pci_has_subordinate(pci_dev))
 		pci_disable_enabled_device(pci_dev);
 }
 
@@ -717,7 +717,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 
 	if (!pci_dev->state_saved) {
 		pci_save_state(pci_dev);
-		if (!pci_is_bridge(pci_dev))
+		if (!pci_has_subordinate(pci_dev))
 			pci_prepare_to_sleep(pci_dev);
 	}
 
@@ -971,7 +971,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 			return error;
 	}
 
-	if (!pci_dev->state_saved && !pci_is_bridge(pci_dev))
+	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
 		pci_prepare_to_sleep(pci_dev);
 
 	/*
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6bd0822..65108fc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -77,7 +77,7 @@ static inline void pci_wakeup_event(struct pci_dev *dev)
 	pm_wakeup_event(&dev->dev, 100);
 }
 
-static inline bool pci_is_bridge(struct pci_dev *pci_dev)
+static inline bool pci_has_subordinate(struct pci_dev *pci_dev)
 {
 	return !!(pci_dev->subordinate);
 }
-- 
1.7.1
