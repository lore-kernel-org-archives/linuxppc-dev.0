Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yNdyG6hzFzDqfh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 20:35:01 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9R9YY5P039346
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 05:34:59 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dux744ncr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 05:34:58 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Fri, 27 Oct 2017 10:34:56 +0100
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: [PATCH] powerpc/kernel/sysfs: Export ldbar spr to sysfs
Date: Fri, 27 Oct 2017 15:04:50 +0530
Message-Id: <1509096890-22655-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add ldbar spr to sysfs. The spr will hold thread level In-Memory Collection (IMC)
counter configuration data.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Acked-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 4437c70c7c2b..8efcaece4796 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -466,6 +466,7 @@ static ssize_t __used \
 #ifdef HAS_PPC_PMC_CLASSIC
 SYSFS_PMCSETUP(mmcr0, SPRN_MMCR0);
 SYSFS_PMCSETUP(mmcr1, SPRN_MMCR1);
+SYSFS_PMCSETUP(ldbar, SPRN_LDBAR);
 SYSFS_PMCSETUP(pmc1, SPRN_PMC1);
 SYSFS_PMCSETUP(pmc2, SPRN_PMC2);
 SYSFS_PMCSETUP(pmc3, SPRN_PMC3);
@@ -492,6 +493,7 @@ SYSFS_SPRSETUP(pir, SPRN_PIR);
   Lets be conservative and default to pseries.
 */
 static DEVICE_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
+static DEVICE_ATTR(ldbar, 0600, show_ldbar, store_ldbar);
 static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
 static DEVICE_ATTR(purr, 0400, show_purr, store_purr);
 static DEVICE_ATTR(pir, 0400, show_pir, NULL);
@@ -757,6 +759,9 @@ static int register_cpu_online(unsigned int cpu)
 			device_create_file(s, &pmc_attrs[i]);
 
 #ifdef CONFIG_PPC64
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		device_create_file(s, &dev_attr_ldbar);
+
 	if (cpu_has_feature(CPU_FTR_MMCRA))
 		device_create_file(s, &dev_attr_mmcra);
 
@@ -842,6 +847,9 @@ static int unregister_cpu_online(unsigned int cpu)
 			device_remove_file(s, &pmc_attrs[i]);
 
 #ifdef CONFIG_PPC64
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		device_remove_file(s, &dev_attr_ldbar);
+
 	if (cpu_has_feature(CPU_FTR_MMCRA))
 		device_remove_file(s, &dev_attr_mmcra);
 
-- 
2.14.1
