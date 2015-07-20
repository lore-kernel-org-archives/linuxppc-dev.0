Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE7CB1A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 20:15:13 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 20 Jul 2015 15:45:08 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8DD6A125805B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 15:48:02 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6KAF2ea52887678
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 15:45:03 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6K8tajl022925
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 14:25:36 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Fix the log message when disabling VF
Date: Mon, 20 Jul 2015 18:14:58 +0800
Message-Id: <1437387298-10668-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powernv platform, IOV BAR would be shifted if necessary. While the log
message is not correct when disabling VFs.

This patch fixes this by print correct message based on the offset value.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d1530cb..80b8099 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -946,8 +946,9 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 		res2 = *res;
 		res->start += size * offset;
 
-		dev_info(&dev->dev, "VF BAR%d: %pR shifted to %pR (enabling %d VFs shifted by %d)\n",
-			 i, &res2, res, num_vfs, offset);
+		dev_info(&dev->dev, "VF BAR%d: %pR shifted to %pR (%sabling %d VFs shifted by %d)\n",
+			 i, &res2, res, (offset > 0) ? "En" : "Dis",
+			 num_vfs, offset);
 		pci_update_resource(dev, i + PCI_IOV_RESOURCES);
 	}
 	return 0;
-- 
1.7.9.5
