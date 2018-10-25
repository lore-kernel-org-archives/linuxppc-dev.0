Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF20C46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 20:33:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2622054F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 20:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2622054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gzNf1SrPzF3G0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 07:33:38 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gzDB6jJpzF3FN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 07:26:18 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9PKOnPd042108
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 16:26:17 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nbgm1kum5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 16:26:16 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 25 Oct 2018 21:26:14 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 25 Oct 2018 21:26:12 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9PKQBEb65929348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Oct 2018 20:26:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEE675204E;
 Thu, 25 Oct 2018 20:26:11 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.79.235.97])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2F12F52050;
 Thu, 25 Oct 2018 20:26:10 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>, 
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Jeremy Kerr <jk@ozlabs.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v1 3/5] powerpc/pseries: Fix stolen time accounting when dtl
 debugfs is used
Date: Fri, 26 Oct 2018 01:55:44 +0530
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1540488386.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1540488386.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18102520-0028-0000-0000-0000030D5BEE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102520-0029-0000-0000-000023C972DA
Message-Id: <16929569199445cd09d9142505b2349620328b38.1540488386.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-25_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
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

When the dtl debugfs interface is used, we usually set the
dtl_enable_mask to 0x7 (DTL_LOG_ALL). When this happens, we start seeing
DTL entries for all preempt reasons, including CEDE. In
scan_dispatch_log(), we add up the times from all entries and account
those towards stolen time. However, we should only be accounting stolen
time when the preemption was due to HDEC at the end of our time slice.

Fix this by checking for the dispatch reason in the DTL entry before
adding to the stolen time.

Fixes: cf9efce0ce313 ("powerpc: Account time using timebase rather than PURR")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/time.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 40868f3ee113..923abc3e555d 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -199,7 +199,7 @@ static u64 scan_dispatch_log(u64 stop_tb)
 	struct lppaca *vpa = local_paca->lppaca_ptr;
 	u64 tb_delta;
 	u64 stolen = 0;
-	u64 dtb;
+	u64 dtb, dispatch_reason;
 
 	if (!dtl)
 		return 0;
@@ -210,6 +210,7 @@ static u64 scan_dispatch_log(u64 stop_tb)
 		dtb = be64_to_cpu(dtl->timebase);
 		tb_delta = be32_to_cpu(dtl->enqueue_to_dispatch_time) +
 			be32_to_cpu(dtl->ready_to_enqueue_time);
+		dispatch_reason = dtl->dispatch_reason;
 		barrier();
 		if (i + N_DISPATCH_LOG < be64_to_cpu(vpa->dtl_idx)) {
 			/* buffer has overflowed */
@@ -221,7 +222,9 @@ static u64 scan_dispatch_log(u64 stop_tb)
 			break;
 		if (dtl_consumer)
 			dtl_consumer(dtl, i);
-		stolen += tb_delta;
+		/* 7 indicates that this dispatch follows a time slice preempt */
+		if (dispatch_reason == 7)
+			stolen += tb_delta;
 		++i;
 		++dtl;
 		if (dtl == dtl_end)
-- 
2.19.1

