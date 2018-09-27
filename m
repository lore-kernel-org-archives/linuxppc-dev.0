Return-Path: <yuehaibing@huawei.com>
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LQHr12MJzF33Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 16:43:34 +1000 (AEST)
From: YueHaibing <yuehaibing@huawei.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas
 <bhelgaas@google.com>
CC: YueHaibing <yuehaibing@huawei.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-pci@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] PCI: hotplug: Use kmemdup rather than duplicating its
 implementation in pnv_php_add_devtree()
Date: Thu, 27 Sep 2018 06:52:21 +0000
Message-ID: <1538031141-138417-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use kmemdup rather than duplicating its implementation

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pci/hotplug/pnv_php.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 5070620..ee54f5b 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -275,14 +275,13 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 		goto free_fdt1;
 	}
 
-	fdt = kzalloc(fdt_totalsize(fdt1), GFP_KERNEL);
+	fdt = kmemdup(fdt1, fdt_totalsize(fdt1), GFP_KERNEL);
 	if (!fdt) {
 		ret = -ENOMEM;
 		goto free_fdt1;
 	}
 
 	/* Unflatten device tree blob */
-	memcpy(fdt, fdt1, fdt_totalsize(fdt1));
 	dt = of_fdt_unflatten_tree(fdt, php_slot->dn, NULL);
 	if (!dt) {
 		ret = -EINVAL;
