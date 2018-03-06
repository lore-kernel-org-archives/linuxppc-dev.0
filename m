Return-Path: <bharata@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwV1g30FtzF0gk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 19:14:47 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w268ESWi014694
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2018 03:14:44 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ghpp99hgy-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 03:14:44 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Tue, 6 Mar 2018 08:14:41 -0000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, mpe@ellerman.id.au,
 Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: [FIX PATCH] powerpc/pseries: Fix vector5 in ibm architecture vector
 table
Date: Tue,  6 Mar 2018 13:44:32 +0530
Message-Id: <20180306081432.3653-1-bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With ibm,dynamic-memory-v2 and ibm,drc-info coming around the
same time, byte22 in vector5 of ibm architecture vector table
got set twice separately. The end result is that guest kernel
isn't advertising support for ibm,dynamic-memory-v2.

Fix this by removing the duplicate assignment of byte22.

Fixes: 02ef6dd8109b5 (powerpc: Enable support for ibm,drc-info devtree property)
Fixes: c7a3275e0f9e4 (powerpc/pseries: Revert support for ibm,drc-info devtree property)

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index d22c41c26bb3..acf4b2e0530c 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -874,7 +874,6 @@ struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
 		.mmu = 0,
 		.hash_ext = 0,
 		.radix_ext = 0,
-		.byte22 = 0,
 	},
 
 	/* option vector 6: IBM PAPR hints */
-- 
2.14.3
