Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E0794141392
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Apr 2014 19:26:19 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 07/13] sparc/PCI: Use new pci_is_bridge() to simplify code
Date: Fri, 25 Apr 2014 17:18:29 +0800
Message-ID: <1398417515-8740-8-git-send-email-wangyijing@huawei.com>
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
 arch/sparc/kernel/pci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 1555bbc..857ad77 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -543,8 +543,7 @@ static void pci_of_scan_bus(struct pci_pbm_info *pbm,
 			printk("PCI: dev header type: %x\n",
 			       dev->hdr_type);
 
-		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-		    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+		if (pci_is_bridge(dev))
 			of_scan_pci_bridge(pbm, child, dev);
 	}
 }
-- 
1.7.1
