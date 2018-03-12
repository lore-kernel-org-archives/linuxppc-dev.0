Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400GFK296KzF08D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 22:37:57 +1100 (AEDT)
Received: by mail-io0-x243.google.com with SMTP id d71so11047201iog.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 04:37:57 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, fbarrat@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] misc: mic: Release reference count and memory for VOP
 device
Date: Mon, 12 Mar 2018 17:06:52 +0530
Message-Id: <46d6830218c1652a1e06ede169a4bcc8cf0e3b58.1520849284.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
References: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
References: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Never directly free @dev after calling device_register(),
even if it returned an error! Always use put_device() to
give up the reference initialized.
Release allocated memory for vop device in vop_release_dev().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/misc/mic/bus/vop_bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mic/bus/vop_bus.c b/drivers/misc/mic/bus/vop_bus.c
index fd7f2a6..e5bb9c7 100644
--- a/drivers/misc/mic/bus/vop_bus.c
+++ b/drivers/misc/mic/bus/vop_bus.c
@@ -135,7 +135,9 @@ void vop_unregister_driver(struct vop_driver *driver)
 
 static void vop_release_dev(struct device *d)
 {
-	put_device(d);
+	struct vop_device *dev = dev_to_vop(d);
+
+	kfree(dev);
 }
 
 struct vop_device *
@@ -174,7 +176,7 @@ struct vop_device *
 		goto free_vdev;
 	return vdev;
 free_vdev:
-	kfree(vdev);
+	put_device(&vdev->dev);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(vop_register_device);
-- 
1.9.1
