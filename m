Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A5021A048F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 04:27:58 +1100 (AEDT)
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 24 Feb 2016 17:27:55 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 436831B0804B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 17:28:13 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1OHRrxc65470686
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 17:27:53 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1OHRqWo011090
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 10:27:53 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] cxl: Fix PSL timebase synchronization detection
Date: Wed, 24 Feb 2016 18:27:51 +0100
Message-Id: <1456334871-30397-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PSL timebase synchronization is seemingly failing for
configuration not including VIRT_CPU_ACCOUNTING_NATIVE. The driver
shows the following trace in dmesg:
PSL: Timebase sync: giving up!

The PSL timebase register is actually syncing correctly, but the cxl
driver is not detecting it. Fix is to use the proper timebase-to-time
conversion.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: <stable@vger.kernel.org> # 4.3+
---
 drivers/misc/cxl/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 4c1903f..0c6c17a1 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -415,7 +415,7 @@ static int cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
 		delta = mftb() - psl_tb;
 		if (delta < 0)
 			delta = -delta;
-	} while (cputime_to_usecs(delta) > 16);
+	} while (tb_to_ns(delta) > 16000);
 
 	return 0;
 }
-- 
1.9.1
