Return-Path: <SRS0=IYgH=GR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A06AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 22:12:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B678B22A84
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Jan 2021 22:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B678B22A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DGz7q4ZLNzDsPw
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 09:12:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=nathanl@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=W8ldI+0g; dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DGysq4qz0zDsPv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2021 09:00:15 +1100 (AEDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 10ELWcOF023486; Thu, 14 Jan 2021 17:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=a0XWaV4X1JBvqAlmDy4c/K1A6qjScGXOtcvS+noK1ao=;
 b=W8ldI+0gPbKLqRpsIyjM5fGo3YXDcumfYZZI3o/va2Dxn/y12q3VBE2SERtoSW0MH4Yx
 QY82zprj02/+6ozNfeps22Ot66RAUm7xWqBo88Kmjoj4wX7qj0tsUShxJ/nfM28W6VZM
 KoPSfB8xS4Z9YXRmzv150AnXMRyedyC9AG0JN0jaDko7gzvKa+2bM6AGhCyE6nWLNiOv
 XZpZpqhiIK25hL8YiA/xrLdtLOniAenAuHxZPuuTZLrWO8+r6mF16Rr6DyuBLOwiEMsU
 OPW6gHasYLtezT84SNb4NA8psE+lvazmpOmb19yew50qNv5PGRUdY5mJPJg9NBEECjpc sA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 362vwr24p8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Jan 2021 17:00:09 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10ELwJ7k011122;
 Thu, 14 Jan 2021 22:00:08 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03dal.us.ibm.com with ESMTP id 35y449t7xx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Jan 2021 22:00:08 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 10EM070418088418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Jan 2021 22:00:07 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DFB178069;
 Thu, 14 Jan 2021 22:00:07 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 196257806E;
 Thu, 14 Jan 2021 22:00:07 +0000 (GMT)
Received: from localhost (unknown [9.163.36.68])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 14 Jan 2021 22:00:07 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/6] powerpc/rtas: rename RTAS_RMOBUF_MAX to
 RTAS_USER_REGION_SIZE
Date: Thu, 14 Jan 2021 16:00:03 -0600
Message-Id: <20210114220004.1138993-6-nathanl@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114220004.1138993-1-nathanl@linux.ibm.com>
References: <20210114220004.1138993-1-nathanl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-14_08:2021-01-14,
 2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140124
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
Cc: tyreld@linux.ibm.com, ajd@linux.ibm.com, aik@ozlabs.ru,
 aneesh.kumar@linux.ibm.com, brking@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

RTAS_RMOBUF_MAX doesn't actually describe a "maximum" value in any
sense. It represents the size of an area of memory set aside for user
space to use as work areas for certain RTAS calls.

Rename it to RTAS_USER_REGION, and express the value in terms of the
number of work areas allocated.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>

squash! powerpc/rtas: rename RTAS_RMOBUF_MAX to RTAS_USER_REGION_SIZE
---
 arch/powerpc/include/asm/rtas.h | 9 ++++++---
 arch/powerpc/kernel/rtas-proc.c | 2 +-
 arch/powerpc/kernel/rtas.c      | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 332e1000ca0f..1aa7ab1cbc84 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -19,8 +19,11 @@
 #define RTAS_UNKNOWN_SERVICE (-1)
 #define RTAS_INSTANTIATE_MAX (1ULL<<30) /* Don't instantiate rtas at/above this value */
 
-/* Buffer size for ppc_rtas system call. */
-#define RTAS_RMOBUF_MAX (64 * 1024)
+/* Work areas shared with RTAS must be 4K, naturally aligned. */
+#define RTAS_WORK_AREA_SIZE   4096
+
+/* Work areas allocated for user space access. */
+#define RTAS_USER_REGION_SIZE (RTAS_WORK_AREA_SIZE * 16)
 
 /* RTAS return status codes */
 #define RTAS_BUSY		-2    /* RTAS Busy */
@@ -357,7 +360,7 @@ extern void rtas_take_timebase(void);
 static inline int page_is_rtas_user_buf(unsigned long pfn)
 {
 	unsigned long paddr = (pfn << PAGE_SHIFT);
-	if (paddr >= rtas_rmo_buf && paddr < (rtas_rmo_buf + RTAS_RMOBUF_MAX))
+	if (paddr >= rtas_rmo_buf && paddr < (rtas_rmo_buf + RTAS_USER_REGION_SIZE))
 		return 1;
 	return 0;
 }
diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index d2b0d99824a4..6857a5b0a1c3 100644
--- a/arch/powerpc/kernel/rtas-proc.c
+++ b/arch/powerpc/kernel/rtas-proc.c
@@ -767,6 +767,6 @@ static int ppc_rtas_tone_volume_show(struct seq_file *m, void *v)
  */
 static int ppc_rtas_rmo_buf_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "%016lx %x\n", rtas_rmo_buf, RTAS_RMOBUF_MAX);
+	seq_printf(m, "%016lx %x\n", rtas_rmo_buf, RTAS_USER_REGION_SIZE);
 	return 0;
 }
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 55f6aa170e57..da65faadbbb2 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1204,7 +1204,7 @@ void __init rtas_initialize(void)
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		rtas_region = min(ppc64_rma_size, RTAS_INSTANTIATE_MAX);
 #endif
-	rtas_rmo_buf = memblock_phys_alloc_range(RTAS_RMOBUF_MAX, PAGE_SIZE,
+	rtas_rmo_buf = memblock_phys_alloc_range(RTAS_USER_REGION_SIZE, PAGE_SIZE,
 						 0, rtas_region);
 	if (!rtas_rmo_buf)
 		panic("ERROR: RTAS: Failed to allocate %lx bytes below %pa\n",
-- 
2.29.2

