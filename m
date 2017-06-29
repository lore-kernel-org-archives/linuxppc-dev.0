Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wypY346s7zDr1h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 15:45:43 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id f127so10622477pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 22:45:43 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 tlfalcon@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] net: ibm: ibmveth: constify dev_pm_ops structures.
Date: Thu, 29 Jun 2017 11:14:50 +0530
Message-Id: <24303710c4e099faa0ca7d9d92a71e53d6b66bcc.1498714986.git.arvind.yadav.cs@gmail.com>
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
  15426	   1256	      0	  16682	   412a	drivers/net/ethernet/ibm/ibmveth.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  15618	   1064	      0	  16682	   412a	drivers/net/ethernet/ibm/ibmveth.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 72ab7b6..02b26bf 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1843,7 +1843,7 @@ static int ibmveth_resume(struct device *dev)
 };
 MODULE_DEVICE_TABLE(vio, ibmveth_device_table);
 
-static struct dev_pm_ops ibmveth_pm_ops = {
+static const struct dev_pm_ops ibmveth_pm_ops = {
 	.resume = ibmveth_resume
 };
 
-- 
1.9.1
