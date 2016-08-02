Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3N6P0hCjzDrFW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:10:52 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7248qR6087055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 00:10:51 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24gre1xhwq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 00:10:50 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 14:10:48 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DC5A72BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:10:46 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u724AkHB29163586
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:46 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u724Akk9030002
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:46 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 1/9] powerpc/powernv: Pass CPU-endian PE number to
 opal_pci_eeh_freeze_clear()
Date: Tue,  2 Aug 2016 14:10:29 +1000
In-Reply-To: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1470111037-18531-2-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PE number (@frozen_pe_no), filled by opal_pci_next_error() is in
big-endian format. It should be converted to CPU-dian before it is
passed to opal_pci_eeh_freeze_clear() when clearing the frozen state
if the PE is invalid one. As Michael Ellerman pointed out, the issue
is also detected by sparse:

  gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
                    arch/powerpc/platforms/powernv/eeh-powernv.o
      :
  arch/powerpc/platforms/powernv/eeh-powernv.c:1541:41: \
  warning: incorrect type in argument 2 (different base types)
  arch/powerpc/platforms/powernv/eeh-powernv.c:1541:41: \
  expected unsigned long long [unsigned] [usertype] pe_number
  arch/powerpc/platforms/powernv/eeh-powernv.c:1541:41: \
  got restricted __be64 [addressable] [usertype] frozen_pe_no

This passes CPU-endian PE number to opal_pci_eeh_freeze_clear() and
it should be part of commit <0f36db77643b> ("powerpc/eeh: Fix wrong
printed PE number"), which was merged to 4.3 kernel.

Fixes: 71b540adffd9 ("powerpc/powernv: Don't escalate non-existing frozen PE")
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
