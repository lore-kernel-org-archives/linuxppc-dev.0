Return-Path: <SRS0=UD/r=UN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B56C31E4C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Jun 2019 15:51:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329E32168B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Jun 2019 15:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329E32168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45QQ8G3r2vzDrgt
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 01:51:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=naveen.n.rao@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45QQ004pFRzDrPV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2019 01:44:32 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5EFhLPN138819
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2019 11:44:31 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t4c5f6m8n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2019 11:44:30 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 14 Jun 2019 16:44:28 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Jun 2019 16:44:26 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5EFiPfY27590812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jun 2019 15:44:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E392011C050;
 Fri, 14 Jun 2019 15:44:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B13D11C04A;
 Fri, 14 Jun 2019 15:44:23 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.85.70.176])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jun 2019 15:44:23 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 2/9] powerpc/pseries: Do not save the previous DTL mask
 value
Date: Fri, 14 Jun 2019 21:14:00 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560526066.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1560526066.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061415-0016-0000-0000-00000289216C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061415-0017-0000-0000-000032E66335
Message-Id: <bffc6b74c78c3e3bb54cc7fc79816d5f39775db4.1560526066.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-14_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=842 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140130
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Mingming Cao <mingming.cao@ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is enabled, we always initialize
DTL enable mask to DTL_LOG_PREEMPT (0x2). There are no other places
where the mask is changed. As such, when reading the DTL log buffer
through debugfs, there is no need to save and restore the previous mask
value.

We don't need to save and restore the earlier mask value if
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not enabled. So, remove the field
from the structure as well.

Acked-by: Nathan Lynch <nathanl@linux.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dtl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index 337378f3d1fd..a88176afba32 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -42,7 +42,6 @@ struct dtl_ring {
 	struct dtl_entry *write_ptr;
 	struct dtl_entry *buf;
 	struct dtl_entry *buf_end;
-	u8	saved_dtl_mask;
 };
 
 static DEFINE_PER_CPU(struct dtl_ring, dtl_rings);
@@ -92,7 +91,6 @@ static int dtl_start(struct dtl *dtl)
 	dtlr->write_ptr = dtl->buf;
 
 	/* enable event logging */
-	dtlr->saved_dtl_mask = lppaca_of(dtl->cpu).dtl_enable_mask;
 	lppaca_of(dtl->cpu).dtl_enable_mask |= dtl_event_mask;
 
 	dtl_consumer = consume_dtle;
@@ -110,7 +108,7 @@ static void dtl_stop(struct dtl *dtl)
 	dtlr->buf = NULL;
 
 	/* restore dtl_enable_mask */
-	lppaca_of(dtl->cpu).dtl_enable_mask = dtlr->saved_dtl_mask;
+	lppaca_of(dtl->cpu).dtl_enable_mask = DTL_LOG_PREEMPT;
 
 	if (atomic_dec_and_test(&dtl_count))
 		dtl_consumer = NULL;
-- 
2.21.0

