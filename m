Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E604FC282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:02:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033852173C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033852173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kj7g2mbxzDqML
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 23:02:23 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kj4W1Ws7zDqM3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 22:59:38 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3HCnVBW025648
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 08:59:36 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rx4g60bh8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 08:59:35 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 17 Apr 2019 13:59:33 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Apr 2019 13:59:31 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3HCxUOE27000898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Apr 2019 12:59:31 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8970BE059;
 Wed, 17 Apr 2019 12:59:30 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1A11BE053;
 Wed, 17 Apr 2019 12:59:28 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.40.202])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Apr 2019 12:59:28 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v4 1/8] powerpc/mm/hash64: Add a variable to track the end of
 IO mapping
Date: Wed, 17 Apr 2019 18:29:13 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417125920.785-1-aneesh.kumar@linux.ibm.com>
References: <20190417125920.785-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041712-8235-0000-0000-00000E81584C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010943; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01190369; UDB=6.00623770; IPR=6.00971167; 
 MB=3.00026484; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-17 12:59:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041712-8236-0000-0000-0000452E59BD
Message-Id: <20190417125920.785-2-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904170089
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

