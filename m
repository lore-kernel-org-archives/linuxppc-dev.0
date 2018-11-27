Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B24EC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 20:39:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24BD208E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 20:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24BD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434Fxj63wdzDqjl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 07:39:05 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 434FsX2q9szDqjZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 07:35:28 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wARKY3HP003867
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 15:35:26 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p1cnah2je-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 15:35:25 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 27 Nov 2018 20:35:25 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 27 Nov 2018 20:35:23 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wARKZMOa19005678
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 27 Nov 2018 20:35:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93E31B2066;
 Tue, 27 Nov 2018 20:35:22 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D31DB205F;
 Tue, 27 Nov 2018 20:35:21 +0000 (GMT)
Received: from oc5000245537.ibm.com (unknown [9.53.179.223])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 27 Nov 2018 20:35:21 +0000 (GMT)
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH 2/4] powerpc/pseries: Move DRMEM processing out of prom.c
Openpgp: preference=signencrypt
Autocrypt: addr=mwb@linux.vnet.ibm.com; prefer-encrypt=mutual; keydata=
 xsBNBFcY7GcBCADzw3en+yzo9ASFGCfldVkIg95SAMPK0myXp2XJYET3zT45uBsX/uj9/2nA
 lBmXXeOSXnPfJ9V3vtiwcfATnWIsVt3tL6n1kqikzH9nXNxZT7MU/7gqzWZngMAWh/GJ9qyg
 DTOZdjsvdUNUWxtiLvBo7y+reA4HjlQhwhYxxvCpXBeRoF0qDWfQ8DkneemqINzDZPwSQ7zY
 t4F5iyN1I9GC5RNK8Y6jiKmm6bDkrrbtXPOtzXKs0J0FqWEIab/u3BDrRP3STDVPdXqViHua
 AjEzthQbGZm0VCxI4a7XjMi99g614/qDcXZCs00GLZ/VYIE8hB9C5Q+l66S60PLjRrxnABEB
 AAHNLU1pY2hhZWwgVy4gQnJpbmdtYW5uIDxtd2JAbGludXgudm5ldC5pYm0uY29tPsLAeAQT
 AQIAIgUCVxjsZwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQSEdag3dpuTI0NAf8
 CKYTDKQLgOSjVrU2L5rM4lXaJRmQV6oidD3vIhKSnWRvPq9C29ifRG6ri20prTHAlc0vycgm
 41HHg0y2vsGgNXGTWC2ObemoZBI7mySXe/7Tq5mD/semGzOp0YWZ7teqrkiSR8Bw0p+LdE7K
 QmT7tpjjvuhrtQ3RRojUYcuy1nWUsc4D+2cxsnZslsx84FUKxPbLagDgZmgBhUw/sUi40s6S
 AkdViVCVS0WANddLIpG0cfdsV0kCae/XdjK3mRK6drFKv1z+QFjvOhc8QIkkxFD0da9w3tJj
 oqnqHFV5gLcHO6/wizPx/NV90y6RngeBORkQiRFWxTXS4Oj9GVI/Us7ATQRXGOxnAQgAmJ5Y
 ikTWrMWPfiveUacETyEhWVl7u8UhZcx3yy2te8O0ay7t9fYcZgIEfQPPVVus89acIXlG3wYL
 DDPvb21OprLxi+ZJ2a0S5we+LcSWN1jByxJlbWBq+/LcMtGAOhNLpysY1gD0Y4UW/eKS+TFZ
 562qKC3k1dBvnV9JXCgeS1taYFxRdVAn+2DwK3nuyG/DDq/XgJ5BtmyC3MMx8CiW3POj+O+l
 6SedIeAfZlZ7/xhijx82g93h07VavUQRwMZgZFsqmuxBxVGiav2HB+dNvs3PFB087Pvc9OHe
 qhajPWOP/gNLMmvBvknn1NToM9a8/E8rzcIZXoYs4RggRRYh6wARAQABwsBfBBgBAgAJBQJX
 GOxnAhsMAAoJEEhHWoN3abky+RUH/jE08/r5QzaNKYeVhu0uVbgXu5fsxqr2cAxhf+KuwT3T
 efhEP2alarxzUZdEh4MsG6c+X2NYLbD3cryiXxVx/7kSAJEFQJfA5P06g8NLR25Qpq9BLsN7
 ++dxQ+CLKzSEb1X24hYAJZpOhS8ev3ii+M/XIo+olDBKuTaTgB6elrg3CaxUsVgLBJ+jbRkW
 yQe2S5f/Ja1ThDpSSLLWLiLK/z7+gaqwhnwjQ8Z8Y9D2itJQcj4itHilwImsqwLG7SxzC0NX
 IQ5KaAFYdRcOgwR8VhhkOIVd70ObSZU+E4pTET1WDz4o65xZ89yfose1No0+r5ht/xWOOrh8
 53/hcWvxHVs=
Organization: IBM Linux Technology Center
Date: Tue, 27 Nov 2018 14:35:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112720-0072-0000-0000-000003D0111C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010132; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123648; UDB=6.00582089; IPR=6.00903777; 
 MB=3.00024358; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-27 20:35:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112720-0073-0000-0000-00004A400774
Message-Id: <26d3e11f-ec62-8d58-0d45-0e836db2231c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-27_17:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270173
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
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>, Juliet Kim <minkim@us.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
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

