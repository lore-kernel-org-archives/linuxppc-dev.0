Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295ADC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 20:49:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC86208E7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 20:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC86208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433fCg2x9jzDqcK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 07:49:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433dyK2FTXzDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 07:37:29 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAQKYePY168442
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 15:37:26 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p0nc06uyc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 15:37:26 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 26 Nov 2018 20:37:25 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 26 Nov 2018 20:37:24 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAQKbNxm13107428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Nov 2018 20:37:23 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D49C124055;
 Mon, 26 Nov 2018 20:37:23 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB213124058;
 Mon, 26 Nov 2018 20:37:22 +0000 (GMT)
Received: from ltczep4-lp5.aus.stglabs.ibm.com (unknown [9.40.193.67])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 26 Nov 2018 20:37:22 +0000 (GMT)
Received: from ltczep4-lp5.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltczep4-lp5.aus.stglabs.ibm.com (Postfix) with ESMTP id 7FE1340CAA83;
 Mon, 26 Nov 2018 14:37:22 -0600 (CST)
Subject: [Internal Review PATCH] powerpc/pseries: Move DRMEM processing out
 of prom.c
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Juliet Kim <minkim@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 26 Nov 2018 14:37:22 -0600
In-Reply-To: <20181126203633.11871.94010.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
References: <20181126203633.11871.94010.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112620-0060-0000-0000-000002D90F5B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010125; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123169; UDB=6.00583042; IPR=6.00903298; 
 MB=3.00024341; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-26 20:37:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112620-0061-0000-0000-00004753AD4C
Message-Id: <20181126203709.11871.49572.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-26_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260175
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The implementation of the pseries-specific dynamic memory features
is currently implemented in several non-pseries-specific files.
This patch set moves the implementation of the device-tree parsing
code for the properties ibm,dynamic-memory, ibm,dynamic-memory-v2,
and its representation in the kernel into the platform-specific
directory to the Pseries features.

This patch refactors references to drmem features out of prom.c, so
that they can be moved to drmem.c.  Changes include creating a
platform function platform_early_init_dt_scan_memory_ppc that any
powerpc platform may implement, and moving a support function to
powerpc/include/asm/sparsemem.h

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/platform.h    |   23 ++++++++
 arch/powerpc/include/asm/prom.h        |    3 +
 arch/powerpc/include/asm/sparsemem.h   |   19 +++++++
 arch/powerpc/kernel/prom.c             |   90 +-------------------------------
 arch/powerpc/platforms/pseries/drmem.c |   73 ++++++++++++++++++++++++++
 5 files changed, 122 insertions(+), 86 deletions(-)
 create mode 100644 arch/powerpc/include/asm/platform.h

diff --git a/arch/powerpc/include/asm/platform.h b/arch/powerpc/include/asm/platform.h
new file mode 100644
index 0000000..36f0f9e
--- /dev/null
+++ b/arch/powerpc/include/asm/platform.h
@@ -0,0 +1,23 @@
+#ifndef _POWERPC_PLATFORM_H
+#define _POWERPC_PLATFORM_H
+#ifdef __KERNEL__
+
+/*
+ * Definitions for talking to the Platform-specific functions of PowerPC
+ *
+ * Copyright (C) 2018 Michael Bringmann, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/types.h>
+
+/* Memory initialization support */
+extern int platform_early_init_dt_scan_memory_ppc(unsigned long node,
+						const char *uname,
+						int depth, void *data);
+
+#endif /* __KERNEL__ */
+#endif /* _POWERPC_PLATFORM_H */
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index b04c5ce..4504773 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -180,5 +180,8 @@ extern int of_read_drc_info_cell(struct property **prop,
 /* Option Vector 6: IBM PAPR hints */
 #define OV6_LINUX		0x02	/* Linux is our OS */
 
+/* Other functions */
+extern bool validate_mem_limit(u64 base, u64 *size);
+
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PROM_H */
diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index 68da493..25edfc2 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -32,5 +32,24 @@ static inline int hot_add_scn_to_nid(unsigned long scn_addr)
 #endif /* CONFIG_NUMA */
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
+
+#ifdef CONFIG_SPARSEMEM
+static inline bool validate_mem_limit(u64 base, u64 *size) 
+{
+	u64 max_mem = 1UL << (MAX_PHYSMEM_BITS);
+
+	if (base >= max_mem)
+		return false;
+	if ((base + *size) > max_mem)
+		*size = max_mem - base;
+	return true;
+}
+#else
+static inline bool validate_mem_limit(u64 base, u64 *size) 
+{
+	return true;
+}
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_SPARSEMEM_H */
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index fe758ce..ea32fee 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -58,7 +58,7 @@
 #include <asm/epapr_hcalls.h>
 #include <asm/firmware.h>
 #include <asm/dt_cpu_ftrs.h>
-#include <asm/drmem.h>
+#include <asm/platform.h>
 
 #include <mm/mmu_decl.h>
 
@@ -444,96 +444,14 @@ static int __init early_init_dt_scan_chosen_ppc(unsigned long node,
  * size if it cross the limit.
  */
 
-#ifdef CONFIG_SPARSEMEM
-static bool validate_mem_limit(u64 base, u64 *size)
-{
-	u64 max_mem = 1UL << (MAX_PHYSMEM_BITS);
-
-	if (base >= max_mem)
-		return false;
-	if ((base + *size) > max_mem)
-		*size = max_mem - base;
-	return true;
-}
-#else
-static bool validate_mem_limit(u64 base, u64 *size)
-{
-	return true;
-}
-#endif
-
-#ifdef CONFIG_PPC_PSERIES
-/*
- * Interpret the ibm dynamic reconfiguration memory LMBs.
- * This contains a list of memory blocks along with NUMA affinity
- * information.
- */
-static void __init early_init_drmem_lmb(struct drmem_lmb *lmb,
-					const __be32 **usm)
-{
-	u64 base, size;
-	int is_kexec_kdump = 0, rngs;
-
-	base = lmb->base_addr;
-	size = drmem_lmb_size();
-	rngs = 1;
-
-	/*
-	 * Skip this block if the reserved bit is set in flags
-	 * or if the block is not assigned to this partition.
-	 */
-	if ((lmb->flags & DRCONF_MEM_RESERVED) ||
-	    !(lmb->flags & DRCONF_MEM_ASSIGNED))
-		return;
-
-	if (*usm)
-		is_kexec_kdump = 1;
-
-	if (is_kexec_kdump) {
-		/*
-		 * For each memblock in ibm,dynamic-memory, a
-		 * corresponding entry in linux,drconf-usable-memory
-		 * property contains a counter 'p' followed by 'p'
-		 * (base, size) duple. Now read the counter from
-		 * linux,drconf-usable-memory property
-		 */
-		rngs = dt_mem_next_cell(dt_root_size_cells, usm);
-		if (!rngs) /* there are no (base, size) duple */
-			return;
-	}
-
-	do {
-		if (is_kexec_kdump) {
-			base = dt_mem_next_cell(dt_root_addr_cells, usm);
-			size = dt_mem_next_cell(dt_root_size_cells, usm);
-		}
-
-		if (iommu_is_off) {
-			if (base >= 0x80000000ul)
-				continue;
-			if ((base + size) > 0x80000000ul)
-				size = 0x80000000ul - base;
-		}
-
-		DBG("Adding: %llx -> %llx\n", base, size);
-		if (validate_mem_limit(base, &size))
-			memblock_add(base, size);
-	} while (--rngs);
-}
-#endif /* CONFIG_PPC_PSERIES */
-
 static int __init early_init_dt_scan_memory_ppc(unsigned long node,
 						const char *uname,
 						int depth, void *data)
 {
-#ifdef CONFIG_PPC_PSERIES
-	if (depth == 1 &&
-	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0) {
-		walk_drmem_lmbs_early(node, early_init_drmem_lmb);
+	if (!platform_early_init_dt_scan_memory_ppc(node, uname,
+						depth, data))
 		return 0;
-	}
-#endif
-	
+
 	return early_init_dt_scan_memory(node, uname, depth, data);
 }
 
diff --git a/arch/powerpc/platforms/pseries/drmem.c b/arch/powerpc/platforms/pseries/drmem.c
index 3f18036..ccb0d3b 100644
--- a/arch/powerpc/platforms/pseries/drmem.c
+++ b/arch/powerpc/platforms/pseries/drmem.c
@@ -17,6 +17,7 @@
 #include <linux/memblock.h>
 #include <asm/prom.h>
 #include <asm/drmem.h>
+#include <asm/platform.h>
 
 static struct drmem_lmb_info __drmem_info;
 struct drmem_lmb_info *drmem_info = &__drmem_info;
@@ -445,3 +446,75 @@ static int __init drmem_init(void)
 	return 0;
 }
 late_initcall(drmem_init);
+
+
+/*
+ * Interpret the ibm dynamic reconfiguration memory LMBs.
+ * This contains a list of memory blocks along with NUMA affinity
+ * information.
+ */
+static void __init early_init_drmem_lmb(struct drmem_lmb *lmb,
+					const __be32 **usm)
+{
+	u64 base, size;
+	int is_kexec_kdump = 0, rngs;
+
+	base = lmb->base_addr;
+	size = drmem_lmb_size();
+	rngs = 1;
+
+	/*
+	 * Skip this block if the reserved bit is set in flags
+	 * or if the block is not assigned to this partition.
+	 */
+	if ((lmb->flags & DRCONF_MEM_RESERVED) ||
+	    !(lmb->flags & DRCONF_MEM_ASSIGNED))
+		return;
+
+	if (*usm)
+		is_kexec_kdump = 1;
+
+	if (is_kexec_kdump) {
+		/*
+		 * For each memblock in ibm,dynamic-memory, a
+		 * corresponding entry in linux,drconf-usable-memory
+		 * property contains a counter 'p' followed by 'p'
+		 * (base, size) duple. Now read the counter from
+		 * linux,drconf-usable-memory property
+		 */
+		rngs = dt_mem_next_cell(dt_root_size_cells, usm);
+		if (!rngs) /* there are no (base, size) duple */
+			return;
+	}
+
+	do {
+		if (is_kexec_kdump) {
+			base = dt_mem_next_cell(dt_root_addr_cells, usm);
+			size = dt_mem_next_cell(dt_root_size_cells, usm);
+		}
+
+		if (iommu_is_off) {
+			if (base >= 0x80000000ul)
+				continue;
+			if ((base + size) > 0x80000000ul)
+				size = 0x80000000ul - base;
+		}
+
+		DBG("Adding: %llx -> %llx\n", base, size);
+		if (validate_mem_limit(base, &size))
+			memblock_add(base, size);
+	} while (--rngs);
+}
+
+int __init platform_early_init_dt_scan_memory_ppc(unsigned long node,
+						const char *uname,
+						int depth, void *data)
+{
+	if (depth == 1 &&
+	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0) {
+		walk_drmem_lmbs_early(node, early_init_drmem_lmb);
+		return 0;
+	}
+
+	return -ENODEV;
+}

