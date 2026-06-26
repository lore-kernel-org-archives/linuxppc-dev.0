Return-Path: <linuxppc-dev+bounces-23009-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0E1CDE008
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 08:59:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmqNC55VCz2yh4;
	Fri, 26 Jun 2026 18:58:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782464331;
	cv=none; b=YTUFmPyDyQjYCA2fla0FpeKuUGnX4clZTdbfjfpMbAOw3X3roxjHMScSJUte/yhdsPx7W6Kl7BgT9ovjkn1CQHh4PMto+q4ZVcXOW4S3VmIqKxJ3fgVRWa8cJJErSBah5q5Z78FkCYQG4RRr5BLw4JUOjF8t7FWOPuY0B9Wp4B2kFj2MVz4wN8QTEOlnZAF4PHm+86iAdkO5W46HtP4mJYxvi9R0eyves6C+hAhuQCIdUDVx80UrDYoBPM88wxBFY4Mml3OctdosygFOjYN46BNRUcB3cKqp3PrG5ZZ4p7gZNw2jIatbE3YAsT3c+tUp9/LKlo09B+UvcAyVWP6nuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782464331; c=relaxed/relaxed;
	bh=dq2iJH3ZBxy9MuvW63gPgQjNUyVQUQHN+hh9clQFrqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3VrU0rtgPjXSFMr7svNQKHSRIuzeNG7F8N9HMA0l17VwCd/Ty833BjwFJVScFRFPelEwtqIRXNAmq9OK256gOCNwivQ8xx9mNYYzs7LBCDBh3JA8KffrY95X7k+zSQw6kMkaiCDYUWWAIY03odhQBCXGLeRrmKaM+JDxliQTXyrCbGOKFjGZd0OdNORL+PWl1Wmc5fLoazh9QdunxtIE5JEz67w6H/Z38M8uBc7DTqWcdPcPL4dN/3TWuvU7IXkDBggwBxvq7u46gdiqtn63eqaZtp0bEvZkj6jnQ1qQN3Hs1z/YnScqCuwmVi5w5lHW+Q9vsAYiguBmulj7x8t4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OSWTvxHd; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OSWTvxHd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmqNC0Nlzz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 18:58:50 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q6nBfc2221391;
	Fri, 26 Jun 2026 08:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dq2iJH3ZBxy9MuvW6
	3gPgQjNUyVQUQHN+hh9clQFrqw=; b=OSWTvxHdkeMs7oFspfn/vpBlKgW+OnZks
	M/oIkwuW6s1B1MypgxPmffzhng2mZnG76ZFi2V60dO/jCYohpclcDJYabZIiXJAG
	mvg+2aYyPnsX/Pi+tOCH18/FcuePoj7A2B+XghL18iGrrhvG81UOR806FRIEAFjo
	Z1hk5Ikq53LKCKmOjKNAd89LqcBlmFDRvyc+vwRO/0SnuUBkN336oKRjJBaiDHff
	SKiX9ZBbRITuvNxKFOzLy0Dxiu9azhBO7mfh7QI7aIEZ0fm3O7hyiZRyB1IjLbIp
	2/cTeFOzrVA9s7GgBf0jXsTMW3ak+Z2miH2hCm4pl6MGm/j/Kk8Tw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9j62yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 08:58:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65Q8njNO001484;
	Fri, 26 Jun 2026 08:58:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qthuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 08:58:35 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65Q8wYvU32703216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 08:58:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 108FB5803F;
	Fri, 26 Jun 2026 08:58:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 817B958056;
	Fri, 26 Jun 2026 08:58:29 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.20.139])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with SMTP;
	Fri, 26 Jun 2026 08:58:29 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Fri, 26 Jun 2026 14:28:28 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>
Subject: [PATCH v4 2/2] kunit: Add example of test suite that can be skipped at runtime
Date: Fri, 26 Jun 2026 14:28:07 +0530
Message-ID: <20260626085811.151133-3-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626085811.151133-1-vaibhav@linux.ibm.com>
References: <20260626085811.151133-1-vaibhav@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ZJ8nUWzOPibnE_4HGKDwr7KZD7-vjhPI
X-Proofpoint-GUID: LSCqZt8pxDgpYvnHYkLVsI-2UQyVz1-N
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3e3f3d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=nzuXsxulAAAA:8
 a=ER9KG9QWV2A1lhMn8r8A:9 a=Jn5cl5okm61iLnyvC_SE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfX+K4XeN0OChbK
 gsEfb8qxoF/2mD/0bpgiStMhEoLgIHejVSNd9iUpyTMT8tkHSUCFHPXgvli2gWSOcFdYQqIbhgf
 RnufnotmcvNkwn9B9UNNFqx8QhrcX/rPrpX9xw9Zcbc1r7/cnIU8UR013ZEg715qz4jGtZXr5zp
 ECecIP3JAzvBPE1GPtQo58v3aY2pA+ggvuqZF2cX86MVbB5DqFRSwO+fHCg+eNQa7T21rBvHg4F
 CCMc9npIaW9wq7u2LUj6EwYT9QIjHECio4cSptdiQYpD+/2UZpfRhk5CStVuQ9U8qvfwkmFR372
 yReHC2h21+FMyJJGKajb8Nj8y4XlVBDr39bYeCPjw2PlJRXvgvbRuDgHsOvepeU4Z5drpfyqUOQ
 tZlmon74vMDBVnZUK1D5XzVSCGKNdNy3xgddpAKqw5gydJaeZCwtDDTrsEZiLj+SIaECqlclzCX
 to7RE+wvoArjTYj7n7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfX2Y5pxUSuobM5
 LTziNjbjv8zx99Kqq67lxKSIE+RtLymWq5dlTCzAE2QnT2gv7/kB8VUAL+b0kpCmtMCmNLlJqBm
 kGSfbLmuD1f6Y8MCIncTBMGYlqBRYJ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260070

Add an example test suite name 'example_test_skip_suite' to
'kunit-example-test.c' that shows how to skip an entire test suite based on
runtime conditions.

The example suite 'example_skip_suite' provides a 'suite_init' callback
named example_skip_suite_init() which marks the entire suite as skipped
using kunit_mark_skipped().

This demonstrates a way for conditionally skipping test suites when any
prerequisites for kunit_suite execution are not met. The 'suite_init'
callback can perform any necessary checks and mark the suite as skipped,
preventing all test cases from executing while also indicating why the
suite was skipped.

Reviewed-by: David Gow <david@davidgow.net>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog
=========
V3->V4:
Link:
https://lore.kernel.org/all/20260617121535.462459-4-vaibhav@linux.ibm.com
* Updated patch index in the series
* Added RB from David Gow

V2->V3:
Link:
https://lore.kernel.org/all/20260608090438.219497-3-vaibhav@linux.ibm.com
* Updated patch index in the series

V1->V2:
Link:
https://lore.kernel.org/all/20260604162805.556135-3-vaibhav@linux.ibm.com/
* Added RB from 'David Gow'
---
 lib/kunit/kunit-example-test.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 0bae7b7ca0b0..b8ded54fa46d 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -591,5 +591,34 @@ static struct kunit_suite example_init_test_suite = {
  */
 kunit_test_init_section_suites(&example_init_test_suite);
 
+/*
+ * This test should always be skipped.
+ */
+static void example_skip_suite_test(struct kunit *test)
+{
+	/* This line should never be seen */
+	KUNIT_FAIL(test, "You should not see a this.");
+}
+
+static struct kunit_case  example_skip_suite_test_cases[] = {
+	KUNIT_CASE(example_skip_suite_test),
+	{}
+};
+
+static int example_skip_suite_init(struct kunit_suite *suite)
+{
+	kunit_mark_skipped(suite, "Test suite expected to be skipped");
+	return 0;
+}
+
+static struct kunit_suite example_test_skip_suite = {
+	.name = "example_skip_suite",
+	.suite_init = example_skip_suite_init,
+	.test_cases = example_skip_suite_test_cases,
+};
+
+/* This registers a test suite that will be skipped */
+kunit_test_suite(example_test_skip_suite);
+
 MODULE_DESCRIPTION("Example KUnit test suite");
 MODULE_LICENSE("GPL v2");
-- 
2.54.0


