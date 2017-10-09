Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9W4V0YZ7zDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Oct 2017 17:46:49 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v996i6P0056211
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 02:46:47 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dg3xe8drp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 02:46:47 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 9 Oct 2017 07:46:45 +0100
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v996kfKQ19726484
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 06:46:42 GMT
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v996keoL002214
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 17:46:41 +1100
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH] powerpc/powernv: Add kernel cmdline parameter to disable imc
Date: Mon,  9 Oct 2017 12:16:37 +0530
Message-Id: <1507531597-25947-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a kernel command line parameter option to disable In-Memory Collection
(IMC) counters and add documentation. This helps in debug.
 
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-By: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++
 arch/powerpc/platforms/powernv/opal-imc.c       | 35 +++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0549662..06a8da1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -820,6 +820,13 @@
 	disable_ipv6=	[IPV6]
 			See Documentation/networking/ipv6.txt.
 
+	disable_imc=	[PPC]
+			Format {nest | core | all}
+			Disable imc counters during boot.
+			nest----- Disable nest-imc counters.
+			core----- Disable core and thread imc counters.
+			all------ Disable nest, core and thread imc counters.
+
 	disable_mtrr_cleanup [X86]
 			The kernel tries to adjust MTRR layout from continuous
 			to discrete, to make X server driver able to add WB
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 21f6531..e929f33 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -22,6 +22,28 @@
 #include <asm/imc-pmu.h>
 #include <asm/cputhreads.h>
 
+static bool disable_nest_imc;
+static bool disable_core_imc;
+
+/*
+ * diasble_imc=nest: skip the registration of nest pmus.
+ * disable_imc=core: skip the registration of core and thread pmus.
+ * disable_imc=all : disables nest, core and thread.
+ */
+static int __init disable_imc_counters(char *p)
+{
+	if (strncmp(p, "nest", 4) == 0)
+		disable_nest_imc = true;
+	else if (strncmp(p, "core", 4) == 0)
+		disable_core_imc = true;
+	else if (strncmp(p, "all", 3) == 0) {
+		disable_nest_imc = true;
+		disable_core_imc = true;
+	}
+	return 0;
+}
+early_param("disable_imc", disable_imc_counters);
+
 /*
  * imc_get_mem_addr_nest: Function to get nest counter memory region
  * for each chip
@@ -169,6 +191,10 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/* If kernel is booted with disable_imc parameters, then return */
+	if (disable_nest_imc && disable_core_imc)
+		return -ENODEV;
+
 	for_each_compatible_node(imc_dev, NULL, IMC_DTB_UNIT_COMPAT) {
 		if (of_property_read_u32(imc_dev, "type", &type)) {
 			pr_warn("IMC Device without type property\n");
@@ -177,12 +203,21 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 
 		switch (type) {
 		case IMC_TYPE_CHIP:
+			if (disable_nest_imc)
+				continue;
+
 			domain = IMC_DOMAIN_NEST;
 			break;
 		case IMC_TYPE_CORE:
+			if (disable_core_imc)
+				continue;
+
 			domain =IMC_DOMAIN_CORE;
 			break;
 		case IMC_TYPE_THREAD:
+			if (disable_core_imc)
+				continue;
+
 			domain = IMC_DOMAIN_THREAD;
 			break;
 		default:
-- 
2.7.4
