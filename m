Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E279A1401F5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 12:27:22 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 23 Apr 2014 07:57:19 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 653093940048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 07:57:17 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3N2ROMV8520186
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 07:57:24 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3N2R8eR021350
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 07:57:16 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/powernv: release the refcount for pci_dev
Date: Wed, 23 Apr 2014 10:26:33 +0800
Message-Id: <1398219993-6326-2-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1398219993-6326-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1398219993-6326-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, aik@au1.ibm.com,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerNV platform, we are holding an unnecessary refcount on a pci_dev, which
leads to the pci_dev is not destroyed when hotplugging a pci device.

This patch release the unnecessary refcount.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index bd3870e..cec6a75 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -558,7 +558,6 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 				pci_name(dev));
 			continue;
 		}
-		pci_dev_get(dev);
 		pdn->pcidev = dev;
 		pdn->pe_number = pe->pe_number;
 		pe->dma_weight += pnv_ioda_dma_weight(dev);
-- 
1.7.9.5
