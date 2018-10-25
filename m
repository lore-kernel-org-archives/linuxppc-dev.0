Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD78C46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 20:31:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B6A2054F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 20:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B6A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gzLK2RW0zF3D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 07:31:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gzDB0CHHzF3CJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 07:26:17 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9PKOdol084028
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 16:26:15 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nbhmq8py5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 16:26:15 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 25 Oct 2018 21:26:13 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 25 Oct 2018 21:26:09 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9PKQ8mR34996406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Oct 2018 20:26:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB79C5204F;
 Thu, 25 Oct 2018 20:26:08 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.79.235.97])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4FCA852051;
 Thu, 25 Oct 2018 20:26:07 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>, 
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Jeremy Kerr <jk@ozlabs.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v1 2/5] powerpc/pseries: Do not save the previous DTL mask
 value
Date: Fri, 26 Oct 2018 01:55:43 +0530
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1540488386.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1540488386.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18102520-4275-0000-0000-000002D3D023
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102520-4276-0000-0000-000037DFE0DE
Message-Id: <4119c6283cd3d8234f95e2d91e65a82a2063b4a5.1540488386.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-25_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=910 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810250167
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
Cc: linuxppc-dev@lists.ozlabs.org
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

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dtl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index 051ea2de1e1a..fb05804adb2f 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -55,7 +55,6 @@ struct dtl_ring {
 	struct dtl_entry *write_ptr;
 	struct dtl_entry *buf;
 	struct dtl_entry *buf_end;
-	u8	saved_dtl_mask;
 };
 
 static DEFINE_PER_CPU(struct dtl_ring, dtl_rings);
@@ -105,7 +104,6 @@ static int dtl_start(struct dtl *dtl)
 	dtlr->write_ptr = dtl->buf;
 
 	/* enable event logging */
-	dtlr->saved_dtl_mask = lppaca_of(dtl->cpu).dtl_enable_mask;
 	lppaca_of(dtl->cpu).dtl_enable_mask |= dtl_event_mask;
 
 	dtl_consumer = consume_dtle;
@@ -123,7 +121,7 @@ static void dtl_stop(struct dtl *dtl)
 	dtlr->buf = NULL;
 
 	/* restore dtl_enable_mask */
-	lppaca_of(dtl->cpu).dtl_enable_mask = dtlr->saved_dtl_mask;
+	lppaca_of(dtl->cpu).dtl_enable_mask = DTL_LOG_PREEMPT;
 
 	if (atomic_dec_and_test(&dtl_count))
 		dtl_consumer = NULL;
-- 
2.19.1

