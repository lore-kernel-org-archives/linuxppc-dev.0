Return-Path: <linuxppc-dev+bounces-22740-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8205BCD98E4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2026 12:39:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggNhM4vQsz2xHK;
	Wed, 17 Jun 2026 22:38:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781699939;
	cv=none; b=WTztT2WXpbkQdMfUQ4R80PdLsOhCoI7IW51ypvXL4Ejdog7Ca+LWbfMBnFxCt61xvLA0UAQskKr3BrY1mfotVjOPLZUksxJUn2Nbfyle6Ij7GltmgubX2Nhr4QhxUjqcVCcNv64RO+OuHoOPHD1OW3BZnQuNdUb5OzyjtzwPnsWINGUu9LMZ+4dv2mPuldRt8uLUGvshTDRDOn/wH7wtMiJVjH5Ja5fJYwE+TLvUREpYwlPHKoNoTpvoZPxRfaVJnqgxA+dny/nLG0zaJLSnQPtXqEFQT6ERaEbV5AQ3w9ENxg9vvp5rGYrYIzPSREZzfOIYejYwGA61UEmZuhRtTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781699939; c=relaxed/relaxed;
	bh=JmmEtwAC+IzjnnOdassXkR7D2VbpXwWYi5VYohYNvCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J7Md0wBdEUx1/uZD66irP9XJuJ/CcFMDjh2G+PwtMW8NLPCmJ+zB77+Z5R0nU9DaWalcDkuKppAsRIJWXIc8FZfVGGcOmG3nEEz6z9f0wGTE04fcU10PyGPiR+nQuEwWAV/m66fgo2kOcfsv2mpaF/wBYbawfSz0UC3dcppi2XOVep4Ex9NsXONp/4eYT7dtyQdEe19o8Pucet7Q358BsCwUxGKzCti3inLMOamJHp03cvXdnFO+yO5ALiwGeTqOX2UNW1vPeHNa27oaqL8TCMC2fsaH/+BlvlLYvQNeaS2KJ9ls6gv2eJDCCWcaayu5nsxuTkMj91qg2pJqbVgnaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lsLNtA7U; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lsLNtA7U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggNhL3KMkz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 22:38:57 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8mUbJ4041355;
	Wed, 17 Jun 2026 12:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=JmmEtwAC+IzjnnOdassXkR7D2VbpXwWYi5VYohYNv
	CU=; b=lsLNtA7U7IehynhoTX1t+0Yl+KMO09Qeulb0pmkcvuzYW3JFUS9wbwn7o
	/jLLB/g/muK+ldoAwoG0ljXfUzWOlJvlKAXUxb7oHzzD1bI4vZOV1xZJhtZZHEoe
	JucDcVxQ6d2YBKJRKQLThOkKGe4ho629aDrABZYGzrEgiZtgbJnzyKso/lShUQCB
	2LfBPFQhD4WdqfE2L9grq0GpxSH264zxBeHWXmpmQqobQNcdZLZVce0jTxyxXW2o
	D+bbWo3bk74VSkohFlqs5fEfTuYtMFRu1h0o8ZrQAqJ1QrNPUDpMFTBuEKnEMAKN
	A5YoWkIJquJ3mcKRAtfML7fhWAIsg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxau31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 12:38:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65HCYcYY003680;
	Wed, 17 Jun 2026 12:38:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvab3w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 12:38:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65HCcbY832572146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 12:38:37 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22AC358064;
	Wed, 17 Jun 2026 12:38:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A279B58056;
	Wed, 17 Jun 2026 12:38:32 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.28.81])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with SMTP;
	Wed, 17 Jun 2026 12:38:32 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Wed, 17 Jun 2026 18:08:31 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <david@davidgow.net>, Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2] kvm powerpc/book3s-apiv2: Add suite initialization to skip GSB tests without APIv2 support
Date: Wed, 17 Jun 2026 18:08:18 +0530
Message-ID: <20260617123820.467601-1-vaibhav@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a32954f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SRakg5jYXA31ZsQ6RxEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDExNyBTYWx0ZWRfXy1ha+JNSDO3a
 XHZ8fvjQbldOimJ2SkhIxPHKxtUDsVDzAv15nSDCz0Vi127QtkcWnX0ySf+5xLDIq6irnIs+NB0
 dNxMS5sYYGdRti0JjKVXq/g2NkDtUeBDqavF9f1o834gLvznsO3cpYk2aL23jQ+21NcjxViQhUT
 bQgZS+26CKE0Ybw0xoq9zY51mPRfUAbbrlHQo/R0xEXimISuMqLHa7sa28lW98kkQ7K+NaO5yKG
 47K74WllQyQ1z0cMwppiEb0SNu5ItMXG3mTVm2uKGdCC3tMwId49FTCbHxDNcBEMNDZynUuLSEG
 SVP0ddF02vkeRq2MSoPFyWfb3B/ettwryWRptv4Kz+fNXj93cdCgUr/E/OQc3K6Vq75I2UasdkF
 MydGB6hDEhkBc2IazJpDcVKfm3K9obntWkmz+CPRTdbL1jYXbd/ahEAIeY/qT8XzkoYp9rHILPS
 jmXl7No1rhUWKd2hbmQ==
X-Proofpoint-GUID: 5ZlxN5mkTsg8ZKm5Nq3NjBxbTdvThqxc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDExNyBTYWx0ZWRfX02pFcEngnAFQ
 kH/5Izf1Yb7i/OAsEJbnpJj3by9DieA3wsa0KWfrCbW+GGjNC32wm5gu4EQ4fcqYwGevkIyPpw3
 vGrR/nh4mGvZtMN4T+hajnUydxZPrLY=
X-Proofpoint-ORIG-GUID: 5ZlxN5mkTsg8ZKm5Nq3NjBxbTdvThqxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170117

The guest state buffer (GSB) test suite currently fails on systems that
do not support the PAPR APIv2 nested virtualization. This happens because
the tests attempt to use APIv2-specific functionality without first
checking if the host supports it. This was recently reported [1] when
test-guest-state-buffer kunit tests were being run on Qemu without enabling
Qemu capability 'cap-nested-papr' which enabled APIv2 nested virtualization
for PPC64 Pseries Qemu machine.

Add a suite_init callback that checks for APIv2 support by calling
plpar_guest_get_capabilities(). If the host does not support APIv2
(indicated by H_SUCCESS not being returned), mark the kunit_suite as
skipped. This prevents test failures on systems without APIv2 support while
still allowing the tests to run on capable systems.

This patch uses the ability to skip entire kunit_suite which is proposed at
[2].

[1] https://lore.kernel.org/all/20260603064225.GC18149@sol/
[2] https://lore.kernel.org/all/20260617121535.462459-1-vaibhav@linux.ibm.com/

Reported-by: Eric Biggers <ebiggers@kernel.org>
Closes: https://lore.kernel.org/all/20260603064225.GC18149@sol
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Assisted-by: Bob:Claude-3.7-Sonnet Bob-Shell

---

Change-log
=========
V1->V2:
* Updated the init_gs_test_suite() to use 'kunit_mark_skipped()' for
kunit_suite.
* Addressed sashiko-bot's review comment regarding unconditional execution
of hcall on non-PSeries systems like PowerNV [Sashiko]
---
 arch/powerpc/kvm/test-guest-state-buffer.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/kvm/test-guest-state-buffer.c b/arch/powerpc/kvm/test-guest-state-buffer.c
index 5ccca306997a..232c00493a25 100644
--- a/arch/powerpc/kvm/test-guest-state-buffer.c
+++ b/arch/powerpc/kvm/test-guest-state-buffer.c
@@ -521,6 +521,21 @@ static void test_gs_hostwide_counters(struct kunit *test)
 	kvmppc_gsb_free(gsb);
 }
 
+static int init_gs_test_suite(struct kunit_suite *suite)
+{
+	long rc = H_NOT_AVAILABLE;
+	unsigned long host_capabilities = 0;
+
+	/* Enable test suite only if APIv2 is supported */
+	if (kvmhv_on_pseries())
+		rc = plpar_guest_get_capabilities(0, &host_capabilities);
+
+	if (rc)
+		kunit_mark_skipped(suite, "Unsupported hypervisor");
+
+	return 0;
+}
+
 static struct kunit_case guest_state_buffer_testcases[] = {
 	KUNIT_CASE(test_creating_buffer),
 	KUNIT_CASE(test_adding_element),
@@ -535,6 +550,7 @@ static struct kunit_case guest_state_buffer_testcases[] = {
 static struct kunit_suite guest_state_buffer_test_suite = {
 	.name = "guest_state_buffer_test",
 	.test_cases = guest_state_buffer_testcases,
+	.suite_init = init_gs_test_suite,
 };
 
 kunit_test_suites(&guest_state_buffer_test_suite);
-- 
2.54.0


