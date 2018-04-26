Return-Path: <srs0=trvj=hp=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WwCn1L0LzF25Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 21:42:29 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40WwCn0TMGz8tF7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 21:42:29 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40WwCm2ypLz9s06
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 21:42:28 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3QBd86O130285
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 07:42:26 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hkd2y2mm5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 07:42:26 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 26 Apr 2018 12:42:24 +0100
Subject: [PATCH v5 3/4] powerpc/fadump: throw proper error message on fadump
 registration failure.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>
Date: Thu, 26 Apr 2018 17:12:19 +0530
In-Reply-To: <152474278043.5697.2553982145593952228.stgit@jupiter.in.ibm.com>
References: <152474278043.5697.2553982145593952228.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152474293927.5697.12873126077341855884.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

fadump fails to register when there are holes in reserved memory area.
This can happen if user has hot-removed a memory that falls in the fadump
reserved memory area. Throw a meaningful error message to the user in
such case.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index d44d89c8967f..16dec2e8bc88 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -227,6 +227,36 @@ static int is_boot_memory_area_contiguous(void)
 	return ret;
 }
 
+/*
+ * Returns 1, if there are no holes in reserved memory area,
+ * 0 otherwise.
+ */
+static int is_reserved_memory_area_contiguous(void)
+{
+	struct memblock_region *reg;
+	unsigned long start, end;
+	unsigned long d_start = fw_dump.reserve_dump_area_start;
+	unsigned long d_end = d_start + fw_dump.reserve_dump_area_size;
+	int ret = 0;
+
+	for_each_memblock(memory, reg) {
+		start = max(d_start, (unsigned long)reg->base);
+		end = min(d_end, (unsigned long)(reg->base + reg->size));
+		if (d_start < end) {
+			/* Memory hole from d_start to start */
+			if (start > d_start)
+				break;
+
+			if (end == d_end) {
+				ret = 1;
+				break;
+			}
+			d_start = end + 1;
+		}
+	}
+	return ret;
+}
+
 /* Print firmware assisted dump configurations for debugging purpose. */
 static void fadump_show_config(void)
 {
@@ -589,6 +619,9 @@ static int register_fw_dump(struct fadump_mem_struct *fdm)
 		if (!is_boot_memory_area_contiguous())
 			pr_err("Can't have holes in boot memory area while "
 			       "registering fadump\n");
+		else if (!is_reserved_memory_area_contiguous())
+			pr_err("Can't have holes in reserved memory area while"
+			       " registering fadump\n");
 
 		printk(KERN_ERR "Failed to register firmware-assisted kernel"
 			" dump. Parameter Error(%d).\n", rc);
