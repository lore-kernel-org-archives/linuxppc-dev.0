Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7380FC282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:27:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FF820645
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FF820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kjhG4CszzDqNJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 23:27:10 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kj9m1N2SzDqB5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 23:04:12 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3HCraWU053874
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 09:04:10 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rx4j30dhg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 09:04:09 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 17 Apr 2019 14:04:08 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Apr 2019 14:04:06 +0100
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3HD45ic28639400
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Apr 2019 13:04:05 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33ADAC6059;
 Wed, 17 Apr 2019 13:04:05 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00EE2C6057;
 Wed, 17 Apr 2019 13:04:02 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.40.202])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Apr 2019 13:04:02 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, paulus@samba.org, mpe@ellerman.id.au,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 2/6] powerpc/mm: Remove PPC_MM_SLICES #ifdef for book3s64
Date: Wed, 17 Apr 2019 18:33:47 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417130351.3805-1-aneesh.kumar@linux.ibm.com>
References: <20190417130351.3805-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041713-0020-0000-0000-00000ED8D0F5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010943; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01190371; UDB=6.00623771; IPR=6.00971169; 
 MB=3.00026484; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-17 13:04:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041713-0021-0000-0000-000065775099
Message-Id: <20190417130351.3805-3-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=879 adultscore=0 classifier=spam adjust=0 reason=mlx
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

Book3s64 always have PPC_MM_SLICES enabled. So remove the unncessary #ifdef

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h   |  4 ----
 arch/powerpc/include/asm/book3s/64/slice.h | 13 -------------
 2 files changed, 17 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 1ceee000c18d..484a8ff9b338 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -123,7 +123,6 @@ typedef struct {
 	/* NPU NMMU context */
 	struct npu_context *npu_context;
 
-#ifdef CONFIG_PPC_MM_SLICES
 	 /* SLB page size encodings*/
 	unsigned char low_slices_psize[BITS_PER_LONG / BITS_PER_BYTE];
 	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
@@ -136,9 +135,6 @@ typedef struct {
 	struct slice_mask mask_16m;
 	struct slice_mask mask_16g;
 # endif
-#else
-	u16 sllp;		/* SLB page size encoding */
-#endif
 	unsigned long vdso_base;
 #ifdef CONFIG_PPC_SUBPAGE_PROT
 	struct subpage_prot_table spt;
diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
index db0dedab65ee..062e11136e9c 100644
--- a/arch/powerpc/include/asm/book3s/64/slice.h
+++ b/arch/powerpc/include/asm/book3s/64/slice.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_POWERPC_BOOK3S_64_SLICE_H
 #define _ASM_POWERPC_BOOK3S_64_SLICE_H
 
-#ifdef CONFIG_PPC_MM_SLICES
-
 #define SLICE_LOW_SHIFT		28
 #define SLICE_LOW_TOP		(0x100000000ul)
 #define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
@@ -13,15 +11,4 @@
 #define SLICE_NUM_HIGH		(H_PGTABLE_RANGE >> SLICE_HIGH_SHIFT)
 #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
 
-#else /* CONFIG_PPC_MM_SLICES */
-
-#define get_slice_psize(mm, addr)	((mm)->context.user_psize)
-#define slice_set_user_psize(mm, psize)		\
-do {						\
-	(mm)->context.user_psize = (psize);	\
-	(mm)->context.sllp = SLB_VSID_USER | mmu_psize_defs[(psize)].sllp; \
-} while (0)
-
-#endif /* CONFIG_PPC_MM_SLICES */
-
 #endif /* _ASM_POWERPC_BOOK3S_64_SLICE_H */
-- 
2.20.1

