Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED42AC46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 08:07:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F80A20652
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 08:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F80A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fQwB6rNvzF36n
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 19:07:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=naveen.n.rao@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fQt01VzDzF1Cr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 19:05:11 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9N84Rcd113569
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 04:05:09 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n9vvs7f2g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 04:05:08 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 23 Oct 2018 09:05:07 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 23 Oct 2018 09:05:05 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9N854fR29425908
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 23 Oct 2018 08:05:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7701A4057;
 Tue, 23 Oct 2018 08:05:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEEF7A405D;
 Tue, 23 Oct 2018 08:05:03 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.77.121.203])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 23 Oct 2018 08:05:03 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH] selftests/powerpc: Relax L1d miss targets for rfi_flush test
Date: Tue, 23 Oct 2018 13:34:56 +0530
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18102308-4275-0000-0000-000002D23CBF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102308-4276-0000-0000-000037DE3EA1
Message-Id: <20181023080456.2558-1-naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-23_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810230072
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

When running the rfi_flush test, if the system is loaded, we see two
issues:
1. The L1d misses when rfi_flush is disabled increase significantly due
to other workloads interfering with the cache.
2. The L1d misses when rfi_flush is enabled sometimes goes slightly
below the expected number of misses.

To address these, let's relax the expected number of L1d misses:
1. When rfi_flush is disabled, we allow upto half the expected number of
the misses for when rfi_flush is enabled.
2. When rfi_flush is enabled, we allow ~1% lower number of cache misses.

Reported-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 .../selftests/powerpc/security/rfi_flush.c     | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/powerpc/security/rfi_flush.c b/tools/testing/selftests/powerpc/security/rfi_flush.c
index 564ed45bbf73..0a7d0afb26b8 100644
--- a/tools/testing/selftests/powerpc/security/rfi_flush.c
+++ b/tools/testing/selftests/powerpc/security/rfi_flush.c
@@ -49,6 +49,7 @@ int rfi_flush_test(void)
 	struct perf_event_read v;
 	__u64 l1d_misses_total = 0;
 	unsigned long iterations = 100000, zero_size = 24 * 1024;
+	unsigned long l1d_misses_expected;
 	int rfi_flush_org, rfi_flush;
 
 	SKIP_IF(geteuid() != 0);
@@ -71,6 +72,12 @@ int rfi_flush_test(void)
 
 	iter = repetitions;
 
+	/*
+	 * We expect to see l1d miss for each cacheline access when rfi_flush
+	 * is set. Allow a small variation on this.
+	 */
+	l1d_misses_expected = iterations * (zero_size / CACHELINE_SIZE - 2);
+
 again:
 	FAIL_IF(perf_event_reset(fd));
 
@@ -78,10 +85,9 @@ int rfi_flush_test(void)
 
 	FAIL_IF(read(fd, &v, sizeof(v)) != sizeof(v));
 
-	/* Expect at least zero_size/CACHELINE_SIZE misses per iteration */
-	if (v.l1d_misses >= (iterations * zero_size / CACHELINE_SIZE) && rfi_flush)
+	if (rfi_flush && v.l1d_misses >= l1d_misses_expected)
 		passes++;
-	else if (v.l1d_misses < iterations && !rfi_flush)
+	else if (!rfi_flush && v.l1d_misses < (l1d_misses_expected / 2))
 		passes++;
 
 	l1d_misses_total += v.l1d_misses;
@@ -92,13 +98,15 @@ int rfi_flush_test(void)
 	if (passes < repetitions) {
 		printf("FAIL (L1D misses with rfi_flush=%d: %llu %c %lu) [%d/%d failures]\n",
 		       rfi_flush, l1d_misses_total, rfi_flush ? '<' : '>',
-		       rfi_flush ? (repetitions * iterations * zero_size / CACHELINE_SIZE) : iterations,
+		       rfi_flush ? repetitions * l1d_misses_expected :
+		       repetitions * l1d_misses_expected / 2,
 		       repetitions - passes, repetitions);
 		rc = 1;
 	} else
 		printf("PASS (L1D misses with rfi_flush=%d: %llu %c %lu) [%d/%d pass]\n",
 		       rfi_flush, l1d_misses_total, rfi_flush ? '>' : '<',
-		       rfi_flush ? (repetitions * iterations * zero_size / CACHELINE_SIZE) : iterations,
+		       rfi_flush ? repetitions * l1d_misses_expected :
+		       repetitions * l1d_misses_expected / 2,
 		       passes, repetitions);
 
 	if (rfi_flush == rfi_flush_org) {
-- 
2.19.1

