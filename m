Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjP8q3Sk7zDrSD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 22:55:55 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8QCrFN5039417
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 08:55:53 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25p6akanuh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 08:55:52 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 26 Sep 2016 22:55:49 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4AFA92BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 22:55:46 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8QCtkvN65994774
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 22:55:46 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8QCtjAP024983
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 22:55:46 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 1/5] powerpc/eeh: Allow to freeze PE in eeh_pe_set_option()
Date: Mon, 26 Sep 2016 22:56:03 +1000
In-Reply-To: <1474894567-15229-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1474894567-15229-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1474894567-15229-2-git-send-email-gwshan@linux.vnet.ibm.com>
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
