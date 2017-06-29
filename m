Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wysBT3Dr6zDr46
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 17:44:49 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id e199so12080104pfh.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 00:44:49 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: tyreld@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ibmvscsi: constify dev_pm_ops structures.
Date: Thu, 29 Jun 2017 13:13:55 +0530
Message-Id: <ff2eee2670f773454efdece4f455bb367fff3baa.1498722090.git.arvind.yadav.cs@gmail.com>
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
  17956	   1456	      8	  19420	   4bdc	drivers/scsi/ibmvscsi/ibmvscsi.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  18164	   1264	      8	  19436	   4bec	drivers/scsi/ibmvscsi/ibmvscsi.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 1deb0a9..da22b36 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -2336,7 +2336,7 @@ static int ibmvscsi_resume(struct device *dev)
 };
 MODULE_DEVICE_TABLE(vio, ibmvscsi_device_table);
 
-static struct dev_pm_ops ibmvscsi_pm_ops = {
+static const struct dev_pm_ops ibmvscsi_pm_ops = {
 	.resume = ibmvscsi_resume
 };
 
-- 
1.9.1
