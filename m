Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wysQv15kZzDr46
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 17:55:34 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id f127so10987968pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 00:55:34 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: tyreld@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ibmvfc: constify dev_pm_ops structures.
Date: Thu, 29 Jun 2017 13:24:41 +0530
Message-Id: <c0ec5db7e2c3313cb7b417e76330520fd2b6136c.1498722828.git.arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

dev_pm_ops are not supposed to change at runtime. All functions
working with dev_pm_ops provided by <linux/device.h> work with const
dev_pm_ops. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
  41937	   1296	     20	  43253	   a8f5	drivers/scsi/ibmvscsi/ibmvfc.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  42129	   1104	     20	  43253	   a8f5	drivers/scsi/ibmvscsi/ibmvfc.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 26cd3c2..cc4e05b 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -4935,7 +4935,7 @@ static unsigned long ibmvfc_get_desired_dma(struct vio_dev *vdev)
 };
 MODULE_DEVICE_TABLE(vio, ibmvfc_device_table);
 
-static struct dev_pm_ops ibmvfc_pm_ops = {
+static const struct dev_pm_ops ibmvfc_pm_ops = {
 	.resume = ibmvfc_resume
 };
 
-- 
1.9.1
