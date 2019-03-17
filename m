Return-Path: <SRS0=npwJ=RU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E585C10F05
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 15:52:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25FDC20896
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 15:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FDC20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44MkMx1dr1zDqP6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 02:52:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44MkJ63b7JzDqDL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 02:48:54 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2HFiLEg058645
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Mar 2019 11:48:52 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r9e229ryx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Mar 2019 11:48:52 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Sun, 17 Mar 2019 15:48:51 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 17 Mar 2019 15:48:48 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2HFmlsk20840466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 17 Mar 2019 15:48:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6925BB2064;
 Sun, 17 Mar 2019 15:48:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16B28B205F;
 Sun, 17 Mar 2019 15:48:45 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.84.106])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Sun, 17 Mar 2019 15:48:44 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: [PATCH v2 1/5] powerpc/mm/hash64: Add a variable to track the end of
 IO mapping
Date: Sun, 17 Mar 2019 21:18:23 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190317154827.9188-1-aneesh.kumar@linux.ibm.com>
References: <20190317154827.9188-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031715-0072-0000-0000-0000040C5E74
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010774; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01175713; UDB=6.00614895; IPR=6.00956389; 
 MB=3.00026019; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-17 15:48:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031715-0073-0000-0000-00004B84D488
Message-Id: <20190317154827.9188-2-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-17_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903170123
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This makes it easy to update the region mapping in the later patch

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 3 ++-
 arch/powerpc/include/asm/book3s/64/pgtable.h | 8 +++++---
 arch/powerpc/include/asm/book3s/64/radix.h   | 1 +
 arch/powerpc/mm/hash_utils_64.c              | 1 +
 arch/powerpc/mm/pgtable-radix.c              | 1 +
 arch/powerpc/mm/pgtable_64.c                 | 2 ++
 6 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 54b7af6cd27f..8cbc4106d449 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -69,7 +69,8 @@
 #define H_VMALLOC_SIZE (H_KERN_VIRT_SIZE - H_KERN_IO_SIZE)
 #define H_VMALLOC_END  (H_VMALLOC_START + H_VMALLOC_SIZE)
 
-#define H_KERN_IO_START H_VMALLOC_END
+#define H_KERN_IO_START	H_VMALLOC_END
+#define H_KERN_IO_END	(H_KERN_VIRT_START + H_KERN_VIRT_SIZE)
 
 /*
  * Region IDs
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 581f91be9dd4..51190a6d1c8a 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -277,9 +277,12 @@ extern unsigned long __vmalloc_end;
 extern unsigned long __kernel_virt_start;
 extern unsigned long __kernel_virt_size;
 extern unsigned long __kernel_io_start;
+extern unsigned long __kernel_io_end;
 #define KERN_VIRT_START __kernel_virt_start
 #define KERN_VIRT_SIZE  __kernel_virt_size
 #define KERN_IO_START  __kernel_io_start
+#define KERN_IO_END __kernel_io_end
+
 extern struct page *vmemmap;
 extern unsigned long ioremap_bot;
 extern unsigned long pci_io_base;
@@ -296,8 +299,7 @@ extern unsigned long pci_io_base;
 
 #include <asm/barrier.h>
 /*
- * The second half of the kernel virtual space is used for IO mappings,
- * it's itself carved into the PIO region (ISA and PHB IO space) and
+ * IO space itself carved into the PIO region (ISA and PHB IO space) and
  * the ioremap space
  *
  *  ISA_IO_BASE = KERN_IO_START, 64K reserved area
@@ -310,7 +312,7 @@ extern unsigned long pci_io_base;
 #define  PHB_IO_BASE	(ISA_IO_END)
 #define  PHB_IO_END	(KERN_IO_START + FULL_IO_SIZE)
 #define IOREMAP_BASE	(PHB_IO_END)
-#define IOREMAP_END	(KERN_VIRT_START + KERN_VIRT_SIZE)
+#define IOREMAP_END	(KERN_IO_END)
 
 /* Advertise special mapping type for AGP */
 #define HAVE_PAGE_AGP
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 5ab134eeed20..6d760a083d62 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -111,6 +111,7 @@
 #define RADIX_VMEMMAP_BASE		(RADIX_VMALLOC_END)
 
 #define RADIX_KERN_IO_START	(RADIX_KERN_VIRT_START + (RADIX_KERN_VIRT_SIZE >> 1))
+#define RADIX_KERN_IO_END       (RADIX_KERN_VIRT_START + RADIX_KERN_VIRT_SIZE)
 
 #ifndef __ASSEMBLY__
 #define RADIX_PTE_TABLE_SIZE	(sizeof(pte_t) << RADIX_PTE_INDEX_SIZE)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0a4f939a8161..394dd969002f 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1017,6 +1017,7 @@ void __init hash__early_init_mmu(void)
 	__vmalloc_start = H_VMALLOC_START;
 	__vmalloc_end = H_VMALLOC_END;
 	__kernel_io_start = H_KERN_IO_START;
+	__kernel_io_end = H_KERN_IO_END;
 	vmemmap = (struct page *)H_VMEMMAP_BASE;
 	ioremap_bot = IOREMAP_BASE;
 
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 154472a28c77..bca1bf66c56e 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -578,6 +578,7 @@ void __init radix__early_init_mmu(void)
 	__vmalloc_start = RADIX_VMALLOC_START;
 	__vmalloc_end = RADIX_VMALLOC_END;
 	__kernel_io_start = RADIX_KERN_IO_START;
+	__kernel_io_end = RADIX_KERN_IO_END;
 	vmemmap = (struct page *)RADIX_VMEMMAP_BASE;
 	ioremap_bot = IOREMAP_BASE;
 
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index fb1375c07e8c..7cea39bdf05f 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -98,6 +98,8 @@ unsigned long __vmalloc_end;
 EXPORT_SYMBOL(__vmalloc_end);
 unsigned long __kernel_io_start;
 EXPORT_SYMBOL(__kernel_io_start);
+unsigned long __kernel_io_end;
+EXPORT_SYMBOL(__kernel_io_end);
 struct page *vmemmap;
 EXPORT_SYMBOL(vmemmap);
 unsigned long __pte_frag_nr;
-- 
2.20.1

