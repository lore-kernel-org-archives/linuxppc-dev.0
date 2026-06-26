Return-Path: <linuxppc-dev+bounces-23008-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8E8CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 08:58:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmqN94m1Jz2yVv;
	Fri, 26 Jun 2026 18:58:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782464329;
	cv=none; b=E8yz6ym7S/+Jc7Z6dmBwTdhCX0uggl92DUO3JfwY8TDFnZCLH69DJzq2z8GjhSKLZAVBROZFUydHdQ1JSJIE6cDlxrhwf2kuLCoS11RBY9XmXrObKqj+Rxn2OODAgjX7BYUMkxXhebTKZ10JuiN+5k3LCJOVRKv1043NWWrda1pM+Er1KhnLMloMFgdEd1H+vefp2Xt8ZB/eQQ9UaJD4T7bcVkiwDMMLQIYcXi0YgzclmmCBRKLo//qSZc/17OOuFzZxcJlR3hXpW+ejkuC94vWvHMXFlB8Wa1ndB/Nf3tuz6BWNLUPALY0Nr9oFrPabzKTotI/5xEqDVv/+GLYXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782464329; c=relaxed/relaxed;
	bh=f5Yi5YTgsXm9woOMnBjAq27JmMu4wFvpfL0WVartkYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpSS1j8tZG/149kDJ4IWAjFGxQsPvJlhcnPImlzUCkgaoiGCNe4QSjuUkUx2nbc/lN3msjyrvtBWLCN6H+/SrLqKC3HbyzilVIhhiaXF2Iqz8DLHZd8xLN185lIhm2u0Y+BLdpM/YlNEXJXNs4EXTsWKRkg2H6hkJCjcpWQYVRHvld8AB5tFdgfxlpq81wv1p/LWpQbZvu2MZ3p2EEYTbM4O1+FblQGHEQZaSm+rt1xAM/6wMvYLaFfVTNH5BprdRswfgcyPD6fh+YjGaQJQsd4wrSCGOj2a27gCQB8HMG72n//9ZdTRfEUX8HYh0wuXIKT58BIpoXqDxRZWfkKjhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GCkc31aM; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GCkc31aM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmqN706DZz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 18:58:46 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q6n5Nq2221334;
	Fri, 26 Jun 2026 08:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=f5Yi5YTgsXm9woOMn
	BjAq27JmMu4wFvpfL0WVartkYM=; b=GCkc31aM4hN6yvLQReYt+r2qpX/WdwIU8
	40Kz0B2qR/w6TzDGUvkFCOlJQn8soKtJeTtC8E190AKgS0GGABC+wo2n+Bg4Hl1P
	cT2SCyYg2Kv+9/F2cZ02G+geLPtLxEW57pPaLatP8rr3DTIyPZOKoKFx/5W8SKCm
	uZiSnsjnVEg7kuZjXFfwQRhsu+24rVbmoFVIZvmkExRFtddoFH1LnztMRslOsTMt
	PInLgyZzES1yCHIAYYo9BDcW+OoadD9SIQo0Tm+HLp03mTSt1jsYQzYBZdf6dvXM
	22RZnDVBPTEzw8V0AEA2yRj1hKGRMbHxLRdjwFHGCPprGreHFBp9w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gwsfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 08:58:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65Q8ndnn026212;
	Fri, 26 Jun 2026 08:58:28 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwtf1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 08:58:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65Q8wRb634668844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 08:58:27 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9888A58055;
	Fri, 26 Jun 2026 08:58:27 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0729158043;
	Fri, 26 Jun 2026 08:58:23 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.20.139])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with SMTP;
	Fri, 26 Jun 2026 08:58:22 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Fri, 26 Jun 2026 14:28:21 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>
Subject: [PATCH v4 1/2] kunit,rust: Add ability to skip entire test suites
Date: Fri, 26 Jun 2026 14:28:06 +0530
Message-ID: <20260626085811.151133-2-vaibhav@linux.ibm.com>
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
X-Proofpoint-GUID: 5wpwKIa490xVn3paB2ZAOXoiOgRyT8ou
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfX02X22oONUiar
 KlFSKs8LYsvIL2Sk8PK2TWq2NfTvnbvz+BoH7PmbOhZlGuCWg80bgwuvayZmVfz2zWx8uKWO5QG
 b9z81J9NlWToZGOEZM7X48UiVdhYubM=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3e3f35 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=nzuXsxulAAAA:8
 a=kWyL9k4a9h0CpjG28HMA:9 a=Jn5cl5okm61iLnyvC_SE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfXx7KAooMZ5Ntx
 40LN2yFOWlsJM43V1p3QlZ9cCMsU9wrypLauEcasf+55QFpIpdq07GgheoMmdS/AmRqWu8yKXrv
 cy+wP08X9JYSE0VkthhO9Ymth2DVCI3g981gbUkN3TI0lab2GX9xaGIyqLKGHH8DsLkktdPOuzD
 ykfeMd05eyw4gJfITFw3R0opf6HIm0HcE6+Rfyk9UJ2M08ldEjqlbBkRLMG4gGusmGLzq/wEldN
 i7EYVQtDoU0IJ6sS/4ePXgsnLmNaiYNgkiwKTCaB1094Q2s9jmZaGNGXLcDawMZVKOkSvm2QbCs
 GKy0EFzTBnTOTQ2spAn4OqCM4l3mYonz7lZFXDN6eBz7LAXPoqbLJhXkwKqM43KJPesJyI6G1Y3
 HLcE8v8FoFtnel2vE+eRAfAWSUjbDbutfksv8v7ubi9hZtujpeBJ4lY6U04V8REO6je154pIUEm
 aqGFei8BOs7ouWWHB/Q==
X-Proofpoint-ORIG-GUID: _bsM-yup26uosl2Q1bMEihNiU9rGvtV-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260070

Currently, KUnit provides mechanisms to skip individual test cases, but
there is no way to skip an entire test suite based on runtime conditions
checked during suite initialization. This limitation forces test suites
to either fail or skip tests individually when certain prerequisites are
not available.

To address this limitation, the patch adds a 'status' field to struct
kunit_suite that allows suite_init callbacks to mark the entire suite as
KUNIT_SKIPPED. When a suite is marked as skipped, all test cases within
that suite are bypassed without execution.

The patch proposed changes to kunit_suite_has_succeeded() to Check suite
status before evaluating individual test case results. Also
kunit_run_tests() is updated to skip suite execution if kunit_suite's
'status' is KUNIT_SKIPPED, thats either set before suite_init or by the
suite_init callback itself. kunit_init_suite() is updated to initialize the
'status' of kunit_suite to KUNIT_SUCCESS so that any skipped suite's can be
restarted from debugfs.

This enables test suites to perform runtime capability checks in their
'suite_init' callback and gracefully skip all tests when prerequisites are
not met, rather than reporting failures or requiring each test case to
perform redundant checks. In case a kunit-suite is skipped it can be re-run
from the kunit's debugfs interface.

Also update debugfs_print_results() to clearly log the kunit-suite as
'SKIP'. kunit_suite_has_succeeded() is also updated on which
debugfs_print_results() depends to update 'kunit_suite.status' in case any
of the kunit_case has failed.

Finally, update KUnit Rust binding macro-rule 'kunit_unsafe_test_suite' to
add and initialize the newly introduced 'kunit_suite.status'. Without this
'kunit_suite.status' field is never initialized which is an error for the
Rust compiler.

Reviewed-by: David Gow <david@davidgow.net>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog
=========

V3->V4:
Link: https://lore.kernel.org/all/20260617121535.462459-2-vaibhav@linux.ibm.com
* Merged rust kunit binding related changes with this patch [ David Gow ]
* Added David Gow's RB
* Fixed a indentation issue in rust changes [ David Gow ]

V2->V3:
Link:
https://lore.kernel.org/all/20260608090438.219497-2-vaibhav@linux.ibm.com

None

V1->V2:
Link:
https://lore.kernel.org/all/20260604162805.556135-2-vaibhav@linux.ibm.com/

* Fix malformed and missing test-log when skipping kunit-suite. [David Gow]
* Update kunit_init_suite() to reset the kunit-suite so that it can be
re-run [David Gow]
* Update kunit_suite_has_succeeded() to check for any failed test-case and
update the 'status' for kunit-suite.
---
 include/kunit/test.h |  1 +
 lib/kunit/debugfs.c  | 30 +++++++++++++++++++++---------
 lib/kunit/test.c     | 17 ++++++++++++++++-
 rust/kernel/kunit.rs |  1 +
 4 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index e52452e58305..da5312e0dfa5 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -285,6 +285,7 @@ struct kunit_suite {
 	struct string_stream *log;
 	int suite_init_err;
 	bool is_init;
+	enum kunit_status status;
 };
 
 /* Stores an array of suites, end points one past the end */
diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 9c326f1837bd..442b2ceb955b 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -76,18 +76,30 @@ static int debugfs_print_results(struct seq_file *seq, void *v)
 	seq_puts(seq, "KTAP version 1\n");
 	seq_puts(seq, "1..1\n");
 
-	/* Print suite header because it is not stored in the test logs. */
-	seq_puts(seq, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
-	seq_printf(seq, KUNIT_SUBTEST_INDENT "# Subtest: %s\n", suite->name);
-	seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n", kunit_suite_num_test_cases(suite));
-
-	kunit_suite_for_each_test_case(suite, test_case)
-		debugfs_print_result(seq, test_case->log);
+	if (suite->status != KUNIT_SKIPPED) {
+		/* Print suite header because it is not stored in the test logs. */
+		seq_puts(seq,
+			 KUNIT_SUBTEST_INDENT "KTAP version 1\n");
+		seq_printf(seq,
+			   KUNIT_SUBTEST_INDENT "# Subtest: %s\n",
+			   suite->name);
+		seq_printf(seq,
+			   KUNIT_SUBTEST_INDENT "1..%zd\n",
+			   kunit_suite_num_test_cases(suite));
+
+		kunit_suite_for_each_test_case(suite, test_case)
+			debugfs_print_result(seq, test_case->log);
+	}
 
 	debugfs_print_result(seq, suite->log);
 
-	seq_printf(seq, "%s %d %s\n",
-		   kunit_status_to_ok_not_ok(success), 1, suite->name);
+	if (suite->status != KUNIT_SKIPPED)
+		seq_printf(seq, "%s %d %s\n",
+			   kunit_status_to_ok_not_ok(success), 1, suite->name);
+	else
+		seq_printf(seq, "%s %d %s # SKIP %s\n",
+			   kunit_status_to_ok_not_ok(success), 1, suite->name,
+			   suite->status_comment);
 	return 0;
 }
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 99773e000e1b..09e3dabfac0c 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -214,12 +214,18 @@ enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
 	const struct kunit_case *test_case;
 	enum kunit_status status = KUNIT_SKIPPED;
 
+	if (suite->status == KUNIT_SKIPPED)
+		return KUNIT_SKIPPED;
+
 	if (suite->suite_init_err)
 		return KUNIT_FAILURE;
 
 	kunit_suite_for_each_test_case(suite, test_case) {
-		if (test_case->status == KUNIT_FAILURE)
+		if (test_case->status == KUNIT_FAILURE) {
+			/* Update the kunit_suite status also */
+			suite->status = KUNIT_FAILURE;
 			return KUNIT_FAILURE;
+		}
 		else if (test_case->status == KUNIT_SUCCESS)
 			status = KUNIT_SUCCESS;
 	}
@@ -795,12 +801,20 @@ int kunit_run_tests(struct kunit_suite *suite)
 	/* Taint the kernel so we know we've run tests. */
 	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
 
+	if (suite->status == KUNIT_SKIPPED)
+		goto suite_end;
+
 	if (suite->suite_init) {
 		suite->suite_init_err = suite->suite_init(suite);
 		if (suite->suite_init_err) {
+			suite->status = KUNIT_FAILURE;
 			kunit_err(suite, KUNIT_SUBTEST_INDENT
 				  "# failed to initialize (%d)", suite->suite_init_err);
 			goto suite_end;
+
+		} else if (suite->status == KUNIT_SKIPPED) {
+			/* Skip this kunit suite */
+			goto suite_end;
 		}
 	}
 
@@ -825,6 +839,7 @@ static void kunit_init_suite(struct kunit_suite *suite)
 	kunit_debugfs_create_suite(suite);
 	suite->status_comment[0] = '\0';
 	suite->suite_init_err = 0;
+	suite->status = KUNIT_SUCCESS;
 
 	if (suite->log)
 		string_stream_clear(suite->log);
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index cdee5f27bd7f..91eaff8c186a 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -288,6 +288,7 @@ macro_rules! kunit_unsafe_test_suite {
                     log: ::core::ptr::null_mut(),
                     suite_init_err: 0,
                     is_init: false,
+                    status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
                 };
 
             #[used(compiler)]
-- 
2.54.0


