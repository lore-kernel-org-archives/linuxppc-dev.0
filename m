Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZMHQ66vxzDsTX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 12:07:14 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sZMHQ2mCpz9t0p
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:14 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8F23HJ7140736
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Sep 2016 22:07:12 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25exb925t1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Sep 2016 22:07:12 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 12:07:10 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 854D72BB0057
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:07 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8F277tW61669568
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:07 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8F277us018262
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:07 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 1/4] powerpc/eeh: Allow to freeze PE in eeh_pe_set_option()
Date: Thu, 15 Sep 2016 12:07:19 +1000
In-Reply-To: <1473905242-898-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1473905242-898-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1473905242-898-2-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function eeh_pe_set_option() is used to apply the requested options
(enable, disable, unfreeze) in EEH virtualization path. The semantics
of this function isn't complete until freezing is supported.

This allows to freeze the indicated PE. The new semantics is going to
be used in PCI surprise hot remove path, to freeze removed PCI devices
(PE) to avoid unexpected EEH error reporting.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 7429556..0699f15 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1502,6 +1502,7 @@ int eeh_pe_set_option(struct eeh_pe *pe, int option)
 		break;
 	case EEH_OPT_THAW_MMIO:
 	case EEH_OPT_THAW_DMA:
+	case EEH_OPT_FREEZE_PE:
 		if (!eeh_ops || !eeh_ops->set_option) {
 			ret = -ENOENT;
 			break;
-- 
2.1.0
