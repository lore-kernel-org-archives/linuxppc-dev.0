Return-Path: <linuxppc-dev+bounces-23007-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D322CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 08:58:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmqN83yV0z2yYf;
	Fri, 26 Jun 2026 18:58:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782464328;
	cv=none; b=JulrKTWUVQJth+EIETcfE3xhHWq0uwj/s2taoj7acicM/WZ3u6RWZ48810nE2yFRYSQHh2q8vU7BHG5CmWHG69sTVImYsgNgGUIhg8jjyktpbfLh8PWFn/jjWlA01NZTeYrQchA74CpPmI6NoMkOhg4Z2YGi/1w8NQrgVAGToKELONNGiC+Y3e+b7xs5lu+ItTXaOQisxVyd9iZk8oeeHYESVZ45XiqmS1BcLVRbdHt30jmXIa0w1DFlvEY2LgNB3vH3CLAtyJjyS57wPu40w6c0FrJVPx4plVsPqXT1HP296fb+UZlooBcOkEQSLU1GoNWwROYtWnMOlMfcVhCayA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782464328; c=relaxed/relaxed;
	bh=O7oXCJbRKAYcUKitUCxoVUnPEUiiGF6hsfMLMh4f06o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGLijN/uGHvr81F9mlbKJlEzXXeInYry0H8N9rOWHid5d1HUh0ynH+2KVljZ8lbCi8KzXrmKkERi+yBYp+5LwRsaaPAUWUUdgChad5Aym0z7d4FaPFfN8cqzR7zD7a3w20E8nYH9B17WALu+c2ONVsy9JrdvIOi/t20Rc5ArxB3Df/8LvCmpJWfbVlyyYV5Wu95BdgzXWGEf8CNgjD7JEAL9pOypxoF07CpWrArA5PJVmUeswf0Ogn7RI35/Bu6xPIXm4FJlFyAUE3hrQkIa4rB8ND0m3mnNToQgukTRX0K01Ebi7WnvbQvbpB0rDoKoYzNB/Fuk0e2a6sO837AYUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dBjBa4Cu; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dBjBa4Cu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmqN66Ytzz2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 18:58:46 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q6mtee2220768;
	Fri, 26 Jun 2026 08:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=O7oXCJbRKAYcUKitUCxoVUnPEUiiGF6hsfMLMh4f0
	6o=; b=dBjBa4CuuGJ7Emt9KO8CviLOFXnfrz93+lSeqD5LipDmQuX8j4wO11RJ+
	hNVHYsv7okoTeBWZVXDUyDUI4c1WPDVo71m1bQA+ISNGDy5QjQv8rYrcxzIM3ZnM
	sO7F5bdQZvSW2qfXuyvcyDwaV6LyVJ+g88wJKW7evA9AqNWzflrEJCyoA85Mv9Md
	PFyS0amcsYRfMdIFm1sgZWjHnphMcrW7TN8Hr1N25Ka1q2obbZ78e4IugVzuXrjn
	zXKMf4OA6fvHROAZeCu1ttvIDjS7C+qfM7DZ6d/cPoqN4TtxbweGsRZ4azJl7lWu
	7C8P35CBBXpufZw6p59b9OeQqQq6g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gwsfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 08:58:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65Q8negw022803;
	Fri, 26 Jun 2026 08:58:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dgj3dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 08:58:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65Q8wLgU26411520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 08:58:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15B115805E;
	Fri, 26 Jun 2026 08:58:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97DB158056;
	Fri, 26 Jun 2026 08:58:16 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.20.139])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with SMTP;
	Fri, 26 Jun 2026 08:58:16 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Fri, 26 Jun 2026 14:28:14 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>
Subject: [PATCH v4 0/2] kunit: Add support for skipping entire test suites
Date: Fri, 26 Jun 2026 14:28:05 +0530
Message-ID: <20260626085811.151133-1-vaibhav@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: UNJBq8_YnAj-fi6ugCZ3fU4P4D-_97Rj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfXyvZB9LMd3ddY
 YIf6IPcx0wPduiUd0GcP0cHGzRdC2YJ8uzA+MdxDTUhrh0ODwckvx7HMsmq1go0vA9lddAuKUNx
 VxAafPkUORQw4XHjBH2i5jOf6Ahm6yE=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3e3f2f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FF_GvKQqgJ40MD8C4q4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfX9S7LtgcNaIld
 n7EE33sbJTjm6ig+KuRXKiX+7Hb9isRqHGvMe6XG0zzuGJZzQ1R64ihRUix0dTGWxeObG2wUrsJ
 orBoRxRKN4+3ven3AnZpgi5jpCJIQJT1dsxeyh/3elQfoqCyK8ZZMNm0Nc8UA7AHMSxt1G4c7rh
 q4W6ohfF6kDbZSZ0wD4jPepd8X7yBiyLYgxqV5X79CfRbDo+dSeIhNOQu8I8OuHR+uI9/5+0sgx
 L80sfs7hkdUa0ip2z8wY59yUawg6FpIyUYBXoF5hqfOLd2HEZyKu8yAv676KjMnPT8R3YjQQVuQ
 1OdqLo0YqB23+bLf7vlVL6PmvopUl2BnGWp84lH34SjKbL5IGr/kU0QOX43ZL7c8Crp4qDBhuZ0
 xzZ7g0kfYqg2+R6Ne0qwgXHXUBZKzb/YB2tgW+/eajQbHHtLjbeufMbLJyE2zBGggnnmWN7rh+B
 kok+48e8qSD6MYR6swA==
X-Proofpoint-ORIG-GUID: 2NZMWzdmNhbMG9yGo1uB05padzAI6FhX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260070

Changelog:
==========
Previous version:
https://lore.kernel.org/all/20260617121535.462459-1-vaibhav@linux.ibm.com

* Merged the KUnit rust binding updates to Patch-1

Summary of changes
==================

This patch series introduces the ability to skip entire 'kunit_suite'
based on runtime conditions, addressing a limitation where test suites
could only skip individual test cases or fail when prerequisites were not
met.

The motivation for this feature comes from test suites that depend on
specific hardware features, kernel capabilities, or runtime conditions.
Currently, such suites must either:
* Fail when prerequisites are missing
* Skip each test case individually with redundant checks
* Implement workarounds to avoid running tests

An example of such a requirement came from [1] where the patch author
wanted to skip the entire 'kunit_suite' but then had to resort marking all
struct 'kunit_case' as skipped by accessing 'kunit_case.status' private
struct member. This usecase being addressed in the patch[1] can be better
implemented with the changes proposed in this patch series.

Structure of the patch series
=============================
PATCH 1:
* Add a 'status' field to struct kunit_suite that allows 'suite_init'
  callbacks to mark the entire suite as KUNIT_SKIPPED.
* Modify the KUnit core to check this newly introduced 'status' field
  and bypass all test cases when a suite is marked as skipped.
* Update debugfs_print_results() to emmit correct logs for skipped
  'kunit-suite'
* Init 'kunit_suite.status' to KUNIT_SUCCESS so that kunit_suite can be
  re-run from debugfs
* Update KUnit Rust binding macro-rule 'kunit_unsafe_test_suite' to include
  and initialize the newly introduced 'kunit_suite.status'

Patch 3:
* Providing an example in kunit-example-test.c demonstrating the usage
  pattern.

The implementation is minimal and non-intrusive, adding only a status field
to kunit_suite and checks in two key functions. Test suites that don't use
this proposed feature should be unaffected.

References
==========
[1]
https://lore.kernel.org/all/20260604092931.344101-1-vaibhav@linux.ibm.com

Vaibhav Jain (2):
  kunit,rust: Add ability to skip entire test suites
  kunit: Add example of test suite that can be skipped at runtime

 include/kunit/test.h           |  1 +
 lib/kunit/debugfs.c            | 30 +++++++++++++++++++++---------
 lib/kunit/kunit-example-test.c | 29 +++++++++++++++++++++++++++++
 lib/kunit/test.c               | 17 ++++++++++++++++-
 rust/kernel/kunit.rs           |  1 +
 5 files changed, 68 insertions(+), 10 deletions(-)

-- 
2.54.0


