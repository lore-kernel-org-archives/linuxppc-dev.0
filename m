Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B90A1A0250
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 13:36:29 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EF8D514017B
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:28 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 12 Nov 2014 12:36:28 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 56E2E357805C
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:26 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAC2cKAn27984112
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:38:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAC2aPnd021608
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:25 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/8] powerpc/powernv: Rename alloc_m64_pe() to reserve_m64_pe()
Date: Wed, 12 Nov 2014 13:36:06 +1100
Message-Id: <1415759771-11359-4-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch renames alloc_m64_pe() to reserve_m64_pe() to reflect
its real usage: We reserve PE numbers for M64 segments in advance
and then pick up the reserved PE numbers when building the mapping
between PE numbers and M64 segments.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 8 ++++----
 arch/powerpc/platforms/powernv/pci.h      | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 7aa0404..cf90cce 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -172,7 +172,7 @@ fail:
 	return -EIO;
 }
 
-static void pnv_ioda2_alloc_m64_pe(struct pnv_phb *phb)
+static void pnv_ioda2_reserve_m64_pe(struct pnv_phb *phb)
 {
 	resource_size_t sgsz = phb->ioda.m64_segsize;
 	struct pci_dev *pdev;
@@ -345,7 +345,7 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 	/* Use last M64 BAR to cover M64 window */
 	phb->ioda.m64_bar_idx = 15;
 	phb->init_m64 = pnv_ioda2_init_m64;
-	phb->alloc_m64_pe = pnv_ioda2_alloc_m64_pe;
+	phb->reserve_m64_pe = pnv_ioda2_reserve_m64_pe;
 	phb->pick_m64_pe = pnv_ioda2_pick_m64_pe;
 }
 
@@ -837,8 +837,8 @@ static void pnv_pci_ioda_setup_PEs(void)
 		phb = hose->private_data;
 
 		/* M64 layout might affect PE allocation */
-		if (phb->alloc_m64_pe)
-			phb->alloc_m64_pe(phb);
+		if (phb->reserve_m64_pe)
+			phb->reserve_m64_pe(phb);
 
 		pnv_ioda_setup_PEs(hose->bus);
 	}
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 34d29eb..6c02ff8 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -130,7 +130,7 @@ struct pnv_phb {
 	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
 	void (*shutdown)(struct pnv_phb *phb);
 	int (*init_m64)(struct pnv_phb *phb);
-	void (*alloc_m64_pe)(struct pnv_phb *phb);
+	void (*reserve_m64_pe)(struct pnv_phb *phb);
 	int (*pick_m64_pe)(struct pnv_phb *phb, struct pci_bus *bus, int all);
 	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
 	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
-- 
1.8.3.2
