Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwhR41mC0zDr1S
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 05:03:11 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5PIxQrL026921
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jun 2017 15:03:09 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2babdevg52-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jun 2017 15:03:09 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 26 Jun 2017 05:03:06 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5PJ34ei65732692
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 05:03:04 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5PJ33Pf029975
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 05:03:04 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/sysfs: Expose MMCR2 spr in sysfs
Date: Mon, 26 Jun 2017 00:32:52 +0530
Message-Id: <1498417372-27137-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Monitor Mode Control Register 2 (MMCR2) is a 64-bit
register that contains 9-bit control fields for
controlling the operation of PMC1 - PMC6. Patch
to expose the MMCR2 spr in sysfs.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 4437c70c7c2b..587eb3a7b5da 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -482,6 +482,7 @@ SYSFS_PMCSETUP(pmc7, SPRN_PMC7);
 SYSFS_PMCSETUP(pmc8, SPRN_PMC8);
 
 SYSFS_PMCSETUP(mmcra, SPRN_MMCRA);
+SYSFS_PMCSETUP(mmcr2, SPRN_MMCR2);
 SYSFS_SPRSETUP(purr, SPRN_PURR);
 SYSFS_SPRSETUP(spurr, SPRN_SPURR);
 SYSFS_SPRSETUP(pir, SPRN_PIR);
@@ -492,6 +493,7 @@ SYSFS_SPRSETUP(pir, SPRN_PIR);
   Lets be conservative and default to pseries.
 */
 static DEVICE_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
+static DEVICE_ATTR(mmcr2, 0600, show_mmcr2, store_mmcr2);
 static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
 static DEVICE_ATTR(purr, 0400, show_purr, store_purr);
 static DEVICE_ATTR(pir, 0400, show_pir, NULL);
@@ -760,6 +762,9 @@ static int register_cpu_online(unsigned int cpu)
 	if (cpu_has_feature(CPU_FTR_MMCRA))
 		device_create_file(s, &dev_attr_mmcra);
 
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		device_create_file(s, &dev_attr_mmcr2);
+
 	if (cpu_has_feature(CPU_FTR_PURR)) {
 		if (!firmware_has_feature(FW_FEATURE_LPAR))
 			add_write_permission_dev_attr(&dev_attr_purr);
@@ -845,6 +850,9 @@ static int unregister_cpu_online(unsigned int cpu)
 	if (cpu_has_feature(CPU_FTR_MMCRA))
 		device_remove_file(s, &dev_attr_mmcra);
 
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		device_remove_file(s, &dev_attr_mmcr2);
+
 	if (cpu_has_feature(CPU_FTR_PURR))
 		device_remove_file(s, &dev_attr_purr);
 
-- 
2.7.4
