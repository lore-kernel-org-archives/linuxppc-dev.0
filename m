Return-Path: <srs0=b3cw=ld=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41v69q07glzF1bR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 18:17:35 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41v69p6ZrCz8x2C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 18:17:34 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41v69p3FBSz9s5c
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2018 18:17:34 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7K8E1b5110853
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2018 04:17:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kysjmh1w9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2018 04:17:32 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 20 Aug 2018 09:17:30 +0100
Subject: [PATCH v7 2/3] powerpc/fadump: throw proper error message on fadump
 registration failure.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Ananth Narayan <ananth@in.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, kernelfans@gmail.com
Date: Mon, 20 Aug 2018 13:47:24 +0530
In-Reply-To: <153475298147.22527.9680437074324546897.stgit@jupiter.in.ibm.com>
References: <153475298147.22527.9680437074324546897.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153475304473.22527.6346461873197204245.stgit@jupiter.in.ibm.com>
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
index 166e71635921..44a29e4d419c 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -234,6 +234,36 @@ static int is_boot_memory_area_contiguous(void)
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
@@ -602,6 +632,9 @@ static int register_fw_dump(struct fadump_mem_struct *fdm)
 		if (!is_boot_memory_area_contiguous())
 			pr_err("Can't have holes in boot memory area while "
 			       "registering fadump\n");
+		else if (!is_reserved_memory_area_contiguous())
+			pr_err("Can't have holes in reserved memory area while"
+			       " registering fadump\n");
 
 		printk(KERN_ERR "Failed to register firmware-assisted kernel"
 			" dump. Parameter Error(%d).\n", rc);
