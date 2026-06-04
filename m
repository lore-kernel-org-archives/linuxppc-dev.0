Return-Path: <linuxppc-dev+bounces-22056-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE49CD6E6D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:29:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWVQ74ffyz3bpt;
	Fri, 05 Jun 2026 02:29:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780590559;
	cv=none; b=fva3n4FOst77QVZc0P2RtKOC/NbSg2iIV7ioJ++maCGC1Vs74ORnRpfUxnU+bIOiGoB6mJQXuqbcIUmxoLusGFFN1ZptRUN0nDNNGLjudUnLpfGaR88qkI2rLpfmY2GcRBLi5YhuzosGRsS7qCeMosW2W1RD73h0kbh9UxP+Rxjlz/TMPHc/EAwd1aJ++S6Z49+4GP5AstGi7T2k3LGL/pfPSLYbY2RK5zthV/nBYiDeVsdlfn5/uSqhlO4fIMSB8nmf+BCj9hJvxYo0Dq7oyDQayvzIoFz5JnPnOZ7EV7qkA2TL+cLfRG1px6wp5ePLiATAXrBLPbBTY7K+YLpVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780590559; c=relaxed/relaxed;
	bh=aGhkjMbL9jGA36zxnKFsvHm85EotilaI+QQ2hzympgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZ5mmpKspBK3nASNg10P4Eh6KPLZ9UP6GeuQWNiEHOoSRnDhjZGR6Q+IZBRIm3tBNfxSEcEEJHh2vzEB++h/s8bYeAl7EQxqdwIxIBDWLb3DwHweEuP5UXUSflqPTAzY6ozghRakejbNVovjKr+TZx5tfjUXAGEdD66Kf//4xZrI4pOBpykSQPMD0aTHWhpyclFjLdJCFNmkOjoqUnSmW/pxPbHRB5lT1+t0hQQLApdmBw3StxgQmudrtGbzIcVe1LKVQ+dUggIVzyclmNxdT0EAOqyIpVBdtavwLNEZnOd89PFnpkOY1vPe1bI3Nq6zYtx5eFMIZWtvIwZfDfZ7mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NqNvgxYh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NqNvgxYh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWVQ7067gz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 02:29:18 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654FaPQQ510186;
	Thu, 4 Jun 2026 16:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aGhkjMbL9jGA36zxn
	KFsvHm85EotilaI+QQ2hzympgk=; b=NqNvgxYhnjCn3plJR/szKGLAAHSfdx3cs
	qr7bWAUSZ9YWu+I96wC5XfBNR6GBfrdxyU8vs9hrJGUncaTdQSydiH4oDwUfFwWy
	Qzh+mI85Ybsu5drYw+KLHzSfgaqiXDkzfYQBeLzxypWS1yb2imQ4icPdWldd+BWX
	YKQANNY2X+MclbjvcfMQG+wfWl0LD9siAiBkCNNF4FpSdIfAsf2sC3nn3dQ9ERKG
	HYITBHnrr0a754c6dYmEeGp9IlrYPCUrynBLzc6P0mqaAfaAfzfqdz3/7ZQMfMOf
	63nEhDnRBXVhikSg9PNvjMEI0M0z66IhgJa0qoLXYpmpudcTiRzbg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaeg4yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:28:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654GOU44000871;
	Thu, 4 Jun 2026 16:28:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegwmpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:28:46 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 654GSjoJ28771044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 16:28:45 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E39D35805E;
	Thu,  4 Jun 2026 16:28:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9363B5805C;
	Thu,  4 Jun 2026 16:28:38 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.208.128])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with SMTP;
	Thu,  4 Jun 2026 16:28:38 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Thu, 04 Jun 2026 21:58:36 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>
Subject: [PATCH 1/2] kunit: Add ability to skip entire test suites
Date: Thu,  4 Jun 2026 21:58:00 +0530
Message-ID: <20260604162805.556135-2-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604162805.556135-1-vaibhav@linux.ibm.com>
References: <20260604162805.556135-1-vaibhav@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a21a7c0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VtAGnrMgrpcAnsMWHQwA:9
X-Proofpoint-GUID: cCt_lGw3SoN8gaGSsLnaDcvnLsyVNTgj
X-Proofpoint-ORIG-GUID: lps7YldLokQhbBkBuuPmYy42MdRuRIVE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE1NyBTYWx0ZWRfX1i06YlSRNGVK
 26J5KAN5HPSdbqyiJ4p1UxXd0cOel8xaBRY7YaMWTU6C3450mCov6mQayKpipKiZGEHPzrUryoV
 ja2M8/DIOLn7y61gvEvq5FI9nF0nkVPutm5stGcva5Cq49DNg9+VI+59/0D7M9dMUL75GwsZ4SE
 OziM/tN/9fVwd7xChWzDeLnnkU7kQ1nNmLm0jml4i3o9iwZz0h/4pQLa6nk2f8AIljbmBL8KviN
 LnPvabiYLn96Y+YoLWBTKQSkhzAxIZ7dB8swi8DOZTnZyto1Zhv8YEhxOR72tqtn6AiAHPoepZ2
 qB+hb89EVq7RW7wugNUYYxj/nx5m7FgB4dzi4G63lL/7zsYTCmFhos/+xrRWjHKnBfrPZYzmwRv
 inB5N3kEP9wOJGy0t4TvNCwSMg64WSiahmaG2su9Z1663dFlqVymRzTTrsyZILEytVv81EgzU//
 48XVudF04MhZKvOgyfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040157

Currently, KUnit provides mechanisms to skip individual test cases, but
there is no way to skip an entire test suite based on runtime conditions
checked during suite initialization. This limitation forces test suites
to either fail or skip tests individually when certain prerequisites are
not available.

To address this limitation, the patch adds a 'status' field to struct
kunit_suite that allows suite_init callbacks to mark the entire suite as
KUNIT_SKIPPED. When a suite is marked as skipped, all test cases within
that suite are bypassed without execution.

The patch proposes changes to kunit_suite_has_succeeded() to check suite
status before evaluating individual test case results. Also
kunit_run_tests() is updated to skip suite execution if 'kunit_suite.status'
is set to KUNIT_SKIPPED, thats either set before suite_init or by the
suite_init callback itself.

This enables test suites to perform runtime capability checks in their
'suite_init' callback and gracefully skip all tests when prerequisites are
not met, rather than reporting failures or requiring each test case to
perform redundant checks.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 include/kunit/test.h |  1 +
 lib/kunit/test.c     | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index ce0573e196ce..395221d623f7 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -285,6 +285,7 @@ struct kunit_suite {
 	struct string_stream *log;
 	int suite_init_err;
 	bool is_init;
+	enum kunit_status status;
 };
 
 /* Stores an array of suites, end points one past the end */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 99773e000e1b..989acc770265 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -214,6 +214,9 @@ enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite)
 	const struct kunit_case *test_case;
 	enum kunit_status status = KUNIT_SKIPPED;
 
+	if (suite->status == KUNIT_SKIPPED)
+		return KUNIT_SKIPPED;
+
 	if (suite->suite_init_err)
 		return KUNIT_FAILURE;
 
@@ -795,12 +798,20 @@ int kunit_run_tests(struct kunit_suite *suite)
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
 
-- 
2.54.0


