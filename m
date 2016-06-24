Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbQpn4YtmzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 14:49:21 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rbQpn02tvz9t12
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2016 14:49:20 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5O4iFxA074991
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2016 00:49:18 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23rmrr0dx9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2016 00:49:18 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 24 Jun 2016 14:49:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7EB553578057
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2016 14:49:12 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5O4nCjO8651234
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2016 14:49:12 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5O4nBmh005564
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2016 14:49:12 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, ppaidipe@in.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/eeh: Fix wrong argument passed to eeh_rmv_device()
Date: Fri, 24 Jun 2016 14:49:02 +1000
Message-Id: <1466743750-28332-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When calling eeh_rmv_device() in eeh_reset_device() for partial
hotplug case, @rmv_data instead of its address is the proper
argument. Otherwise, the stack frame is corrupted when writing
to @rmv_data (actually its address) in eeh_rmv_device(). It
results in kernel crash as observed.

This fixes the issue by passing @rmv_data, not its address to
eeh_rmv_device() in eeh_reset_device().

Cc: stable@vger.kernel.org # v4.6+
Fixes: 67086e32b564 ("powerpc/eeh: powerpc/eeh: Support error recovery for VF PE")
Reported-by: Pridhiviraj Paidipeddi <ppaidipe@in.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 389b0d3..5c0429f 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -648,7 +648,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 			pci_unlock_rescan_remove();
 		}
 	} else if (frozen_bus) {
-		eeh_pe_dev_traverse(pe, eeh_rmv_device, &rmv_data);
+		eeh_pe_dev_traverse(pe, eeh_rmv_device, rmv_data);
 	}
 
 	/*
-- 
2.1.0
