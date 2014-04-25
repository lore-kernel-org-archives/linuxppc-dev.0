Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 52328141362
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Apr 2014 19:26:20 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 12/13] PCI, pcmcia: Use new pci_is_bridge() to simplify code
Date: Fri, 25 Apr 2014 17:18:34 +0800
Message-ID: <1398417515-8740-13-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1398417515-8740-1-git-send-email-wangyijing@huawei.com>
References: <1398417515-8740-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
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

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pcmcia/cardbus.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
index 8bde619..4fe4cc4 100644
--- a/drivers/pcmcia/cardbus.c
+++ b/drivers/pcmcia/cardbus.c
@@ -78,8 +78,7 @@ int __ref cb_alloc(struct pcmcia_socket *s)
 	max = bus->busn_res.start;
 	for (pass = 0; pass < 2; pass++)
 		list_for_each_entry(dev, &bus->devices, bus_list)
-			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+			if (pci_is_bridge(dev))
 				max = pci_scan_bridge(bus, dev, max, pass);
 
 	/*
-- 
1.7.1
