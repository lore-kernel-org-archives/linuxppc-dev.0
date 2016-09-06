Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSxdf6HLtzDrpg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 16:34:14 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sSxdf23sJz9s5g
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Sep 2016 16:34:14 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u866WrjV117511
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Sep 2016 02:34:12 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 259nc46xbg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 06 Sep 2016 02:34:11 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 6 Sep 2016 16:34:08 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 94B6F2BB0055
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Sep 2016 16:33:51 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u866Xpd07274836
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Sep 2016 16:33:51 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u866Xo8F025830
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Sep 2016 16:33:51 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Detach from PE on releasing PCI device
Date: Tue,  6 Sep 2016 16:34:01 +1000
Message-Id: <1473143641-25413-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PCI hotplug can be part of EEH error recovery. The @pdn and
the device's PE number aren't removed and added afterwords. The
PE number in @pdn should be set to an invalid one. Otherwise, the
PE's device count is decreased on removing devices while failing
to be increased on adding devices. It leads to unbalanced PE's
device count and make normal PCI hotplug path broken.

Fixes: c5f7700bbd2e ("powerpc/powernv: Dynamically release PE")
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c16d790..e98f4a8 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3442,7 +3442,16 @@ static void pnv_pci_release_device(struct pci_dev *pdev)
 	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
 		return;
 
+	/* PCI hotplug can happen as part of EEH error recovery. The @pdn
+	 * isn't removed and added afterwards in this scenario. We should
+	 * set the PE number in @pdn to an invalid one. Otherwise, the PE's
+	 * device count is decreased on removing devices while failing to
+	 * be increased on adding devices. It leads to unbalanced PE's device
+	 * count and eventually make normal PCI hotplug path broken.
+	 */
 	pe = &phb->ioda.pe_array[pdn->pe_number];
+	pdn->pe_number = IODA_INVALID_PE;
+
 	WARN_ON(--pe->device_count < 0);
 	if (pe->device_count == 0)
 		pnv_ioda_release_pe(pe);
-- 
2.1.0
