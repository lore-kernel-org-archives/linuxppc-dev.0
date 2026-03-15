Return-Path: <linuxppc-dev+bounces-18201-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F04D58B18
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Mar 2026 10:58:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYZvS2syzz2yYy;
	Sun, 15 Mar 2026 21:58:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773572292;
	cv=none; b=VayxD0zpQdTkHrPj8pzdtrSqWQNh3U480vWDq8MPhcIOQGorzshTbcPwD0VsiKcXOBcDDHtzDXzeas4rzGsbNpm8aE0xC2+hf77VBWeYVA1d4RvRNBnS1Cl6zOQmVEdIgrIziZfjbKG1qa8nzWtbg/4hcxzYqEC+AkrXlxjLg1n7c6prDfZ2TyrIgeMPIRond6vlyM1/VggnTFeDtVPHbYP6F1Tb+zdX45rQxMLCTGXQ1hfxbiALf9aTs7XaO51VjUg/1TaWx+Mx5jHOsAchbYjf2N9cALi5km/zKEdN+doK5L9hIxl1lcuSRu9JxzaGRFSar/X3lioH1LPQRe1fOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773572292; c=relaxed/relaxed;
	bh=XYU9H+HugBhtGHUKD5r1M8roOAoRsCqDwzTMloiz0s4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UJa3iaqDmAlbKYl2Yw3uQEaiJKdkEEN9QOKq+vRDu9AHDW3ug0Z5hIBZrhtDmOdYJpZHkxQhsyHoZ4IMuKVcE8gLKeZQFHRKcooCf5UzUrY+S6k8FpQxW0ZaRWBkpVlpsxedaEkNPspUrCltC38rTeJ/r7s3zrrQpQP2jX54GxUKo2mBCe2bAzXvBDGy4qNWUaQ6X1ekl7odJSSB8vaazqEcO/c2JY6+U6sTIUFW/a30Kq/ezRCQkrolG46WkiGI1xI+8vpQp0s5hBjcNyHm5GUpDBN+tnJG/ps2yaWnoAMIGoWF28ACSy23gElYtKrBZcYi1m4v9CUuPAnTtULVXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=POBhDDEq; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=POBhDDEq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYZvR1Tkpz2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Mar 2026 21:58:10 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FAur0B3831306;
	Sun, 15 Mar 2026 10:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XYU9H+HugBhtGHUKD5r1M8roOAoRsCqDwzTMloiz0
	s4=; b=POBhDDEqDLKyOdj9zZdRAk7Cetw22tzXDitN6zfYk8ltcFtWIccM562SF
	Yntv2x8uYKEpE3pjXnpPfVy7KRA70FqRghlJ32Nan2E7KyuBueFSaz/lYuq5361J
	cRGRUYXI4KDumd3J95wXFdI3aAGbjagdh2kt5oE0iU0o4OHGPgBY9q5ov0Sw7H70
	z8Ax8nVWvVqPP0qj2D4pv+LUaz2T8TRClAC5gij5umvOzEDKqqVgj3zps1MCxYdV
	unRFn0eeMqHR6nPGhrDC3J894nl4LwQeqIEzrh7ZxgGD6Cri2Y7NGLORtDqImni1
	6b+nIz+baSMzLjsFKxKRxAsreaeww==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hkx5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 10:58:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62F7TZT9004585;
	Sun, 15 Mar 2026 10:58:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s18ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 10:58:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62FAvwJ751642814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Mar 2026 10:57:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5120C2004E;
	Sun, 15 Mar 2026 10:57:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 430CF2004B;
	Sun, 15 Mar 2026 10:57:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.217.178])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Mar 2026 10:57:55 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: [PATCH] tools/perf/test: Check for perf stat return code in perf all PMU test
Date: Sun, 15 Mar 2026 16:27:51 +0530
Message-Id: <20260315105751.86835-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
X-Proofpoint-GUID: zi_pv8WPv5R8pjdMiETpAg4L5X4dADm1
X-Proofpoint-ORIG-GUID: MgB_8JlMZPf17b1ARC1XGXMK6DNnfl8V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE1MDA4NCBTYWx0ZWRfX5Jndi9q/ARmO
 A99nAlIfc/F+1cy9bl8/+EeRVY9nbhtstqp+e3PMpwv0Q6pmGtqUmEpZi2b1Jp9tDeh4K1L1siM
 feW/oE7oMTZWKgGNEcZlu8+QXpwSWunybhDDnx2rgngePoSCAvgR5zyNDd7K6bd/nWiCjkC2IA5
 226sJr7N0UrbcivNpOADn9G+jDgCVMxAzG/KtIKw2otGFw0REBfyfG4VH3ofzikDjLcny9+0EK4
 ve/Y0US7PpIBJCVbSmLUiEWUwVBD8uoQP985BWPuviKKeKXAmN25rr5zcuPpP8+GxTQE/Mw06op
 lhbRYxIBuLBZXXShJ8mH9hhHjceAuScLDtE1ahbFeMzs+7a6AeI78MmrdpRVyjKQddCaXJu66Cd
 kAJVBpg5cw+TewwlA0DKEGstHxao88ThBBSzIjbrFKNdTjys8nu8+1pW0JodATY9M/ipyNFns/c
 kT7exSwJRR2uDKcKyMw==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b690bb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=qZq1WOfte6T52t-qA6kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-15_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603150084

Currently in "perf all PMU test", for "perf stat -e <event> true",
below checks are done:
- if return code is zero, look for "not supported" to decide pass
  scenario
- check for "not supported" to ignore the event
- looks for "No permission to enable" to skip the event.
- If output has "Bad event name", fail the test.
- Use "Access to performance monitoring and observability operations is
  limited." to ignore fail due to access limitations

If we failed to see event and it is supported, retries with longer
workload "perf bench internals synthesize".
- Here if output has <event>, the test is a pass.

Snippet of code check:
  ```
  output=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
  if echo "$output" | grep -q "$p"
  ```
- if output doesn't have event printed in logs, considers it fail.

But this results in false pass for events in some cases.
Example, if perf stat fails as below:

 # ./perf stat -e pmu/event/  true
 event syntax error: 'pmu/event/'
                     \___ Bad event or PMU

 Unable to find PMU or event on a PMU of 'pmu'
 Run 'perf list' for a list of valid events

  Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
 # echo $?
 129

Since this has non-zero return code and doesn't have the
fail strings being checked in the test, it will enter check using
longer workload. and since the output fail log has event, it
declares test as "supported".

Since all the fail strings can't be added in the check, update
the testcase to check return code before proceeding to longer
workload run.

Another missing scenario is when system wide monitoring is supported
example:
 # ./perf stat -e pmu/event/ true
 Error:
 No supported events found.
  Unsupported event (pmu/event/H) in per-thread mode, enable system wide with '-a'.

Update testcase to check with "perf stat -a -e $p" as well

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/tests/shell/stat_all_pmu.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
index 9c466c0efa85..6c4d59cbfa5f 100755
--- a/tools/perf/tests/shell/stat_all_pmu.sh
+++ b/tools/perf/tests/shell/stat_all_pmu.sh
@@ -53,6 +53,26 @@ do
     continue
   fi
 
+  # check with system wide if it is supported.
+  output=$(perf stat -a -e "$p" true 2>&1)
+  stat_result=$?
+  if echo "$output" | grep -q "not supported"
+  then
+    # Event not supported, so ignore.
+    echo "not supported"
+    continue
+  fi
+
+  # checked through possible access limitations and permissions.
+  # At this step, non-zero return code from "perf stat" needs to
+  # reported as fail for the user to investigate
+  if [ $stat_result -ne 0 ]
+  then
+    echo "perf stat failed with non-zero return code"
+    err=1
+    continue
+  fi
+
   # We failed to see the event and it is supported. Possibly the workload was
   # too small so retry with something longer.
   output=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
-- 
2.47.3


