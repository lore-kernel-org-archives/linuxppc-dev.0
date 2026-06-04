Return-Path: <linuxppc-dev+bounces-22055-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DA0CD6E6D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:29:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWVQ40ltvz2y8p;
	Fri, 05 Jun 2026 02:29:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780590556;
	cv=none; b=A5WuUZNxcATfDyMhq/f8ByHah3EsLlZC0KkEAYJ+UloN0267lTDGBAMGTFdZDVefMFMsDcAS2Im1QJfLtfb2W2CZb613YMQMPL3dETogw0TCrKJynDhPnRLtaASZpqrVrFQUYKuUu+amafwzQKN3aLQnkF3uCJ0V9oBwm1NMs7+1ISL96sdnAiXU3mICENaixkgI1Qr2gErhTBDRi4CHoflrdcPfhPApOP7xeeCPpVf0U/zlEqbOibsv7YVKuVS6So/7v4sVO6/uL9xCbnOV3/KWnOG9f99sgN/Tag2NLogYCuTDqNQx0B9QeUmpLkjeYN69u8ReJi2R7css0leRkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780590556; c=relaxed/relaxed;
	bh=BPSJrVnBuwau2689hQICWWc7F8+4zc9GOFbACznAN3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxfgQ7i6Rj+nVNdjwTN3u89KrzTE0my/sBJSi9HJiEhy7HkqcjEhWXBwjNObp8SApjHWXm1vI0M82fgoOXA/fac4z5XVzX7CC9W5DWRXYFqkFLscaqsIAJAfayOy6iaLBkHKz12b994EiVRPcaUn576kKPEGvbVRDTr6N30jriExUPtZPjTfMYOWX4jzY+/BZ/aHf66l2zM//tvVjN9LBC++5lBPomfrRh26To/CgSK8OYJ8Ckfgb7wN3GAANPYfTIHagLKEgXiUyXXvuGchk5TM5dOvmxDTUMcCrWSbTFDofA8MZrH/F/Z1dlsxwU9mgWR3owl8PZzWRA3+OXZyFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AqBmdrta; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AqBmdrta;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWVQ26lh7z2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 02:29:14 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654FhXs33717409;
	Thu, 4 Jun 2026 16:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BPSJrVnBuwau2689hQICWWc7F8+4zc9GOFbACznAN
	3U=; b=AqBmdrtawiu5Og+BJZytNVI4SwcctKy8Ca6HPgj3zsoeVJ1a380b68MAn
	GhAQlQJO7RNd6ioXfurd3LsHphEXSL0IiMAqSB5gtwQ+2YLbQUIeGkPmni6mX4XZ
	rROqRvWsor0Vv8KjohrrQ8mLFfCm40uC1IEfPvIBCLCAJ63j/B+AcJBZE8C+phzc
	DJkzFZ0bK+4I1LkhQuO23Hy99Hea49lZl31st+jCvcJK/2+B3SsxnQmD5kMINIbf
	FqAFG2F8cBxZkqg1lwpNNPREeGi6dRE4KfQDC/G13heESpfgKaNrLZfrryrH1wRJ
	TsekJFetW8obKmmFiDDbA3Ny9k/xw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnaj0a14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:28:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654GO8kd012085;
	Thu, 4 Jun 2026 16:28:37 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7kdw0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:28:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 654GSaZ418481820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 16:28:36 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29DA558059;
	Thu,  4 Jun 2026 16:28:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AB9558058;
	Thu,  4 Jun 2026 16:28:29 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.208.128])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Thu,  4 Jun 2026 16:28:29 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Thu, 04 Jun 2026 21:58:27 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>
Subject: [PATCH 0/2] kunit: Add support for skipping entire test suites
Date: Thu,  4 Jun 2026 21:57:59 +0530
Message-ID: <20260604162805.556135-1-vaibhav@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE1NyBTYWx0ZWRfX4oWToME9+TIB
 fh3gHNdCF80qPy4uHV498boj0907tAAjFpn16aQ5SnalRS5Haf0nv41K89s67SfZlmcD+zQUiAQ
 v1Z9xr+6rAtsnzGVwnjkbNGBlCclJQqwCHqkHCXo488eT7pxMwSeZGQkVyxkCp02TVM2w4T/FAC
 f3FivEE2wlT0ITWwzLPxCYK535VhC/nbx/f0bO3dcqKr02gr7lIR6J7ARNc4915orZodmhD3lbu
 5A/IsJvcJB7qOmFtjEWVN9VVck/93nPvCc44acYAD5PXQsIFNqN971JWIob1gcbTEpltohcOmWn
 kXlbaTiUpiGF5DTYJuHIMRy8BWV436jveuXTQFqV5TqPboJMOoCRKRgoKPcaLq8/XF/6iTfc6mq
 sprXq1I9G51cVbfaXz7+hJ+8Crh7WBGSnQ/n7tBPgb91jffBmbtxOVviSjBmiq+P9RvD/EBf0tn
 rju3WsmhsX/gAOUeBrA==
X-Proofpoint-ORIG-GUID: d1hHI7oGOazXSV-3busXYoupSNLicc__
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a21a7b6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=YJbK2cU66lbDfEsmsGcA:9
X-Proofpoint-GUID: yaeo8ucO4uWMpUG45YiIvtfbt6LsO0gV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040157

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

Patch 2:
* Providing an example in kunit-example-test.c demonstrating the usage
  pattern.

The implementation is minimal and non-intrusive, adding only a status field
to kunit_suite and checks in two key functions. Test suites that don't use
this proposed feature should be unaffected.

References
==========
[1] https://lore.kernel.org/all/20260604092931.344101-1-vaibhav@linux.ibm.com

Vaibhav Jain (2):
  kunit: Add ability to skip entire test suites
  kunit: Add example of test suite that can be skipped at runtime

 include/kunit/test.h           |  1 +
 lib/kunit/kunit-example-test.c | 29 +++++++++++++++++++++++++++++
 lib/kunit/test.c               | 11 +++++++++++
 3 files changed, 41 insertions(+)

-- 
2.54.0


