Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zx6gc5gNNzF1YN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 19:46:19 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id m19so646584pgn.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 00:46:19 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH] PCI/hotplug: ppc: correct a php_slot usage after free
Date: Wed,  7 Mar 2018 16:46:04 +0800
Message-Id: <1520412364-2680-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

In pnv_php_unregister_one(), pnv_php_put_slot() might kfree
php_slot structure. But there is pci_hp_deregister() after
that with php_slot reference.

This patch moves pnv_php_put_slot() to the end of function.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 drivers/pci/hotplug/pnv_php.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 74f6a17..eb60692e 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -930,8 +930,8 @@ static void pnv_php_unregister_one(struct device_node *dn)
 		return;
 
 	php_slot->state = PNV_PHP_STATE_OFFLINE;
-	pnv_php_put_slot(php_slot);
 	pci_hp_deregister(&php_slot->slot);
+	pnv_php_put_slot(php_slot);
 }
 
 static void pnv_php_unregister(struct device_node *dn)
-- 
1.8.3.1
