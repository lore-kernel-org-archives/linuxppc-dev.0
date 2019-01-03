Return-Path: <SRS0=6Lu7=PL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B65C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 16:12:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D918208E3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 16:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D918208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43VtHJ5rQLzDqLP
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 03:12:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=debian.org
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43VtFf5VMjzDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 03:11:12 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x03G4DHl131863
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Jan 2019 11:11:10 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2psn3thvv1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Jan 2019 11:11:09 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Thu, 3 Jan 2019 16:11:08 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 3 Jan 2019 16:11:06 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x03GB5tr8978432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 3 Jan 2019 16:11:05 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B6F5AE05C;
 Thu,  3 Jan 2019 16:11:05 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7E41AE05F;
 Thu,  3 Jan 2019 16:11:03 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.80.232.7])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  3 Jan 2019 16:11:03 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 1/2] selftests/powerpc: Add MSR bits
Date: Thu,  3 Jan 2019 14:11:01 -0200
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19010316-0052-0000-0000-0000037214E6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010338; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01141196; UDB=6.00593919; IPR=6.00921422; 
 MB=3.00024955; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-03 16:11:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010316-0053-0000-0000-00005F5374AD
Message-Id: <1546531862-11926-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-03_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=661 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901030142
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
Cc: Breno Leitao <leitao@debian.org>, mikey@neuling.org,
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch simply adds definitions for the MSR bits and some macros to
test for MSR TM bits.

This was copied from arch/powerpc/include/asm/reg.h generic MSR part.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/powerpc/include/reg.h | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/powerpc/include/reg.h b/tools/testing/selftests/powerpc/include/reg.h
index 52b4710469d2..b67a85404255 100644
--- a/tools/testing/selftests/powerpc/include/reg.h
+++ b/tools/testing/selftests/powerpc/include/reg.h
@@ -77,6 +77,51 @@
 #define TEXASR_TE	0x0000000004000000
 #define TEXASR_ROT	0x0000000002000000
 
+/* MSR register bits */
+#define MSR_SF_LG       63              /* Enable 64 bit mode */
+#define MSR_ISF_LG      61              /* Interrupt 64b mode valid on 630 */
+#define MSR_HV_LG       60              /* Hypervisor state */
+#define MSR_TS_T_LG     34              /* Trans Mem state: Transactional */
+#define MSR_TS_S_LG     33              /* Trans Mem state: Suspended */
+#define MSR_TS_LG       33              /* Trans Mem state (2 bits) */
+#define MSR_TM_LG       32              /* Trans Mem Available */
+#define MSR_VEC_LG      25              /* Enable AltiVec */
+#define MSR_VSX_LG      23              /* Enable VSX */
+#define MSR_POW_LG      18              /* Enable Power Management */
+#define MSR_WE_LG       18              /* Wait State Enable */
+#define MSR_TGPR_LG     17              /* TLB Update registers in use */
+#define MSR_CE_LG       17              /* Critical Interrupt Enable */
+#define MSR_ILE_LG      16              /* Interrupt Little Endian */
+#define MSR_EE_LG       15              /* External Interrupt Enable */
+#define MSR_PR_LG       14              /* Problem State / Privilege Level */
+#define MSR_FP_LG       13              /* Floating Point enable */
+#define MSR_ME_LG       12              /* Machine Check Enable */
+#define MSR_FE0_LG      11              /* Floating Exception mode 0 */
+#define MSR_SE_LG       10              /* Single Step */
+#define MSR_BE_LG       9               /* Branch Trace */
+#define MSR_DE_LG       9               /* Debug Exception Enable */
+#define MSR_FE1_LG      8               /* Floating Exception mode 1 */
+#define MSR_IP_LG       6               /* Exception prefix 0x000/0xFFF */
+#define MSR_IR_LG       5               /* Instruction Relocate */
+#define MSR_DR_LG       4               /* Data Relocate */
+#define MSR_PE_LG       3               /* Protection Enable */
+#define MSR_PX_LG       2               /* Protection Exclusive Mode */
+#define MSR_PMM_LG      2               /* Performance monitor */
+#define MSR_RI_LG       1               /* Recoverable Exception */
+#define MSR_LE_LG       0               /* Little Endian */
+
+#ifdef __ASSEMBLY__
+#define __MASK(X)       (1<<(X))
+#else
+#define __MASK(X)       (1UL<<(X))
+#endif
+
+/* macros to check TM MSR bits */
+#define MSR_TM          __MASK(MSR_TM_LG)     /* Transactional Mem Available */
+#define MSR_TS_S        __MASK(MSR_TS_S_LG)   /* Transaction Suspended */
+#define MSR_TS_T        __MASK(MSR_TS_T_LG)   /* Transaction Transactional */
+#define MSR_TS_MASK     (MSR_TS_T | MSR_TS_S) /* Transaction State bits */
+
 /* Vector Instructions */
 #define VSX_XX1(xs, ra, rb)	(((xs) & 0x1f) << 21 | ((ra) << 16) |  \
 				 ((rb) << 11) | (((xs) >> 5)))
-- 
2.19.0

