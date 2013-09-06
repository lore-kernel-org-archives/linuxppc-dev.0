Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 399552C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 11:00:19 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 5 Sep 2013 21:00:16 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D046638C8042
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 21:00:13 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8610D9h37945554
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Sep 2013 01:00:13 GMT
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8610ChO029738
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Sep 2013 22:00:12 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/6] powerpc/powernv: Double size of log blob
Date: Fri,  6 Sep 2013 09:00:03 +0800
Message-Id: <1378429205-16248-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1378429205-16248-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1378429205-16248-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Each PHB instance (struct pnv_phb) has its corresponding log blob,
which is used to hold the retrieved error log from firmware. The
current size of that (4096) isn't enough for PHB3 case and the patch
makes that double to 8192.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index d633c64..f4bccc8 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -17,7 +17,7 @@ enum pnv_phb_model {
 	PNV_PHB_MODEL_PHB3,
 };
 
-#define PNV_PCI_DIAG_BUF_SIZE	4096
+#define PNV_PCI_DIAG_BUF_SIZE	8192
 #define PNV_IODA_PE_DEV		(1 << 0)	/* PE has single PCI device	*/
 #define PNV_IODA_PE_BUS		(1 << 1)	/* PE has primary PCI bus	*/
 #define PNV_IODA_PE_BUS_ALL	(1 << 2)	/* PE has subordinate buses	*/
-- 
1.7.5.4
