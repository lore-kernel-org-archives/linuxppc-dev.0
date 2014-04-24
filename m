Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C6F0C14018F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:34 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:34 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E40AA2CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:30 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7daL311272292
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80TNX017512
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:30 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 16/25] powerpc/powernv: Reset root port in firmware
Date: Thu, 24 Apr 2014 18:00:22 +1000
Message-Id: <1398326431-24305-17-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linux-stable <stable@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Resetting root port has more stuff to do than that for PCIe switch
ports and we should have resetting root port done in firmware instead
of the kernel itself. The problem was introduced by commit 5b2e198e
("powerpc/powernv: Rework EEH reset").

Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 3a755b5..0844e00 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -510,12 +510,10 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 	int ret;
 
 	/*
-	 * The rules applied to reset, either fundamental or hot reset:
-	 *
-	 * We always reset the direct upstream bridge of the PE. If the
-	 * direct upstream bridge isn't root bridge, we always take hot
-	 * reset no matter what option (fundamental or hot) is. Otherwise,
-	 * we should do the reset according to the required option.
+	 * For PHB reset, we always have complete reset. For those PEs whose
+	 * primary bus derived from root complex (root bus) or root port
+	 * (usually bus#1), we apply hot or fundamental reset on the root port.
+	 * For other PEs, we always have hot reset on the PE primary bus.
 	 *
 	 * Here, we have different design to pHyp, which always clear the
 	 * frozen state during PE reset. However, the good idea here from
@@ -529,7 +527,8 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 		ret = ioda_eeh_phb_reset(hose, option);
 	} else {
 		bus = eeh_pe_bus_get(pe);
-		if (pci_is_root_bus(bus))
+		if (pci_is_root_bus(bus) ||
+		    pci_is_root_bus(bus->parent))
 			ret = ioda_eeh_root_reset(hose, option);
 		else
 			ret = ioda_eeh_bridge_reset(bus->self, option);
-- 
1.8.3.2
