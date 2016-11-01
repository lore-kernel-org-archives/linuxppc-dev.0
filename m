Return-Path: <jhovold@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com
 [IPv6:2a00:1450:4010:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7Zp42JMNzDvHX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 02:26:36 +1100 (AEDT)
Received: by mail-lf0-x244.google.com with SMTP id p100so4603354lfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Nov 2016 08:26:36 -0700 (PDT)
Sender: Johan Hovold <jhovold@gmail.com>
From: Johan Hovold <johan@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] powerpc/pci: fix device reference leaks
Date: Tue,  1 Nov 2016 16:26:03 +0100
Message-Id: <1478013963-28871-4-git-send-email-johan@kernel.org>
In-Reply-To: <1478013963-28871-1-git-send-email-johan@kernel.org>
References: <1478013963-28871-1-git-send-email-johan@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make sure to drop any device reference taken by vio_find_node() when
adding and removing virtual I/O slots.

Fixes: 5eeb8c63a38f ("[PATCH] PCI Hotplug: rpaphp: Move VIO...")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/pci/hotplug/rpadlpar_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index dc67f39779ec..c614ff7c3bc3 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -257,8 +257,13 @@ static int dlpar_add_phb(char *drc_name, struct device_node *dn)
 
 static int dlpar_add_vio_slot(char *drc_name, struct device_node *dn)
 {
-	if (vio_find_node(dn))
+	struct vio_dev *vio_dev;
+
+	vio_dev = vio_find_node(dn);
+	if (vio_dev) {
+		put_device(&vio_dev->dev);
 		return -EINVAL;
+	}
 
 	if (!vio_register_device_node(dn)) {
 		printk(KERN_ERR
@@ -334,6 +339,9 @@ static int dlpar_remove_vio_slot(char *drc_name, struct device_node *dn)
 		return -EINVAL;
 
 	vio_unregister_device(vio_dev);
+
+	put_device(&vio_dev->dev);
+
 	return 0;
 }
 
-- 
2.7.3
