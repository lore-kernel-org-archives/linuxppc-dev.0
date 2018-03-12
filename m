Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400GFP2fP7zF088
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 22:38:01 +1100 (AEDT)
Received: by mail-it0-x243.google.com with SMTP id v194-v6so11029009itb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 04:38:01 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, fbarrat@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] misc: ocxl: use put_device() instead of
 device_unregister()
Date: Mon, 12 Mar 2018 17:06:53 +0530
Message-Id: <8c4d28703e408b71284af68d07c117e7b8c8a75a.1520849284.git.arvind.yadav.cs@gmail.com>
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

if device_register() returned an error! Always use put_device()
to give up the reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/misc/ocxl/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/pci.c b/drivers/misc/ocxl/pci.c
index 0051d9e..21f4254 100644
--- a/drivers/misc/ocxl/pci.c
+++ b/drivers/misc/ocxl/pci.c
@@ -519,7 +519,7 @@ static struct ocxl_fn *init_function(struct pci_dev *dev)
 	rc = device_register(&fn->dev);
 	if (rc) {
 		deconfigure_function(fn);
-		device_unregister(&fn->dev);
+		put_device(&fn->dev);
 		return ERR_PTR(rc);
 	}
 	return fn;
-- 
1.9.1
