Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2033214010D
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 May 2014 14:26:45 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 08/13] PCI, rpaphp: Use new pci_is_bridge() to simplify code
Date: Sun, 4 May 2014 12:23:43 +0800
Message-ID: <1399177428-3784-9-git-send-email-wangyijing@huawei.com>
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

Now we can use new pci_is_bridge() helper function
to simplify code.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/rpadlpar_core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index 4fcdeed..7660232 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -157,8 +157,7 @@ static void dlpar_pci_add_bus(struct device_node *dn)
 	}
 
 	/* Scan below the new bridge */
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-	    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+	if (pci_is_bridge(dev))
 		of_scan_pci_bridge(dev);
 
 	/* Map IO space for child bus, which may or may not succeed */
-- 
1.7.1
