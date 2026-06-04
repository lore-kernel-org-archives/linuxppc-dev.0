Return-Path: <linuxppc-dev+bounces-22021-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2399CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 09:30:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWK6M6Cp0z2y1Y;
	Thu, 04 Jun 2026 19:30:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780565403;
	cv=none; b=UjPt7XAdDqFMYrn+IKSnt3ASGxgB+JgcDl/iJKDJOVmBKwz9KtnFxFus3N7J8/u89d5ZddSYWO6NkcO8pYE7eA0y6ztV8emMLC1f1vXuZA6QHVXc079ZNUEO4jF0ZlRI0zNSt3RLOHOhzqiwgexMlsp1cKFsg/62825C7l3jqY7vB/V055tCOqWtV7G/uP/hdZA77XNKP6ED03BlH6OOk9G7iwYW+ZEyIJFsVTNx5xKIe23u0jIDD7krGkUpOEwW0yN4D0e/9a6AtS5W7POj7LYVxP0pSiDRIhRGRs8ZX2KkiS8F/OFxeGxye3VEuaFAA9VR2slOP2gvWWBKlo8iVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780565403; c=relaxed/relaxed;
	bh=yrBNMboK/S7KMAQ3OGVJl0nTy2/+GtpZrb4kKiPuZPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Co/Oc0RlSqEOfQnYWQEKQmpr5LGpLNLiXngd+SdmyMR4M0ebPNzAuKv+ROJ1m2A3qqyU4/GmC+QwCjH+EU4RjHpf7XG/v27vPM5q5IjSzd3mzyItaf0QHcReJfbr3BraI4TN+wFapIG4plvWm+8h7i7JE8NqwGqwsO6iHnmW+iKznieYNgCT/nrJ37Yqs6N/4VEWuxr9tfZRw09svMu+RUo0dsEQAus17jCBSgufTi7IkJlKjRPrXjnqSwhUGaCMG1TmR3YG4Jcq95vvNTSqU1JkMTqGWhDWSR1FsKXLP09Okv17Q33u4Vz3c89yQOr9xYtx+IkWU5Z4YYZ9VdL9oA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nMiJvnwA; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nMiJvnwA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWK6L3YZ1z2xHF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 19:30:01 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6545VIu1500650;
	Thu, 4 Jun 2026 09:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yrBNMboK/S7KMAQ3OGVJl0nTy2/+GtpZrb4kKiPuZ
	PM=; b=nMiJvnwABLKnuqFq4CbyvHuIAmdK1L3UjUwdnNr5ZMjdkZZpKrzaOURBb
	7QMHxGzaY6q5kLLGR8LaYAYIm8vO9WGGKnEJzOKNOugJB5ZQIazztPirUDU1FfmD
	S76a6T62Mc3IIRlV16GYnN0oJnS91GA+eQinImqLsGMYy1ittGLRdNQcAc1bmCHj
	Ko6B5ctJLcmak10hDjk13k9z7MLj2aqndMubFEaD7PlQ2/426IDl2iDLiz4cxhg3
	afEgPR0Lqr6ZRAm1je3rGgQNo4pW+1G6ispdL1f7fNsEzY6rJ+cIglYgjtzhGtFj
	nZlGCidCkpGLyBBubSlzK2kKBPSsA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqf37x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 09:29:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6549O8I5013314;
	Thu, 4 Jun 2026 09:29:44 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qmkea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 09:29:44 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6549TgOs26149624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 09:29:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6258658059;
	Thu,  4 Jun 2026 09:29:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFCE258043;
	Thu,  4 Jun 2026 09:29:38 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.208.31])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with SMTP;
	Thu,  4 Jun 2026 09:29:38 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Thu, 04 Jun 2026 14:59:36 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] kvm powerpc/book3s-apiv2: Add suite initialization to skip GSB tests without APIv2 support
Date: Thu,  4 Jun 2026 14:59:30 +0530
Message-ID: <20260604092931.344101-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-ORIG-GUID: _uxoiUFcdeGLRCUHW02EHEZ614gqhGqZ
X-Proofpoint-GUID: _uxoiUFcdeGLRCUHW02EHEZ614gqhGqZ
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a214589 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SRakg5jYXA31ZsQ6RxEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA4NyBTYWx0ZWRfXz9x7Ll32E6/A
 f7VmUO4XAq6vRwQJQzjI5+IE03xXJFI6k7WDJzyY44t9nRUjTbSnZ1sov/5G1FeI42Z8lfGQ0DB
 ipkabMAdYA0GfuH5zxwJbx2zDNcZQd2nUpfJ/PSdfKw9dOf2wt1YS9p/gJJGVzs0pOFBxHFTjo4
 qX1v3gTPEaGxFvZIzsQZQhU08SrzPJ7B1SJZDo88XEI7fLZwvv8esSNCcBBymgnVZEiB/FxEAT6
 fNI5PC+r4LhGpJd0x/qo6grFwxh5ocZdkfwfwbbKSTdfIN48Nwdt8Ba/EAdTKXcfkLeSaUHkl9c
 3rdGfP6gdmyCaOT/9N8Qk7iMNIyHWh6C60aQEFxJbq00zz7OX1gRkOWlH6YcCMZbMqKG/V7+tMH
 FiUOlGK98AaW9PhaAOLSeKRV2RmkOkab+LRJzegBClC1XUFW/DmQ4/aIcUiCYa/1ejBfX/Tm0mG
 VM8SbG+hL4zpoWMrnEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040087

The guest state buffer (GSB) test suite currently fails on systems that
do not support the PAPR APIv2 nested virtualization. This happens because
the tests attempt to use APIv2-specific functionality without first
checking if the host supports it. This was recently reported [1] when
test-guest-state-buffer kunit tests were being run on Qemu without enabling
Qemu capability 'cap-nested-papr' which enabled APIv2 nested virtualization
for PPC64 Pseries Qemu machine.

Add a suite_init callback that checks for APIv2 support by calling
plpar_guest_get_capabilities(). If the host does not support APIv2
(indicated by H_SUCCESS not being returned), mark all test cases in the
suite as KUNIT_SKIPPED. This prevents test failures on systems without
APIv2 support while still allowing the tests to run on capable systems.

[1] https://lore.kernel.org/all/20260603064225.GC18149@sol/

Reported-by: Eric Biggers <ebiggers@kernel.org>
Closes: https://lore.kernel.org/all/20260603064225.GC18149@sol
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Assisted-by: Bob:Claude-3.7-Sonnet Bob-Shell
---
 arch/powerpc/kvm/test-guest-state-buffer.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/powerpc/kvm/test-guest-state-buffer.c b/arch/powerpc/kvm/test-guest-state-buffer.c
index 5ccca306997a..f84b40fa55db 100644
--- a/arch/powerpc/kvm/test-guest-state-buffer.c
+++ b/arch/powerpc/kvm/test-guest-state-buffer.c
@@ -521,6 +521,24 @@ static void test_gs_hostwide_counters(struct kunit *test)
 	kvmppc_gsb_free(gsb);
 }
 
+static int init_gs_test_suite(struct kunit_suite *suite)
+{
+	long rc;
+	unsigned long host_capabilities;
+	struct kunit_case *test_case;
+
+	/* Enable test suite only if APIv2 is supported */
+	rc = plpar_guest_get_capabilities(0, &host_capabilities);
+
+	if (rc != H_SUCCESS) {
+		/* Skip all testcases if no APIv2 support */
+		kunit_suite_for_each_test_case(suite, test_case)
+			WRITE_ONCE(test_case->status, KUNIT_SKIPPED);
+	}
+
+	return 0;
+}
+
 static struct kunit_case guest_state_buffer_testcases[] = {
 	KUNIT_CASE(test_creating_buffer),
 	KUNIT_CASE(test_adding_element),
@@ -535,6 +553,7 @@ static struct kunit_case guest_state_buffer_testcases[] = {
 static struct kunit_suite guest_state_buffer_test_suite = {
 	.name = "guest_state_buffer_test",
 	.test_cases = guest_state_buffer_testcases,
+	.suite_init = init_gs_test_suite,
 };
 
 kunit_test_suites(&guest_state_buffer_test_suite);
-- 
2.54.0


