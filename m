Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A06191A1E86
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 13:36:31 +1100 (AEDT)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 00395140139
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:30 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 12 Nov 2014 08:06:29 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id DAB20E003F
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 08:06:34 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAC2aB0E56426732
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 08:06:11 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAC2aPbZ025639
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 08:06:25 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/8] powerpc/powernv: Check PHB type in advance
Date: Wed, 12 Nov 2014 13:36:04 +1100
Message-Id: <1415759771-11359-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1415759771-11359-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1415759771-11359-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch checks PHB type a bit early to save a bit cycles
for P7 because we don't support M64 for P7IOC no matter what
OPAL firmware we have.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 468a0f2..7ab1dd7 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -313,6 +313,12 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 	const u32 *r;
 	u64 pci_addr;
 
+	/* FIXME: Support M64 for P7IOC */
+	if (phb->type != PNV_PHB_IODA2) {
+		pr_info("  Not support M64 window\n");
+		return;
+	}
+
 	if (!firmware_has_feature(FW_FEATURE_OPALv3)) {
 		pr_info("  Firmware too old to support M64 window\n");
 		return;
@@ -325,12 +331,6 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 		return;
 	}
 
-	/* FIXME: Support M64 for P7IOC */
-	if (phb->type != PNV_PHB_IODA2) {
-		pr_info("  Not support M64 window\n");
-		return;
-	}
-
 	res = &hose->mem_resources[1];
 	res->start = of_translate_address(dn, r + 2);
 	res->end = res->start + of_read_number(r + 4, 2) - 1;
-- 
1.8.3.2
