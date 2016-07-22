Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwhmg63bkzDrKB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 17:17:23 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6M7E35t020444
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 03:17:21 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24athdr9cc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 03:17:21 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 22 Jul 2016 17:17:18 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6C5463578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 17:17:16 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6M7HGwi28967048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 17:17:16 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6M7HFk3004949
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 17:17:16 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, imunsie@au1.ibm.com
Subject: [PATCH] powerpc/powernv: document cxl dependency on special case in
 pnv_eeh_reset()
Date: Fri, 22 Jul 2016 17:16:35 +1000
Message-Id: <1469171795-9879-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pnv_eeh_reset() has special handling for PEs whose primary bus is the root
bus or the bus immediately underneath the root port.

The cxl bi-modal card support added in b0b5e5918ad1 ("cxl: Add
cxl_check_and_switch_mode() API to switch bi-modal cards") relies on this
behaviour when hot-resetting the CAPI adapter following a mode switch.
Document this in pnv_eeh_reset() so we don't accidentally break it.

Suggested-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Gavin requested that I add this comment a few weeks ago but I didn't get
around to including it in b0b5e5918ad1. Sorry Gavin!
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 86544ea..3af854e 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1094,6 +1094,13 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 	if (pe->type & EEH_PE_VF)
 		return pnv_eeh_reset_vf_pe(pe, option);
 
+	/*
+	 * If dealing with the root bus (or the bus underneath the
+	 * root port), we reset the bus underneath the root port.
+	 *
+	 * The cxl driver depends on this behaviour for bi-modal card
+	 * switching.
+	 */
 	if (pci_is_root_bus(bus) ||
 	    pci_is_root_bus(bus->parent))
 		return pnv_eeh_root_reset(hose, option);
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
