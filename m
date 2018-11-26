Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183D1C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 20:53:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6822F205C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 20:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6822F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433fJh3DmdzDqM5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 07:53:24 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 433dz06NdMzDqcM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 07:38:04 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAQKYBXY073498
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 15:38:02 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p0qm8h23s-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 15:38:02 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 26 Nov 2018 20:38:01 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 26 Nov 2018 20:37:59 -0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAQKbw5b16056540
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Nov 2018 20:37:58 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75EB66E053;
 Mon, 26 Nov 2018 20:37:58 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 501156E04E;
 Mon, 26 Nov 2018 20:37:58 +0000 (GMT)
Received: from ltczep4-lp5.aus.stglabs.ibm.com (unknown [9.40.193.67])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 26 Nov 2018 20:37:58 +0000 (GMT)
Received: from ltczep4-lp5.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltczep4-lp5.aus.stglabs.ibm.com (Postfix) with ESMTP id E171940CAA83;
 Mon, 26 Nov 2018 14:37:57 -0600 (CST)
Subject: [Internal Review PATCH] powerpc/pseries: Relocate drmem.h to pseries
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Juliet Kim <minkim@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 26 Nov 2018 14:37:57 -0600
In-Reply-To: <20181126203633.11871.94010.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
References: <20181126203633.11871.94010.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112620-0036-0000-0000-00000A614403
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010125; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123169; UDB=6.00583042; IPR=6.00903298; 
 MB=3.00024341; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-26 20:38:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112620-0037-0000-0000-000049C49C10
Message-Id: <20181126203746.11871.94470.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-26_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=960 adultscore=0 classifier=spam adjust=0 reason=mlx
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

