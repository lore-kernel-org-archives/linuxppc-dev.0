Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wK0wJ111jzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 15:35:11 +1000 (AEST)
Date: Fri, 5 May 2017 08:34:58 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cxl: Unlock on error in probe
Message-ID: <20170505053458.csrwd2kjber44r4o@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We should unlock if get_cxl_adapter() fails.

Fixes: 594ff7d067ca ("cxl: Support to flash a new image on the adapter from a guest")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
index 7c61c70ba3f6..37475abea3e6 100644
--- a/drivers/misc/cxl/flash.c
+++ b/drivers/misc/cxl/flash.c
@@ -401,8 +401,10 @@ static int device_open(struct inode *inode, struct file *file)
 	if (down_interruptible(&sem) != 0)
 		return -EPERM;
 
-	if (!(adapter = get_cxl_adapter(adapter_num)))
-		return -ENODEV;
+	if (!(adapter = get_cxl_adapter(adapter_num))) {
+		rc = -ENODEV;
+		goto err_unlock;
+	}
 
 	file->private_data = adapter;
 	continue_token = 0;
@@ -446,6 +448,8 @@ static int device_open(struct inode *inode, struct file *file)
 		free_page((unsigned long) le);
 err:
 	put_device(&adapter->dev);
+err_unlock:
+	up(&sem);
 
 	return rc;
 }
