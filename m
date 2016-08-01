Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2qzq6RcGzDqQ9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 17:03:19 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7170hkS083803
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 03:03:17 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24grd3fs2k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 03:03:17 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 17:03:14 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C63223578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 17:03:13 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7173DBh29098030
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 17:03:13 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7173DOg001353
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 17:03:13 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 ruscur@russell.cc, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Fix BE PE number to
 opal_pci_eeh_freeze_clear()
Date: Mon,  1 Aug 2016 17:03:00 +1000
Message-Id: <1470034990-18860-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PE number (@frozen_pe_no), filled by opal_pci_next_error() is
in big-endian format. Frozen PE number in CPU-endian should be passed
to opal_pci_eeh_freeze_clear() when clearing the frozen state if the
PE is invalid one.

This passes CPU-endian PE number to opal_pci_eeh_freeze_clear() and
it should be part of commit <0f36db77643b> ("powerpc/eeh: Fix wrong
printed PE number").

Cc: stable@vger.kernel.org # v4.3+
Suggested-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 86544ea..75363d9 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1538,7 +1538,7 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
 
 				/* Try best to clear it */
 				opal_pci_eeh_freeze_clear(phb->opal_id,
-					frozen_pe_no,
+					be64_to_cpu(frozen_pe_no),
 					OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
 				ret = EEH_NEXT_ERR_NONE;
 			} else if ((*pe)->state & EEH_PE_ISOLATED ||
-- 
2.1.0
