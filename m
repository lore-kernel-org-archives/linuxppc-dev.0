Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E2EC282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 11:17:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674C8222B5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 11:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674C8222B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zxp51sVvzDqPg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 22:17:49 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zxlG326xzDqLV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 22:15:22 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1DBEHXt086896
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 06:15:20 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qmgt3uycx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 06:15:20 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 13 Feb 2019 11:15:18 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 13 Feb 2019 11:15:16 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1DBFFov16515236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Feb 2019 11:15:15 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CF0A12405A;
 Wed, 13 Feb 2019 11:15:15 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13A48124053;
 Wed, 13 Feb 2019 11:15:13 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.70.157])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 13 Feb 2019 11:15:12 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: [PATCH] powerpc/mm/hash: Increase vmalloc space with hash translation
 mode
Date: Wed, 13 Feb 2019 16:45:09 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021311-0064-0000-0000-000003A809DB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010588; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01160421; UDB=6.00605649; IPR=6.00940975; 
 MB=3.00025559; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-13 11:15:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021311-0065-0000-0000-00003C66C203
Message-Id: <20190213111509.25811-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-13_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902130083
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Michael Ellerman <mpe@ellerman.id.au>

This patch updates the kernel none linear virtual map area size to 512TB
with 64K page size and hash translation mode. We allocate one context
for the vmalloc region and hence the max virtual area size is limited
by the context map size (512TB for 64K and 64TB for 4K page size).

This patch fixes boot failures with large amounts of system RAM where we
need large vmalloc space to handle per cpu allocation.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h  | 30 +++++++++++++++-------
 arch/powerpc/include/asm/book3s/64/radix.h |  5 +---
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 247aff9cc6ba..0a7b7d5bfa86 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -40,22 +40,34 @@
 #else
 #define H_PUD_CACHE_INDEX	(H_PUD_INDEX_SIZE)
 #endif
+
 /*
- * Define the address range of the kernel non-linear virtual area
+ * Define the address range of the kernel non-linear virtual area. In contrast
+ * to the linear mapping, this is managed using the kernel page tables and then
+ * inserted into the hash page table to actually take effect, similarly to user
+ * mappings.
  */
 #define H_KERN_VIRT_START ASM_CONST(0xD000000000000000)
-#define H_KERN_VIRT_SIZE  ASM_CONST(0x0000400000000000) /* 64T */
+/*
+ * Allow virtual mapping of one context size.
+ * 512TB for 64K page size
+ * 64TB for 4K page size
+ */
+#define H_KERN_VIRT_SIZE (1UL << MAX_EA_BITS_PER_CONTEXT)
+/*
+ * 8TB IO mapping size
+ */
+#define H_KERN_IO_SIZE ASM_CONST(0x80000000000) /* 8T */
 
 /*
- * The vmalloc space starts at the beginning of that region, and
- * occupies half of it on hash CPUs and a quarter of it on Book3E
- * (we keep a quarter for the virtual memmap)
+ * The vmalloc space starts at the beginning of the kernel non-linear virtual
+ * region, and occupies 504T (64K) or 56T (4K)
  */
-#define H_VMALLOC_START	H_KERN_VIRT_START
-#define H_VMALLOC_SIZE	ASM_CONST(0x380000000000) /* 56T */
-#define H_VMALLOC_END	(H_VMALLOC_START + H_VMALLOC_SIZE)
+#define H_VMALLOC_START H_KERN_VIRT_START
+#define H_VMALLOC_SIZE (H_KERN_VIRT_SIZE - H_KERN_IO_SIZE)
+#define H_VMALLOC_END (H_VMALLOC_START + H_VMALLOC_SIZE)
 
-#define H_KERN_IO_START	H_VMALLOC_END
+#define H_KERN_IO_START H_VMALLOC_END
 
 /*
  * Region IDs
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 7d1a3d1543fc..c7a0feaa1013 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -104,10 +104,7 @@
 #define RADIX_VMALLOC_START	RADIX_KERN_VIRT_START
 #define RADIX_VMALLOC_SIZE	(RADIX_KERN_VIRT_SIZE >> 2)
 #define RADIX_VMALLOC_END	(RADIX_VMALLOC_START + RADIX_VMALLOC_SIZE)
-/*
- * Defines the address of the vmemap area, in its own region on
- * hash table CPUs.
- */
+
 #define RADIX_VMEMMAP_BASE		(RADIX_VMALLOC_END)
 
 #define RADIX_KERN_IO_START	(RADIX_KERN_VIRT_START + (RADIX_KERN_VIRT_SIZE >> 1))
-- 
2.20.1

