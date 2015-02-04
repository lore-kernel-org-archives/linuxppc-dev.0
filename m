Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DBC401A0A2F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 03:09:50 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 5 Feb 2015 02:09:48 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C7F193578048
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 03:09:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t14G9btt47382538
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 03:09:45 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t14G9BsX008601
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 03:09:11 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, benh@au1.ibm.com
Subject: [PATCH] pci/iov: fix memory leak introduced in "PCI: Store individual
 VF BAR size in struct pci_sriov"
Date: Thu,  5 Feb 2015 00:08:50 +0800
Message-Id: <1423066130-8587-1-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <CAErSpo4nLEvL4XGvkvZbfy0dFQcRDHdn5aznkx2fRMMnt1_n4g@mail.gmail.com>
References: <CAErSpo4nLEvL4XGvkvZbfy0dFQcRDHdn5aznkx2fRMMnt1_n4g@mail.gmail.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bjorn, this is an error introduced in the patch "PCI: Store individual VF BAR
size in struct pci_sriov".

This patch is based on the pci/virtualization branch. I have tried, it could
merge with the bad one cleanly.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index d64b9df..721987b 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -430,10 +430,8 @@ found:
 	pci_write_config_dword(dev, pos + PCI_SRIOV_SYS_PGSIZE, pgsz);
 
 	iov = kzalloc(sizeof(*iov), GFP_KERNEL);
-	if (!iov) {
-		rc = -ENOMEM;
-		goto failed;
-	}
+	if (!iov)
+		return -ENOMEM;
 
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
@@ -485,6 +483,8 @@ failed:
 		res->flags = 0;
 	}
 
+	kfree(iov);
+
 	return rc;
 }
 
-- 
1.8.3.1
