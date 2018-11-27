Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F9EC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 20:43:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491712086B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 20:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491712086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434G2t3d1tzDqjL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 07:43:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434Fy42TsBzDqZC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 07:39:24 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wARKdLDM033155
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 15:39:22 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p1auync7g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 15:39:20 -0500
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 27 Nov 2018 20:39:13 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 27 Nov 2018 20:39:11 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wARKdApQ19529938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 27 Nov 2018 20:39:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EE0BB2064;
 Tue, 27 Nov 2018 20:39:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7E6EB2066;
 Tue, 27 Nov 2018 20:39:09 +0000 (GMT)
Received: from oc5000245537.ibm.com (unknown [9.53.179.223])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 27 Nov 2018 20:39:09 +0000 (GMT)
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20181127203129.12853.49746.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH 4/4] powerpc/pseries: Relocate drmem.h to pseries
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
Date: Tue, 27 Nov 2018 14:39:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112720-0068-0000-0000-00000367E5D2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010132; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123649; UDB=6.00583330; IPR=6.00903778; 
 MB=3.00024358; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-27 20:39:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112720-0069-0000-0000-00004691A012
Message-Id: <d2cf1dd9-3fee-739a-cde6-b38fadb48e41@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-27_17:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=857 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270174
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

This patch moves drmem.h from directory arch/powerpc/include/asm to
arch/powerpc/platforms/pseries, and fixing include file references
in pseries files.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/drmem.h                |  107 -----------------------
 arch/powerpc/platforms/pseries/drmem.c          |    2 
 arch/powerpc/platforms/pseries/drmem.h          |  107 +++++++++++++++++++++++
 arch/powerpc/platforms/pseries/hotplug-memory.c |    2 
 arch/powerpc/platforms/pseries/lparcfg.c        |    2 
 5 files changed, 110 insertions(+), 110 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/drmem.h
 create mode 100644 arch/powerpc/platforms/pseries/drmem.h

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
deleted file mode 100644
index 7c1d8e7..0000000
--- a/arch/powerpc/include/asm/drmem.h
+++ /dev/null
@@ -1,107 +0,0 @@
-/*
- * drmem.h: Power specific logical memory block representation
- *
- * Copyright 2017 IBM Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifndef _ASM_POWERPC_LMB_H
-#define _ASM_POWERPC_LMB_H
-
-struct drmem_lmb {
-	u64     base_addr;
-	u32     drc_index;
-	u32     aa_index;
-	u32     flags;
-};
-
-struct drmem_lmb_info {
-	struct drmem_lmb        *lmbs;
-	int                     n_lmbs;
-	u32                     lmb_size;
-};
-
-extern struct drmem_lmb_info *drmem_info;
-
-#define for_each_drmem_lmb_in_range(lmb, start, end)		\
-	for ((lmb) = (start); (lmb) <= (end); (lmb)++)
-
-#define for_each_drmem_lmb(lmb)					\
-	for_each_drmem_lmb_in_range((lmb),			\
-		&drmem_info->lmbs[0],				\
-		&drmem_info->lmbs[drmem_info->n_lmbs - 1])
-
-/*
- * The of_drconf_cell_v1 struct defines the layout of the LMB data
- * specified in the ibm,dynamic-memory device tree property.
- * The property itself is a 32-bit value specifying the number of
- * LMBs followed by an array of of_drconf_cell_v1 entries, one
- * per LMB.
- */
-struct of_drconf_cell_v1 {
-	__be64	base_addr;
-	__be32	drc_index;
-	__be32	reserved;
-	__be32	aa_index;
-	__be32	flags;
-};
-
-/*
- * Version 2 of the ibm,dynamic-memory property is defined as a
- * 32-bit value specifying the number of LMB sets followed by an
- * array of of_drconf_cell_v2 entries, one per LMB set.
- */
-struct of_drconf_cell_v2 {
-	u32	seq_lmbs;
-	u64	base_addr;
-	u32	drc_index;
-	u32	aa_index;
-	u32	flags;
-} __packed;
-
-#define DRCONF_MEM_ASSIGNED	0x00000008
-#define DRCONF_MEM_AI_INVALID	0x00000040
-#define DRCONF_MEM_RESERVED	0x00000080
-
-static inline u32 drmem_lmb_size(void)
-{
-	return drmem_info->lmb_size;
-}
-
-#define DRMEM_LMB_RESERVED	0x80000000
-
-static inline void drmem_mark_lmb_reserved(struct drmem_lmb *lmb)
-{
-	lmb->flags |= DRMEM_LMB_RESERVED;
-}
-
-static inline void drmem_remove_lmb_reservation(struct drmem_lmb *lmb)
-{
-	lmb->flags &= ~DRMEM_LMB_RESERVED;
-}
-
-static inline bool drmem_lmb_reserved(struct drmem_lmb *lmb)
-{
-	return lmb->flags & DRMEM_LMB_RESERVED;
-}
-
-u64 drmem_lmb_memory_max(void);
-void __init walk_drmem_lmbs(struct device_node *dn,
-			void (*func)(struct drmem_lmb *, const __be32 **));
-int drmem_update_dt(void);
-
-#ifdef CONFIG_PPC_PSERIES
-void __init walk_drmem_lmbs_early(unsigned long node,
-			void (*func)(struct drmem_lmb *, const __be32 **));
-#endif
-
-static inline void invalidate_lmb_associativity_index(struct drmem_lmb *lmb)
-{
-	lmb->aa_index = 0xffffffff;
-}
-
-#endif /* _ASM_POWERPC_LMB_H */
diff --git a/arch/powerpc/platforms/pseries/drmem.c b/arch/powerpc/platforms/pseries/drmem.c
index 01ac651..a52f10e 100644
--- a/arch/powerpc/platforms/pseries/drmem.c
+++ b/arch/powerpc/platforms/pseries/drmem.c
@@ -17,7 +17,7 @@
 #include <linux/memblock.h>
 #include <asm/prom.h>
 #include <asm/iommu.h>
-#include <asm/drmem.h>
+#include "drmem.h"
 
 static struct drmem_lmb_info __drmem_info;
 struct drmem_lmb_info *drmem_info = &__drmem_info;
diff --git a/arch/powerpc/platforms/pseries/drmem.h b/arch/powerpc/platforms/pseries/drmem.h
new file mode 100644
index 0000000..7c1d8e7
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/drmem.h
@@ -0,0 +1,107 @@
+/*
+ * drmem.h: Power specific logical memory block representation
+ *
+ * Copyright 2017 IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_POWERPC_LMB_H
+#define _ASM_POWERPC_LMB_H
+
+struct drmem_lmb {
+	u64     base_addr;
+	u32     drc_index;
+	u32     aa_index;
+	u32     flags;
+};
+
+struct drmem_lmb_info {
+	struct drmem_lmb        *lmbs;
+	int                     n_lmbs;
+	u32                     lmb_size;
+};
+
+extern struct drmem_lmb_info *drmem_info;
+
+#define for_each_drmem_lmb_in_range(lmb, start, end)		\
+	for ((lmb) = (start); (lmb) <= (end); (lmb)++)
+
+#define for_each_drmem_lmb(lmb)					\
+	for_each_drmem_lmb_in_range((lmb),			\
+		&drmem_info->lmbs[0],				\
+		&drmem_info->lmbs[drmem_info->n_lmbs - 1])
+
+/*
+ * The of_drconf_cell_v1 struct defines the layout of the LMB data
+ * specified in the ibm,dynamic-memory device tree property.
+ * The property itself is a 32-bit value specifying the number of
+ * LMBs followed by an array of of_drconf_cell_v1 entries, one
+ * per LMB.
+ */
+struct of_drconf_cell_v1 {
+	__be64	base_addr;
+	__be32	drc_index;
+	__be32	reserved;
+	__be32	aa_index;
+	__be32	flags;
+};
+
+/*
+ * Version 2 of the ibm,dynamic-memory property is defined as a
+ * 32-bit value specifying the number of LMB sets followed by an
+ * array of of_drconf_cell_v2 entries, one per LMB set.
+ */
+struct of_drconf_cell_v2 {
+	u32	seq_lmbs;
+	u64	base_addr;
+	u32	drc_index;
+	u32	aa_index;
+	u32	flags;
+} __packed;
+
+#define DRCONF_MEM_ASSIGNED	0x00000008
+#define DRCONF_MEM_AI_INVALID	0x00000040
+#define DRCONF_MEM_RESERVED	0x00000080
+
+static inline u32 drmem_lmb_size(void)
+{
+	return drmem_info->lmb_size;
+}
+
+#define DRMEM_LMB_RESERVED	0x80000000
+
+static inline void drmem_mark_lmb_reserved(struct drmem_lmb *lmb)
+{
+	lmb->flags |= DRMEM_LMB_RESERVED;
+}
+
+static inline void drmem_remove_lmb_reservation(struct drmem_lmb *lmb)
+{
+	lmb->flags &= ~DRMEM_LMB_RESERVED;
+}
+
+static inline bool drmem_lmb_reserved(struct drmem_lmb *lmb)
+{
+	return lmb->flags & DRMEM_LMB_RESERVED;
+}
+
+u64 drmem_lmb_memory_max(void);
+void __init walk_drmem_lmbs(struct device_node *dn,
+			void (*func)(struct drmem_lmb *, const __be32 **));
+int drmem_update_dt(void);
+
+#ifdef CONFIG_PPC_PSERIES
+void __init walk_drmem_lmbs_early(unsigned long node,
+			void (*func)(struct drmem_lmb *, const __be32 **));
+#endif
+
+static inline void invalidate_lmb_associativity_index(struct drmem_lmb *lmb)
+{
+	lmb->aa_index = 0xffffffff;
+}
+
+#endif /* _ASM_POWERPC_LMB_H */
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 2a983b5..988d67e4 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -23,7 +23,7 @@
 #include <asm/prom.h>
 #include <asm/sparsemem.h>
 #include <asm/fadump.h>
-#include <asm/drmem.h>
+#include "drmem.h"
 #include "pseries.h"
 
 static bool rtas_hp_event;
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 7944873..28d931e 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -37,8 +37,8 @@
 #include <asm/vio.h>
 #include <asm/mmu.h>
 #include <asm/machdep.h>
-#include <asm/drmem.h>
 
+#include "drmem.h"
 #include "pseries.h"
 
 /*

