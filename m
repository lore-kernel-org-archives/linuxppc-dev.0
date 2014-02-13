Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DD4EB2C020F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 00:15:40 +1100 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/6] PCI/arm: Use list_for_each_entry() for bus traversal
Date: Thu, 13 Feb 2014 21:13:59 +0800
Message-ID: <1392297243-61848-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1392297243-61848-1-git-send-email-wangyijing@huawei.com>
References: <1392297243-61848-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Russell King <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>,
 linux-pcmcia@lists.infradead.org, Hanjun Guo <guohanjun@huawei.com>,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 Yijing Wang <wangyijing@huawei.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace list_for_each() + pci_bus_b() with the simpler
list_for_each_entry().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/arm/kernel/bios32.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 317da88..0a77858 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -57,13 +57,10 @@ static void pcibios_bus_report_status(struct pci_bus *bus, u_int status_mask, in
 
 void pcibios_report_status(u_int status_mask, int warn)
 {
-	struct list_head *l;
-
-	list_for_each(l, &pci_root_buses) {
-		struct pci_bus *bus = pci_bus_b(l);
+	struct pci_bus *bus;
 
+	list_for_each_entry(bus, &pci_root_buses, node)
 		pcibios_bus_report_status(bus, status_mask, warn);
-	}
 }
 
 /*
-- 
1.7.1
