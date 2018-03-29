Return-Path: <srs0=kku8=gt=linux.vnet.ibm.com=prvs=06262cf245=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BWF86FNfzDr2b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 14:58:20 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40BWF85PfPz8t5N
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 14:58:20 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40BWF80yCVz9ryk
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2018 14:58:19 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2T3sH9X061347
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2018 23:58:18 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h0j00cu82-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2018 23:58:17 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 29 Mar 2018 04:58:16 +0100
Subject: [PATCH v2 2/4] powerpc/fadump: exclude memory holes while reserving
 memory in second kernel.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 29 Mar 2018 09:28:11 +0530
In-Reply-To: <152229586004.24399.4092811524123468871.stgit@jupiter.in.ibm.com>
References: <152229586004.24399.4092811524123468871.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152229588763.24399.14079441283125240496.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

The second kernel, during early boot after the crash, reserves rest of
the memory above boot memory size to make sure it does not touch any of the
dump memory area. It uses memblock_reserve() that reserves the specified
memory region irrespective of memory holes present within that region.
There are chances where previous kernel would have hot removed some of
its memory leaving memory holes behind. In such cases fadump kernel reports
incorrect number of reserved pages through arch_reserved_kernel_pages() hook
causing kernel to hang or panic.

Fix this by excluding memory holes while reserving rest of the memory
above boot memory size during second kernel boot after crash.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 2098583c935f..9d75619cac28 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -434,6 +434,23 @@ static inline unsigned long get_fadump_metadata_base(
 			be64_to_cpu(fdm_active->rmr_region.source_len));
 }
 
+static void fadump_memblock_reserve(unsigned long base, unsigned long size)
+{
+	struct memblock_region *reg;
+	unsigned long start, end;
+
+	for_each_memblock(memory, reg) {
+		start = (unsigned long)reg->base;
+		end = start + (unsigned long)reg->size;
+
+		if ((start >= base) && (start < (base + size))) {
+			if (end > (base + size))
+				end = base + size;
+			memblock_reserve(start, end - start);
+		}
+	}
+}
+
 int __init fadump_reserve_mem(void)
 {
 	unsigned long base, size, memory_boundary;
@@ -488,7 +505,7 @@ int __init fadump_reserve_mem(void)
 		 */
 		base = fw_dump.boot_memory_size;
 		size = memory_boundary - base;
-		memblock_reserve(base, size);
+		fadump_memblock_reserve(base, size);
 		printk(KERN_INFO "Reserved %ldMB of memory at %ldMB "
 				"for saving crash dump\n",
 				(unsigned long)(size >> 20),
