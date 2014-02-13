Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 86B472C032F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 00:15:22 +1100 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5/6] PCI/pcmcia: Use list_for_each_entry() for bus traversal
Date: Thu, 13 Feb 2014 21:14:02 +0800
Message-ID: <1392297243-61848-5-git-send-email-wangyijing@huawei.com>
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
 drivers/pcmcia/yenta_socket.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 8485761..d16fb12 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -1076,7 +1076,7 @@ static void yenta_config_init(struct yenta_socket *socket)
  */
 static void yenta_fixup_parent_bridge(struct pci_bus *cardbus_bridge)
 {
-	struct list_head *tmp;
+	struct pci_bus *silbling;
 	unsigned char upper_limit;
 	/*
 	 * We only check and fix the parent bridge: All systems which need
@@ -1096,8 +1096,8 @@ static void yenta_fixup_parent_bridge(struct pci_bus *cardbus_bridge)
 	upper_limit = bridge_to_fix->parent->busn_res.end;
 
 	/* check the bus ranges of all silbling bridges to prevent overlap */
-	list_for_each(tmp, &bridge_to_fix->parent->children) {
-		struct pci_bus *silbling = pci_bus_b(tmp);
+	list_for_each_entry(silbling, &bridge_to_fix->parent->children,
+			node) {
 		/*
 		 * If the silbling has a higher secondary bus number
 		 * and it's secondary is equal or smaller than our
-- 
1.7.1
