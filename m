Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zh4bb1wqCzF1Fc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 14:27:38 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1E3PA18087955
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 22:27:36 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g4afgd048-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 22:27:36 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 14 Feb 2018 03:27:34 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Expose TSCR via sysfs only on powernv
Date: Wed, 14 Feb 2018 14:27:06 +1100
Message-Id: <20180214032706.6242-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The TSCR can only be accessed in hypervisor mode.

Fixes: 88b5e12eeb11 ("powerpc: Expose TSCR via sysfs")
Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 5a8bfee6e187..04d0bbd7a1dd 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -788,7 +788,8 @@ static int register_cpu_online(unsigned int cpu)
 	if (cpu_has_feature(CPU_FTR_PPCAS_ARCH_V2))
 		device_create_file(s, &dev_attr_pir);
 
-	if (cpu_has_feature(CPU_FTR_ARCH_206))
+	if (cpu_has_feature(CPU_FTR_ARCH_206) &&
+		!firmware_has_feature(FW_FEATURE_LPAR))
 		device_create_file(s, &dev_attr_tscr);
 #endif /* CONFIG_PPC64 */
 
@@ -873,7 +874,8 @@ static int unregister_cpu_online(unsigned int cpu)
 	if (cpu_has_feature(CPU_FTR_PPCAS_ARCH_V2))
 		device_remove_file(s, &dev_attr_pir);
 
-	if (cpu_has_feature(CPU_FTR_ARCH_206))
+	if (cpu_has_feature(CPU_FTR_ARCH_206) &&
+		!firmware_has_feature(FW_FEATURE_LPAR))
 		device_remove_file(s, &dev_attr_tscr);
 #endif /* CONFIG_PPC64 */
 
-- 
2.16.1
